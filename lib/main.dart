import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:motokar/screens/splash/splash_screen.dart';
import 'package:motokar/app/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeLocator();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      'pk_test_51KGtMyBU2AN3SjRRht23LjgjMccM9nsFIPzQI4bGJS63DOJYVDAtbaGFwNBvKni8rdLs7IhBisLVAMzqXGjmjg1q005D4FRMTZ';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(253, 121, 168, 1),
      100: Color.fromRGBO(253, 121, 168, 1),
      200: Color.fromRGBO(253, 121, 168, 1),
      300: Color.fromRGBO(253, 121, 168, 1),
      400: Color.fromRGBO(253, 121, 168, 1),
      500: Color.fromRGBO(253, 121, 168, 1),
      600: Color.fromRGBO(253, 121, 168, 1),
      700: Color.fromRGBO(253, 121, 168, 1),
      800: Color.fromRGBO(253, 121, 168, 1),
      900: Color.fromRGBO(253, 121, 168, 1),
    };

    MaterialColor colorCustom = MaterialColor(0xFD79A8, color);

    return MaterialApp(
      title: 'MotoKar',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashView(),
    );
  }
}
