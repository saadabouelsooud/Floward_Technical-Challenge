

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:floward_task/Feature/data/models/post_model.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/network/api/api.dart';
import 'package:floward_task/core/network/api/http_api.dart';

abstract class PostsApi{
  Future<Response?> callPostsAPI();
  Future<Response?> callUserPostsAPI(int userId);
}

abstract class PostRemoteDataSource
{
  Future<List<PostModel>> getPosts();
  Future<List<PostModel>> getUserPosts(int userId);

}

class PostRemoteDataSourceImpl implements PostRemoteDataSource, PostsApi
{

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      var response = await callPostsAPI();
      var data = response!.data;
      return PostModel.fromJsonList(data);
    } on IOException
        {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getUserPosts(int userId) async{
    try {
      var response = await callUserPostsAPI(userId);
      var data = response!.data;
      return PostModel.fromJsonList(data);
    } on IOException
    {
      throw ServerException();
    }
  }

  @override
  Future<Response?> callUserPostsAPI(int userId) {
    String url = EndPoint.userPosts+userId.toString();
    return HttpApi.request(url,
        type: RequestType.Get, onSendProgress: (int count, int total) {  }, queryParameters: {}, headers: {});
  }

  @override
  Future<Response?> callPostsAPI() {
    return HttpApi.request(EndPoint.posts,
        type: RequestType.Get, onSendProgress: (int count, int total) {  }, queryParameters: {}, headers: {});
  }


}