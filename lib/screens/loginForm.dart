import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqllite_example/screens/homeForm.dart';
import 'package:sqllite_example/comm/genLoginSignupHeader.dart';
import 'package:sqllite_example/comm/genTextFormField.dart';
import 'package:sqllite_example/screens/signupForm.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatelessWidget {
  final Future<Database> database;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conEmail = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();

  SigninScreen({required this.database});

  void signIn(BuildContext context) async {
    final db = await database;
    String user_name = _conUserName.text;
    String password = _conPassword.text;

    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'user_name = ? AND password = ?',
      whereArgs: [user_name, password],
    );

    getLoginUser(String username, String passwrd) {
      var dbClient = db;
      var res = dbClient.rawQuery("SELECT * FROM $users WHERE "
          "$user_name = '$username' AND "
          "$password = '$passwrd'");

      // if (res.length > 0) {
      //   return users.fromMap(res.first);
      // }

      // return null;
    }
  }

  // login() async {
  //   String userName = _conUserName.text;
  //   String passwd = _conPassword.text;
  //   var users;
  //   if (userName.isEmpty) {
  //     // alertDialog(context as BuildContext, "Please Enter User Name");
  //     print("sow");
  //   } else if (passwd.isEmpty) {
  //     // alertDialog(context as BuildContext, "Please Enter Password");
  //     print("abdul");
  //   } else {
  //     await getLoginUser(userName, passwd).then((users) {
  //       if (users != null) {
  //         (users).whenComplete(() {
  //           Navigator.pushAndRemoveUntil(
  //               context as BuildContext,
  //               MaterialPageRoute(builder: (_) => const MyHomePage()),
  //               (Route<dynamic> route) => false);
  //         });
  //       } else {
  //         alertDialog(context as BuildContext, "Error: User Not Found");
  //       }
  //     }).catchError((error) {
  //       print(error);
  //       alertDialog(context as BuildContext, "Error: Login Fail");
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                genLoginSignupHeader('Login'),
                getTextFormField(
                    controller: _conUserName,
                    icon: Icons.person,
                    hintName: 'User Name'),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextButton(
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                    // onPressed: login
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const MyHomePage()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Do not have an account? '),
                      TextButton(
                        // style: TextStyle(color: Colors.blue)),
                        child: Text('Signup'),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => SignupScreen(
                                        database: database,
                                      )));
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
