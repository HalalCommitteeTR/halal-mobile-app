import 'package:flutter/material.dart';

import 'package:halal_mobile_app/api/api.dart';
import 'package:halal_mobile_app/app_locale.dart';

class PermissivenessBadge extends StatefulWidget {
  const PermissivenessBadge({
    Key? key,
    required this.permissiveness,
    this.onSelected,
    this.selected = false,
    this.padding,
  }) : super(key: key);

  final Permissiveness permissiveness;
  final void Function(bool)? onSelected;
  final bool selected;
  final EdgeInsets? padding;

  @override
  State<PermissivenessBadge> createState() => _PermissivenessBadgeState();
}

class _PermissivenessBadgeState extends State<PermissivenessBadge> {
  Color get _textColor {
    switch (widget.permissiveness) {
      case Permissiveness.haram:
        return const Color.fromRGBO(109, 20, 16, 0.6);
      case Permissiveness.halal:
        return const Color.fromRGBO(17, 109, 51, 0.6);
      case Permissiveness.doubtful:
        return const Color.fromRGBO(17, 46, 82, 0.6);
    }
  }

  Color get _backgroundColor {
    switch (widget.permissiveness) {
      case Permissiveness.haram:
        return const Color.fromRGBO(181, 34, 27, 0.1);
      case Permissiveness.halal:
        return const Color.fromRGBO(17, 109, 51, 0.1);
      case Permissiveness.doubtful:
        return const Color.fromRGBO(28, 76, 137, 0.1);
    }
  }

  String _name(BuildContext context) {
    switch (widget.permissiveness) {
      case Permissiveness.haram:
        return AppLocale.of(context).haram;
      case Permissiveness.halal:
        return AppLocale.of(context).halal;
      case Permissiveness.doubtful:
        return AppLocale.of(context).doubtful;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(
        _name(context),
        style: TextStyle(
          color: _textColor,
        ),
      ),
      backgroundColor: _backgroundColor,
      labelPadding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      padding: widget.padding ?? EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      disabledColor: _backgroundColor,
      tapEnabled: true,
      onSelected: widget.onSelected,
      selected: widget.selected,
    );
  }
}
