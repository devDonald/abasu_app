import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';

class UnApprovedPosts extends StatefulWidget {
  const UnApprovedPosts({
    Key? key,
  }) : super(key: key);

  @override
  _UnApprovedPostsState createState() => _UnApprovedPostsState();
}

class _UnApprovedPostsState extends State<UnApprovedPosts> {
  PaginateRefreshedChangeListener refreshChangeListener =
      PaginateRefreshedChangeListener();
  late double _height;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}

class ListItemsCard extends StatelessWidget {
  final String text;
  const ListItemsCard({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 16.0,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              backgroundColor: Colors.pinkAccent,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
