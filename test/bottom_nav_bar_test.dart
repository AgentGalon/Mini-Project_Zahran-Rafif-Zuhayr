import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:car_wash_app/widgets/bottom_nav_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  testWidgets('BottomNavBar Widget Test', (WidgetTester tester) async {
    int selectedIndex = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: BottomNavBar(
          currentIndex: selectedIndex,
          onTabTapped: (index) {
            selectedIndex = index;
          },
        ),
      ),
    );

    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);
    expect(find.byIcon(Icons.chat), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    await tester.tap(find.widgetWithText(GButton, 'Favorite'));
    await tester.pump();

    expect(selectedIndex, 1);
  });
}
