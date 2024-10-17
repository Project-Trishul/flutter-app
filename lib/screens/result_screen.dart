import 'dart:async';
import 'dart:io';

import 'package:apprecognition/controller/pattern_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:get/get.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff121212),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Results',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              
              Text(
                'Dark Patterns identified:\n1. False Urgency: \"Watch for Free\".\n2. Forced Action: \"Keep shopping for Appliance inverter...\"\n3. Interface Interference: The \"x\" button to close the \"Keep shopping for Appliance inverter...\" is hidden and not easily visible.\n4. Drip Pricing: The full price of the product is not shown until the user clicks on the \"Buy Now\" button.\n5. Disguised Ads: The \"miniTV\" section looks like a news article or user-generated content, but it is actually an advertisement.\n',
                style: TextStyle(fontSize: 16),
              ),

              SizedBox(
                height: 30,
              ),
              Text(
                'Rating: E',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
