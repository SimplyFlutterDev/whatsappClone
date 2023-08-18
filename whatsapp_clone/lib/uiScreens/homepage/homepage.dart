import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helperFiles/colorCodes/colorCodes.dart';
import 'package:whatsapp_clone/helperFiles/commonWidgets/commonWidgets.dart';
import 'package:whatsapp_clone/uiScreens/homepage/statusPage/statusPage.dart';

import 'callsPage/callsPage.dart';
import 'chats/chatPage.dart';
import 'communityPage/communityPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int selectedTab = 1;
  PageController _pageController = PageController();
  List pages = [CommunityPage(),ChatPage(),StatusPage(),CallsPage()];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(elevation:0,
          backgroundColor: ColorCodes.teal_green,
          automaticallyImplyLeading: false,
          title: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(text: "WhatsApp", fontColor: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            Spacer(),
            Icon(Icons.camera_alt_outlined,size: 22,),
            selectedTab != 0 ? SizedBox(width: 20,) : Container(),
            selectedTab != 0 ? Icon(Icons.search,size: 22,) : Container(),
            SizedBox(width: 20,),
            Icon(Icons.more_vert,size: 22,)
          ],)),
      body: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: [
        Container(height: 40,color:ColorCodes.teal_green,
        padding: EdgeInsets.only(left: 15,right: 20),
        child: Row(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,children: [
          InkWell(onTap:(){
            setState((){
              selectedTab = 0;
            });
          },
              child: Icon(Icons.groups,color: selectedTab == 0 ? Colors.white.withOpacity(0.8) : Colors.white.withOpacity(0.5) ,)),
            SizedBox(width: 30,),
            InkWell(onTap: (){
              setState((){
                selectedTab = 1;
              });
            },
              child: Container(child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                child: Column(
                  children: [
                    CustomText(text: "Chats", fontColor: selectedTab == 1 ? Colors.white : Colors.white.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.bold),
                  ],
                ),
              )),
            ),
            Spacer(),
            InkWell(onTap: (){
              setState((){
                selectedTab = 2;
              });
            },
              child: Container(child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                child: CustomText(text: "Status", fontColor: selectedTab == 2 ? Colors.white : Colors.white.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.bold),
              )),
            ),            Spacer(),
            InkWell(onTap: (){
              setState((){
                selectedTab = 3;
              });
            },
              child: Container(child: Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                child: CustomText(text: "Calls", fontColor: selectedTab == 3 ? Colors.white : Colors.white.withOpacity(0.6), fontSize: 15, fontWeight: FontWeight.bold),
              )),
            ),            SizedBox(width: 10,)
          ],),),
        Container(height: 3,color: ColorCodes.teal_green,
        child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(height: 3,width: 60,color: selectedTab == 0 ? Colors.white : ColorCodes.teal_green,),
          Flexible(child: Container(color: selectedTab == 1 ? Colors.white : ColorCodes.teal_green,width: double.infinity,)),
          SizedBox(width: 3,),
          Flexible(child: Container(color: selectedTab == 2 ? Colors.white : ColorCodes.teal_green,width: double.infinity,)),
          SizedBox(width: 3,),
          Flexible(child: Container(color: selectedTab == 3 ? Colors.white : ColorCodes.teal_green,width: double.infinity,)),
          SizedBox(width: 20,),
        ],),),

        Flexible(
          child: Container(height: double.infinity,
            child: PageView.builder(physics: ScrollPhysics(),
                controller: _pageController,
                itemCount: 4,
                onPageChanged: (int value){
              setState((){
                selectedTab = value;
              });
                },
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                      /*  _pageController.jumpToPage(index); // for regular jump
                        _pageController.animateToPage(_position, curve: Curves.decelerate, duration: Duration(milliseconds: 300)); */// for animated jump. Requires a curve and a duration
                      },
                      child: pages[selectedTab]
                  );
                }
            ),
          ),
        ),
      ],),
    );
  }
}
