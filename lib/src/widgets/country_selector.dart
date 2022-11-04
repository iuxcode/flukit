import 'package:emojis/emojis.dart';
import 'package:flukit/src/utils/flu_utils.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import 'button/index.dart';
import 'input/inputs.dart';
import 'outline.dart';

class FluCountrySelect extends StatefulWidget {
  const FluCountrySelect(
    this.onSelect, {
    Key? key,
    this.title,
    this.desc,
    this.searchInputHint,
  }) : super(key: key);

  final void Function(FluCountryModel) onSelect;
  final String? title, desc, searchInputHint;

  @override
  State<FluCountrySelect> createState() => FluCountrySelectState();
}

class FluCountrySelectState extends State<FluCountrySelect> {
  late List<FluCountryModel> foundCountries;
  final double height = Flu.screenSize.height * .85,
      radius = Flu.screenSize.width * .08,
      flagRadius = 18,
      flagSize = 50;

  @override
  void initState() {
    foundCountries = Flu.countries;
    super.initState();
  }

  BorderRadius get borderRadius => BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      );

  void filter(String enteredKeyword) {
    List<FluCountryModel> results = [];

    if (enteredKeyword.isEmpty) {
      results = Flu.countries;
    } else {
      results = Flu.countries
          .where((FluCountryModel country) =>
              country.name
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()) ||
              country.phoneCode
                  .toLowerCase()
                  .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() => foundCountries = results);
  }

  @override
  Widget build(BuildContext context) => SizedBox(
      height: height,
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        builder: (context, scrollController) {
          return Column(
            children: [
              Container(
                height: 4,
                width: Flu.screenSize.width * .2,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                    color: Flu.theme().background.withOpacity(.5),
                    borderRadius: BorderRadius.circular(2)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Flu.theme().background,
                      borderRadius: borderRadius),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Scrollbar(
                      radius: const Radius.circular(10),
                      child: ListView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        padding:
                            EdgeInsets.all(Flu.appSettings.defaultPaddingSize),
                        children: <Widget>[
                          Text(
                              widget.title ??
                                  'Select your country ${Emojis.compass}',
                              style: Flu.textTheme.bodyText1!.copyWith(
                                  fontSize: Flu.appSettings.headlineFs,
                                  fontWeight: Flu.appSettings.textBold,
                                  color: Flu.theme().accentText)),
                          const SizedBox(height: 5),
                          Text(
                            widget.desc ??
                                'Select your country in order to get authentified or to get the best deals in your area.',
                            style: Flu.textTheme.bodyText1,
                          ),
                          FluOutline(
                            radius: Flu.appSettings.minElRadius + 2,
                            margin: const EdgeInsets.only(
                              bottom: 15,
                              top: 25,
                            ),
                            boxShadow: Flu.boxShadow(
                              blurRadius: 30,
                              opacity: .045,
                              offset: const Offset(10, 10),
                              color: Flu.theme().shadow,
                            ),
                            child: FluTextField(
                              label: widget.searchInputHint ??
                                  'Search for a country.',
                              height: Flu.appSettings.minElSize + 5,
                              cornerRadius: Flu.appSettings.minElRadius,
                              fillColor: Flu.theme().background,
                              textAlign: TextAlign.left,
                              prefixIcon: FluIcons.searchNormal,
                              iconSize: 18,
                              iconStrokeWidth: 2,
                              iconColor: Flu.theme().text,
                              borderWidth: 1.2,
                              boxShadow: [
                                Flu.boxShadow(
                                  blurRadius: 30,
                                  opacity: .035,
                                  offset: const Offset(0, 5),
                                  color: Flu.theme().primary,
                                )
                              ],
                              onChanged: (value) => filter(value),
                            ),
                          ),
                          ...foundCountries.map((FluCountryModel country) {
                            return FluButton(
                              onPressed: () {
                                widget.onSelect(country);
                                Navigator.pop(context);
                              },
                              style: FluButtonStyle(
                                height: null,
                                padding:
                                    const EdgeInsets.all(6).copyWith(right: 10),
                                margin: const EdgeInsets.only(bottom: 10),
                                background:
                                    Flu.theme().secondary.withOpacity(.45),
                                radius: flagRadius + 2,
                              ),
                              child: Row(
                                children: [
                                  FluOutline(
                                    spacing: 2,
                                    margin: const EdgeInsets.only(right: 10),
                                    radius: flagRadius + 2,
                                    thickness: 1.5,
                                    boxShadow: Flu.boxShadow(
                                        offset: const Offset(0, 0),
                                        opacity: .15,
                                        color: Flu.theme().primary),
                                    child: Container(
                                      height: flagSize,
                                      width: flagSize,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(flagRadius),
                                          image: DecorationImage(
                                            image: AssetImage(
                                                'icons/flags/png/${country.isoCode.toLowerCase()}.png',
                                                package: 'country_icons'),
                                            fit: BoxFit.fill,
                                          )),
                                    ),
                                  ),
                                  Expanded(
                                      child: Text(country.name,
                                          overflow: TextOverflow.ellipsis,
                                          style: Flu.textTheme.bodyText1!
                                              .copyWith(
                                                  fontWeight: Flu.appSettings
                                                      .textSemibold))),
                                  const SizedBox(width: 5),
                                  Text('+${country.phoneCode}',
                                      textAlign: TextAlign.right,
                                      style: Flu.textTheme.bodyText1!.copyWith(
                                          fontWeight: Flu.appSettings.textLight,
                                          color: Flu.theme().accentText))
                                ],
                              ),
                            );
                          }).toList()
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ));
}
