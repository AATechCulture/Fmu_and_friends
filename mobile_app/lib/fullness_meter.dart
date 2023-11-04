import 'package:flutter/material.dart';

class OverheadBinMeter extends StatelessWidget {
  final String className;
  final double fullness; // A value between 0.0 (empty) and 1.0 (full)

  const OverheadBinMeter({
    Key? key,
    required this.className,
    required this.fullness,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the gradient colors based on fullness
    Color getColor(double fullness) {
      return fullness > 0.75
          ? Theme.of(context)
              .colorScheme
              // TODO: change bright ref from here
              .secondary
          : Theme.of(context)
              .colorScheme
              .error;
    }

    double totalWidth = MediaQuery.of(context).size.width - 16;
    double filledWidth = totalWidth * fullness;
    double iconSize = 72.0;
    double iconHorizontalPosition = filledWidth - iconSize / 2;

    // Prevent the icon from going off the edge when fullness is 1.0
    iconHorizontalPosition =
        iconHorizontalPosition.clamp(0.0, totalWidth - iconSize);

    String percentageString = '${(fullness * 100).toStringAsFixed(0)}%';

    //TODO: change text style to make larger for the bottom widget of screen
    TextStyle percentageTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: fullness > 0.5
          ? Colors.white
          : Colors.black, // Contrast color based on fullness
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              className,
              //TODO: change font in theme
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
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
              Container(
                height: 24,
                width: filledWidth,
                decoration: BoxDecoration(
                  color: getColor(fullness),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              Positioned(
                left: iconHorizontalPosition,
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
  }
}
