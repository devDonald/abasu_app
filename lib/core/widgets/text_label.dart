import 'package:flutter/material.dart';

import '../themes/theme_colors.dart';
import '../themes/theme_text.dart';

class TextLabel extends StatelessWidget {
  TextLabel({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(bottom: 5.0),
      child: RichText(
        text: TextSpan(
          text: (label != null) ? label : '',
          style: const TextStyle(
            color: ThemeColors.primaryGreyColor,
            fontFamily: JanguAskFontFamily.primaryFontNunito,
            fontWeight: JanguAskFontWeight.kBoldText,
            fontSize: 15.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: (label != null) ? '*' : '',
              style: const TextStyle(
                color: ThemeColors.primaryColor,
                fontFamily: JanguAskFontFamily.primaryFontNunito,
                fontWeight: JanguAskFontWeight.kBoldText,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
