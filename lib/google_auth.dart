import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing_app/enum_string.dart';
import 'package:testing_app/login_page.dart';
import 'package:testing_app/profile_screen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<FirebaseUser> signInWithGoogle(BuildContext context) async {
  Scaffold.of(context).showSnackBar(new SnackBar(content: new Text('Sign In')));

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);

  final AuthResult authResult = await _auth.signInWithCredential(credential);
  final FirebaseUser user = authResult.user;

  ProviderDetails providerInfo = new ProviderDetails(user.providerId);

  List<ProviderDetails> providerData = new List<ProviderDetails>();
  providerData.add(providerInfo);

  UserDetails userDetails = new UserDetails(user.providerId, user.displayName,
      user.photoUrl, user.email, providerData);

  Navigator.push(context,
      new MaterialPageRoute(builder: (context) => new ProfileScreen(userDetails, LOGIN_TYPE.GOOGLE)));

  return user;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print('User Sign Out');
}
