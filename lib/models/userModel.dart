class User {
  final int? id;
  // final String user_id;
  final String user_name;
  final String email;
  final String password;
  // final String con_password;

  User({
    this.id,
    // required this.user_id,
    required this.user_name,
    required this.email,
    required this.password,
    //required this.con_password
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      //  'user_id': user_id,
      'user_name': user_name,
      'email': email,
      'password': password,
      // 'con_password': con_password
    };
  }
}
