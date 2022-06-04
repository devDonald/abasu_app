import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final int notificationCount;

  const Badge({
    Key? key,
    this.onTap,
    required this.iconData,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  color: Colors.black,
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: notificationCount == 0 ? Colors.white : Colors.red),
                alignment: Alignment.center,
                child: Text(notificationCount == 0 ? '' : '$notificationCount'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
