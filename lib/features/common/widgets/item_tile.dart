import 'package:flutter/material.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.trailing,
    this.description,
    this.onExpansionChanged,
    this.borderColor,
  }) : super(key: key);

  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final Widget? trailing;
  final Widget? description;
  final void Function(bool)? onExpansionChanged;
  final Color? borderColor;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
        gradient: widget.borderColor != null
            ? LinearGradient(
                stops: const [1 / 69, 1 / 69],
                colors: [widget.borderColor!, Colors.white],
              )
            : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        leading: widget.leading != null
            ? Container(
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
                child: widget.leading,
              )
            : null,
        title: widget.title,
        subtitle: widget.subtitle,
        trailing: widget.trailing,
        children: [
          SizedBox(
            height: 15,
          ),
          if (widget.description != null) widget.description!,
          SizedBox(
            height: 20,
          ),
        ],
        onExpansionChanged: (isExpanded) => setState(() {
          _expanded = isExpanded;
          if (widget.onExpansionChanged != null)
            widget.onExpansionChanged!(isExpanded);
        }),
      ),
    );
  }
}
