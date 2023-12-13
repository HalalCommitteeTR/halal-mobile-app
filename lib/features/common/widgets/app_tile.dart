import 'package:expansion_tile_group/expansion_tile_group.dart';
import 'package:flutter/material.dart';
import 'package:halal_mobile_app/features/common/widgets/container_app_tile.dart';
import 'package:halal_mobile_app/features/common/widgets/container_leading.dart';
import 'package:halal_mobile_app/theme/halal_app_theme.dart';

class AppTile extends StatefulWidget {
  const AppTile({
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
  State<AppTile> createState() => _AppTileState();
}

class _AppTileState extends State<AppTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return ContainerAppTile(
      padding: widget.subtitle == null
          ? const EdgeInsets.symmetric(
              vertical: 8,
            )
          : null,
      gradient: widget.borderColor != null
          ? LinearGradient(
              stops: const [1 / 69, 1 / 69],
              colors: [widget.borderColor!, Colors.white],
            )
          : null,
      child: ExpansionTileItem(
        isHasTrailing: false,
        leading: widget.leading != null
            ? ContainerLeading(
                child: widget.leading,
              )
            : null,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            runSpacing: 8,
            spacing: 8,
            children: [
              widget.title,
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
        subtitle: widget.subtitle,
        textColor: HalalAppTheme.mainTextColor,
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
