
import 'package:equatable/equatable.dart';
class User extends Equatable
{
  final int? albumId;
  final int? userId;
  final String? name;
  final String? url;
  final String? thumbnailUrl;


  const User({this.albumId,this.userId,this.name,this.url,this.thumbnailUrl});

  @override
  // TODO: implement props
  List<Object?> get props => [albumId,userId,name,url,thumbnailUrl];

}