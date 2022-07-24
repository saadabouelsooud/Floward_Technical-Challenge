import 'dart:convert';

import 'package:floward_task/Feature/data/models/post_model.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/utils/prefrences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSource
{
  Future<PostModel> getPostByPostId(int PostId);
  Future<void> cachePosts(List<PostModel> Posts);
  Future<List<PostModel>> getCachePosts();

}

class PostLocalDataSourceImpl implements PostLocalDataSource
{
  final SharedPreferences? sharedPreferences;

  PostLocalDataSourceImpl({this.sharedPreferences});

  @override
  Future<void> cachePosts(List<PostModel> posts) {
    return SharedPreferenceUtils.putObjectList("Posts", posts);
  }

  @override
  Future<PostModel> getPostByPostId(int PostId) {
    final jsonString = sharedPreferences!.getString(PostId.toString());
    if(jsonString != null)
    {
      return Future.value(PostModel.fromJsonObject(json.decode(jsonString)));
    }
    else
    {
      throw CacheException();
    }
  }

  @override
  Future<List<PostModel>> getCachePosts() {
    var Posts = SharedPreferenceUtils.getObjList<PostModel>(
        "Posts", (v) => PostModel.fromJsonObject(v as Map<String, dynamic>));
    if(Posts != null)
    {
      return Future.value(PostModel.fromJsonList(Posts));
    }
    else
    {
      throw CacheException();
    }
  }

}