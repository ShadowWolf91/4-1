import 'package:flutter/material.dart';
import 'package:lab45/description.dart';
import 'package:lab45/bg.dart';
import 'main.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            FractionallySizedBox(
              heightFactor: 1,
              child: Bg(),
            ),

            Bg(),
            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.3,
              child: Description(),

            ),
          ],
        ),
      ),
    );
  }
}
