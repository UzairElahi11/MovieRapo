import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testmovie/model/network/topRatedModel.dart';
import 'package:testmovie/ui/controller/detailscreen/detailscreen_controller.dart';
import 'package:testmovie/ui/widget/widgets/base/base_widget.dart';
import 'package:testmovie/ui/widget/widgets/generic_space.dart';
import 'package:testmovie/ui/widget/widgets/generic_text.dart';
import 'package:testmovie/ui/widget/widgets/styles.dart';
import 'package:testmovie/utils/apputils.dart';

// ignore: must_be_immutable
class Detailscreen extends StatelessWidget {
  Result data;
  Detailscreen({super.key, required this.data});
  final DetailscreenController _controller = Get.put(DetailscreenController());
  @override
  Widget build(BuildContext context) {
    if(_controller.isFirst.value){

    
    _controller.setData(data);
    }
    return BaseWidget(
      useBaseWidgetPadding: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.height * 0.6,
            child: Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "${imagePath}${data.posterPath}",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: context.height * 0.1),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GenericText(
                            "In theaters ${AppUtil.formatDate(data.releaseDate)}",
                            style: AppTextStyles.font16_500(Colors.white),
                          ),
                          const Gap(spacing: 30),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff61C3F2),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: GenericText(
                              'Get Tickets',
                              style: AppTextStyles.font14_400(Colors.white),
                            ),
                          ),

                          const Gap(spacing: 20),
                          // Watch Trailer Button
                          OutlinedButton.icon(
                            onPressed: () {
                             _controller.fetchMovieList(context: context, movieIDD: data.id.toString(), completion:(success) {
                               if(success){
                                _controller.youtubePlayer(_controller.videoKey.value);
                               }
                             },);
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              side: const BorderSide(
                                  color: Color(0xff61C3F2), width: 2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            icon: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                            label: GenericText(
                              'Watch Trailer',
                              style: AppTextStyles.font14_600(Colors.white),
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ),
          ),
          Gap(spacing: 30),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: context.width * 0.05),
                      child: GenericText(
                        "Genres",
                        style: AppTextStyles.font16_500(Colors.black),
                      ),
                    ),
                    const Gap(spacing: 10),
                    Center(child: wrapTiles()),
                    const Gap(spacing: 15),
                    const Divider(endIndent: 10,indent: 10,),
                    const Gap(spacing: 15),
                    Padding(
                      padding: EdgeInsets.only(left: context.width * 0.05),
                      child: GenericText(
                        "Overview",
                        style: AppTextStyles.font16_500(Colors.black),
                      ),
                    ),
                     Padding(
                      padding: EdgeInsets.only(left: context.width * 0.05),
                      child: GenericText(
                        data.overview,
                        style: AppTextStyles.font14_400(const Color(0xFF8F8F8F)),
                      ),
                    ),

                     const Gap(spacing: 20),
                
                
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget wrapTiles() {
    return SizedBox(
      height: 35,
      width: double.infinity,
      child: ListView.builder(
        itemCount: _controller.genereListHelper.length,
        scrollDirection: Axis.horizontal,
        itemBuilder:(context, index) {
          return  catagories(_controller.genereListHelper[index].name??"", _controller.genereListHelper[index].color??Colors.black);
        },),
    );
    
  }

  Widget catagories(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: GenericText(
        label,
        style:const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
