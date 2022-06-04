import 'package:flutter/material.dart';

class PostLabel extends StatelessWidget {
  const PostLabel({
    Key? key,
    required this.label,
  }) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: Colors.green,
        fontSize: 13.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
