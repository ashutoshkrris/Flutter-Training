import 'package:first_app/screens/home.dart';
import 'package:first_app/screens/login.dart';
import 'package:first_app/session/session_management.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashScreen extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (BuildContext context, AsyncSnapshot<FirebaseApp> snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "Let's Hang Out!",
                  style: TextStyle(
                    fontFamily: 'productSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                  ),
                ),
                // imageZone(),
                SizedBox(
                  height: 30.0,
                ),
                Image.asset("assets/images/welcome.png"),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  width: 200.0,
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (snapshot.connectionState == ConnectionState.done) {
                        performRouting(context);
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                    child: Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'productSans',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 50),
                      elevation: 20,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void performRouting(BuildContext context) {
    SessionManagement.getLoggedInStatus().then((value) {
      value
          ? Navigator.pushNamed(context, HomeScreen.ROUTE_HOME)
          : Navigator.pushNamed(context, LoginScreen.ROUTE_LOGIN);
    }).catchError((onError) => print(onError));
  }

// Widget imageZone() {
//   return Container(
//     height: 400,
//     child: PageView.builder(
//       itemBuilder: (ctx, index) => Column(
//         children: [
//           Expanded(
//             child: ClipRRect(
//               child: Image.network(LocalData.imageList[index]['image']),
//             ),
//           ),
//           Text(LocalData.imageList[index]['title']),
//         ],
//       ),
//       itemCount: LocalData.imageList.length,
//     ),
//   );
// }
}
