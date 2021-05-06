import '../components/chats.dart';
import '../components/contacts.dart';
import '../components/profile.dart';

class LocalData {
  static const List<Map<String, String>> imageList = [
    {
      'image': 'https://source.unsplash.com/collection/190727/1600x900',
      'title': 'Random Image 1'
    },
    {
      'image': 'https://source.unsplash.com/collection/190728/1600x900',
      'title': 'Random Image 2'
    },
    {
      'image': 'https://source.unsplash.com/collection/190726/1600x900',
      'title': 'Random Image 3'
    },
  ];

  static List<Map<String, dynamic>> bottomNavList = [
    {
      'screen': Chats(),
      'title': 'Chats'
    }, {
      'screen': Contacts(),
      'title': 'Contacts'
    }, {
      'screen': Profile(),
      'title': 'Profile'
    },
  ];
}
