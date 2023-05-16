import 'package:flutter/material.dart';
import 'package:halal_mobile_app/app_locale.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/caterings/domain/entities/cuisine_type.dart';

import 'package:halal_mobile_app/features/common/widgets/container_app_tile.dart';
import 'package:halal_mobile_app/features/common/widgets/container_leading.dart';

import 'package:halal_mobile_app/theme/halal_app_theme.dart';

class CateringTile extends StatelessWidget {
  const CateringTile({
    Key? key,
    required this.companyBranch,
  }) : super(key: key);
  final CompanyBranch companyBranch;

  @override
  Widget build(BuildContext context) {
    return ContainerAppTile(
      child: Column(
        children: [
          ListTile(
            title: Text(companyBranch.name),
            subtitle: Text(
              '${companyBranch.districtSettlementName ?? ''}, ${companyBranch.street ?? ''} ${companyBranch.building ?? ''}',
              style: TextStyle(
                color: HalalAppTheme.mainTextColor,
              ),
            ),
            leading: ContainerLeading(
              child: companyBranch.imageSource != null
                  ? Image.network(
                      companyBranch.imageSource!,
                    )
                  : const Icon(Icons.emoji_food_beverage_rounded),
            ),
            // trailing: Icon(Icons.ice_skating),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              bottom: 10.0,
            ),
            child: Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: [
                RawChip(
                  label: Text(
                    companyBranch.foodPointType.getString(context),
                    style: TextStyle(color: HalalAppTheme.doubtfulTextColor),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: HalalAppTheme.doubtfulBackgroundColor,
                ),
                RawChip(
                  label: Text(
                    companyBranch.cuisineType.getString(context),
                    style: TextStyle(
                      color: HalalAppTheme.cuisineTypeChipTextColor,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  backgroundColor: HalalAppTheme.cuisineTypeChipBackgroundColor,
                ),
                // TODO: this field should be non nullable
                if (companyBranch.isPrayerRoomExist!)
                  RawChip(
                    label: Text(
                      AppLocale.of(context).prayerRoom,
                      style: TextStyle(
                        color: HalalAppTheme.halalTextColor,
                      ),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    backgroundColor: HalalAppTheme.halalBackgroundColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
