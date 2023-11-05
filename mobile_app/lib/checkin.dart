// importing a flutter library and making a widget called check in page

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

/*
This class creates a check in page with multiple features , users can ++ and -- 
the number of carry ons and a submit button that has a process being represented
a loading animation for 2 secs
 */

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

/* declaring  variables (isSubmitting, submissionComplete, carryOnCount)
define 2 methods (increaseCarryon , Decreasecarryon to change carryoncount)
*/

class _CheckinPageState extends State<CheckinPage> {
  bool _isSubmitting = false;
  bool _submissionComplete = false;

  int carryOnCount = 0;

  void _increaseCarryOn() {
    if (!_isSubmitting && carryOnCount < 2) {
      setState(() {
        carryOnCount++;
      });
    }
  }

  void _decreaseCarryOn() {
    if (!_isSubmitting && carryOnCount > 0) {
      setState(() {
        carryOnCount--;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 500)).then((value) =>  _showSnackBar(),);
  }

/*
Using the build method to define a widget called scaffold that gives us structure 
for  building the app bar and main body
*/

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // setting up app bar
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Image.asset(
            'assets/aa_logo.png',
            width: screenSize.width * 0.60,
            height: screenSize.height * 0.1,
          ),
        ),
        automaticallyImplyLeading: true,
        backgroundColor: Colors.blue.shade50,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        // setting up the main body
        bottom: false,
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Colors.blue.shade50,
                Colors.blue.shade500,
              ])),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Time Until Flight',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                              fontSize: 36),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          color: Theme.of(context).primaryColor,
                          size: 24.0,
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '12 Hours 32 min',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                  color: Theme.of(context).primaryColorDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    const Divider(thickness: 2, color: Colors.white70),
                    if (!_submissionComplete) ...[
                      const SizedBox(height: 16),
                      Text(
                        'How many carry-ons?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: Colors.black87, fontSize: 32),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          '*Pick your carry-ons in the app now and get an instant estimate of overhead bin space for a smoother boarding experience!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black87, fontSize: 16),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Custom icons
                          IconButton(
                              onPressed: _decreaseCarryOn,
                              icon: const Icon(Icons.remove_circle_outline,
                                  size: 32)),
                          const SizedBox(width: 8),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 500),
                            transitionBuilder: (child, animation) =>
                                ScaleTransition(scale: animation, child: child),
                            child: Text(
                              '$carryOnCount',
                              key: ValueKey<int>(carryOnCount),
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: _increaseCarryOn,
                            icon: const Icon(
                              Icons.add_circle_outline,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ],
                    // Add the conditional loading or success message overlay here
                    if (_isSubmitting || _submissionComplete)
                      _isSubmitting
                          ? const CircularProgressIndicator()
                          : const Text(
                              'Congrats, your carry-on bags are checked in!',
                              style: TextStyle(
                                color: Colors.white54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    const SizedBox(height: 124),
                    if (!_submissionComplete)
                      ElevatedButton(
                        onPressed: _isSubmitting
                            ? null
                            : _submit, // Disable button when submitting
                        style: ElevatedButton.styleFrom(
                            foregroundColor:
                                _isSubmitting ? Colors.white10 : null,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16)),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    setState(() {
      _isSubmitting = true;
    });
    // Simulate a network request or long running task
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isSubmitting = false;
      _submissionComplete = true;
    });
  }

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
}
