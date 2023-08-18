import 'package:flutter/material.dart';
import 'package:whatsapp_clone/helperFiles/colorCodes/colorCodes.dart';
import 'package:whatsapp_clone/helperFiles/commonWidgets/commonWidgets.dart';
import 'package:whatsapp_clone/uiScreens/homepage/chats/chatDetailPage.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      ListView.builder(physics: ScrollPhysics(),
          padding: EdgeInsets.only(top: 30,left: 20,right: 20),
          itemCount: 7,
          shrinkWrap: true,
          itemBuilder: (context,index){
        return GestureDetector(onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatDetailPage()));
        },
          child: Container(margin:EdgeInsets.only(bottom: 20),child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           // Container(height: 50,width: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey),),
            CircleAvatar(backgroundImage: const AssetImage("assets/images/man_placeholder.png"),radius: 26 ,backgroundColor: Colors.white),
            SizedBox(width: 15,),
            Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              CustomText(text: "Flutter Friend", fontColor: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
              SizedBox(height: 8,),
              CustomText(text: "ok", fontColor: Colors.black.withOpacity(0.5), fontSize: 13, fontWeight: FontWeight.w400),
            ],),
            Spacer(),
            Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 5,),
                CustomText(text: "1:18 pm", fontColor: ColorCodes.light_green, fontSize: 13, fontWeight: FontWeight.w400),
                SizedBox(height: 8,),
                Container(height:20,width:20,decoration:BoxDecoration(borderRadius: BorderRadius.circular(50),color: ColorCodes.light_green),
                  child: Center(child: CustomText(text: "1", fontColor: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),)
                ),
              ],)
          ],),),
        );
      })
    ],),
      );
  }
}
