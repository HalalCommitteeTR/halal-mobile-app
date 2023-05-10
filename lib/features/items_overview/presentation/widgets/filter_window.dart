import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/permissiveness_badge.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

import 'package:halal_mobile_app/features/items_overview/presentation/bloc/items_overview_bloc.dart';

class FilterWindow extends StatefulWidget {
  const FilterWindow({Key? key}) : super(key: key);

  @override
  State<FilterWindow> createState() => _FilterWindowState();
}

class _FilterWindowState extends State<FilterWindow> {
  OrderBy orderBy = OrderBy.none;
  Set<Permissiveness> permissivenessFilter = {};
  
  @override
  void initState() {
    super.initState();
    final state = context.read<ItemsOverviewBloc>().state;
    orderBy = state.orderBy;
    permissivenessFilter = Set.of(state.permissivenessFilter);
  }

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
                permissivenessFilter.add(
                  Permissiveness.halal,
                );
              } else if (permissivenessFilter.contains(Permissiveness.halal)) {
                permissivenessFilter.remove(Permissiveness.halal);
              }
              setState(() {});
            },
            selected: permissivenessFilter.contains(Permissiveness.halal),
          ),
          SizedBox(
            height: 5,
          ),
          PermissivenessBadge(
            permissiveness: Permissiveness.haram,
            onSelected: (value) {
              if (value) {
                permissivenessFilter.add(
                  Permissiveness.haram,
                );
              } else if (permissivenessFilter.contains(Permissiveness.haram)) {
                permissivenessFilter.remove(Permissiveness.haram);
              }
              setState(() {});
            },
            selected: permissivenessFilter.contains(Permissiveness.haram),
          ),
          SizedBox(
            height: 5,
          ),
          PermissivenessBadge(
            permissiveness: Permissiveness.doubtful,
            onSelected: (value) {
              if (value) {
                permissivenessFilter.add(
                  Permissiveness.doubtful,
                );
              } else if (permissivenessFilter
                  .contains(Permissiveness.doubtful)) {
                permissivenessFilter.remove(Permissiveness.doubtful);
              }
              setState(() {});
            },
            selected: permissivenessFilter.contains(Permissiveness.doubtful),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  context
                      .read<ItemsOverviewBloc>()
                      .add(ItemsOverviewFilterChanged(
                        filter: context
                            .read<ItemsOverviewBloc>()
                            .state
                            .itemsViewFilter,
                        permissivenessFilter: permissivenessFilter,
                        orderBy: orderBy,
                      ));
                  Navigator.of(context).pop();
                },
                child: Text('Ok'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}