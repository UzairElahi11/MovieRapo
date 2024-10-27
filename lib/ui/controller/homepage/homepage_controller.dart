import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmovie/apimanager/serverManager.dart';
import 'package:testmovie/utils/apputils.dart';

class HomepageController extends GetxController with ProfileServer {
  @override
  void onReady() {
    fetchMovieList(context: Get.context!,completion: (success) {
      
    },);
    super.onReady();
  }




  fetchMovieList(
      {required BuildContext context,
      required void Function(
        bool success,
      )
          completion}) {
    fetchMovieListApi(
        context: context,
        // name: fullName.text,
        // email: email.text,
        // phone: phone.text,
        onForeground: true,
        callBack: (success, json) {
          if (json != null && json is Map) {
            // updateProfileModel = UpdateProfileModel.fromJson(json);
            //debugPrint("Response of login " + json.toString());

          } else {
            AppUtil.showWarning(
              context: context,
              title: "Retry",
              barrierDismissible: false,
              handler: (action) {
                completion(
                  false,
                );
                Navigator.of(context, rootNavigator: true).pop();
              },
            );
          }
        });
  }

  

}


mixin ProfileServer {
  bool apiCallingProgress = false;
  fetchMovieListApi(
      {required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.fetchRatedMovies((responseBody, success) {
        apiCallingProgress = false;
        if (onForeground) {
          AppUtil.dismissLoader(context: context);
        }
        if (success) {
          try {
            dynamic json = AppUtil.decodeString(responseBody);
            if (json != null && json is Map) {
              callBack(true, json);
            } else {
              callBack(false, json);
            }
          } catch (e) {
            if (onForeground) {
              AppUtil.showWarning(
                  context: context, title: "Error", bodyText: "Error");
            }
            callBack(false, null);
          }
        }
      });
    }
      }}