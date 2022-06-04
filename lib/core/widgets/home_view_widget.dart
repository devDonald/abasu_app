import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final String? category;
  final String? image, comingSoon;

  const HomeView({Key? key, this.category, this.image, this.comingSoon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.300,
      height: MediaQuery.of(context).size.height * 0.150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            offset: Offset(
              0.0,
              2.5,
            ),
            color: Colors.black12,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
              bottom: 7,
              top: 7,
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Text(
              category!,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Container(
              height: 50.0,
              padding: const EdgeInsets.only(
                top: 8,
                left: 9,
                right: 9,
              ),
              child: Image(
                image: AssetImage(image!),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              comingSoon ?? '',
              style: const TextStyle(
                fontSize: 10,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
