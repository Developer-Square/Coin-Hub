import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:Coin_Hub/view/navBart.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double myWidth = MediaQuery.of(context).size.width;
    double myHeight = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: myWidth,
        height: myHeight,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Image.asset('assets/image/1.gif'),
          Column(
            children: [
              const Text(
                'The Future',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: myHeight * 0.02),
              const Text(
                'Learn more about cryptocurrency, look to',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
              SizedBox(height: myHeight * 0.008),
              const Text(
                ' the future in IO crypto',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: myWidth * 0.14),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const NavBar()));
              },
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xffFBC700),
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: myWidth * 0.05, vertical: myHeight * 0.01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Create Portfolio',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      RotationTransition(
                        turns: AlwaysStoppedAnimation(310 / 360),
                        child: Icon(Icons.arrow_forward_rounded),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    ));
  }
}
