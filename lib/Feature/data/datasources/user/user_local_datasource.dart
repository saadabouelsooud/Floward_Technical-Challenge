import 'dart:convert';

import 'package:floward_task/Feature/data/models/user_model.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/utils/prefrences_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource
{
  Future<UserModel> getUserByUserId(int userId);
  Future<void> cacheUsers(List<UserModel> users);
  Future<List<UserModel>> getCacheUsers();

}

class UserLocalDataSourceImpl implements UserLocalDataSource
{
  final SharedPreferences? sharedPreferences;

  UserLocalDataSourceImpl({this.sharedPreferences});

  @override
  Future<void> cacheUsers(List<UserModel> users) {
    return SharedPreferenceUtils.putObjectList("users", users);
  }

  @override
  Future<UserModel> getUserByUserId(int userId) {
    final jsonString = sharedPreferences!.getString(userId.toString());
    if(jsonString != null)
    {
      return Future.value(UserModel.fromJsonObject(json.decode(jsonString)));
    }
    else
    {
      throw CacheException();
    }
  }

  @override
  Future<List<UserModel>> getCacheUsers() {
    var users = SharedPreferenceUtils.getObjList<UserModel>(
        "users", (v) => UserModel.fromJsonObject(v as Map<String, dynamic>));
    if(users != null)
    {
      return Future.value(UserModel.fromJsonList(users));
    }
    else
    {
      throw CacheException();
    }
  }

}