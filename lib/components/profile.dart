import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 200,
          ),
          height: 200,
          top: 20,
        ),
        Positioned.fill(
          child: Column(
            children: [
              Text('Hello'),
            ],
          ),
        )
      ],
    );
  }
}
