import 'package:flutter/material.dart';

class genLoginSignupHeader extends StatelessWidget {
  String headerName;

  genLoginSignupHeader(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(height: 50.0),
          Text(
            headerName,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 40.0),
          ),
          const SizedBox(height: 10.0),
          // Image.asset(
          //   "assets/images/logo.png",
          //  height: 150.0,
          // width: 150.0,
          // ),
          const SizedBox(height: 10.0),
          const Text(
            'NoteKepper App',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black38,
                fontSize: 25.0),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
