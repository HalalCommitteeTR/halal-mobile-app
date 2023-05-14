import 'package:flutter/material.dart';

class ContainerLeading extends StatelessWidget {
  const ContainerLeading({Key? key, this.child,}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0, 0),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      constraints: const BoxConstraints.tightFor(
        height: 50,
        width: 50,
      ),
      child: child,
    );
  }
}
