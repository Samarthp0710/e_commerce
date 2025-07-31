
import 'package:flutter/material.dart';
import 'package:e_commerce/Widgets/banner.dart';
import 'package:e_commerce/Widgets/curated_items.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:e_commerce/Widgets/category.dart';

class CuratedItems extends StatelessWidget {
  final AppModel eCommerceItems;
  final Size size;
  const CuratedItems({
    super.key,
    required this.eCommerceItems,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),image: DecorationImage(image: AssetImage(eCommerceItems.image),
        ),
        ),
      ),
      ],
    );
  }
}
