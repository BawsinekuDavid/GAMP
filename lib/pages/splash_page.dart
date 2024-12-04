import 'package:flutter/material.dart';

import '../components/app_btn.dart';
import '../constant.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: BezierClipper(),
              child: Container(
                color:  colors,
                height: 400,
              ),
            ),
            const Text(
              "Welcome to FreshCarts",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Expanded(
                  child: Text(
                     "From fresh produce to everyday essentials, we're here to deliver the best to your door!",
                    // style: TextStyle(fontSize: 18.0,
                    // fontWeight: FontWeight.normal,
                    // color: bg),
                    style: kTitle(context),

                  ),
                ),
              ),
            
             
            const SizedBox(height: 60),

            Padding(padding: const EdgeInsets.symmetric(horizontal: 140),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color:  colors,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  
                ),
                Container(
                  width:15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  
                ),

_buldContianer()
              ],
            ),),
            const SizedBox(height: 60),

             AppBtn(lbl: 'Get Started', onPressed: () {
              Navigator.pushNamed(context, '/welcome');
             },textColorState: Colors.white, colorState: colors, )
              
           ],
        ),
      ),
    );
  }

Widget _buldContianer(){
  return                 Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(100)
                  ),
                  
                );
}

}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var height = size.height;
    var width = size.width;
    var heightOffset = height * 0.2;
    Path path = Path();

    path.lineTo(
      0,
      height - heightOffset,
    );
    path.quadraticBezierTo(
      width * 0.75,
      height - (heightOffset * 3),
      width,
      height - heightOffset,
    );
    path.lineTo(width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
