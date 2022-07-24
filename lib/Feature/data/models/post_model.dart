import 'package:floward_task/Feature/domain/entities/post.dart';

class PostModel extends Post
{
  PostModel({int? userId,int? id,String? title,String? body}) : super(userId: userId,id: id,title: title,body: body);

  factory PostModel.fromJsonObject(Map<String,dynamic> json)
  {
    return PostModel(userId: json['userId'], id: json['id'],title: json['title'],body: json['body']);
  }

  static List<PostModel> fromJsonList(List<dynamic> jsonList)
  {
    List<PostModel> list = [];
    for (var element in jsonList) {
      list.add(PostModel.fromJsonObject(element));
    }
    return list;
  }

  Map<String,dynamic> toJson() {
    return {
      "userId": userId,
      "id": id,
      "title": title,
      "body": body
    };
  }
}