import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final btnColor;
  final textColor;
  final String buttonText;
  final buttonTapped;

  const MyButton({super.key, 
    required this.btnColor,
    required this.textColor,
    required this.buttonText,
    required this.buttonTapped,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(20.0),
          child: Container(
            color: btnColor,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
