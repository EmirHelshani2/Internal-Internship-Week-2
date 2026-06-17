import 'package:flutter_test/flutter_test.dart';
import 'package:registration_form/main.dart';

void main() {
  testWidgets('Registration form screen shows key fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const RegistrationFormApp());

    expect(find.text('Registration Form'), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Role/Status'), findsOneWidget);
  });
}
