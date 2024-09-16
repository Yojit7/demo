import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  const Screen2 ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Text("Screen2")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
