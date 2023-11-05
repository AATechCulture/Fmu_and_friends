import 'package:mobile_app/checkin.dart';
import 'package:mobile_app/bin_meter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/send_to_api.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title,});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double parsedProbability = .55;

  Future<void> _parseProbability() async {
    try {
      String probabilityString = await getBagsToCabinPercent();
      setState(() {
        parsedProbability = double.parse(probabilityString);
      });
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    
   _parseProbability();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.blue.shade50,
              Colors.blue.shade500,
            ])),
        child: SafeArea(
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.start, // Adjust alignment for better spacing
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 18.0, 24.0, 24.0),
                child: Image.asset(
                  'assets/aa_logo.png',
                  width: screenSize.width * 0.60,
                  height: screenSize.height * 0.1,
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(24),
                  children: [
                    const Text(
                      'Carry-On Luggage Check-In',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      style: _buttonStyle(context),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const CheckinPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Proceed to Check-in',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          TweenAnimationBuilder<double>(
                            duration: const Duration(seconds: 2),
                            tween: Tween<double>(
                                begin: 0, end: parsedProbability.toDouble() * 100),
                            builder: (context, value, child) {
                              // Formatting the text to display only the integer part if the value is an integer
                              String percentageString = value.toStringAsFixed(
                                  value.truncateToDouble() == value ? 0 : 1) ;
                              return Text(
                                '$percentageString%',
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                            onEnd: () {},
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 50,
                                width: 250,
                                child: Text(
                                  'Chance of Carrying on Bags as of Sunday, November 5',
                                  style: TextStyle(fontSize: 16),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              TweenAnimationBuilder<double>(
                                duration: const Duration(seconds: 2),
                                tween: Tween<double>(
                                    begin: 0, end: parsedProbability),
                                builder: (context, value, child) {
                                  return CircularPercentIndicator(
                                    progressColor: Colors.yellow.shade800,
                                    radius: 20,
                                    percent:
                                        value, // Use animated value for the percent
                                    lineWidth: 5,
                                  );
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 120),
                    const Text(
                      'Current overhead bin capacity:',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    const OverheadBinMeter(
                      fullness: .56,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Chat',
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }

  

  

  ButtonStyle _buttonStyle(BuildContext context) {
    Color borderColor =
        Theme.of(context).colorScheme.onSurface.withOpacity(0.2);

    return ElevatedButton.styleFrom(
      foregroundColor:
          Theme.of(context).colorScheme.background, // Button text color
      backgroundColor:
          Colors.pink.shade50, // Make the button's background transparent
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: BorderSide(
            color: borderColor, width: 1.5), // Soft border with thickness
      ),
      elevation: 5, // Apply elevation for shadow
      shadowColor: borderColor, // Shadow color
    ).copyWith(
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context)
                .colorScheme
                .primary
                .withOpacity(0.8); // Overlay color when pressed
          }
          return Colors.transparent; // Default - No overlay
        },
      ),
    );
  }
}
