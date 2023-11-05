import 'package:flutter/material.dart';

class OverheadBinMeter extends StatefulWidget {
  final double fullness;

  const OverheadBinMeter({
    Key? key,
    required this.fullness,
  }) : super(key: key);

  @override
  OverheadBinMeterState createState() => OverheadBinMeterState();
}

class OverheadBinMeterState extends State<OverheadBinMeter>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positionAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _positionAnimation =
        Tween<double>(begin: 0.0, end: widget.fullness).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void didUpdateWidget(OverheadBinMeter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.fullness != widget.fullness) {
      _positionAnimation = Tween<double>(
        begin: _positionAnimation.value,
        end: widget.fullness,
      ).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
      );
      _animationController
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width - 40;
    double iconSize = 72.0;

    return AnimatedBuilder(
      animation: _positionAnimation,
      builder: (context, child) {
        double filledWidth = totalWidth * _positionAnimation.value;

        double iconHorizontalPosition =
            totalWidth - (totalWidth * _positionAnimation.value) - iconSize / 2;
        iconHorizontalPosition =
            iconHorizontalPosition.clamp(0.0, totalWidth - iconSize);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: 24,
                    width: totalWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Container(
                      height: 24,
                      width: filledWidth,
                      decoration: BoxDecoration(
                        color: getColor(context, _positionAnimation.value),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(
                              filledWidth == totalWidth ? 12 : 0),
                          topRight: const Radius.circular(12),
                          bottomLeft: Radius.circular(
                              filledWidth == totalWidth ? 12 : 0),
                          bottomRight: const Radius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: iconHorizontalPosition - 10,
                    top: -30,
                    child: Image.asset(
                      'assets/luggage_icon.png',
                      width: iconSize,
                      height: iconSize,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color getColor(BuildContext context, double fullness) {
    // Assuming fullness = 0.0 should be red and fullness = 1.0 should be green
    return Color.lerp(Colors.red, Colors.green, fullness)!;
  }
}
