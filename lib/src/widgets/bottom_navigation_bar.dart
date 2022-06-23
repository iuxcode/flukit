import 'package:flukit/flukit.dart';
import 'package:flukit_icons/flukit_icons.dart';
import 'package:flutter/material.dart';

enum FluBottomNavBarIndicatorPosition {
  top,
  bottom
}

enum FluBottomNavBarIndicatorStyle {
  normal,
  drop
}

class FluBottomNavBarItem {
  final FluIconModel icon;
  final FluIconModel? filledIcon;
  final String label;

  FluBottomNavBarItem({required this.icon, required this.label, this.filledIcon});
}

class FluBottomNavBarStyle {
  final Color? background, color, activeColor, indicatorColor;
  final bool showItemLabelOnSelected;
  final Duration animationDuration;
  final Curve animationCurve;
  final FluBottomNavBarIndicatorStyle indicatorStyle;
  final FluBottomNavBarIndicatorPosition indicatorPosition;

  FluBottomNavBarStyle({
    this.background,
    this.color,
    this.activeColor,
    this.indicatorColor,
    this.showItemLabelOnSelected = false,
    this.indicatorStyle = FluBottomNavBarIndicatorStyle.drop,
    this.indicatorPosition = FluBottomNavBarIndicatorPosition.top,
    this.animationDuration = const Duration(milliseconds: 350),
    this.animationCurve = Curves.fastOutSlowIn,
  });

  static FluBottomNavBarStyle defaultt = FluBottomNavBarStyle(
    background: Flukit.themePalette.dark,
    color: Flukit.theme.textColor,
    activeColor: Flukit.theme.primaryColor
  );

  static FluBottomNavBarStyle secondary = FluBottomNavBarStyle(
    background: Flukit.theme.secondaryColor,
    color: Flukit.theme.textColor,
    activeColor: Flukit.theme.primaryColor
  );
}

class FluBottomNavBar extends StatefulWidget {
  final double selectedIndex;
  final List<FluBottomNavBarItem> items;
  final Function(int) onItemTap;
  final FluBottomNavBarStyle? style;

  FluBottomNavBar({
    Key? key,
    required this.onItemTap,
    required this.items,
    this.selectedIndex = 0,
    this.style
  }): super(key: key) {
    style ??= FluBottomNavBarStyle.defaultt;
  }

  set style(FluBottomNavBarStyle? newStyle) => style = newStyle;

  @override
  State<FluBottomNavBar> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<FluBottomNavBar> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  final GlobalKey itemKey = GlobalKey();

  int previousIndex = 0;
  double itemWidth = 0;

  FluBottomNavBarStyle get style => widget.style!;

  void getItemWidth() {
    final RenderBox box = itemKey.currentContext?.findRenderObject() as RenderBox;
    final double width = box.size.width;
    setState(() => itemWidth = width);
  }

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: style.animationDuration,
    )..forward(from: 0.0);
    WidgetsBinding.instance.addPostFrameCallback((_) => getItemWidth());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Flukit.appConsts.bottomNavBarHeight,
      clipBehavior: Clip.hardEdge,
      margin: EdgeInsets.symmetric(
        horizontal: Flukit.appConsts.bottomNavBarHMarginSize
      ).copyWith(bottom: Flukit.appConsts.bottomNavBarBMarginSize),
      decoration: BoxDecoration(
        color: style.background ?? Flukit.themePalette.dark,
        borderRadius: BorderRadius.circular(Flukit.appConsts.bottomNavBarRadius)
      ),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: widget.items.map((FluBottomNavBarItem item) {
              int index = widget.items.indexOf(item);

              return _BottomNavBarItem(
                key: index == 0 ? itemKey : null,
                isSelected: widget.selectedIndex.round() == index,
                onTap: () {
                  setState(() => previousIndex = index);
                  widget.onItemTap(index);
                  Future.delayed(style.animationDuration, () => animationController.forward(from: 0.0));
                },
                data: item,
                color: style.color ?? Flukit.theme.textColor,
                activeColor: style.activeColor ?? Flukit.theme.primaryColor,
                animationDuration: style.animationDuration,
                animationCurve: style.animationCurve,
                showLabel: style.showItemLabelOnSelected,
              );
            }).toList()
          ),
          _Indicator(
            controller: animationController,
            selectedIndex: widget.selectedIndex,
            previousIndex: previousIndex,
            height: 6.5,
            maxWidth: itemWidth,
            duration: style.animationDuration,
            curve: style.animationCurve,
            color: style.indicatorColor ?? style.activeColor ?? Flukit.theme.primaryColor,
            activeColor: style.activeColor ?? Flukit.theme.primaryColor,
            style: style.indicatorStyle,
            position: style.indicatorPosition,
          )
        ],
      )
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  final FluBottomNavBarItem data;
  final Color color, activeColor;
  final void Function() onTap;
  final bool isSelected, showLabel;
  final Duration animationDuration;
  final Curve animationCurve;

  const _BottomNavBarItem({
    Key? key,
    required this.data,
    required this.color,
    required this.activeColor,
    required this.onTap,
    required this.animationDuration,
    required this.animationCurve,
    this.isSelected = false,
    this.showLabel = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FluButton(
        onPressed: () => onTap(),
        style: FluButtonStyle(
          height: double.infinity,
          width: double.infinity,
          backgroundColor: Colors.transparent,
          radius: 0,
          padding: const EdgeInsets.symmetric(horizontal: 30),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: animationDuration,
            switchInCurve: animationCurve,
            switchOutCurve: animationCurve,
            child: isSelected && showLabel ? Text(
              data.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Flukit.textTheme.bodyText1!.copyWith(
                fontSize: Flukit.appConsts.smallFs,
                color: Flukit.theme.primaryColor
              ),
            ) : FluIcon(
              icon: isSelected && data.filledIcon != null ? data.filledIcon! : data.icon,
              style: FluIconStyle(
                color: isSelected ? activeColor : color,
                strokeWidth: 2,
                size: isSelected && data.filledIcon != null ? 26 : 24
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Indicator extends StatelessWidget {
  final AnimationController controller;
  final double selectedIndex;
  final int previousIndex;
  final double height, maxWidth, radius;
  final Color color, activeColor;
  final Duration duration;
  final Curve curve;
  final FluBottomNavBarIndicatorStyle? style;
  final FluBottomNavBarIndicatorPosition position;

  const _Indicator({
    Key? key,
    required this.controller,
    required this.selectedIndex,
    required this.previousIndex,
    required this.height,
    required this.maxWidth,
    required this.color,
    required this.activeColor,
    required this.duration,
    required this.curve,
    // ignore: unused_element
    this.radius = 8,
    this.style = FluBottomNavBarIndicatorStyle.drop,
    this.position = FluBottomNavBarIndicatorPosition.top,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: position == FluBottomNavBarIndicatorPosition.top ? 0 : null,
      bottom: position == FluBottomNavBarIndicatorPosition.bottom ? 0 : null,
      left: selectedIndex * maxWidth,
      duration: duration,
      curve: curve,
      child: style == FluBottomNavBarIndicatorStyle.normal ? Container(
        height: height,
        width: maxWidth,
        alignment: Alignment.bottomCenter,
        child: Container(
          height: double.infinity,
          width: height * 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              topRight: Radius.circular(radius)
            ),
            boxShadow: [Flukit.boxShadow(
              blurRadius: 30,
              offset: const Offset(0, -4),
              color: color.withOpacity(.5)
            )]
          )
        )
      ) :
      AnimatedBuilder(
        animation: controller,
        builder: (_, __) => /* Transform.translate(
          offset: Tween<Offset>(
            begin: Offset(previousIndex * maxWidth, 0),
            end: Offset(selectedIndex * maxWidth, 0)
          )
            .animate(
              CurvedAnimation(
                parent: controller,
                curve: const Interval(0.0, 0.35),
              ),
            )
            .value,
          child:  */Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Transform.translate(
                offset: Tween<Offset>(
                  begin: const Offset(0, 5.0),
                  end: const Offset(0, 40),
                )
                  .animate(CurvedAnimation(
                    parent: controller,
                    // 46
                    curve: const Interval(0.40, 1, curve: Curves.fastOutSlowIn),
                  ))
                  .value,
                child: Container(
                  width: 6.0,
                  height: 6.0,
                  decoration: BoxDecoration(
                    color: controller.value > 0.65 ? Colors.transparent : activeColor,
                    // color: Colors.amber,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Opacity(
                opacity: controller.value <= 0.45 ? 1.0 : 0.0,
                child: _FallingDrop(
                  itemWidth: maxWidth,
                  color: color,
                  width: Tween<double>(begin: 72, end: 56)
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: const Interval(0.45, 0.55),
                      ),
                    )
                    .value,
                  height: Tween<double>(begin: 16, end: 24)
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: const Interval(0.45, 0.55),
                      ),
                    )
                    .value,
                ),
              ),
              Opacity(
                opacity: controller.value >= 0.45 ? 1.0 : 0.0,
                child: _FallingDrop(
                    itemWidth: maxWidth,
                    color: color,
                    width: Tween<double>(begin: 56, end: 72)
                        .animate(
                          CurvedAnimation(
                            parent: controller,
                            curve: const Interval(0.45, 0.60),
                          ),
                        )
                        .value,
                    height: Tween<double>(begin: 24, end: 16)
                        .animate(
                          CurvedAnimation(
                            parent: controller,
                            curve: const Interval(0.45, 0.60),
                          ),
                        )
                        .value,
                  ),
              ),
            ],
          ),
        ),
      /* ) */
    );
  }
}

class _FallingDrop extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final double itemWidth;

  const _FallingDrop({
    required this.width,
    required this.height,
    this.color,
    required this.itemWidth,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: itemWidth,
      child: UnconstrainedBox(
        child: SizedBox(
          width: width,
          height: height,
          child: CustomPaint(
            size: Size.zero,
            painter: _WaterPainter(color ?? Flukit.theme.primaryColor),
          ),
        )
      ),
    );
  }
}

class _WaterPainter extends CustomPainter {
  final Color color;

  _WaterPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    path.cubicTo(
      size.width * 0.239841,
      size.height * 0.06489535,
      size.width * 0.285956,
      size.height * 0.4886860,
      size.width * 0.42016,
      size.height * 0.8271512,
    );
    path.cubicTo(
      size.width * 0.467771,
      size.height * 0.9466628,
      size.width * 0.530574,
      size.height * 0.9472209,
      size.width * 0.578344,
      size.height * 0.8285814,
    );
    path.cubicTo(
      size.width * 0.7185669,
      size.height * 0.4786744,
      size.width * 0.757325,
      size.height * 0.06629070,
      size.width * 0.999682,
      0
    );
    path.lineTo(0, 0);
    path.close();

    Paint fillColor = Paint()..style = PaintingStyle.fill;

    fillColor.color = color;
    canvas.drawPath(path, fillColor);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
