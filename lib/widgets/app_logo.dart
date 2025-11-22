import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Medical",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(width: 5),
        Text(
          "Book",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade700,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
