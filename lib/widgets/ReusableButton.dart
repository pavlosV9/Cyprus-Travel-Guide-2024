import 'package:flutter/material.dart';

class ReusableButton extends StatelessWidget {
  final int index;
  const ReusableButton(this.index, {Key? key}) : super(key: key);

  static const Color defaultColor = Colors.blueAccent;
  static const Color alternateColor = Color(0xFF5d69b3);

  @override
  Widget build(BuildContext context) {
    // Determine the color based on the index
    final Color buttonColor = index == 1 ? alternateColor : defaultColor;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/CityPage');
      },
      child: Container(
        width: 150,
        height: 50, // Adjusted for a more typical button size
        decoration: BoxDecoration(
          color: buttonColor, // Use the determined color
          borderRadius: BorderRadius.circular(8), // Rounded corners
          boxShadow: const [
            BoxShadow(
              color: Colors.black, // Shadow color
              blurRadius: 5, // Shadow blur radius
              offset: Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Icons.forward_outlined,
            color: Colors.black, // Icon color for better visibility
            size: 35, // Icon size
          ),
        ),
      ),
    );
  }
}
