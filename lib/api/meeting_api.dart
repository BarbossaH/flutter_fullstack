import 'dart:convert';

import 'package:amazone_clone/common/utils/meeting_user_id.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:http/http.dart' as http;

// ignore: non_constant_identifier_names
String MEETING_API_URL = '$uri/api/meeting';

var client = http.Client();

Future<http.Response?> startMeetingAPI() async {
  Map<String, String> reqHeaders = {'Content-Type': 'application/json'};
  var meetingUserId = await loadMeetingUserId();
  var response = await client.post(Uri.parse('$MEETING_API_URL/start'),
      headers: reqHeaders,
      body: jsonEncode({'hostId': meetingUserId, 'hostName': ''}));
  if (response.statusCode == 200) {
    return response;
  } else {
    return null;
  }
}

Future<http.Response> joinMeetingAPI(String meetingId) async {
  var res =
      await http.get(Uri.parse('$MEETING_API_URL/join?meetingId=$meetingId'));
  if (res.statusCode >= 200 && res.statusCode < 400) {
    return res;
  }
  throw UnsupportedError('Nota valid meeting');
}
