import 'dart:io';

import 'package:apprecognition/screens/result_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../config.dart';

class PatternController extends GetxController {
  //get dio
  var dio = Dio();

  var isDark = false.obs;

  //api request to get data from an image
  getPattern(File image) async {
    print("afdasdf");
    List<int> imageBytes = image.readAsBytesSync();
    //Image to base64
    String base64Image = base64Encode(imageBytes);
    dio.options.headers["content-Type"] = "application/json";
    dio.options.headers["Authorization"] = "Bearer ${accesstoken}";
    var res = dio.post(
        'https://asia-southeast1-aiplatform.googleapis.com/v1/projects/genai-404319/locations/asia-southeast1/publishers/google/models/gemini-pro-vision:streamGenerateContent',
        data: {
          {
            "contents": [
              {
                "role": "user",
                "parts": [
                  {
                    "text":
                        "Below given is the input of an image from an ecommerce website. Identify dark patterns in it from the following list of dark patterns.\nDark Patterns identified by DoCA\n1. False Urgency: Creating a false sense of urgency or scarcity to pressure users into quick decisions.\n2. Basket Sneaking: Adding additional products or services to the shopping cart without user consent.\n3. Confirm Shaming: Using guilt as a tactic to make users adhere to a particular belief or viewpoint.\n4. Forced Action: Forcing users into actions they may not want, such as signing up for a service to access content.\n5. Subscription Traps: Making it easy to sign up for a service but challenging to cancel, often by hiding the cancellation option.\n6. Interface Interference: Making it difficult for users to take certain actions, such as canceling a subscription or deleting an account.\n7. Bait and Switch: Advertising one product or service but delivering another, often of lower quality.\n8. Drip Pricing: Hiding additional costs from users until they are already committed to making a purchase.\n9. Disguised Ads: Creating advertisements that look like other types of content, such as news articles or user-generated content.\n10. Nagging: Persistent, repetitive, and annoyingly constant criticism, complaints, or requests for action.\nThe output should contain the type of dark pattern present and give it a rating A to E (A being no dark pattern and E being 4 or more dark patterns). Below is the screenshot from the ecommerce site"
                  },
                  {
                    "inlineData": {"mimeType": "image/png", "data": base64Image}
                  }
                ]
              }
            ],
            "generation_config": {
              "maxOutputTokens": 2048,
              "temperature": 0.4,
              "topP": 1,
              "topK": 32
            }
          }
        });
    print(res);
    print(base64Image);
    Get.to(() => ResultsScreen());
  }
}
