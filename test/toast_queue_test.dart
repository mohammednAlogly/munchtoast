import 'package:flutter_test/flutter_test.dart';
import 'package:munchtoast/src/controllers/toast_queue.dart';
import 'package:munchtoast/src/models/toast_config.dart';
import 'package:munchtoast/src/models/toast_type.dart';

void main() {
  group('ToastQueue', () {
    late ToastQueue queue;

    setUp(() {
      queue = ToastQueue();
    });

    test('should start empty', () {
      expect(queue.isEmpty, isTrue);
      expect(queue.length, 0);
    });

    test('should add toast configs to queue', () {
      final config = MunchToastConfig(
        message: 'Test message',
        type: MunchToastType.info,
      );

      queue.add(config);
      expect(queue.isEmpty, isFalse);
      expect(queue.length, 1);
    });

    test('should pop toast configs from queue', () {
      final config1 = MunchToastConfig(
        message: 'Message 1',
        type: MunchToastType.info,
      );
      final config2 = MunchToastConfig(
        message: 'Message 2',
        type: MunchToastType.success,
      );

      queue.add(config1);
      queue.add(config2);

      expect(queue.length, 2);

      final popped = queue.pop();
      expect(popped, equals(config1));
      expect(queue.length, 1);

      final popped2 = queue.pop();
      expect(popped2, equals(config2));
      expect(queue.isEmpty, isTrue);
    });

    test('should return null when popping from empty queue', () {
      expect(queue.pop(), isNull);
    });

    test('should clear all toasts', () {
      queue.add(MunchToastConfig(
        message: 'Message 1',
        type: MunchToastType.info,
      ));
      queue.add(MunchToastConfig(
        message: 'Message 2',
        type: MunchToastType.success,
      ));

      expect(queue.length, 2);
      queue.clear();
      expect(queue.isEmpty, isTrue);
      expect(queue.length, 0);
    });

    test('should track processing state', () {
      expect(queue.isProcessing, isFalse);
      queue.setProcessing(true);
      expect(queue.isProcessing, isTrue);
      queue.setProcessing(false);
      expect(queue.isProcessing, isFalse);
    });
  });
}
