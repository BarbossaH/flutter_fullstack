import 'dart:convert';

import 'package:amazone_clone/common/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpResMsgHandler({
  required http.Response res,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (res.statusCode) {
    case 200:
    case 201:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(res.body)['message']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(res.body)['error']);
      break;
    default:
      showSnackBar(context, (res.body));
  }
}
