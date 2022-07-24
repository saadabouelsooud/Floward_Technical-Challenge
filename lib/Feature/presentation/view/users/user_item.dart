import 'package:floward_task/Feature/domain/entities/user.dart';
import 'package:floward_task/Feature/presentation/view/posts/user_post_count.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget
{
  final User userModel;
  UserItem(this.userModel);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(userModel.thumbnailUrl!),
              ),
            ),
            Container (
              // width: 100,
              child: Column (
                children: <Widget>[
                  Text (userModel.name!, style: TextStyle(fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0,top: 2),
                    child: UserPostCount(userModel.userId!),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}