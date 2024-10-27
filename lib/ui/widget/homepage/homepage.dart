import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:testmovie/ui/controller/homepage/homepage_controller.dart';
import 'package:testmovie/ui/widget/detailscreen/detailscreen.dart';
import 'package:testmovie/ui/widget/widgets/base/base_widget.dart';
import 'package:testmovie/ui/widget/widgets/extensions/padding_extension.dart';
import 'package:testmovie/ui/widget/widgets/generic_container.dart';
import 'package:testmovie/ui/widget/widgets/generic_space.dart';
import 'package:testmovie/ui/widget/widgets/generic_text.dart';
import 'package:testmovie/ui/widget/widgets/styles.dart';
import 'package:testmovie/ui/widget/widgets/svg_loader.dart';
import 'package:testmovie/utils/apputils.dart';

class HomePage extends StatelessWidget {
  final HomepageController _controller = Get.put(HomepageController());
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      useBaseWidgetPadding: false,
      child: SafeArea(
        child: Column(
          children: [
            const Gap(spacing: 30),
            Obx(() => _controller.isSearch.value ? searchWidget() : titleWidget()),
            const Gap(spacing: 30),
            Obx(() => _controller.isSearch.value ? catList() : moviesList())
          ],
        ),
      ),
    );
  }

  Widget catList() {
    return Expanded(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: _controller.filteredMovies.isEmpty
              ? GridView.builder(
                  itemCount: _controller.genereList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Stack(
                        children: [
                          Image.asset(
                            "${baseIconPath}dummy.png",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              _controller.genereList[index].name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: const Color(0xFFF7F8FA),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                "$imagePath${_controller.filteredMovies[index].posterPath}",
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _controller.filteredMovies[index].title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _controller.filteredMovies[index].originalTitle,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Dots indicator
                            const Icon(
                              Icons.more_horiz,
                              color: Colors.blueAccent,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: _controller.filteredMovies.length,
                ),
        ),
      ),
    );
  }

  Widget searchWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F6), // Light grey background color
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        onChanged: (query) => _controller.searchMovies(query),
        decoration: InputDecoration(
          contentPadding: (0, 10).symmetricPadding,
          prefixIcon: const Icon(Icons.search, color: Color(0xFF202C43)), // Search icon
          hintText: "TV shows, movies and more",
          hintStyle: AppTextStyles.font14_400(const Color(0xff202c434d).withOpacity(0.3)), // Hint text color
          border: InputBorder.none, // No underline
          suffixIcon: InkWell(
              onTap: () {
                _controller.searchChanger();
              },
              child: const Icon(Icons.close, color: Color(0xFF202C43))), // Clear icon
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GenericText(
            "Watch",
            style: AppTextStyles.font16_500(const Color(0xFF202C43)),
          ),
          InkWell(
              onTap: () {
                _controller.searchChanger();
              },
              child: SvgLoader(
                svgPath: "${baseIconPath}search.svg",
                height: 36,
                width: 36,
              ))
        ],
      ),
    );
  }

  Widget moviesList() {
    return Obx(() => Expanded(
          child: GenericContainer(
            color: const Color(0xFFF6F6FA),
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: _controller.moviesList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.to(() =>  Detailscreen(data: _controller.moviesList[index],));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: GenericContainer(
                      clip: Clip.antiAlias,
                      borderRadius: BorderRadius.circular(12),
                      height: 250,
                      width: double.infinity,
                      child: Stack(children: [
                        CachedNetworkImage(
                          imageUrl: "$imagePath${_controller.moviesList[index].posterPath}",
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) {
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                child: const SizedBox(
                                  height: 220,
                                  width: double.infinity,
                                ));
                          },
                        ),
                        Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(30),
                              child: GenericText(
                                _controller.moviesList[index].title,
                                style: AppTextStyles.font18_700(const Color(0xFFFFFFFF)),
                              ),
                            ))
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
