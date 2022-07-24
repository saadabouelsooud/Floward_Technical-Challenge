import 'package:floward_task/Feature/domain/entities/post.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget
{
  final Post postModel;
  PostItem(this.postModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Column(
        children: [
          Text(postModel.title!),
          SizedBox(height: 20,),
          Text(postModel.body!),
        ],
      ),
    );
  }

}