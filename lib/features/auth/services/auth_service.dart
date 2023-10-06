// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazone_clone/common/utils/res_msg_handling.dart';
import 'package:amazone_clone/common/utils/snack_bar.dart';
import 'package:amazone_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:amazone_clone/constants/global_variables.dart';

class AuthService {
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String password,
      required String name}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');

      http.Response res = await http.post(
        Uri.parse('$uri/api/auth/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpResMsgHandler(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(
                context, 'Account created! Login with the same credentials');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/auth/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpResMsgHandler(
          res: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Login successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
