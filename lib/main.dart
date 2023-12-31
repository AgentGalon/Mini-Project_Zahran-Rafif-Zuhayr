import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:car_wash_app/screens/home_screen.dart';
import 'package:car_wash_app/screens/login_screen.dart';
import 'package:car_wash_app/providers/login_provider.dart';
import 'package:car_wash_app/providers/home_provider.dart';
import 'package:car_wash_app/providers/details_screen_provider.dart';
import 'package:car_wash_app/providers/payment_method_provider.dart';
import 'package:car_wash_app/providers/history_provider.dart';
import 'package:car_wash_app/providers/notification_provider.dart';
import 'package:car_wash_app/providers/chatbot_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        ChangeNotifierProvider(create: (context) => DetailScreenProvider()),
        ChangeNotifierProvider(create: (context) => PaymentMethodProvider()),
        ChangeNotifierProvider(create: (context) => HistoryProvider()),
        ChangeNotifierProvider(create: (context) => NotificationProvider()),
        ChangeNotifierProvider(create: (context) => ChatBotProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.red,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        ),
        home: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return authProvider.isLoggedIn
                ? const HomeScreen()
                : const LoginPage();
          },
        ),
      ),
    );
  }
}
