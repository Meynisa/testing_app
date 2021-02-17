import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AppleAuth{
  final _firebaseAuth = FirebaseAuth.instance;

  Future<FirebaseUser> signInWithApple({List<Scope> scopes = const []}) async{
    final result = await AppleSignIn.performRequests([AppleIdRequest(requestedScopes: scopes)]);

    switch(result.status){
      case AuthorizationStatus.authorized:
        final appleIdCredential = result.credential;
        final oAuthProvider = OAuthProvider(providerId: 'apple.com');
        final credential = oAuthProvider.getCredential(idToken: String.fromCharCodes(appleIdCredential.identityToken),
        accessToken: String.fromCharCodes(appleIdCredential.authorizationCode));
        final authResult = await _firebaseAuth.signInWithCredential(credential);
        final firebaseUser = authResult.user;
        if(scopes.contains(Scope.fullName)){
          final displayName = '${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}';

          UserUpdateInfo userUpdateInfo = UserUpdateInfo();
          userUpdateInfo.displayName = displayName;

          await firebaseUser.updateProfile(userUpdateInfo);
        }
        return firebaseUser;
      case AuthorizationStatus.error:
        throw PlatformException(
          code: 'ERROR_AUTHORIZATION_DENIED',
          message: result.error.toString()
        );
      case AuthorizationStatus.cancelled:
        throw PlatformException(
          code: 'ERROR_ABORTED_BY_USER',
          message: 'Sign in aborted by User'
        );
      default:
        throw UnimplementedError();
    }
  }
}