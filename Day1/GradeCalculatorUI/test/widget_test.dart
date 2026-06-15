import 'package:flutter_test/flutter_test.dart';
import 'package:grade_calculator_ui/main.dart';

void main() {
  testWidgets('Grade calculator screen shows main UI', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const GradeCalculatorApp());

    expect(find.text('Grade Calculator UI'), findsOneWidget);
    expect(find.text('Calculate Average'), findsOneWidget);
    expect(find.text('First grade'), findsOneWidget);
    expect(find.text('Second grade'), findsOneWidget);
    expect(find.text('Third grade'), findsOneWidget);
  });
}
