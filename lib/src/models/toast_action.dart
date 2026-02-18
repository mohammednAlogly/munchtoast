import 'package:flutter/material.dart';

/// Represents an action button that can be displayed in a toast notification.
class MunchToastAction {
  /// The label text for the action button
  final String label;

  /// Callback function when the action button is pressed
  final VoidCallback onPressed;

  /// Optional text style for the action button label
  final TextStyle? textStyle;

  /// Optional background color for the action button
  final Color? backgroundColor;

  /// Optional foreground color for the action button
  final Color? foregroundColor;

  const MunchToastAction({
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
  });
}
