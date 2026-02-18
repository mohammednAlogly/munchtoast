import 'package:flutter/material.dart';
import 'toast_type.dart';
import 'toast_position.dart';
import 'toast_action.dart';

/// Configuration class for toast notifications.
class MunchToastConfig {
  /// The message to display
  final String message;

  /// Type of toast (affects default colors)
  final MunchToastType type;

  /// Position where toast appears
  final MunchToastPosition position;

  /// Duration before auto-dismiss
  final Duration duration;

  /// Optional action button
  final MunchToastAction? action;

  /// Optional leading icon
  final IconData? icon;

  /// Optional icon color
  final Color? iconColor;

  /// Optional background color (overrides type defaults)
  final Color? backgroundColor;

  /// Optional gradient background (overrides backgroundColor)
  final Gradient? gradient;

  /// Border radius for the toast
  final double borderRadius;

  /// Elevation/shadow depth
  final double elevation;

  /// Callback when toast is dismissed
  final VoidCallback? onDismiss;

  /// Whether to show a progress indicator
  final bool showProgress;

  /// Whether toast requires manual dismiss
  final bool persistent;

  /// Optional custom text style
  final TextStyle? textStyle;

  /// Optional border
  final Border? border;

  /// Optional padding
  final EdgeInsets? padding;

  /// Optional margin
  final EdgeInsets? margin;

  /// Custom offset from position
  final Offset? offset;

  /// Animation curve
  final Curve animationCurve;

  /// Whether to enable swipe to dismiss
  final bool enableSwipeToDismiss;

  /// Whether to enable haptic feedback
  final bool enableHapticFeedback;

  /// Optional custom widget to display instead of standard content
  final Widget? customWidget;

  const MunchToastConfig({
    required this.message,
    this.type = MunchToastType.info,
    this.position = MunchToastPosition.bottom,
    this.duration = const Duration(seconds: 3),
    this.action,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.gradient,
    this.borderRadius = 12.0,
    this.elevation = 6.0,
    this.onDismiss,
    this.showProgress = false,
    this.persistent = false,
    this.textStyle,
    this.border,
    this.padding,
    this.margin,
    this.offset,
    this.animationCurve = Curves.easeOut,
    this.enableSwipeToDismiss = true,
    this.enableHapticFeedback = false,
    this.customWidget,
  });

  /// Creates a copy of this config with modified fields
  MunchToastConfig copyWith({
    String? message,
    MunchToastType? type,
    MunchToastPosition? position,
    Duration? duration,
    MunchToastAction? action,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
    Gradient? gradient,
    double? borderRadius,
    double? elevation,
    VoidCallback? onDismiss,
    bool? showProgress,
    bool? persistent,
    TextStyle? textStyle,
    Border? border,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Offset? offset,
    Curve? animationCurve,
    bool? enableSwipeToDismiss,
    bool? enableHapticFeedback,
    Widget? customWidget,
  }) {
    return MunchToastConfig(
      message: message ?? this.message,
      type: type ?? this.type,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      action: action ?? this.action,
      icon: icon ?? this.icon,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      gradient: gradient ?? this.gradient,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      onDismiss: onDismiss ?? this.onDismiss,
      showProgress: showProgress ?? this.showProgress,
      persistent: persistent ?? this.persistent,
      textStyle: textStyle ?? this.textStyle,
      border: border ?? this.border,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      offset: offset ?? this.offset,
      animationCurve: animationCurve ?? this.animationCurve,
      enableSwipeToDismiss: enableSwipeToDismiss ?? this.enableSwipeToDismiss,
      enableHapticFeedback: enableHapticFeedback ?? this.enableHapticFeedback,
      customWidget: customWidget ?? this.customWidget,
    );
  }
}
