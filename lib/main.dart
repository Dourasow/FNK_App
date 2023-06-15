import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqllite_example/screens/loginForm.dart';
import 'package:sqllite_example/screens/signupForm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    join(await getDatabasesPath(), 'users_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, user_name TEXT, email TEXT, password TEXT)',
      );
    },
    version: 1,
  );

  runApp(MyApp(database: database));
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  final Future<Database> database;

  MyApp({required this.database});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NoteKeeper ',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SigninScreen(
          database: database,
        ),
        initialRoute: '/',
        routes: {
          //   '/': (context) => AuthenticationScreen(database: database),
          '/signup': (context) => SignupScreen(database: database),
          '/signin': (context) => SigninScreen(database: database),
          //   //'/home': (context) => const MyHomePage(),
        });
  }
}
