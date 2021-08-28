import 'package:flutter/material.dart';
import 'package:Sociio/common/styles.dart';

class OnlineIndicator extends StatelessWidget {
  final double width;
  final double height;

  const OnlineIndicator({Key key, this.width = 14.0, this.height = 14.0})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
    );
  }
}
