import 'package:flukit/flukit.dart';
import 'package:flutter/material.dart';

class FluTermsScreen extends StatefulWidget {
  final void Function() onAgree;
  final void Function() onDecline;

  const FluTermsScreen({
    Key? key,
    required this.onAgree,
    required this.onDecline
  }) : super(key: key);

  @override
  State<FluTermsScreen> createState() => _FluTermsScreenState();
}

class _FluTermsScreenState extends State<FluTermsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FluScreen(
    body: SafeArea(
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        child: Column(
          children: [
            Expanded(child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: FluConsts.defaultPaddingSize,
                vertical: 20
              ),
              child: Column(
                children: [
                  Text('sunt in culpa qui officia deserunt mollit anim id est laborum.', style: Flukit.textTheme.headline1!.copyWith(
                    fontSize: FluConsts.headlineFs + 2
                  )),
                  const SizedBox(height: 10),
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                  const SizedBox(height: 15),
                  const Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Diam in arcu cursus euismod quis viverra nibh cras. Enim nunc faucibus a pellentesque sit. Nec nam aliquam sem et tortor consequat. Dictumst quisque sagittis purus sit amet volutpat consequat mauris. Ultricies leo integer malesuada nunc vel risus commodo viverra. Parturient montes nascetur ridiculus mus. Sit amet facilisis magna etiam tempor. Odio aenean sed adipiscing diam donec adipiscing. Amet consectetur adipiscing elit pellentesque habitant morbi tristique. Suspendisse faucibus interdum posuere lorem ipsum dolor sit amet. Tempor orci dapibus ultrices in. Vitae auctor eu augue ut lectus arcu bibendum. Tellus at urna condimentum mattis pellentesque id. Nam at lectus urna duis. Diam maecenas ultricies mi eget mauris pharetra et ultrices. Viverra maecenas accumsan lacus vel. Tristique senectus et netus et malesuada fames ac. Suspendisse interdum consectetur libero id faucibus. Egestas fringilla phasellus faucibus scelerisque eleifend donec pretium. Eu turpis egestas pretium aenean pharetra. Nec ultrices dui sapien eget mi proin sed libero. Ultricies lacus sed turpis tincidunt id aliquet. Et netus et malesuada fames ac turpis egestas. Dolor sit amet consectetur adipiscing elit. Laoreet id donec ultrices tincidunt arcu non sodales. Nisi quis eleifend quam adipiscing vitae proin sagittis. Aliquam vestibulum morbi blandit cursus. Vitae ultricies leo integer malesuada nunc. Nunc aliquet bibendum enim facilisis gravida neque convallis a cras. Suspendisse faucibus interdum posuere lorem ipsum dolor. Arcu bibendum at varius vel pharetra vel turpis nunc. Et pharetra pharetra massa massa ultricies mi.'),
                  const SizedBox(height: 5),
                ],
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: FluConsts.defaultPaddingSize).copyWith(top: 15, bottom: 25),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                FluButton.text(
                  onPressed: () => widget.onDecline(),
                  backgroundColor: Colors.transparent,
                  color: Flukit.themePalette.danger,
                  text: 'Decline.',
                  textStyle: TextStyle(
                    fontWeight: FluConsts.textSemibold
                  ),
                ),
                Hero(
                  tag: '<main_button>',
                  child: FluButton.text(
                    onPressed: () => widget.onAgree(),
                    height: FluConsts.minElSize + 5,
                    radius: FluConsts.defaultElRadius,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    backgroundColor: Flukit.theme.secondaryColor,
                    color: Flukit.theme.accentTextColor,
                    text: 'I agree. 😊',
                    textStyle: TextStyle(
                      fontWeight: FluConsts.textSemibold
                    ),
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    )
  );
}