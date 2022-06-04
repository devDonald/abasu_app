import 'package:flutter/material.dart';

class ArtisanItemsCard extends StatelessWidget {
  final String? item;
  final IconData? icon;
  final Function()? onTap;

  const ArtisanItemsCard({Key? key, this.item, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 3.0,
        left: 3.0,
        right: 3.0,
        bottom: 3.0,
      ),
      padding: const EdgeInsets.only(
        left: 3.0,
        right: 3.0,
        top: 3.0,
        bottom: 3.0,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5.0,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(
              0.0,
              2.5,
            ),
            blurRadius: 8.0,
            color: Colors.white60,
          )
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.green,
        ),
        title: Text(
          '$item',
          textScaleFactor: 1.0,
        ),
        onTap: onTap!,
      ),
    );
  }
}
