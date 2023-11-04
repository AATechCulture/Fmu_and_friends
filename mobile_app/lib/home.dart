import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:mobile_app/checkin.dart';
import 'package:mobile_app/fullness_meter.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/member_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset(
                  'assets/aa_logo.png',
                  width: screenSize.width * 0.60,
                  height: screenSize.height * 0.1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  onPressed: () => _navigateToCheckinPage(context),
                  style: _buttonStyle(context),
                  child: const Text(
                    'Luggage Check-In',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => _navigateToMemberPage(context),
                  style: _buttonStyle(context),
                  child: const Text(
                    'American Airlines Only',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const OverheadBinMeter(className: 'Overhead Bin Meter', fullness: 0.7),
              const SizedBox(height: 20),
              const SizedBox(),
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

  //TODO: show this on an animation of the luggage moving forward
  // ignore: unused_element
  void _showSnackBar() {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Almost Full!',
        message:
            'The overhead space is likely to fill soon. Please check-in your items.',
        contentType: ContentType.warning,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }


  // Navigate to the Check-in Page
  void _navigateToCheckinPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CheckinPage()),
    );
  }

  // Navigate to the Member Page
  void _navigateToMemberPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MemberPage()),
    );
  }

  // TODO: change button style 'defocus it'
  ButtonStyle _buttonStyle(BuildContext context) {
    return ElevatedButton.styleFrom(
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 10,
    );
  }
}
