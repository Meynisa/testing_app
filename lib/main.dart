import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing_app/apple_auth.dart';
import 'package:testing_app/apple_sign_in_available.dart';
import 'package:testing_app/edit_profile.dart';
import 'package:testing_app/login_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // SystemChrome.setEnabledSystemUIOverlays([]);
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseApp.instance;
  final appleSignInAvailable = await AppleSignInAvailable.check();
  runApp(Provider<AppleSignInAvailable>.value(
    value: appleSignInAvailable,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AppleAuth>(
        create: (_) => AppleAuth(),
        child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            debugShowCheckedModeBanner: false,
            home: LoginPage()));
  }
}
