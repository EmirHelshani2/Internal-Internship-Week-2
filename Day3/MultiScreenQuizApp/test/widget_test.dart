import 'package:flutter_test/flutter_test.dart';
import 'package:multi_screen_quiz_app/main.dart';

void main() {
  testWidgets('Quiz screen shows question and answers', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MultiScreenQuizApp());

    expect(find.text('Multi-screen Quiz App'), findsOneWidget);
    expect(find.text('Question 1 of 5'), findsOneWidget);
    expect(find.text('Current score: 0'), findsOneWidget);
  });
}
