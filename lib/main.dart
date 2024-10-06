import 'package:flutter/material.dart';

import 'package:animated_3d_buttons/animated_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated 3D Buttons',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AnimatedButton(
                  label: 'Save',
                  color: Colors.blueAccent,
                ),
                SizedBox(height: 50),
                AnimatedButton(
                  label: 'LOGOUT',
                  color: Colors.red,
                ),
                SizedBox(height: 50),
                AnimatedButton(
                  label: 'Checkout',
                  color: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
