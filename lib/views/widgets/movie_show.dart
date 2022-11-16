import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imdb/models/videos_model.dart';
import 'package:imdb/views/constants/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieShowWidget extends StatelessWidget {
  const MovieShowWidget({
    super.key,
    required this.size,
    required this.video,
  });

  final double size;
  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        width: size * 0.35,
        height: size * 0.50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: '$imageUrl${video.posterPath}',
                fit: BoxFit.cover,
                width: size * 0.35,
                height: size * 0.50,
              ),
            ),
            Positioned(
              top: 5,
              left: 10,
              child: Chip(
                label: Text(
                  '${video.voteAverage!.roundToDouble()}',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                  ),
                ),
                backgroundColor: kRedButtonColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
