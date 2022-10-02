import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class FluTermsScreen extends StatefulWidget {
  final Widget content;
  final void Function() onAgree;
  final void Function() onDecline;

  const FluTermsScreen(
      {Key? key,
      required this.content,
      required this.onAgree,
      required this.onDecline})
      : super(key: key);

  @override
  State<FluTermsScreen> createState() => _FluTermsScreenState();
}

class _FluTermsScreenState extends State<FluTermsScreen> {
  final ScrollController scrollController = ScrollController();
  bool canAgree = false;

  void onInit() async {
    await Flukit.appController
        .setAuthorizationState(FluAuthorizationStates.waitTerms)
        .onError((error, stackTrace) => throw {
              "Error while setting authorizationState parameter in secure storage.",
              error,
              stackTrace
            });
  }

  @override
  void initState() {
    onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FluScreen(
          body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          child: Column(
            children: [
              Expanded(
                  child: NotificationListener(
                child: Scrollbar(
                  child: SingleChildScrollView(
                      controller: scrollController,
                      // physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                          horizontal: Flukit.appSettings.defaultPaddingSize,
                          vertical: 20),
                      child: widget.content),
                ),
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    setState(() => canAgree = scrollController.position.pixels ==
                        scrollController.position.maxScrollExtent);
                  }
                  return false;
                },
              )),
              Padding(
                padding: EdgeInsets.symmetric(
                        horizontal: Flukit.appSettings.defaultPaddingSize)
                    .copyWith(top: 15, bottom: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FluButton.text(
                          onPressed: () => widget.onDecline(),
                          text: 'Decline.',
                          textStyle:
                              TextStyle(fontWeight: Flukit.appSettings.textSemibold),
                          style: FluButtonStyle(
                            backgroundColor: Colors.transparent,
                            color: Flukit.themePalette.danger,
                          )),
                      Hero(
                        tag: Flukit.appSettings.mainButtonHeroTag,
                        child: FluButton.text(
                          onPressed: canAgree ? () => widget.onAgree() : null,
                          text: 'I agree. 😊',
                          textStyle:
                              TextStyle(fontWeight: Flukit.appSettings.textSemibold),
                          style: FluButtonStyle(
                            height: Flukit.appSettings.minElSize,
                            radius: Flukit.appSettings.minElRadius,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            backgroundColor: canAgree
                                ? Flukit.theme.primaryColor
                                : Flukit.theme.secondaryColor,
                            color: canAgree
                                ? Flukit.themePalette.light
                                : Flukit.theme.accentTextColor,
                          ),
                        ),
                      ),
                    ]),
              )
            ],
          ),
        ),
      ));
}
