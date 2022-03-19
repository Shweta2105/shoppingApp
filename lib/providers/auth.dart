import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shoppingapp/models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String _userId = '';

  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String? email, String? password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDSp_Xwy55w2_bjWwdu5DXGVR10UolI48A';
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true,
          }));
      print('////////////////////////////auth');
      print(json.decode(response.body)['idToken']);

      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['meaasage']);
      }
      _token = json.decode(response.body)['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(seconds: int.parse(responseData['expiresIn'])),
      );
      print("----_token-------");
      print(_token);
      print("...........response token........");
      print(responseData['idToken']);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String? email, String? password) async {
    return _authenticate(email, password, 'signUp');
    // const url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDSp_Xwy55w2_bjWwdu5DXGVR10UolI48A';
    // final response = await http.post(Uri.parse(url),
    //     body: json.encode({
    //       'email': email,
    //       'password': password,
    //       'returnSecureToken': true,
    //     }));
    // print(json.decode(response.body));
  }

  Future<void> login(String? email, String? password) async {
    return _authenticate(email, password, 'signInWithPassword');
    // const url =
    //     'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyDSp_Xwy55w2_bjWwdu5DXGVR10UolI48A';
    // final response = await http.post(Uri.parse(url),
    //     body: json.encode({
    //       'email': email,
    //       'password': password,
    //       'returnSecureToken': true,
    //     }));
    // print(json.decode(response.body));
  }
}
