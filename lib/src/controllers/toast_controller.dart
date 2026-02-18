import 'package:flutter/material.dart';
import '../models/toast_config.dart';
import '../models/toast_action.dart';
import '../models/toast_position.dart';
import '../utils/toast_constants.dart';
import '../utils/toast_theme.dart';
import 'toast_queue.dart';

/// Global controller for managing toast notifications.
class ToastController {
  static final ToastController _instance = ToastController._internal();
  factory ToastController() => _instance;
  ToastController._internal();

  final Map<BuildContext, OverlayEntry> _activeToasts = {};
  final Map<BuildContext, ToastQueue> _queues = {};

  /// Shows a toast notification.
  void show(BuildContext context, MunchToastConfig config) {
    final overlay = Overlay.of(context);

    // Get or create queue for this context
    final queue = _queues.putIfAbsent(context, () => ToastQueue());

    // If there's already an active toast, add to queue
    if (_activeToasts.containsKey(context)) {
      queue.add(config);
      return;
    }

    _displayToast(context, overlay, config);
  }

  /// Displays a toast notification.
  void _displayToast(
    BuildContext context,
    OverlayState overlay,
    MunchToastConfig config,
  ) {
    final entry = OverlayEntry(
      builder: (context) => _ToastOverlay(
        config: config,
        onDismiss: () {
          _dismissToast(context, config: config);
        },
      ),
    );

    overlay.insert(entry);
    _activeToasts[context] = entry;

    // Auto-dismiss if not persistent
    if (!config.persistent) {
      Future.delayed(config.duration, () {
        if (context.mounted &&
            _activeToasts.containsKey(context) &&
            _activeToasts[context] == entry) {
          _dismissToast(context, config: config);
        }
      });
    }
  }

  /// Dismisses the current toast and shows the next one in queue.
  void _dismissToast(BuildContext context, {MunchToastConfig? config}) {
    final entry = _activeToasts.remove(context);
    if (entry != null) {
      config?.onDismiss?.call();
      entry.remove();
    }

    final queue = _queues[context];
    if (queue != null && queue.isNotEmpty) {
      final nextConfig = queue.pop()!;
      final overlay = Overlay.maybeOf(context);
      if (overlay != null) {
        Future.delayed(const Duration(milliseconds: 100), () {
          final currentOverlay = Overlay.maybeOf(context);
          if (currentOverlay != null && currentOverlay.mounted) {
            _displayToast(context, currentOverlay, nextConfig);
          }
        });
      }
    }

    // Clean up empty queues
    if (queue != null && queue.isEmpty) {
      _queues.remove(context);
    }
  }

  /// Dismisses all toasts for a given context.
  void dismissAll(BuildContext context) {
    final entry = _activeToasts.remove(context);
    entry?.remove();

    final queue = _queues[context];
    queue?.clear();
    _queues.remove(context);
  }

  /// Cleans up resources for a context (call in dispose).
  void dispose(BuildContext context) {
    dismissAll(context);
  }
}

/// Internal overlay widget for toast notifications.
class _ToastOverlay extends StatelessWidget {
  final MunchToastConfig config;
  final VoidCallback onDismiss;

  const _ToastOverlay({
    required this.config,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return _ToastPositioned(
      position: config.position,
      offset: config.offset,
      child: _ToastWidget(
        config: config,
        onDismiss: onDismiss,
      ),
    );
  }
}

/// Positions the toast based on configuration.
class _ToastPositioned extends StatelessWidget {
  final MunchToastPosition position;
  final Offset? offset;
  final Widget child;

  const _ToastPositioned({
    required this.position,
    this.offset,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).padding;

    switch (position) {
      case MunchToastPosition.top:
        return Positioned(
          top: (offset?.dy ?? ToastConstants.defaultMargin) + safePadding.top,
          left: offset?.dx ?? ToastConstants.defaultMargin,
          right: offset?.dx ?? ToastConstants.defaultMargin,
          child: child,
        );
      case MunchToastPosition.bottom:
        return Positioned(
          bottom: (offset?.dy ?? ToastConstants.defaultMargin) +
              safePadding.bottom,
          left: offset?.dx ?? ToastConstants.defaultMargin,
          right: offset?.dx ?? ToastConstants.defaultMargin,
          child: child,
        );
      case MunchToastPosition.center:
        return Center(
          child: Padding(
            padding: EdgeInsets.only(
              top: safePadding.top,
              bottom: safePadding.bottom,
              left: offset?.dx ?? ToastConstants.defaultMargin,
              right: offset?.dx ?? ToastConstants.defaultMargin,
            ),
            child: child,
          ),
        );
    }
  }
}

/// The actual toast widget.
class _ToastWidget extends StatefulWidget {
  final MunchToastConfig config;
  final VoidCallback onDismiss;

  const _ToastWidget({
    required this.config,
    required this.onDismiss,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _dragOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: ToastConstants.defaultAnimationDuration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.config.animationCurve,
    );

    _controller.forward();

    if (widget.config.enableHapticFeedback) {
      // Haptic feedback can be added here if needed
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDismiss() {
    _controller.reverse().then((_) {
      widget.config.onDismiss?.call();
      widget.onDismiss();
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.config.enableSwipeToDismiss) return;

    setState(() {
      _dragOffset += details.primaryDelta ?? 0.0;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.config.enableSwipeToDismiss) return;

    if (_dragOffset.abs() > ToastConstants.minSwipeDistance) {
      _handleDismiss();
    } else {
      setState(() {
        _dragOffset = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: _getSlideBegin(),
          end: Offset.zero,
        ).animate(_animation),
        child: Transform.translate(
          offset: Offset(0, _dragOffset),
          child: GestureDetector(
            onHorizontalDragUpdate: _handleDragUpdate,
            onHorizontalDragEnd: _handleDragEnd,
            onVerticalDragUpdate: _handleDragUpdate,
            onVerticalDragEnd: _handleDragEnd,
            child: _ToastContainer(
              config: widget.config,
              onDismiss: widget.config.persistent ? _handleDismiss : null,
            ),
          ),
        ),
      ),
    );
  }

  Offset _getSlideBegin() {
    switch (widget.config.position) {
      case MunchToastPosition.top:
        return const Offset(0, -1);
      case MunchToastPosition.bottom:
        return const Offset(0, 1);
      case MunchToastPosition.center:
        return Offset.zero;
    }
  }
}

/// Container widget for toast content.
class _ToastContainer extends StatelessWidget {
  final MunchToastConfig config;
  final VoidCallback? onDismiss;

  const _ToastContainer({
    required this.config,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ToastTheme.getBackgroundColor(
      config.type,
      context,
      config.backgroundColor,
    );

    Widget content = config.customWidget ??
        _ToastContent(
          config: config,
          onDismiss: onDismiss,
        );

    Widget container = Container(
      constraints: const BoxConstraints(
        maxWidth: ToastConstants.maxToastWidth,
        minHeight: 48,
      ),
      padding: config.padding ??
          const EdgeInsets.symmetric(
            horizontal: ToastConstants.defaultHorizontalPadding,
            vertical: ToastConstants.defaultVerticalPadding,
          ),
      margin: config.margin,
      decoration: BoxDecoration(
        color: config.gradient == null ? theme : null,
        gradient: config.gradient,
        borderRadius: BorderRadius.circular(config.borderRadius),
        border: config.border,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: config.elevation,
            offset: Offset(0, config.elevation / 2),
          ),
        ],
      ),
      child: content,
    );

    return Semantics(
      label: config.message,
      button: config.action != null,
      child: Material(
        color: Colors.transparent,
        child: container,
      ),
    );
  }
}

/// Content widget for toast.
class _ToastContent extends StatelessWidget {
  final MunchToastConfig config;
  final VoidCallback? onDismiss;

  const _ToastContent({
    required this.config,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final icon = config.icon ??
        ToastTheme.getDefaultIcon(config.type);

    final iconColor = ToastTheme.getIconColor(
      config.type,
      context,
      config.iconColor,
    );

    final textStyle = ToastTheme.getTextStyle(context, config.textStyle);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(
            icon,
            color: iconColor,
            size: ToastConstants.defaultIconSize,
          ),
          const SizedBox(width: ToastConstants.defaultIconSpacing),
        ],
        Expanded(
          child: Text(
            config.message,
            style: textStyle,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (config.action != null) ...[
          const SizedBox(width: ToastConstants.defaultActionSpacing),
          _ActionButton(action: config.action!, textStyle: textStyle),
        ],
        if (config.persistent && onDismiss != null) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.close, size: 18),
            color: Colors.white.withValues(alpha: 0.8),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: onDismiss,
          ),
        ],
      ],
    );
  }
}

/// Action button widget.
class _ActionButton extends StatelessWidget {
  final MunchToastAction action;
  final TextStyle textStyle;

  const _ActionButton({
    required this.action,
    required this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final actionStyle = ToastTheme.getActionTextStyle(
      context,
      action.textStyle,
    );

    return TextButton(
      onPressed: action.onPressed,
      style: TextButton.styleFrom(
        backgroundColor: action.backgroundColor,
        foregroundColor: action.foregroundColor ?? Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        action.label,
        style: actionStyle,
      ),
    );
  }
}
