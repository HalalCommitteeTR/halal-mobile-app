import 'package:flutter/material.dart';
import 'package:halal_mobile_app/app_locale.dart';

class CateringsPage extends StatelessWidget {
  const CateringsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
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
                      Icons.search,
                      size: 26,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Icon(
                  Icons.read_more,
                  size: 26,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
