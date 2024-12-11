import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double? width;
  final Color? color;
  final Widget? child;
  final double radius;
  final EdgeInsetsGeometry? padding;

  const CustomCard(
      {super.key,
      this.width,
      this.color = Colors.white,
      required this.child,
      this.radius = 15,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      child: Container(
        width: width,
        padding: padding,
        child: child,
      ),
    );
  }
}
