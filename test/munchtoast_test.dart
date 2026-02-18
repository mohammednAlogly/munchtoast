import 'package:flutter_test/flutter_test.dart';
import 'package:munchtoast/munchtoast.dart';

void main() {
  group('MunchToast', () {
    test('MunchToastType enum values', () {
      expect(MunchToastType.success, isNotNull);
      expect(MunchToastType.error, isNotNull);
      expect(MunchToastType.info, isNotNull);
      expect(MunchToastType.warning, isNotNull);
      expect(MunchToastType.custom, isNotNull);
    });

    test('MunchToastPosition enum values', () {
      expect(MunchToastPosition.top, isNotNull);
      expect(MunchToastPosition.bottom, isNotNull);
      expect(MunchToastPosition.center, isNotNull);
    });

    test('MunchToastAction creation', () {
      final action = MunchToastAction(
        label: 'Test',
        onPressed: () {},
      );
      expect(action.label, 'Test');
      expect(action.onPressed, isNotNull);
    });
  });
}
