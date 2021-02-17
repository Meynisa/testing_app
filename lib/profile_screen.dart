import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testing_app/enum_string.dart';
import 'package:testing_app/fb_auth.dart';
import 'package:testing_app/google_auth.dart';
import 'package:testing_app/login_page.dart';

class ProfileScreen extends StatefulWidget {
  final UserDetails userDetails;
  final LOGIN_TYPE login_type;

  ProfileScreen(this.userDetails, this.login_type);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.userDetails.userName),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                icon: Icon(FontAwesomeIcons.signOutAlt),
                onPressed: () {
                  widget.login_type == LOGIN_TYPE.GOOGLE ? signOutGoogle() : signOutFacebook();
                  Navigator.pop(context);
                })
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(widget.userDetails.photoUrl),
                radius: 50.0,
              ),
              SizedBox(height: 10.0),
              Text(
                "Name : " + widget.userDetails.userName,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Email : " + widget.userDetails.userEmail,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0),
              ),
              SizedBox(height: 10.0),
              Text(
                "Provider : " + widget.userDetails.providerDetails,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20.0),
              ),
            ],
          ),
        ));
  }
}
