import 'package:flutter/material.dart';

typedef void RatingChangeCallback(double rating);

class SmoothStarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;
  final Color color;
  final Color borderColor;
  final double size;
  final bool allowHalfRating;
  final IconData filledIconData;
  final IconData halfFilledIconData;
  final IconData
      defaultIconData; //this is needed only when having fullRatedIconData && halfRatedIconData
  final double spacing;
  const SmoothStarRating({
    Key? key,
    this.starCount = 5,
    this.spacing = 0.0,
    this.rating = 0.0,
    required this.defaultIconData,
    required this.onRatingChanged,
    required this.color,
    required this.borderColor,
    this.size = 25,
    required this.filledIconData,
    required this.halfFilledIconData,
    this.allowHalfRating = true,
  }) : super(key: key);

  Widget buildStar(BuildContext context, int index) {
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        defaultIconData,
        color: borderColor,
        size: size,
      );
    } else if (index > rating - (allowHalfRating ? 0.5 : 1.0) &&
        index < rating) {
      icon = Icon(
        halfFilledIconData,
        color: color,
        size: size,
      );
    } else {
      icon = Icon(
        filledIconData,
        color: color,
        size: size,
      );
    }

    return GestureDetector(
      onTap: () {
        onRatingChanged(index + 1.0);
      },
      onHorizontalDragUpdate: (dragDetails) {
        RenderBox? box = context.findRenderObject() as RenderBox?;
        var _pos = box!.globalToLocal(dragDetails.globalPosition);
        var i = _pos.dx / size;
        var newRating = allowHalfRating ? i : i.round().toDouble();
        if (newRating > starCount) {
          newRating = starCount.toDouble();
        }
        if (newRating < 0) {
          newRating = 0.0;
        }

        onRatingChanged(newRating);
      },
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Wrap(
          alignment: WrapAlignment.start,
          spacing: spacing,
          children:
              List.generate(starCount, (index) => buildStar(context, index))),
    );
  }
}
