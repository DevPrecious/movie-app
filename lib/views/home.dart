import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb/controllers/video_controller.dart';
import 'package:imdb/views/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdb/views/single_video.dart';
import 'package:imdb/views/widgets/movie_show.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VideoController _videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        selectedItemColor: kRedButtonColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'My List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return _videoController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: kRedButtonColor,
                      ),
                    )
                  : Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SingleVideoPage(
                                  video: _videoController.singlevideo.value,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            height: size * 0.90,
                            // color: kRedButtonColor,
                            child: CachedNetworkImage(
                              imageUrl: imageUrl +
                                  _videoController
                                      .singlevideo.value.backdropPath!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: size * 0.20,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'M',
                                  style: GoogleFonts.poppins(
                                    fontSize: size * 0.070,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: const [
                                    // search icon
                                    Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    SizedBox(width: 20.0),
                                    // Notification icon
                                    Icon(
                                      Icons.notifications,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: size * 0.63,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _videoController.singlevideo.value.title!,
                                  style: GoogleFonts.poppins(
                                    fontSize: size * 0.050,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _videoController.singlevideo.value.genres!
                                      .map((e) => e.name)
                                      .join(', '),
                                  style: GoogleFonts.poppins(
                                    fontSize: size * 0.028,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Chip(
                                      backgroundColor: kRedButtonColor,
                                      avatar: const Icon(
                                        Icons.play_circle,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Play',
                                        style: GoogleFonts.poppins(
                                          fontSize: size * 0.028,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Chip(
                                      label: Text(
                                        "My List",
                                        style: GoogleFonts.poppins(
                                          fontSize: size * 0.028,
                                          color: Colors.black,
                                        ),
                                      ),
                                      avatar: const Icon(Icons.add),
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                        side: const BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
            }),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top 10 Movies This Week',
                    style: GoogleFonts.poppins(
                      fontSize: size * 0.050,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'See all',
                    style: GoogleFonts.poppins(
                      fontSize: size * 0.030,
                      fontWeight: FontWeight.w500,
                      color: kRedButtonColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: size * 0.52,
              child: Obx(() {
                return _videoController.isLoading2.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: kRedButtonColor,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _videoController.video.value.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleVideoPage(
                                    video: _videoController.video.value[index],
                                  ),
                                ),
                              );
                            },
                            child: MovieShowWidget(
                              size: size,
                              video: _videoController.video.value[index],
                            ),
                          );
                        }),
                      );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'New Releases',
                    style: GoogleFonts.poppins(
                      fontSize: size * 0.050,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    'See all',
                    style: GoogleFonts.poppins(
                      fontSize: size * 0.030,
                      fontWeight: FontWeight.w500,
                      color: kRedButtonColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: size * 0.52,
              child: Obx(() {
                return _videoController.isLoading3.value
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: kRedButtonColor,
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: _videoController.newRelease.value.length,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleVideoPage(
                                    video: _videoController
                                        .newRelease.value[index],
                                  ),
                                ),
                              );
                            },
                            child: MovieShowWidget(
                              size: size,
                              video: _videoController.newRelease.value[index],
                            ),
                          );
                        }),
                      );
              }),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
