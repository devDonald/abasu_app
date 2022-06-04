import 'package:abasu_app/core/themes/theme_colors.dart';
import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags({
    Key? key,
    this.tag,
  }) : super(key: key);

  final String? tag;
  @override
  Widget build(BuildContext context) {
    //limited box
    return Container(
      margin: const EdgeInsets.only(right: 7.5),
      padding: const EdgeInsets.only(
        top: 4.5,
        bottom: 4.5,
        left: 10.5,
        right: 10.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          9.5,
        ),
        color: ThemeColors.whiteTagColor,
      ),
      child: Text(
        tag!,
        maxLines: 1,
        style: TextStyle(fontSize: 13),
        overflow: TextOverflow.fade,
      ),
    );
  }
}
