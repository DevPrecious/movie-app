import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imdb/models/single_video.dart';
import 'package:imdb/models/videos_model.dart';
import 'package:imdb/views/constants/constants.dart';
import 'package:http/http.dart' as http;

class VideoController extends GetxController {
  final singlevideo = SingleVideoModel().obs;
  final video = Rx<List<VideoModel>>([]);
  final newRelease = Rx<List<VideoModel>>([]);
  final isLoading = false.obs;
  final isLoading2 = false.obs;
  final isLoading3 = false.obs;

  @override
  void onInit() {
    fetchSingleVideo();
    fetchTrendingVideos();
    fetchNewReleaseVideo();
    super.onInit();
  }

  Future fetchSingleVideo() async {
    try {
      // generate random 3 digit number
      final randomMovie = (100 + (999 - 100) * 0.5).toInt();
      isLoading.value = true;
      var url = Uri.parse('${apiUrl}movie/$randomMovie?api_key=$apiKey');
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        isLoading.value = false;
        final content = json.decode(response.body) as Map<String, dynamic>;
        singlevideo.value = SingleVideoModel.fromJson(content);
        // print(content);
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future fetchTrendingVideos() async {
    try {
      isLoading2.value = true;
      var url = Uri.parse('$apiUrl/trending/all/day?api_key=$apiKey');
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        isLoading2.value = false;
        final content = json.decode(response.body);
        for (var item in content['results']) {
          video.value.add(VideoModel.fromJson(item));
        }
        print('Treding $content');
      }
    } catch (e) {
      isLoading2.value = false;
      debugPrint(e.toString());
    }
  }

  Future fetchNewReleaseVideo() async {
    try {
      isLoading3.value = true;
      var url = Uri.parse('$apiUrl/trending/all/week?api_key=$apiKey');
      final http.Response response = await http.get(url);
      if (response.statusCode == 200) {
        isLoading3.value = false;
        final content = json.decode(response.body);
        for (var item in content['results']) {
          newRelease.value.add(VideoModel.fromJson(item));
        }
        print('New $content');
      }
    } catch (e) {
      isLoading3.value = false;
      debugPrint(e.toString());
    }
  }
}
