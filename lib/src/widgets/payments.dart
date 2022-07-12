import 'package:flukit/flukit.dart';
import 'package:flukit/src/models/payment_methods.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

enum FluPaymentMethods {
  tmoneyOrmoovMoney,
  card,
  bank,
}

class FluPaymentMethodSelector extends StatelessWidget {
  final double iconContainerSize, iconSize;
  final bool optionsOutlined;
  final List<FluPaymentMethods>? paymentMethods;
  final Function(FluPaymentMethods) onSelected;

  final List<FluPaymentMethods> _defaultPaymentMethods = [
    FluPaymentMethods.tmoneyOrmoovMoney,
    FluPaymentMethods.card,
    FluPaymentMethods.bank,
  ];

  FluPaymentMethodSelector({
    Key? key,
    this.iconContainerSize = 55,
    this.iconSize = 20,
    this.optionsOutlined = true,
    this.paymentMethods,
    required this.onSelected,
  }) : super(key: key);

  Map<FluPaymentMethods, FluPaymentMethodInfoModel> get _paymentMethodsInfos =>
      {
        FluPaymentMethods.tmoneyOrmoovMoney: FluPaymentMethodInfoModel(
          title: 'TMoney or Moov',
          description:
              'TMoney is a payment service that allows you to pay for goods and services with your mobile phone.',
          icon: FluTwotoneIcons.arrow_arrowSwapHorizontal,
        ),
        FluPaymentMethods.card: FluPaymentMethodInfoModel(
          title: 'Card',
          description:
              'Card is a payment service that allows you to pay for goods and services with your mobile phone.',
          icon: FluTwotoneIcons.money_cards,
        ),
        FluPaymentMethods.bank: FluPaymentMethodInfoModel(
            title: 'Bank Transfer',
            description:
                'Bank is a payment service that allows you to pay for goods and services with your mobile phone.',
            icon: FluTwotoneIcons.building_bank),
      };

  @override
  Widget build(BuildContext context) => FluOptionsList(
      shrinkWrap: true,
      itemHeight: 60,
      itemRadius: 20,
      itemSpacing: 6,
      itemIconMarginSize: 12,
      itemOutlined: true,
      itemPadding: const EdgeInsets.all(5),
      itemBoxShadow: Flukit.boxShadow(
        opacity: .035,
        offset: const Offset(-25, 20),
      ),
      outlineSpacing: 2,
      outlineColor: Flukit.theme.backgroundColor.withOpacity(.85),
      titleTextStyle: TextStyle(
          color: Flukit.theme.accentTextColor,
          fontSize: Flukit.appConsts.bodyFs + 1),
      descTextStyle: const TextStyle(fontSize: 13),
      iconColor: Flukit.theme.accentTextColor,
      iconStrokewidth: 1.8,
      suffixWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: FluIcon(
          icon: FluTwotoneIcons.arrow_arrowRight1,
          style: FluIconStyle(
            color: Flukit.theme.textColor,
            size: 15,
          ),
        ),
      ),
      options: (paymentMethods ?? _defaultPaymentMethods).map((e) {
        FluPaymentMethodInfoModel paymentMethodsInfo = _paymentMethodsInfos[e]!;

        return FluOption(
          title: paymentMethodsInfo.title,
          description: paymentMethodsInfo.description,
          icon: paymentMethodsInfo.icon,
          iconBackgroundColor: Flukit.theme.secondaryColor,
          imageType: FluImageSource.network,
          onPressed: () => onSelected(e),
        );
      }).toList());
}
