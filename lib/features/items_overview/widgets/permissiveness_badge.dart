import 'package:flutter/material.dart';

import 'package:halal_mobile_app/api/api.dart';
import 'package:halal_mobile_app/app_locale.dart';

class PermissivenessBadge extends StatelessWidget {
  const PermissivenessBadge({Key? key, required this.permissiveness})
      : super(key: key);

  final Permissiveness permissiveness;

  Color get _textColor {
    switch (permissiveness) {
      case Permissiveness.haram:
        return const Color.fromRGBO(109, 20, 16, 0.6);
      case Permissiveness.halal:
        return const Color.fromRGBO(17, 109, 51, 0.6);
      case Permissiveness.doubtful:
        return const Color.fromRGBO(17, 46, 82, 0.6);
    }
  }

  Color get _backgroundColor {
    switch (permissiveness) {
      case Permissiveness.haram:
        return const Color.fromRGBO(181, 34, 27, 0.1);
      case Permissiveness.halal:
        return const Color.fromRGBO(17, 109, 51, 0.1);
      case Permissiveness.doubtful:
        return const Color.fromRGBO(28, 76, 137, 0.1);
    }
  }

  String _name(BuildContext context) {
    switch (permissiveness) {
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
    return Container(
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
      child: Text(
        _name(context),
        style: TextStyle(
          color: _textColor,
        ),
      ),
    );
  }
}
