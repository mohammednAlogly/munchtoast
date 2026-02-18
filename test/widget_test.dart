import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:munchtoast/munchtoast.dart';

void main() {
  group('MunchToast Widget Tests', () {
    testWidgets('MunchToast.show can be called without errors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TestWidget(),
          ),
        ),
      );

      // Trigger toast - verify it doesn't throw
      final button = find.text('Show Toast');
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pump();
      
      // Wait for any pending timers
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
    });

    testWidgets('MunchToast.success can be called without errors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SuccessTestWidget(),
          ),
        ),
      );

      final button = find.text('Show Success');
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pump();
      
      // Wait for any pending timers
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
    });

    testWidgets('MunchToast.error can be called without errors', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ErrorTestWidget(),
          ),
        ),
      );

      final button = find.text('Show Error');
      expect(button, findsOneWidget);
      await tester.tap(button);
      await tester.pump();
      
      // Wait for any pending timers
      await tester.pump(const Duration(milliseconds: 200));
      await tester.pumpAndSettle();
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          MunchToast.show(
            context,
            message: 'Test message',
            duration: const Duration(milliseconds: 100),
          );
        },
        child: const Text('Show Toast'),
      ),
    );
  }
}

class SuccessTestWidget extends StatelessWidget {
  const SuccessTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          MunchToast.success(
            context,
            message: 'Success!',
            duration: const Duration(milliseconds: 100),
          );
        },
        child: const Text('Show Success'),
      ),
    );
  }
}

class ErrorTestWidget extends StatelessWidget {
  const ErrorTestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          MunchToast.error(
            context,
            message: 'Error occurred',
            duration: const Duration(milliseconds: 100),
          );
        },
        child: const Text('Show Error'),
      ),
    );
  }
}
