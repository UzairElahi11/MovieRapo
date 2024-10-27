
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:testmovie/utils/Dynamic_size.dart';

class AppUtil {
  AppUtil._();
  static final AppUtil _instance = AppUtil._();
  
    static dynamic decodeString(String responseBody) {
    return json.decode(responseBody);
  }

   static void showWarning(
      {required BuildContext context,
      String? title,
      String? bodyText,
      String? btnTitle,
      bool barrierDismissible = true,
      Handler? handler,
      bool forNotification = false}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title ?? "Error"),
            content: Text(bodyText ?? "Error"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Close')),
            ],
          );
        });
  }
    static void dismissLoader({required BuildContext context}) {
    loaderCount--;
    if (loaderCount < 0) {
      loaderCount = 0;
    }
    debugPrint("dismissloader : " + loaderCount.toString());
    showingLoader = false;
    Navigator.of(context, rootNavigator: true).pop();
  }

    static int loaderCount = 0;
      static bool showingLoader = false;

     static void showLoader(
      {required BuildContext context, bool resetCount = false}) {
    // if (resetCount) {
    //   loaderCount = 1;
    //   showingLoader = false;
    // } else
    loaderCount++;
    
    debugPrint("showLoader $loaderCount");
    if (context == null || showingLoader) return;
    showingLoader = true;
    showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Container(
                height: DynamicSize.width(0.45, context),
                width: DynamicSize.width(0.45, context),
                child: Lottie.asset("assets/animation/loader.json"),
              ),
            ),
          );
        });
  }

}
class AlertHander {
  String? title;
  bool showWhiteButton = false;
  Handler? handler;
}

typedef void Handler(AlertHander action);


String bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ODBkZGZkMDFjZDdiZmQwNzhhNzk1NDI4MDIxZmYxYSIsIm5iZiI6MTczMDAxNjgyOS4xNjM2NTgsInN1YiI6IjVmNzRiOTIwMTU2Y2M3MDAzODQ1YTM2MSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.eubHM_ax6ke2nK3_ducCq-16LIHmi8DbYpR8WRmAp2o";
String apiKey = "780ddfd01cd7bfd078a795428021ff1a";
String imagePath = 'https://image.tmdb.org/t/p/w300/';
String baseIconPath = "assets/icon/";