import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.title,
    required this.btnColor,
    this.btnTapped,
  });

  final String? title;
  final Color btnColor;
  final btnTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: GFButton(
        onPressed: btnTapped,
        color: btnColor,
        child: Text(
          '${title}',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
