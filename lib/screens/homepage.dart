import 'dart:async';
import 'dart:io';

import 'package:apprecognition/controller/pattern_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sharing_intent/flutter_sharing_intent.dart';
import 'package:flutter_sharing_intent/model/sharing_file.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var controller = Get.put(PatternController());
  @override
  late StreamSubscription _intentDataStreamSubscription;
  List<SharedFile>? list;
  @override
  void initState() {
    super.initState();
    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = FlutterSharingIntent.instance
        .getMediaStream()
        .listen((List<SharedFile> value) {
      setState(() {
        list = value;
        
      });

      controller.getPattern(File(list![0].value??""));

      print("Shared: getMediaStream ${value.map((f) => f.value).join(",")}");
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    FlutterSharingIntent.instance
        .getInitialSharing()
        .then((List<SharedFile> value) {
      print("Shared: getInitialMedia ${value.map((f) => f.value).join(",")}");
      setState(() {
        list = value;
      });
      controller.getPattern(File(list![0].value??""));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              Text(
                'Welcome to Trishul',
                style: TextStyle(
                  fontSize: 40, // adjust the size as needed
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // replace with your color
                ),
              ),
              Spacer(),
              Image.asset(
                  'assets/images/trishul.png'), // replace with your image path
              Spacer(),
              Text(
                'Share a screenshot to check for dark patterns!',
                style: TextStyle(
                  fontSize: 15, // adjust the size as needed
                  fontWeight: FontWeight.normal,
                  color: Colors.blueGrey, // replace with your color
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
