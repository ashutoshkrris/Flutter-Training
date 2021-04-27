import 'package:first_app/data/local_data.dart';
import 'package:first_app/screens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(context, LoginScreen.ROUTE_LOGIN);
                },
                child: Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
