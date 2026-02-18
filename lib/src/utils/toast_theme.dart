import 'package:flutter/material.dart';
import '../models/toast_type.dart';

/// Theme utilities for toast notifications.
class ToastTheme {
  /// Gets the default background color for a toast type.
  static Color getBackgroundColor(
    MunchToastType type,
    BuildContext context,
    Color? customColor,
  ) {
    if (customColor != null) return customColor;

    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    switch (type) {
      case MunchToastType.success:
        return isDark ? Colors.green.shade700 : Colors.green.shade600;
      case MunchToastType.error:
        return isDark ? Colors.red.shade700 : Colors.red.shade600;
      case MunchToastType.info:
        return isDark ? Colors.blue.shade700 : Colors.blue.shade600;
      case MunchToastType.warning:
        return isDark ? Colors.orange.shade700 : Colors.orange.shade600;
      case MunchToastType.custom:
        return isDark ? Colors.grey.shade800 : Colors.grey.shade700;
    }
  }

  /// Gets the default icon color for a toast type.
  static Color getIconColor(
    MunchToastType type,
    BuildContext context,
    Color? customColor,
  ) {
    if (customColor != null) return customColor;

    return Colors.white;
  }

  /// Gets the default icon for a toast type.
  static IconData? getDefaultIcon(MunchToastType type) {
    switch (type) {
      case MunchToastType.success:
        return Icons.check_circle;
      case MunchToastType.error:
        return Icons.error;
      case MunchToastType.info:
        return Icons.info;
      case MunchToastType.warning:
        return Icons.warning;
      case MunchToastType.custom:
        return null;
    }
  }

  /// Gets the default text style for toast messages.
  static TextStyle getTextStyle(BuildContext context, TextStyle? customStyle) {
    if (customStyle != null) return customStyle;

    final theme = Theme.of(context);
    return theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ) ??
        const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        );
  }

  /// Gets the default action button style.
  static TextStyle getActionTextStyle(
    BuildContext context,
    TextStyle? customStyle,
  ) {
    if (customStyle != null) return customStyle;

    return const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  }
}
