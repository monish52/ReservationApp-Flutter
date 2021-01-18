class UserId {
  final String uid;
  UserId({this.uid});
}

class UserData {
  final String uid;
  final String name;
  final int contactNo;
  final String emailId;
  final DateTime date;
  final String time;

  UserData(
      {this.uid,
      this.name,
      this.contactNo,
      this.emailId,
      this.date,
      this.time});
}
