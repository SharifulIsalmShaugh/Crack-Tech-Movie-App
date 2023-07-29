import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../utils/constrains.dart';
import '../data/movieDataResponse.dart';

class Repo {
  static Future<MovieDataResponse?> movieDataResponseApi() async {
    String dataUrl =
        "${Constants.BASEURL}/erik-sytnyk/movies-list/master/db.json";
    var dioClient = Dio();
    dioClient.options.headers['Accept'] = "application/json";
    dioClient.options.headers['content-Type'] = 'application/json';
    dioClient.options.headers['Access-Control-Allow-Origin'] = '*';
    dioClient.options.headers["X-Requested-With"] = "XMLHttpRequest";
    dioClient.options.headers['Access-Control-Allow-Credentials'] = true;
    dioClient.options.headers['Access-Control-Allow-Headers'] = {
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale"
    };
    dioClient.options.headers['Access-Control-Allow-Methods'] =
        "POST, GET, OPTIONS, PUT, DELETE, HEAD";
    try {
      final response = await dioClient.get(dataUrl);
      var box = Hive.box('movieDataList');
      Map<String, dynamic> result = jsonDecode(response.data);
      box.put(Constants.APIRESPONSE,
          jsonEncode(MovieDataResponse.fromJson(result)));
      return MovieDataResponse.fromJson(result);
    } on DioError catch (e) {
      debugPrint('DIO error movieDataResponseApi: ${e.response}');
    }
  }
}
