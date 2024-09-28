import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

/// Controller class to manage the image data and scrolling.
class ImageController extends GetxController {
  final String apiKey = '43434663-d265904f2024d757430d1556d';  // Replace with your actual API key.

  var images = [].obs;
  var isLoading = false.obs;
  int _page = 1;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _fetchImages();
    scrollController.addListener(_onScroll);
  }

  /// Fetches images from the Pixabay API.
  Future<void> _fetchImages() async {
    if (isLoading.value) return;

    isLoading.value = true;

    final url = Uri.parse(
        'https://pixabay.com/api/?key=$apiKey&image_type=photo&per_page=20&page=$_page');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      images.addAll(data['hits']);
      _page++;
    }

    isLoading.value = false;
  }

  /// Handles scrolling to load more images when reaching the bottom.
  void _onScroll() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent &&
        !isLoading.value) {
      _fetchImages();
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
