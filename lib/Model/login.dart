class Login {
  String session_id;
  String user_id;

  Login(this.session_id, this.user_id);

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      json["session_id"] as String,
      json["user_id"] as String,
    );
  }
}
