import 'package:fitness_app_ui/theme_data/fonts.dart';
import 'package:fitness_app_ui/theme_data/palette.dart';
import 'package:flutter/material.dart';

class HydrationCardWidget extends StatelessWidget {
  const HydrationCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Palette.secondaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      crossAxisAlignment: .start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0%',
                          style: CustomFontStyle.semiboldText.copyWith(
                            color: Palette.blueColor,
                            fontSize: 40,
                            height: 0,
                          ),
                        ),

                        SizedBox(height: 43),

                        Text(
                          'Hydration',
                          style: CustomFontStyle.boldText.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Log Now',
                          style: CustomFontStyle.regularText.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Palette.greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      crossAxisAlignment: .end,
                      children: [
                        Column(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Text(
                              '2 L',
                              style: CustomFontStyle.semiboldText.copyWith(
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              '0 L',
                              style: CustomFontStyle.semiboldText.copyWith(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: SizedBox(
                              width: 120,
                              child: Column(
                                mainAxisAlignment: .center,
                                crossAxisAlignment: .start,
                                children:
                                    List.generate(
                                          11,
                                          (index) => _buildWaterLevelIndicator(
                                            index == 0 ||
                                                index == 5 ||
                                                index == 10,
                                            index == 10,
                                          ),
                                        )
                                        .expand(
                                          (element) => [
                                            element,
                                            SizedBox(height: 10),
                                          ],
                                        )
                                        .toList()
                                      ..removeLast(),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 8),
                        Text(
                          '0ml',
                          style: CustomFontStyle.semiboldText.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: Palette.parrotColor),
            child: Center(
              child: Text(
                '500 ml added to water log',
                style: CustomFontStyle.regularText.copyWith(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildWaterLevelIndicator(bool fullDivision, bool displayLevel) {
  return Row(
    crossAxisAlignment: .center,
    children: [
      Container(
        width: fullDivision ? 10 : 5,
        height: fullDivision ? 4 : 2,
        decoration: BoxDecoration(
          color: fullDivision
              ? Palette.blueColor
              : Palette.blueColor.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      if (displayLevel) Expanded(child: Divider(height: 1, thickness: 1)),
    ],
  );
}
