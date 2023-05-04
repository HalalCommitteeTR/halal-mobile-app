import 'package:flutter/material.dart';
import 'package:halal_mobile_app/api/api.dart';
import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/features/items_overview/widgets/permissiveness_badge.dart';
import 'package:halal_mobile_app/theme/halal_app_theme.dart';

class FilterWindow extends StatefulWidget {
  const FilterWindow({Key? key}) : super(key: key);

  @override
  State<FilterWindow> createState() => _FilterWindowState();
}

class _FilterWindowState extends State<FilterWindow> {
  OrderBy orderBy = OrderBy.none;
  Set<Permissiveness> filterPermissiveness = {};

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppLocale.of(context).sortByAlphabet),
          Row(
            children: [
              FilterChip(
                label: Text(
                  'от А до Я',
                ),
                onSelected: (bool value) {
                  if (value) {
                    setState(() {
                      orderBy = OrderBy.alphabetic;
                    });
                  } else if (orderBy == OrderBy.alphabetic) {
                    setState(() {
                      orderBy = OrderBy.none;
                    });
                  }
                },
                selected: orderBy == OrderBy.alphabetic,
              ),
              SizedBox(
                width: 15,
              ),
              FilterChip(
                label: Text(
                  'от Я до А',
                ),
                onSelected: (value) {
                  if (value) {
                    setState(() {
                      orderBy = OrderBy.alphabeticReversed;
                    });
                  } else if (orderBy == OrderBy.alphabeticReversed) {
                    setState(() {
                      orderBy = OrderBy.none;
                    });
                  }
                },
                selected: orderBy == OrderBy.alphabeticReversed,
              ),
            ],
          ),
          Text(AppLocale.of(context).filter),
          SizedBox(
            height: 15,
          ),
          PermissivenessBadge(
            permissiveness: Permissiveness.halal,
            onSelected: (value) {
              if (value) {
                filterPermissiveness.add(
                  Permissiveness.halal,
                );
              } else if (filterPermissiveness.contains(Permissiveness.halal)) {
                filterPermissiveness.remove(Permissiveness.halal);
              }
              setState(() {});
            },
            selected: filterPermissiveness.contains(Permissiveness.halal),
          ),
          SizedBox(
            height: 5,
          ),
          PermissivenessBadge(
            permissiveness: Permissiveness.haram,
            onSelected: (value) {
              if (value) {
                filterPermissiveness.add(
                  Permissiveness.haram,
                );
              } else if (filterPermissiveness.contains(Permissiveness.haram)) {
                filterPermissiveness.remove(Permissiveness.haram);
              }
              setState(() {});
            },
            selected: filterPermissiveness.contains(Permissiveness.haram),
          ),
          SizedBox(
            height: 5,
          ),
          PermissivenessBadge(
            permissiveness: Permissiveness.doubtful,
            onSelected: (value) {
              if (value) {
                filterPermissiveness.add(
                  Permissiveness.doubtful,
                );
              } else if (filterPermissiveness
                  .contains(Permissiveness.doubtful)) {
                filterPermissiveness.remove(Permissiveness.doubtful);
              }
              setState(() {});
            },
            selected: filterPermissiveness.contains(Permissiveness.doubtful),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text('Ok'),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel')),
            ],
          ),
        ],
      ),
    );
  }
}

enum OrderBy {
  alphabetic,
  alphabeticReversed,
  none,
}
