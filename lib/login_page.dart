import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:testing_app/apple_auth.dart';
import 'package:testing_app/apple_sign_in_available.dart';
import 'package:testing_app/bounce_animation.dart';
import 'package:testing_app/delayed_animation.dart';
import 'package:testing_app/enum_string.dart';
import 'package:testing_app/fade_animation.dart';
import 'package:testing_app/fb_auth.dart';
import 'package:testing_app/google_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testing_app/profile_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> _signInWithApple(BuildContext context) async {
    try {
      final authService = Provider.of<AppleAuth>(context, listen: false);
      final user = await authService.signInWithApple();
      print('uid: ${user.uid}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final appleSignInAvailable =
        Provider.of<AppleSignInAvailable>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
                child: Column(children: [
          Container(
              height: 400,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/background.png'),
                      fit: BoxFit.fill)),
              child: Stack(children: [
                Positioned(
                    left: 30,
                    width: 80,
                    height: 200,
                    child: FadeAnimation(
                      delay: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-1.png'))),
                      ),
                    )),
                Positioned(
                    left: 140,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                      delay: 1.3,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/light-2.png'))),
                      ),
                    )),
                Positioned(
                    right: 40,
                    top: 40,
                    width: 80,
                    height: 150,
                    child: FadeAnimation(
                      delay: 1.5,
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/clock.png'))),
                      ),
                    )),
                Positioned(
                    child: FadeAnimation(
                  delay: 1.6,
                  child: Container(
                      margin: EdgeInsets.only(top: 50),
                      child: Center(
                          child: Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40)))),
                )),
              ])),
          Padding(
              padding: EdgeInsets.all(30),
              child: Column(children: [
                FadeAnimation(
                  delay: 1.8,
                  child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromRGBO(143, 148, 251, .2),
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.grey[100]))),
                          child: TextField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Email or Phone Number',
                                hintStyle: TextStyle(color: Colors.grey[400])),
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Colors.grey[100]))),
                            child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    hintStyle:
                                        TextStyle(color: Colors.grey[400]))))
                      ])),
                ),
                SizedBox(height: 30),
                DelayedAnimation(
                  delay: 500,
                  child: BounceAnimation(
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Color.fromRGBO(143, 148, 251, 1),
                              Color.fromRGBO(143, 148, 251, .6),
                            ])),
                        child: Center(
                          child: Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    DelayedAnimation(delay: 500.0, child: Text('Sign In With')),
                    SizedBox(height: 10),
                    Builder(
                        builder: (context) => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DelayedAnimation(
                                  delay: 500.0,
                                  child: IconButton(
                                      icon: Image.asset(
                                          'assets/images/google_logo.png',
                                          height: 20),
                                      onPressed: () => signInWithGoogle(context)
                                          .then((FirebaseUser user) =>
                                              print(user))
                                          .catchError((e) => print(e))),
                                ),
                                SizedBox(height: 10),
                                DelayedAnimation(
                                    delay: 500.0,
                                    child: IconButton(
                                        icon: Icon(FontAwesomeIcons.facebookF, color: Color(0xff4267B2),),
                                        onPressed: null)),
                                SizedBox(height: 10),
                                DelayedAnimation(
                                    delay: 500.0,
                                    child: IconButton(icon: Icon(FontAwesomeIcons.appleAlt, color: Colors.black,), onPressed: appleSignInAvailable
                                        .isAvailable
                                        ? () => _signInWithApple(context)
                                        : null,)),
                              ],
                            )),
                  ],
                ),
                SizedBox(height: 10),
                DelayedAnimation(
                  delay: 500,
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(color: Color.fromRGBO(143, 148, 251, 1)),
                  ),
                )
              ]))
        ]))));
  }
}

class UserDetails {
  final String providerDetails;
  final String userName;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;

  UserDetails(this.providerDetails, this.userName, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  final String providerDetails;
  ProviderDetails(this.providerDetails);
}
