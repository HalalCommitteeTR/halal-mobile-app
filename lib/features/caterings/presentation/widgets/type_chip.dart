import 'package:flutter/material.dart';

class TypeChip extends StatefulWidget {
  const TypeChip({
    Key? key,
    required this.label,
     this.textColor,
     this.backgroundColor,
    this.onSelected,
     this.selected,
  }) : super(key: key);
  final String label;
  final Color? textColor;
  final Color? backgroundColor;
  final void Function(bool)? onSelected;
  final bool? selected;

  @override
  State<TypeChip> createState() => _TypeChipState();
}

class _TypeChipState extends State<TypeChip> {
  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(
        widget.label,
        style: TextStyle(color: widget.textColor),
      ),
      labelPadding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      checkmarkColor: widget.textColor,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      disabledColor: widget.backgroundColor,
      selectedColor: widget.backgroundColor?.withOpacity(0.3),
      tapEnabled: true,
      onSelected: widget.onSelected,
      selected: widget.selected ?? false,
      backgroundColor: widget.backgroundColor,
    );
  }
}
