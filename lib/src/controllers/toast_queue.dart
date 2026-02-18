import '../models/toast_config.dart';

/// Manages a queue of toast notifications.
class ToastQueue {
  final List<MunchToastConfig> _queue = [];
  bool _isProcessing = false;

  /// Adds a toast configuration to the queue.
  void add(MunchToastConfig config) {
    _queue.add(config);
  }

  /// Removes and returns the next toast configuration from the queue.
  MunchToastConfig? pop() {
    if (_queue.isEmpty) return null;
    return _queue.removeAt(0);
  }

  /// Checks if the queue is empty.
  bool get isEmpty => _queue.isEmpty;

  /// Checks if the queue is not empty.
  bool get isNotEmpty => _queue.isNotEmpty;

  /// Gets the current queue length.
  int get length => _queue.length;

  /// Clears all pending toasts from the queue.
  void clear() {
    _queue.clear();
  }

  /// Checks if a toast is currently being processed.
  bool get isProcessing => _isProcessing;

  /// Sets the processing state.
  void setProcessing(bool value) {
    _isProcessing = value;
  }

  /// Gets all pending toasts (for debugging).
  List<MunchToastConfig> get pendingToasts => List.unmodifiable(_queue);
}
