// A modern, highly customizable toast/snackbar notification widget for Flutter.
// Perfect for e-commerce applications with support for actions, animations,
// and various customization options.

export 'src/models/toast_type.dart';
export 'src/models/toast_position.dart';
export 'src/models/toast_action.dart';
export 'src/models/toast_config.dart';
export 'src/controllers/toast_controller.dart';

import 'package:flutter/material.dart';
import 'src/models/toast_config.dart';
import 'src/models/toast_type.dart';
import 'src/models/toast_position.dart';
import 'src/models/toast_action.dart';
import 'src/controllers/toast_controller.dart';

/// Main class for displaying toast notifications.
class MunchToast {
  static final ToastController _controller = ToastController();

  /// Shows a toast notification with full customization options.
  ///
  /// Example:
  /// ```dart
  /// MunchToast.show(
  ///   context,
  ///   message: 'Product added to cart',
  ///   type: MunchToastType.success,
  ///   position: MunchToastPosition.bottom,
  ///   duration: Duration(seconds: 3),
  ///   action: MunchToastAction(
  ///     label: 'View Cart',
  ///     onPressed: () => Navigator.pushNamed(context, '/cart'),
  ///   ),
  /// );
  /// ```
  static void show(
    BuildContext context, {
    required String message,
    MunchToastType type = MunchToastType.info,
    MunchToastPosition position = MunchToastPosition.bottom,
    Duration? duration,
    MunchToastAction? action,
    IconData? icon,
    Color? iconColor,
    Color? backgroundColor,
    Gradient? gradient,
    double? borderRadius,
    double? elevation,
    VoidCallback? onDismiss,
    bool showProgress = false,
    bool persistent = false,
    TextStyle? textStyle,
    Border? border,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Offset? offset,
    Curve animationCurve = Curves.easeOut,
    bool enableSwipeToDismiss = true,
    bool enableHapticFeedback = false,
    Widget? customWidget,
  }) {
    final config = MunchToastConfig(
      message: message,
      type: type,
      position: position,
      duration: duration ?? const Duration(seconds: 3),
      action: action,
      icon: icon,
      iconColor: iconColor,
      backgroundColor: backgroundColor,
      gradient: gradient,
      borderRadius: borderRadius ?? 12.0,
      elevation: elevation ?? 6.0,
      onDismiss: onDismiss,
      showProgress: showProgress,
      persistent: persistent,
      textStyle: textStyle,
      border: border,
      padding: padding,
      margin: margin,
      offset: offset,
      animationCurve: animationCurve,
      enableSwipeToDismiss: enableSwipeToDismiss,
      enableHapticFeedback: enableHapticFeedback,
      customWidget: customWidget,
    );

    _controller.show(context, config);
  }

  /// Shows a success toast notification.
  ///
  /// Example:
  /// ```dart
  /// MunchToast.success(
  ///   context,
  ///   message: 'Order placed successfully!',
  /// );
  /// ```
  static void success(
    BuildContext context, {
    required String message,
    MunchToastPosition position = MunchToastPosition.bottom,
    Duration? duration,
    MunchToastAction? action,
    IconData? icon,
    Color? iconColor,
    double? borderRadius,
    double? elevation,
    VoidCallback? onDismiss,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Offset? offset,
  }) {
    show(
      context,
      message: message,
      type: MunchToastType.success,
      position: position,
      duration: duration,
      action: action,
      icon: icon,
      iconColor: iconColor,
      borderRadius: borderRadius,
      elevation: elevation,
      onDismiss: onDismiss,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      offset: offset,
    );
  }

  /// Shows an error toast notification.
  ///
  /// Example:
  /// ```dart
  /// MunchToast.error(
  ///   context,
  ///   message: 'Payment failed. Please try again.',
  ///   action: MunchToastAction(
  ///     label: 'Retry',
  ///     onPressed: _retryPayment,
  ///   ),
  /// );
  /// ```
  static void error(
    BuildContext context, {
    required String message,
    MunchToastPosition position = MunchToastPosition.bottom,
    Duration? duration,
    MunchToastAction? action,
    IconData? icon,
    Color? iconColor,
    double? borderRadius,
    double? elevation,
    VoidCallback? onDismiss,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Offset? offset,
  }) {
    show(
      context,
      message: message,
      type: MunchToastType.error,
      position: position,
      duration: duration,
      action: action,
      icon: icon,
      iconColor: iconColor,
      borderRadius: borderRadius,
      elevation: elevation,
      onDismiss: onDismiss,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      offset: offset,
    );
  }

  /// Shows an info toast notification.
  ///
  /// Example:
  /// ```dart
  /// MunchToast.info(
  ///   context,
  ///   message: 'New products available!',
  /// );
  /// ```
  static void info(
    BuildContext context, {
    required String message,
    MunchToastPosition position = MunchToastPosition.bottom,
    Duration? duration,
    MunchToastAction? action,
    IconData? icon,
    Color? iconColor,
    double? borderRadius,
    double? elevation,
    VoidCallback? onDismiss,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Offset? offset,
  }) {
    show(
      context,
      message: message,
      type: MunchToastType.info,
      position: position,
      duration: duration,
      action: action,
      icon: icon,
      iconColor: iconColor,
      borderRadius: borderRadius,
      elevation: elevation,
      onDismiss: onDismiss,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      offset: offset,
    );
  }

  /// Shows a warning toast notification.
  ///
  /// Example:
  /// ```dart
  /// MunchToast.warning(
  ///   context,
  ///   message: 'Low stock alert',
  /// );
  /// ```
  static void warning(
    BuildContext context, {
    required String message,
    MunchToastPosition position = MunchToastPosition.bottom,
    Duration? duration,
    MunchToastAction? action,
    IconData? icon,
    Color? iconColor,
    double? borderRadius,
    double? elevation,
    VoidCallback? onDismiss,
    TextStyle? textStyle,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Offset? offset,
  }) {
    show(
      context,
      message: message,
      type: MunchToastType.warning,
      position: position,
      duration: duration,
      action: action,
      icon: icon,
      iconColor: iconColor,
      borderRadius: borderRadius,
      elevation: elevation,
      onDismiss: onDismiss,
      textStyle: textStyle,
      padding: padding,
      margin: margin,
      offset: offset,
    );
  }

  /// Dismisses all active toast notifications for the given context.
  static void dismissAll(BuildContext context) {
    _controller.dismissAll(context);
  }
}
