import 'package:halal_mobile_app/features/caterings/domain/entities/company_branch.dart';
import 'package:halal_mobile_app/features/items_overview/domain/entities/item.dart';

enum OrderBy {alphabetic, alphabeticReversed, none,}

extension OrderByFilter on OrderBy {
  int compareTo(Item i1, Item i2) {
    switch (this) {
      case OrderBy.alphabetic:
        return i1.name.compareTo(i2.name);
      case OrderBy.alphabeticReversed:
        return i2.name.compareTo(i1.name);
      case OrderBy.none:
        return 0;
    }
  }

  int cateringsCompareTo(CompanyBranch i1, CompanyBranch i2) {
    switch (this) {
      case OrderBy.alphabetic:
        return i1.name.compareTo(i2.name);
      case OrderBy.alphabeticReversed:
        return i2.name.compareTo(i1.name);
      case OrderBy.none:
        return 0;
    }
  }
}