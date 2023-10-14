import 'package:flukit/src/utils/extensions/context.dart';
import 'package:flukit/src/ui/widgets/image.dart';
import 'package:flukit/src/ui/widgets/inputs.dart';
import 'package:flutter/material.dart';

import '../../utils/countries.dart';
import '../../utils/theme.dart';

class FluCountrySelector extends StatelessWidget {
  const FluCountrySelector({
    super.key,
    required this.countries,
    this.exclude = const [],
    this.title,
    this.description,
    this.onCountrySelected,
    this.titleStyle,
    this.descriptionStyle,
    this.padding = const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
    this.flagSize = 60,
    this.flagCornerRadius = 25,
  });

  final String? title;
  final String? description;
  final TextStyle? titleStyle, descriptionStyle;
  final double flagSize, flagCornerRadius;
  final EdgeInsets padding;
  final List<Country> countries, exclude;
  final void Function(Country)? onCountrySelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "Select your country",
            style: TextStyle(
              fontSize: M3FontSizes.headlineMedium,
              fontWeight: FontWeight.bold,
              color: context.colorScheme.onSurface,
            ).merge(titleStyle),
          ),
          const SizedBox(height: 3),
          Text(
            description ??
                "Qui consequatur natus modi saepe sit necessitatibus blanditiis.",
            style: descriptionStyle,
          ),
          FluTextField(
            hint: "Search",
            margin: EdgeInsets.symmetric(vertical: context.height * .025),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: countries.length - exclude.length,
            itemBuilder: (context, index) {
              final Country country = countries[index];

              return Padding(
                padding: EdgeInsets.only(top: index == 0 ? 0 : 15),
                child: Row(
                  children: [
                    FluImage(
                      'icons/flags/png/${country.isoCode.toLowerCase()}.png',
                      package: 'country_icons',
                      imageSource: ImageSources.asset,
                      height: flagSize,
                      square: true,
                      cornerRadius: flagCornerRadius,
                      margin: const EdgeInsets.only(right: 15),
                    ),
                    Expanded(
                      child: Text(
                        country.name,
                        style: const TextStyle(
                          fontSize: M3FontSizes.bodyLarge,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text("+${country.phoneCode}"),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
