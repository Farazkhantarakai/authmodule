import 'dart:async';
import 'dart:convert';

import 'package:authmodule/model/httpexception.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? _tokenId;
  DateTime? _expiryDate;
  String? _userId;

  bool get isAuth => token != null;

  get token {
    if (_tokenId != null && _expiryDate != null) {
      if (_expiryDate!.isAfter(DateTime.now())) {
        print(_tokenId);
        return _tokenId;
      }
    }
    return null;
  }

  authenticate(String urlSegment, email, password) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyA0RugQmmuyVMaBcRb4gtun_zhasblGrKc';
    try {
      var response = await http.post(
          Uri.parse(
            url,
          ),
          body: jsonEncode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      // if (kDebugMode) {
      //   print(response.body.toString());
      // }

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        // print(response.body.toString());
        _tokenId = result['idToken'];
        _expiryDate = DateTime.now()
            .add(Duration(seconds: int.parse(result['expiresIn'])));
        _userId = result['localId'];
        // if (kDebugMode) {
        //   print('tokenid $_tokenId  expiry data  $_expiryDate user  $_userId');
        // }

        if (result['error'] != null) {
          throw HttpException(result['error']['message']);
        }
      }

      notifyListeners();
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  signUpUser(String email, String password) async {
    return authenticate('signUp', email, password);
  }

  signInUser(String email, String password) async {
    return authenticate('signInWithPassword', email, password);
  }
}

// Request Body Payload
// Property Name	Type	Description
// email	string	The email for the user to create.
// password	string	The password for the user to create.
// returnSecureToken	boolean	Whether or not to return an ID and refresh token. Should always be true.

// idToken	string	A Firebase Auth ID token for the newly created user.
// email	string	The email for the newly created user.
// refreshToken	string	A Firebase Auth refresh token for the newly created user.
// expiresIn	string	The number of seconds in which the ID token expires.
// localId	string	The uid of the newly created user.