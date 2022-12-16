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
    await Flu.appController
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
                          horizontal: Flu.appSettings.defaultPaddingSize,
                          vertical: 20),
                      child: widget.content),
                ),
                onNotification: (notification) {
                  if (notification is ScrollEndNotification) {
                    setState(() => canAgree =
                        scrollController.position.pixels ==
                            scrollController.position.maxScrollExtent);
                  }
                  return false;
                },
              )),
              Padding(
                padding: EdgeInsets.symmetric(
                        horizontal: Flu.appSettings.defaultPaddingSize)
                    .copyWith(top: 15, bottom: 25),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FluButton.text(
                          onPressed: () => widget.onDecline(),
                          text: 'Decline.',
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          style: FluButtonStyle(
                            background: Colors.transparent,
                            color: Flu.theme().danger,
                          )),
                      Hero(
                        tag: '</mainButton>',
                        child: FluButton.text(
                          onPressed: canAgree ? () => widget.onAgree() : null,
                          text: 'I agree. 😊',
                          textStyle:
                              const TextStyle(fontWeight: FontWeight.w600),
                          style: FluButtonStyle(
                            height: Flu.appSettings.minElSize,
                            cornerRadius: Flu.appSettings.minElRadius,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            background: canAgree
                                ? Flu.theme().primary
                                : Flu.theme().primary.withOpacity(.1),
                            color: canAgree
                                ? Flu.theme().light
                                : Flu.theme().accentText,
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
