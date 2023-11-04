import 'package:car_wash_app/screens/login_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Login Page Widget Test', (WidgetTester tester) async {
    await tester.pumpWidget(const LoginPage());

    expect(find.text('LOGIN'), findsOneWidget);

    await tester.tap(find.text('LOGIN'));

    await tester.pump();

    expect(find.text('Login Failed'), findsOneWidget);
    expect(find.text('Email or password is incorrect'), findsOneWidget);
  });
}
