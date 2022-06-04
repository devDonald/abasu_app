import 'package:flutter/material.dart';

class BuyButton extends StatelessWidget {
  const BuyButton({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.4,
      height: 30.4,
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 5.0),
            blurRadius: 15.0,
            color: Colors.red,
          ),
        ],
      ),
      child: Stack(
        children: const [
          Center(
            child: Text(
              'Buy Now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrackButton extends StatelessWidget {
  const TrackButton({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.4,
      height: 20.0,
      margin: const EdgeInsets.only(
        left: 15.0,
        right: 15.0,
        bottom: 16.0,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0.0, 5.0),
            blurRadius: 15.0,
            color: Colors.red,
          ),
        ],
      ),
      child: Stack(
        children: const [
          Center(
            child: Text(
              'Track',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
