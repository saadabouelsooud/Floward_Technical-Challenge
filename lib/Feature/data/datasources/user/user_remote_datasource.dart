import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:floward_task/Feature/data/models/user_model.dart';
import 'package:floward_task/core/error/exceptions.dart';
import 'package:floward_task/core/network/api/api.dart';
import 'package:floward_task/core/network/api/http_api.dart';


abstract class UsersApi{
  Future<Response?> callAPI();
}

abstract class UserRemoteDataSource
{
  Future<List<UserModel>> getUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource, UsersApi
{

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      var response = await callAPI();
      var data = response!.data;
      return UserModel.fromJsonList(data);
    } on IOException
        {
      throw ServerException();
    }
  }

  @override
  Future<Response?> callAPI() {
    return HttpApi.request(EndPoint.users,
        type: RequestType.Get, onSendProgress: (int count, int total) {  }, queryParameters: {}, headers: {});
  }

}