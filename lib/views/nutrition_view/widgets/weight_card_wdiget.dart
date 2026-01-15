import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../../theme_data/palette.dart';

class WeightCardWdiget extends StatelessWidget {
  const WeightCardWdiget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 4, 14, 10),
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '75',

                style: CustomFontStyle.semiboldText.copyWith(fontSize: 40),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'kg',
                  style: CustomFontStyle.semiboldText.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Image.asset(AssetIcons.up, width: 18),
              SizedBox(width: 4),
              Text(
                '+1.6kg',
                style: CustomFontStyle.regularText.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Palette.greyColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 38),
          Text(
            'Weight',
            style: CustomFontStyle.boldText.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
