import 'package:flutter/material.dart';

class ButtonWithText extends StatelessWidget {
  final String text;
  final Color textColor;
  final Widget plusIcon;
  final VoidCallback onPressed;

  const ButtonWithText({
    Key? key,
    required this.text,
    required this.textColor,
    required this.plusIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 45,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          padding: EdgeInsets.fromLTRB(6.0, 6.0, 3, 6.0),
          side: BorderSide(color: Colors.black.withOpacity(0.5)),
          shadowColor: const Color(0x3F000000),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            plusIcon, // Ícono
            const SizedBox(width: 5),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
