import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:sqllite_example/comm/genLoginSignupHeader.dart';
import 'package:sqllite_example/comm/genTextFormField.dart';

import 'package:sqllite_example/screens/loginForm.dart';
import 'package:sqllite_example/models/userModel.dart';

class SignupScreen extends StatelessWidget {
  final Future<Database> database;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _conUserName = TextEditingController();
  final TextEditingController _conEmail = TextEditingController();
  final TextEditingController _conPassword = TextEditingController();

  SignupScreen({required this.database});

  void signUp(BuildContext context) async {
    final db = await database;
    String user_name = _conUserName.text;
    String email = _conEmail.text;
    String password = _conPassword.text;

    User newUser = User(
      user_name: user_name,
      email: email,
      password: password,
    );

    await db.insert(
      'users',
      newUser.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    Navigator.pushReplacementNamed(context, '/signin');
  }

  // @override
  // Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Sign Up'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: emailController,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                 ),
//               ),
//               TextFormField(
//                 controller: passwordController,
//                 obscureText: true,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     signUp(context);
//                   }
//                 },
//                 child: Text('Sign Up'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  genLoginSignupHeader('Signup'),
                  // getTextFormField(
                  //     controller: _conUserId,
                  //     icon: Icons.person,
                  //     hintName: 'User ID'),
                  // SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conUserName,
                      icon: Icons.person_outline,
                      inputType: TextInputType.name,
                      hintName: 'User Name'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                      controller: _conEmail,
                      icon: Icons.email,
                      inputType: TextInputType.emailAddress,
                      hintName: 'Email'),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Password',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  // getTextFormField(
                  //   controller: _conCPassword,
                  //   icon: Icons.lock,
                  //   hintName: 'Confirm Password',
                  //   isObscureText: true,
                  // ),
                  Container(
                    margin: EdgeInsets.all(30.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: TextButton(
                      child: const Text(
                        'SignUp',
                        style: TextStyle(color: Colors.white),
                      ),
                      // onPressed: signUp,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    SigninScreen(database: database)),
                            (Route<dynamic> route) => false);
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Do you have an account? '),
                        TextButton(
                          // textColor: Colors.blue,
                          child: Text('Sign In'),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>
                                        SigninScreen(database: database)),
                                (Route<dynamic> route) => false);
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
