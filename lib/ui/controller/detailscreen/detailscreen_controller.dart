import 'dart:math';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:testmovie/apimanager/serverManager.dart';
import 'package:testmovie/model/helper/generelist_helper.dart';
import 'package:testmovie/model/network/genereModel.dart';
import 'package:testmovie/model/network/movieDetails.dart';
import 'package:testmovie/model/network/topRatedModel.dart' as top;
import 'package:testmovie/ui/controller/homepage/homepage_controller.dart';
import 'package:testmovie/utils/apputils.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailscreenController  extends GetxController with ProfileServer{
  List<Color> colors = [Color(0xFF15D2BC),Color(0xFFE26CA5),Color(0xFF564CA3),Color(0xFFCD9D0F)];
  RxList <GenerelistHelper> genereListHelper = <GenerelistHelper>[].obs;
      RxList<Genre> genereList = <Genre>[].obs;
          final random = Random();
          RxBool isFirst = true.obs;
          RxString videoKey = "".obs;
          late YoutubePlayerController _youtubePlayerController;

  late ChewieController chewieController;

    @override
  void dispose() {
    _youtubePlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

    @override
  void onInit() {
     _youtubePlayerController = YoutubePlayerController(
    initialVideoId: "nPt8bK2gbaU",
    flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        enableCaption: false),
  );
    super.onInit();
  }
  @override
  void onReady() {
    colors.shuffle();
    super.onReady();
  }
  void setData(top.Result data){
   genereList.addAll(Get.find<HomepageController>().genereList);
    data.genreIds.forEach((i) {
      genereList.forEach((j) {
        if(i == j.id){
          genereListHelper.add(GenerelistHelper(j.name, colors[random.nextInt(4)]));
          return;
        }
      },);
    },);
    isFirst.value = false;
  }
 youtubePlayer(String url ){
  
  try{
 YoutubePlayer(
        controller: _youtubePlayerController,
        showVideoProgressIndicator: true,
        bottomActions: <Widget>[
          const SizedBox(width: 14.0),
          CurrentPosition(),
          const SizedBox(width: 8.0),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
        ],
        aspectRatio: 4 / 3,
        progressIndicatorColor: Colors.white,
        onReady: () {
          print('Player is ready.');
        },
      );
    
  }catch(e){
    debugPrint(e.toString());
  }
 }
  fetchMovieList(
      {required BuildContext context,
      required String movieIDD,
      required void Function(
        bool success,
      )
          completion}) {
    fetchMovieListApi(
        context: context,
        movieId: movieIDD,
        onForeground: true,
        callBack: (success, json) {
          if (json != null) {
            MovieDetails  movieDetails= MovieDetails.fromJson(json);
            if(movieDetails.results!=null &&  movieDetails.results!.isNotEmpty){
               videoKey.value = movieDetails.results?[0].key??"";
            }
            completion(true);
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
      String? movieId,
      required void Function(bool success, Map? json) callBack}) async {
    if (apiCallingProgress) return;
    apiCallingProgress = true;
    if (onForeground) {
      AppUtil.showLoader(context: context);
      ServerManager.fetchMovieDetail(movieId??"", (responseBody, success) {
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
      }
}
