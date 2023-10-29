class Meeting {
  String? id;
  String? hostId;
  String? hostName;

  Meeting({this.id, this.hostId, this.hostName});

  factory Meeting.fromJson(dynamic json) {
    return Meeting(
      id: json['id'],
      hostId: json['hostId'],
      hostName: json['hostName'],
    );
  }
}
