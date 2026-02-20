import 'package:flutter/material.dart';

class ContainerWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color color;
  final Widget child;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final List<BoxShadow>? boxShadow;

  const ContainerWidget({
    super.key,
    this.height,
    this.width,
    required this.color,
    required this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.border,
    this.padding,
    this.margin,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin?? EdgeInsets.all(8.0),
      padding: padding?? EdgeInsets.all(16.0),
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: borderRadius,
        border: border,
        boxShadow: boxShadow,
      ),
      child: child,
    );
  }
}

class ContainerSmall extends StatelessWidget {
  final double? height;
  final double? width;
  final Color color;
  final BoxBorder border;
  final Widget child;

  const ContainerSmall({
    super.key,
    this.height,
    this.width,
    required this.color,
    required this.border,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border:border
      ),
      child: child,
    );
  }
}