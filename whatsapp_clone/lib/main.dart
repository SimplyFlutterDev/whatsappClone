import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helperFiles/colorCodes/colorCodes.dart';
import 'package:whatsapp_clone/uiScreens/welcomeScreen/welcomeScreen.dart';

import 'helperFiles/commonWidgets/commonWidgets.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => WelcomeScreen()));
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
    body: Center(child: Column(
      children: [
        Spacer(),
        CustomAssetImage(fileName: "whatsapp_white_logo.png",imageHeight: 100,imageWidth: 100,color: ColorCodes.light_green,),
        Spacer(),
        CustomAssetImage(fileName: "meta_logo.png",imageHeight: 80,imageWidth: 80,color: ColorCodes.light_green,),

      ],
    ),),);
  }
}
