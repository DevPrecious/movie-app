import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdb/models/videos_model.dart';
import 'package:imdb/views/constants/constants.dart';

class SingleVideoPage extends StatefulWidget {
  const SingleVideoPage({super.key, required this.video});

  final video;

  @override
  State<SingleVideoPage> createState() => _SingleVideoPageState();
}

class _SingleVideoPageState extends State<SingleVideoPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                // color: kRedButtonColor,
                width: double.infinity,
                height: 300,
                child: CachedNetworkImage(
                  imageUrl: imageUrl + widget.video.backdropPath!,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: size * 0.20,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // icon back
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                      // icon cast screen
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.cast,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${widget.video.title}',
                      style: GoogleFonts.poppins(
                        fontSize: size * 0.040,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        // icon bookmark
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmark_border,
                            color: Colors.grey,
                          ),
                        ),
                        // icon share
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.share,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        // icon star
                        const Icon(
                          Icons.star,
                          color: kRedButtonColor,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '${widget.video.voteAverage!.floorToDouble()}',
                          style: GoogleFonts.poppins(),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    // get year only from release date
                    Text(
                      widget.video.releaseDate!
                          .toIso8601String()
                          .substring(0, 4),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: kRedButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.play_circle),
                        label: Text(
                          'Play',
                          style: GoogleFonts.poppins(
                            fontSize: size * 0.040,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.download,
                          color: kRedButtonColor,
                        ),
                        label: Text(
                          'Download',
                          style: GoogleFonts.poppins(
                            fontSize: size * 0.040,
                            color: kRedButtonColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('${widget.video.overview}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
