import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/halal_icons.dart';

import 'package:halal_mobile_app/features/items_overview/presentation/widgets/filter_window.dart';

class HalalSearchBar extends StatefulWidget {
  const HalalSearchBar({Key? key}) : super(key: key);

  @override
  State<HalalSearchBar> createState() => _HalalSearchBarState();
}

class _HalalSearchBarState extends State<HalalSearchBar> {
  // TODO - callback to make a search
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 53,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: AppLocale.of(context).search,
                    iconColor: Theme.of(context).unselectedWidgetColor,
                    icon: Icon(
                      HalalIcons.search,
                      size: 18,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 13,
            child: Card(
              child: IconButton(
                padding: EdgeInsets.zero,
                iconSize: 16,
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => FilterWindow(),
                  );
                },
                icon: SvgPicture.asset('assets/icons/filter.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
