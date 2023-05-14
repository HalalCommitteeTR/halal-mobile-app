import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/halal_icons.dart';

class LogoBar extends StatelessWidget {
  const LogoBar({
    Key? key,
    required this.onSettingsPressed,
    this.actionAsset = 'assets/icons/settings-icon.svg',
  }) : super(key: key);

  final void Function() onSettingsPressed;
  final String actionAsset;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: 50,
                width: 50,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                AppLocale.of(context).title,
                style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontFamily: 'RobotoSlab',
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
          IconButton(
            onPressed: onSettingsPressed,
            icon: SvgPicture.asset(actionAsset),
          ),
        ],
      ),
    );
  }
}
