import 'package:flutter/material.dart';

class EventButton extends StatelessWidget {
  const EventButton({
    Key? key,
    this.icon,
    this.title,
    this.onTap,
    this.viewAll,
  }) : super(key: key);
  final IconData? icon;
  final String? title, viewAll;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      margin: const EdgeInsets.only(
        top: 8.5,
        bottom: 8.5,
      ),
      padding: const EdgeInsets.only(left: 15.0),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          const BoxShadow(
            color: Colors.grey,
            offset: const Offset(0.0, 2.5),
            blurRadius: 7.5,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(width: 9.2),
                Text(
                  title!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                viewAll!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
