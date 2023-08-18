import 'package:flutter/material.dart';

import '../../../helperFiles/colorCodes/colorCodes.dart';
import '../../../helperFiles/commonWidgets/commonWidgets.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(  appBar: AppBar(elevation:0,
        backgroundColor: ColorCodes.teal_green,
        automaticallyImplyLeading: false,
        title: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(child: const Icon(Icons.arrow_back,size: 22,),onTap: (){
              Navigator.pop(context);
            },),
            const SizedBox(width: 10,),
            const CircleAvatar(backgroundImage: AssetImage("assets/images/man_placeholder.png"),radius: 15 ,backgroundColor: Colors.white),
            const SizedBox(width: 8,),
            CustomText(text: "Flutter Friend", fontColor: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            const Spacer(),
            const Icon(Icons.add_call,size: 22,),
            const SizedBox(width: 20,),
            const Icon(Icons.more_vert,size: 22,)
          ],)),
      body: Container(height:MediaQuery.of(context).size.height, width: MediaQuery.of(context).size.width
        ,decoration: const BoxDecoration(
        image: DecorationImage(opacity: 0.6,
            image: AssetImage("assets/images/chat_background.png"),
            fit: BoxFit.cover),
      ),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      const SizedBox(height: 30,),

      Center(
        child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: ColorCodes.encryiption_background),
          width:280,child: Padding(
          padding: const EdgeInsets.only(top: 8,bottom: 8,left: 14,right: 14),
          child: Wrap(crossAxisAlignment: WrapCrossAlignment.center,children: [

            Text(textAlign: TextAlign.center,
              "Messages and calls are end-to-end encrypted.No one outside of this char,not even WhatsApp, can read or listen to them.\nTap to learn More",style: TextStyle(
              fontFamily: 'Helvetica',
              fontSize: 13,
              color: Colors.black.withOpacity(0.7),
              fontWeight: FontWeight.w400,
            ),)

           // CustomText(text: "Messages and calls are end-to-end encrypted.No one outside of this char,not even WhatsApp, can read or listen to them.\nTap to learn More", fontColor: Colors.black.withOpacity(0.6), fontSize: 11, fontWeight: FontWeight.w400)
          ],),
        ),),
      )


    ],),
      ),);
  }
}
