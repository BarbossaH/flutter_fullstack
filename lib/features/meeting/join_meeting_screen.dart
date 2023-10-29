import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/models/meeting.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';

class JoinMeetingScreen extends StatefulWidget {
  final Meeting? meeting;
  const JoinMeetingScreen({super.key, this.meeting});

  @override
  State<JoinMeetingScreen> createState() => _JoinMeetingScreenState();
}

class _JoinMeetingScreenState extends State<JoinMeetingScreen> {
  static final GlobalKey<FormState> meetingFormKey = GlobalKey<FormState>();
  String userName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join Meeting"),
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
          const SizedBox(
            height: 20,
          ),
          FormHelper.inputFieldWidget(context, "userId", "Enter your Name",
              (value) {
            if (value.isEmpty) {
              return 'Name cannot be empty';
            }
            return null;
          }, (onSaved) {
            userName = onSaved;
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
                  child: FormHelper.submitButton("Join", () {
                if (validateAndSave()) {
                  //Meeting:
                }
              })),
            ],
          )
        ]),
      ),
    );
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
