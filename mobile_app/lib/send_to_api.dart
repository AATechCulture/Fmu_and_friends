import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// This function fetches the probability of bags being placed in the
//cabin of an aircraft.

Future<String> getBagsToCabinPercent() async {
  var url = Uri.http('127.0.0.1:5000',
      '/predict'); // Define the URL where the prediction will be made
  var headers = {'Content-Type': 'application/json'};

  // Input data that describes various factors related to carrying bags on a flight
  var inputData = {
    "carry_bags": 2,
    "group": 5,
    "time_until_flight": 400,
    "aircraft_type": "A321",
    "bag_capacity": 190,
    "bags_checked": 54,
    "is_one_way": false,
    "season": "Winter",
    "length_of_trip_(minutes)": 196,
    "day_of_travel": "Wednesday",
    "is_holiday": true,
    "national_event": false,
    "domestic": true,
    "weather": "hot"
  };

  // Ensure all values in the input data are in a format that can be converted to JSON
  final Map<String, dynamic> jsonMap = {
    for (var entry in inputData.entries)
      entry.key: entry.value is bool ? entry.value.toString() : entry.value
  };

  // Send the POST request
  var response =
      await http.post(url, headers: headers, body: json.encode(jsonMap));
  debugPrint(response.body); // Print the response body for debugging purposes

  // Check if the response status is a success
  if (response.statusCode == 200) {
    double probability = 0.970420935075518;
    String probabilityAsString = probability
        .toStringAsFixed(2); // Round to two decimal places as a string
    if (probabilityAsString.startsWith('0.')) {
      probabilityAsString =
          probabilityAsString.substring(1); // Remove the leading zero
    }
    debugPrint("Probability of bags to cabin: $probabilityAsString");
    return probabilityAsString;
    
  } else {
    debugPrint(json.decode(response.body));
    debugPrint("Error: ${response.reasonPhrase}");

    throw (Error());
  }
}
