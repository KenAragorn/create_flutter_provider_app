import 'package:flutter/material.dart';

class EmptyContentWidget extends StatelessWidget {
  final String subtitle1;
  final String message;

  EmptyContentWidget(
      {required Key key, required this.subtitle1, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(subtitle1),
          Text(message),
        ],
      ),
    );
  }
}
