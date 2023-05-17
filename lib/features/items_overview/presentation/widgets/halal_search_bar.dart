import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/halal_icons.dart';

import 'package:halal_mobile_app/logger/logger.dart';

class HalalSearchBar extends StatefulWidget {
  const HalalSearchBar({
    Key? key,
    required this.filterWindow,
    this.search,
  }) : super(key: key);
  final void Function(String searchString)? search;
  final Widget filterWindow;

  @override
  State<HalalSearchBar> createState() => _HalalSearchBarState();
}

class _HalalSearchBarState extends State<HalalSearchBar> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
    controller.addListener(_searchListener);
  }

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
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: TextField(
                  controller: controller,
                  // maxLines: 1,
                  onSubmitted: (String searchString) {
                    logger.i('Submitted searchString $searchString');
                    if (widget.search != null) widget.search!(searchString);
                  },
                  decoration: InputDecoration(
                    hintText: AppLocale.of(context).search,
                    iconColor: Theme.of(context).unselectedWidgetColor,
                    icon: Icon(
                      HalalIcons.search,
                      size: 18,
                    ),
                    suffixIconColor: Theme.of(context).unselectedWidgetColor,
                    // suffixIcon: Icon(Icons.close),
                    suffixIcon: controller.text.length > 0
                        ? IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              controller.clear();
                              if (widget.search != null) widget.search!('');
                            },
                            // splashRadius: 2,
                          )
                        : SizedBox(),
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
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => widget.filterWindow,
                    enableDrag: true,
                    useSafeArea: true,
                    // showDragHandle: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                    ),

                    // constraints: BoxConstraints.loose(
                    //   Size.fromHeight(
                    //     MediaQuery.of(context).size.height * 0.75,
                    //   ),
                    // ),
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

  @override
  void dispose() {
    controller.removeListener(_searchListener);
    controller.dispose();
    super.dispose();
  }

  void _searchListener() {
    if (controller.text.length <= 1) {
      setState(() {});
    }
  }
}
