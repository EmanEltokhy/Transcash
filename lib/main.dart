import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transcash/screens/getting_started_screen.dart';
import 'package:transcash/screens/home_screen.dart';
import 'package:transcash/screens/recharge_screen/recharge_screen.dart';
import 'package:transcash/shared/bloc_observer.dart';

Future main() async {
  Bloc.observer = MyBlocObserver();
  await Future.delayed(const Duration(seconds: 10));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

var kColorSchema = ColorScheme.fromSeed(seedColor: Colors.teal);
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 195),
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Transcash',
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: true,
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData(fontFamily: GoogleFonts.montserrat().fontFamily).copyWith(
        useMaterial3: true,
        colorScheme: kColorSchema,
        cardTheme: const CardTheme().copyWith(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
          color: kColorSchema.secondaryContainer,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kColorSchema.primaryContainer,
                foregroundColor: kColorSchema.onPrimaryContainer
            )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorSchema.onSecondaryContainer,
            fontSize: 18,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[100]
      ),
      themeMode: ThemeMode.system,
      home: GettingStartedScreen(),
    );
  }
}