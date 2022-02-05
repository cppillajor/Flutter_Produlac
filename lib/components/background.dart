import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  final Widget child;
  const BackGround({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/top1.png',
              // color: Colors.blue,
              width: size.width,
              height: size.height * 0.1463,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/images/top2.png',
              // color: Colors.blueAccent,
              width: size.width,
              height: size.height * 0.1902,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: size.height * 0.1024,
            //right: 20,
            left: size.width * 0.0486,
            child: Image.asset(
              'assets/images/produlac.png',
              width: size.width * 0.4861,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bottom1.png',
              width: size.width,
              height: size.height * 0.1902,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/bottom2.png',
              width: size.width,
              height: size.height * 0.1463,
              fit: BoxFit.fill,
            ),
          ),
          child
        ],
      ),
    );
  }
}
