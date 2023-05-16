import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/cuisine_type.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/food_point_type.dart';
import 'package:halal_mobile_app/features/caterings/presentation/widgets/type_chip.dart';
import 'package:halal_mobile_app/features/items_overview/presentation/widgets/permissiveness_badge.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/permissiveness.dart';

import 'package:halal_mobile_app/features/items_overview/presentation/bloc/items_overview_bloc.dart';
import 'package:halal_mobile_app/logger/logger.dart';
import 'package:halal_mobile_app/theme/halal_app_theme.dart';

import '../blocs/catering_bloc.dart';

class CateringsFilterWindow extends StatefulWidget {
  const CateringsFilterWindow({Key? key}) : super(key: key);

  @override
  State<CateringsFilterWindow> createState() => _CateringsFilterWindowState();
}

class _CateringsFilterWindowState extends State<CateringsFilterWindow> {
  late OrderBy orderBy;
  late Set<FoodPointType> foodPointTypeFilter;
  late Set<CuisineType> cuisineTypeFilter;
  late bool prayerRoomFilter;

  @override
  void initState() {
    super.initState();
    final state = context.read<CateringBloc>().state;
    orderBy = state.orderBy;
    foodPointTypeFilter = Set.of(state.foodPointTypeFilter);
    cuisineTypeFilter = Set.of(state.cuisineTypeFilter);
    prayerRoomFilter = state.prayerRoomFilter;
  }

  void _changeFilter(BuildContext context) {
    context.read<CateringBloc>().add(
          CateringFilterChanged(
            foodPointTypeFilter: Set.of(foodPointTypeFilter),
            cuisineTypeFilter: Set.of(cuisineTypeFilter),
            prayerRoomFilter: prayerRoomFilter,
            orderBy: orderBy,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),

      child: Wrap(
        direction: Axis.vertical,
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
                  _changeFilter(context);
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
                  _changeFilter(context);
                },
                selected: orderBy == OrderBy.alphabeticReversed,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(AppLocale.of(context).prayerRoomAvailability + ':'),
          SizedBox(
            height: 15,
          ),
          TypeChip(
            label: AppLocale.of(context).prayerRoom,
            backgroundColor: HalalAppTheme.halalBackgroundColor,
            textColor: HalalAppTheme.halalTextColor,
            selected: prayerRoomFilter,
            onSelected: (bool value) {
              setState(() {
                prayerRoomFilter = value;
              });
              _changeFilter(context);
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text(AppLocale.of(context).cateringType + ':'),
          SizedBox(
            height: 15,
          ),
          Wrap(
            direction: Axis.vertical,
            spacing: 10,
            children: [
              for (int index = 0;
                  index < FoodPointType.values.length;
                  ++index)
                TypeChip(
                  label: FoodPointType.values[index].getString(context),
                  backgroundColor: HalalAppTheme.doubtfulBackgroundColor,
                  textColor: HalalAppTheme.doubtfulTextColor,
                  selected: foodPointTypeFilter
                      .contains(FoodPointType.values[index]),
                  onSelected: (value) {
                    if (value &&
                        !foodPointTypeFilter
                            .contains(FoodPointType.values[index])) {
                      foodPointTypeFilter.add(FoodPointType.values[index]);
                    } else {
                      foodPointTypeFilter.remove(FoodPointType.values[index]);
                    }
                    setState(() {});
                    _changeFilter(context);
                  },
                ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(AppLocale.of(context).cuisineType + ':'),
          SizedBox(
            height: 15,
          ),
          Wrap(
            direction: Axis.vertical,
            spacing: 10,
            children: [
              for (int index = 0; index < CuisineType.values.length; ++index)
                TypeChip(
                  label: CuisineType.values[index].getString(context),
                  backgroundColor:
                      HalalAppTheme.cuisineTypeChipBackgroundColor,
                  textColor: HalalAppTheme.cuisineTypeChipTextColor,
                  selected:
                      cuisineTypeFilter.contains(CuisineType.values[index]),
                  onSelected: (value) {
                    if (value &&
                        !cuisineTypeFilter
                            .contains(CuisineType.values[index])) {
                      cuisineTypeFilter.add(CuisineType.values[index]);
                    } else {
                      cuisineTypeFilter.remove(CuisineType.values[index]);
                    }
                    setState(() {});
                    _changeFilter(context);
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }
}
