import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;

  MyButton({this.color, this.textColor, this.buttonText, this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor, fontSize: 25,),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
