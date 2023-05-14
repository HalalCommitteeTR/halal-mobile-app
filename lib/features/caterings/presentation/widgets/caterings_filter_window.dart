import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/order_by.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/cuisine_type.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/food_point_type.dart';
import 'package:halal_mobile_app/features/caterings/presentation/blocs/catering_bloc.dart';

class CateringsFilterWindow extends StatefulWidget {
  const CateringsFilterWindow({Key? key}) : super(key: key);

  @override
  State<CateringsFilterWindow> createState() => _CateringsFilterWindowState();
}

class _CateringsFilterWindowState extends State<CateringsFilterWindow> {
  OrderBy orderBy = OrderBy.none;
  Set<CuisineType> cuisineTypeFilter = {};
  Set<FoodPointType> foodPointTypeFilter = {};


  @override
  void initState() {
    super.initState();
    final state = context.read<CateringBloc>().state;
    orderBy = state.orderBy;
    cuisineTypeFilter = Set.of(state.cuisineTypeFilter);
    foodPointTypeFilter = Set.of(state.foodPointTypeFilter);
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


          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // context
                  //     .read<CateringBloc>()
                  //     .add(CateringFilterChanged(
                  //   orderBy: orderBy,
                  // ));
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
