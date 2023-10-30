import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

Future<String> loadMeetingUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var meetingUserId;
  if (preferences.containsKey('meetingUserId')) {
    meetingUserId = preferences.getString('meetingUserId');
  } else {
    meetingUserId = uuid.v4();
    preferences.setString('meetingUserId', meetingUserId);
  }

  return meetingUserId;
}
