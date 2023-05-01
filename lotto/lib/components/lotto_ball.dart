import 'package:flutter/material.dart';

class LottoBall extends StatelessWidget {
  final int number;
  const LottoBall({required this.number, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getColor(number),
        borderRadius: BorderRadius.circular(50),
      ),
      width: 50,
      height: 50,
      child: Center(
          child: Text(
        '$number',
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black),
      )),
    );
  }
}

Color _getColor(int number) {
  if (number <= 10) {
    return Colors.yellow.shade600;
  } else if (number <= 20) {
    return Colors.blue;
  } else if (number <= 30) {
    return Colors.red;
  } else if (number <= 40) {
    return Colors.grey;
  } else {
    return Colors.green;
  }
}
