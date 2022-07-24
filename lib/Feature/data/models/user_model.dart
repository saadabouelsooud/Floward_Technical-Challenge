import 'package:floward_task/Feature/domain/entities/user.dart';

class UserModel extends User
{
  UserModel({int? albumId,int? userId,String? name,String? url, String? thumbnailUrl}) : super(albumId: albumId,userId: userId,name: name,url: url, thumbnailUrl: thumbnailUrl);

  factory UserModel.fromJsonObject(Map<String,dynamic> json)
  {
    return UserModel(albumId: json['albumId'], userId: json['userId'],name: json['name'],url: json['url'],thumbnailUrl: json['thumbnailUrl']);
  }

  static List<UserModel> fromJsonList(List<dynamic> jsonList)
  {
    List<UserModel> list = [];
    for (var element in jsonList) {
      list.add(UserModel.fromJsonObject(element));
    }
    return list;
  }

  Map<String,dynamic> toJson() {
    return {
      "albumId": albumId,
      "userId": userId,
      "name": name,
      "url": url,
      "thumbnailUrl": thumbnailUrl
    };
  }
}