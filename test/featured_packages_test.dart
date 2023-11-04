import 'package:car_wash_app/providers/home_provider.dart';
import 'package:car_wash_app/widgets/featured_packages_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:car_wash_app/screens/details_screen.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('RecomendCard widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: RecomendCard(selectedCategory: Category.all),
        ),
      ),
    );

    expect(find.byType(RecomendCard), findsOneWidget);

    await tester.tap(find.byType(Card).first);
    await tester.pumpAndSettle();

    expect(find.byType(PackageDetailScreen), findsOneWidget);
  });
}
