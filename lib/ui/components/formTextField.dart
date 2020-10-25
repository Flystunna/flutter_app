import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/AppGlobal.dart';

class formTextField extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;
  const formTextField({ Key key, this.child, this.color, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color != null ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
