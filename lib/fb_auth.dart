import 'dart:convert';
import 'package:testing_app/enum_string.dart';
import 'package:testing_app/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:testing_app/login_page.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

final fbLogin = FacebookLogin();

Future<UserDetails> signInWithFacebook(BuildContext context) async {
  final FacebookLoginResult result = await fbLogin.logIn(['email']);
  final String token = result.accessToken.token;
  final response = await http.get(
      'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,picture,email&access_token=${token}');
  final profile = jsonDecode(response.body);
  print('profile fb: $profile, ${profile['picture']['data']['url']}');

  ProviderDetails providerInfo = new ProviderDetails(profile['id']);

  List<ProviderDetails> providerData = new List<ProviderDetails>();
  providerData.add(providerInfo);

  UserDetails userDetails = new UserDetails(profile['id'], profile['name'],
      profile['picture']['data']['url'], profile['email'], providerData);

  Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) =>
              ProfileScreen(userDetails, LOGIN_TYPE.FACEBOOK)));

  return userDetails;
}

void signOutFacebook() async {
  await fbLogin.logOut();

  print('User Sign Out');
}
