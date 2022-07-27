import 'package:emojis/emojis.dart';
import 'package:flukit/src/widgets/input/old/input.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

import '../../flukit.dart';

class FluCountrySelect extends StatefulWidget {
  final String? title, desc, searchInputHint;
  final void Function(FluCountryModel) onSelect;

  const FluCountrySelect(
    this.onSelect, {
    Key? key,
    this.title,
    this.desc,
    this.searchInputHint,
  }) : super(key: key);

  @override
  State<FluCountrySelect> createState() => FluCountrySelectState();
}

class FluCountrySelectState extends State<FluCountrySelect> {
  late List<FluCountryModel> foundCountries;

  final double height = Flukit.screenSize.height * .85,
      radius = Flukit.screenSize.width * .08,
      flagRadius = 18,
      flagSize = 50;

  BorderRadius get borderRadius => BorderRadius.only(
        topLeft: Radius.circular(radius),
        topRight: Radius.circular(radius),
      );

  void filter(String enteredKeyword) {
    List<FluCountryModel> results = [];

    if (enteredKeyword.isEmpty) {
      results = Flukit.countries;
    } else {
      results = Flukit.countries
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
  void initState() {
    foundCountries = Flukit.countries;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
      height: height,
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        builder: (context, scrollController) {
          return Column(children: [
            Container(
              height: 4,
              width: Flukit.screenSize.width * .2,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                  color: Flukit.theme.backgroundColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(2)),
            ),
            Expanded(
              child: Container(
                  padding: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Flukit.theme.backgroundColor,
                      borderRadius: borderRadius),
                  child: ClipRRect(
                      borderRadius: borderRadius,
                      child: Scrollbar(
                          radius: const Radius.circular(10),
                          child: ListView(
                              controller: scrollController,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.all(
                                  Flukit.appConsts.defaultPaddingSize),
                              children: <Widget>[
                                    Text(
                                        widget.title ??
                                            'Select your country ${Emojis.compass}',
                                        style: Flukit.textTheme.bodyText1!
                                            .copyWith(
                                                fontSize: Flukit
                                                    .appConsts.headlineFs,
                                                fontWeight:
                                                    Flukit.appConsts.textBold,
                                                color: Flukit
                                                    .theme.palette.accentText)),
                                    const SizedBox(height: 5),
                                    Text(
                                      widget.desc ??
                                          'Select your country in order to get authentified or to get the best deals in your area.',
                                      style: Flukit.textTheme.bodyText1,
                                    ),
                                    FluOutline(
                                      radius: Flukit.appConsts.minElRadius + 2,
                                      margin: const EdgeInsets.only(
                                        bottom: 15,
                                        top: 25,
                                      ),
                                      boxShadow: Flukit.boxShadow(
                                        blurRadius: 30,
                                        opacity: .045,
                                        offset: const Offset(10, 10),
                                        color: Flukit.theme.shadowColor,
                                      ),
                                      child: FluTextInput(
                                        hintText: widget.searchInputHint ??
                                            'Search for a country.',
                                        style: FluTextInputStyle(
                                          height:
                                              Flukit.appConsts.minElSize + 5,
                                          radius: Flukit.appConsts.minElRadius,
                                          fillColor:
                                              Flukit.theme.backgroundColor,
                                          textAlign: TextAlign.left,
                                          prefixIcon: FluTwotoneIcons
                                              .search_searchNormal,
                                          iconSize: 18,
                                          iconStrokeWidth: 2,
                                          iconColor: Flukit.theme.textColor,
                                          borderWidth: 1.2,
                                          boxShadow: [
                                            Flukit.boxShadow(
                                              blurRadius: 30,
                                              opacity: .035,
                                              offset: const Offset(0, 5),
                                              color: Flukit.theme.primaryColor,
                                            )
                                          ],
                                        ),
                                        onChanged: (value) => filter(value),
                                      ),
                                    ),
                                  ] +
                                  (foundCountries.isNotEmpty
                                      ? foundCountries
                                          .map((FluCountryModel country) {
                                          return FluButton(
                                              onPressed: () {
                                                widget.onSelect(country);
                                                Navigator.pop(context);
                                              },
                                              style: FluButtonStyle(
                                                height: null,
                                                padding: const EdgeInsets.all(6)
                                                    .copyWith(right: 10),
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                backgroundColor: Flukit
                                                    .theme.secondaryColor
                                                    .withOpacity(.45),
                                                radius: flagRadius + 2,
                                              ),
                                              child: Row(children: [
                                                FluOutline(
                                                  spacing: 2,
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  radius: flagRadius + 2,
                                                  thickness: 1.5,
                                                  boxShadow: Flukit.boxShadow(
                                                      offset:
                                                          const Offset(0, 0),
                                                      opacity: .15,
                                                      color: Flukit
                                                          .theme.primaryColor),
                                                  child: Container(
                                                    height: flagSize,
                                                    width: flagSize,
                                                    clipBehavior: Clip.hardEdge,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    flagRadius),
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              'icons/flags/png/${country.isoCode.toLowerCase()}.png',
                                                              package:
                                                                  'country_icons'),
                                                          fit: BoxFit.fill,
                                                        )),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Text(country.name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: Flukit.textTheme
                                                            .bodyText1!
                                                            .copyWith(
                                                                fontWeight: Flukit
                                                                    .appConsts
                                                                    .textSemibold))),
                                                const SizedBox(width: 5),
                                                Text('+${country.phoneCode}',
                                                    textAlign: TextAlign.right,
                                                    style: Flukit
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            fontWeight: Flukit
                                                                .appConsts
                                                                .textLight,
                                                            color: Flukit
                                                                .theme
                                                                .palette
                                                                .accentText))
                                              ]));
                                        }).toList()
                                      : [
                                          const Center(
                                            /// Todo show illustrations.
                                            child: Text('Empty'),
                                          )
                                        ]))))),
            )
          ]);
        },
      ));
}
