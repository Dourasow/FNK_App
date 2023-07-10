import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqllite_example/comm/genTextFormField.dart';
import 'package:sqllite_example/screens/homeForm.dart';
import 'package:sqllite_example/screens/signupForm.dart';

import '../Comm/comHelper.dart';
import '../comm/genLoginSignupHeader.dart';

class SigninScreen extends StatelessWidget {
  final Future<Database> database;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();

  SigninScreen({required this.database});

  void signIn(BuildContext context) async {
    if (_formKey.currentState == null) {
      return; // Return early if form key is null
    }

    final db = await database;
    String user_name = _conUserName.text;
    String password = _conPassword.text;

    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'user_name = ? AND password = ?',
      whereArgs: [user_name, password],
    );

    Future<Map<String, dynamic>?> getLoginUser(
        String username, String passwrd) async {
      var res = await db.rawQuery("SELECT * FROM users WHERE "
          "user_name = '$username' AND "
          "password = '$passwrd'");

      if (res.length > 0) {
        return users.first;
      }

      return null;
    }

    void login() async {
      String userName = _conUserName.text;
      String passwd = _conPassword.text;

      if (userName.isEmpty) {
        alertDialog(context, "Please Enter User Name");
        print("sow");
      } else if (passwd.isEmpty) {
        alertDialog(context, "Please Enter Password");
        print("abdul");
      } else {
        var users = await getLoginUser(userName, passwd);

        if (users != null) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const MyHomePage()),
            (Route<dynamic> route) => false,
          );
        } else {
          alertDialog(context, "Error: User Not Found");
        }
      }
    }

    login();
  }

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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Login'),
                  getTextFormField(
                    controller: _conUserName,
                    hintName: 'User Name',
                    icon: Icons.person,
                    // decoration: InputDecoration(
                    //   labelText: 'User Name',
                    //   prefixIcon: Icon(Icons.person),
                    // ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    hintName: 'Password',
                    icon: Icons.lock,
                    // decoration: InputDecoration(
                    //   labelText: 'Password',
                    //   prefixIcon: Icon(Icons.lock),

                    //obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
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
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          signIn(context);
                        }
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Do not have an account? '),
                        TextButton(
                          child: Text('Signup'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    SignupScreen(database: database),
                              ),
                            );
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
      ),
    );
  }
}
