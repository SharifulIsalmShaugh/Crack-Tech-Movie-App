import 'dart:async';
import 'dart:convert';
import 'package:crack_tech_app/utils/constrains.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../../data/movieDataResponse.dart';
import '../../../repository/appRepository.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final Rx<MovieDataResponse> movieData = MovieDataResponse().obs;
  final filteredMovies = RxList<Movie>();
  final isLoading = false.obs;
  final selectedIndex = 0.obs;
  final selectedName = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    localDataCall();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  selectedGenres(int index, String name){
    selectedIndex.value = index;
    selectedName.value = name;

    filteredMovies.value = movieData.value.movies!.where((movie) {
      List<String>? genres = movie.genres;
      return genres!.contains(name);
    }).toList();
    update();
  }

  localDataCall(){
    isLoading.value = true;
    var box = Hive.box('movieDataList');
    if(box.get(Constants.APIRESPONSE) != null){
      Map<String, dynamic>  json = jsonDecode(box.get(Constants.APIRESPONSE));
      movieData.value = MovieDataResponse.fromJson(json);
      selectedGenres(0, movieData.value.genres!.first);
      debugPrint("Print from local data");
      isLoading.value = false;
    }else{
      movieDataCall();
    }
  }

  Future<MovieDataResponse?> movieDataCall() async {
    isLoading.value = true;
    await Repo.movieDataResponseApi().then((response) {
      if(response != null) {
        movieData.value = response;
        selectedGenres(0, movieData.value.genres!.first);
      }
      isLoading.value = false;
    });
    update();
  }

  navigateToDetails(Movie movie){
    Get.toNamed(Routes.DETAILS,arguments: {Constants.MOVIE:movie});
  }
}
