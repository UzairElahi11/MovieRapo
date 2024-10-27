import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmovie/apimanager/serverManager.dart';
import 'package:testmovie/model/network/genereModel.dart';
import 'package:testmovie/model/network/topRatedModel.dart';
import 'package:testmovie/utils/apputils.dart';

import '../../../utils/debouncing.dart';

class HomepageController extends GetxController with ProfileServer {
  RateMovieModel rateMovieModel = RateMovieModel();
  RxList<Result> moviesList = <Result>[].obs;
  RxList<Result> filteredMovies = <Result>[].obs;

  RxList<Genre> genereList = <Genre>[].obs;

  RxBool isSearch = false.obs;
  GenereModel genereModel = GenereModel();
  @override
  void onReady() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMovieList(
        context: Get.context!,
        completion: (success) {},
      );

      fetchGenere(
        context: Get.context!,
        completion: (success) {},
      );
    });
    super.onReady();
  }

  searchChanger() {
    if (isSearch.value) {
      isSearch.value = false;
    } else {
      isSearch.value = true;
    }
  }

  fetchMovieList(
      {required BuildContext context,
      required void Function(
        bool success,
      ) completion}) {
    fetchMovieListApi(
        context: context,
        // name: fullName.text,
        // email: email.text,
        // phone: phone.text,
        onForeground: true,
        callBack: (success, json) {
          if (json != null) {
            rateMovieModel = RateMovieModel.fromJson(json);
            moviesList.addAll(rateMovieModel.results ?? []);
            moviesList.refresh();
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

  fetchGenere(
      {required BuildContext context,
      required void Function(
        bool success,
      ) completion}) {
    fetchGenereApiCall(
        context: context,
        // name: fullName.text,
        // email: email.text,
        // phone: phone.text,
        onForeground: false,
        callBack: (success, json) {
          if (json != null) {
            genereModel = GenereModel.fromJson(json);
            genereList.addAll(genereModel.genres ?? []);
            genereList.refresh();
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

  void searchMovies(String query) {
    if (query.isEmpty) {
      filteredMovies.clear();
    } else {
      final results = moviesList.where((movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();

      filteredMovies.assignAll(results);
    }
  }

  final Debouncer debouncer = Debouncer(const Duration(milliseconds: 500));

  void onSearchChanged(String query) {
    debouncer.run(() {
      searchMovies(query);
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
              AppUtil.showWarning(context: context, title: "Error", bodyText: "Error");
            }
            callBack(false, null);
          }
        }
      });
    }
  }

  fetchGenereApiCall(
      {required BuildContext context,
      bool onForeground = false,
      required void Function(bool success, Map? json) callBack}) async {
    // if (apiCallingProgress) return;
    // apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
    }
    ServerManager.fetchGenere((responseBody, success) {
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
            AppUtil.showWarning(context: context, title: "Error", bodyText: "Error");
          }
          callBack(false, null);
        }
      }
    });
  }
}
