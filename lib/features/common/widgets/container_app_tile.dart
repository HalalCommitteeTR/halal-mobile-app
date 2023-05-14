import 'package:flutter/material.dart';

class ContainerAppTile extends StatelessWidget {
  const ContainerAppTile({
    Key? key,
    this.padding,
    this.gradient,
    this.child,
  }) : super(key: key);
  final EdgeInsets? padding;
  final Gradient? gradient;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(119, 211, 153, 0.05),
            blurRadius: 10,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Color.fromRGBO(119, 211, 153, 0.1),
            blurRadius: 50,
            spreadRadius: 0,
          ),
        ],
        gradient: gradient,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
