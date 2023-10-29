import 'dart:convert';

import 'package:amazone_clone/api/meeting_api.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/meeting/join_meeting_screen.dart';
import 'package:amazone_clone/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class MeetingScreen extends StatefulWidget {
  static const String routeName = 'meeting-screen';
  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  static final GlobalKey<FormState> meetingFormKey = GlobalKey<FormState>();

  String meetingId = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meeting App"),
        backgroundColor: GlobalVariable.primaryColor,
      ),
      body: Form(key: meetingFormKey, child: formUI()),
    );
  }

  formUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(children: [
          const Text(
            'Welcome to Meeting',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 25),
          ),
          const SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(
              context, "meetingId", "Enter your Meeting Id", (value) {
            if (value.isEmpty) {
              return 'Meeting Id cannot be empty';
            }
            return null;
          }, (onSaved) {
            meetingId = onSaved;
          },
              borderRadius: 10,
              borderFocusColor: GlobalVariable.primaryColor,
              borderColor: GlobalVariable.primaryColor,
              hintColor: Colors.grey),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  child: FormHelper.submitButton("Join Meeting", () {
                if (validateAndSave()) {
                  validateMeeting(meetingId);
                }
              })),
              Flexible(
                  child: FormHelper.submitButton("Start Meeting", () async {
                var res = await startMeeting();
                final body = jsonDecode(res!.body);
                final meetingId = body['data'];
                validateMeeting(meetingId);
              })),
            ],
          )
        ]),
      ),
    );
  }

  void validateMeeting(String meetingId) async {
    try {
      Response response = await joinMeeting(meetingId);
      var data = json.decode(response.body);
      final meeting = Meeting.fromJson(data['data']);
      goToJoinScreen(meeting);
    } catch (e) {
      // ignore: use_build_context_synchronously
      FormHelper.showSimpleAlertDialog(
          context, "Meeting App", "Invalid Meeting Id", "Ok", () {
        Navigator.of(context).pop();
      });
    }
  }

  goToJoinScreen(Meeting meeting) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => JoinMeetingScreen(
                  meeting: meeting,
                )));
  }

  bool validateAndSave() {
    final form = meetingFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }

    return false;
  }
}
