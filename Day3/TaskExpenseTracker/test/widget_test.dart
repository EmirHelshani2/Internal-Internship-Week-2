import 'package:flutter_test/flutter_test.dart';
import 'package:task_expense_tracker/main.dart';

void main() {
  testWidgets('Tracker app shows summary and action button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TaskExpenseTrackerApp());

    expect(find.text('Task/Expense Tracker'), findsOneWidget);
    expect(find.text('Add Item'), findsOneWidget);
    expect(find.text('Items: 2'), findsOneWidget);
  });
}
