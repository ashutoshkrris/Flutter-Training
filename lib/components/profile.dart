import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _profileImage = null;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        fit: StackFit.loose,
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            backgroundImage: _profileImage == null
                ? NetworkImage(
                    "https://k2partnering.com/wp-content/uploads/2016/05/Person.jpg")
                : FileImage(_profileImage),
            radius: 80,
          ),
          FloatingActionButton(
            onPressed: showModal,
            child: Icon(Icons.edit),
          ),
        ],
      ),
    );
  }

  void editPicture(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  void showModal() {
    showModalBottomSheet(
        context: context,
        builder: (build) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  child: Icon(Icons.camera_alt, size: 50),
                  onTap: () {
                    editPicture(ImageSource.camera);
                    Navigator.pop(build);
                  },
                ),
                InkWell(
                  child: Icon(Icons.image, size: 50),
                  onTap: () {
                    editPicture(ImageSource.gallery);
                    Navigator.pop(build);
                  },
                )
              ],
            ),
          );
        });
  }
}
