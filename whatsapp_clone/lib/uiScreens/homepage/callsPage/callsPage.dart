import 'package:flutter/material.dart';

import '../../../helperFiles/colorCodes/colorCodes.dart';
import '../../../helperFiles/commonWidgets/commonWidgets.dart';

class CallsPage extends StatefulWidget {
  const CallsPage({Key? key}) : super(key: key);

  @override
  State<CallsPage> createState() => _CallsPageState();
}

class _CallsPageState extends State<CallsPage> {
  @override
  Widget build(BuildContext context) {

    Widget createCallLink(){
      return Container(child: Row(mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         // CircleAvatar(backgroundImage: const AssetImage("assets/images/man_placeholder.png"),radius: 27 ,backgroundColor: Colors.white),

            Container(height: 50,width: 50,decoration: BoxDecoration(border: Border.all(color: Colors.white,width: 2),borderRadius:BorderRadius.circular(50),color: ColorCodes.teal_green),
              child: Center(child: Icon(Icons.link,color: Colors.white,size: 18,),),),
          SizedBox(width: 15,),
          Column(mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              CustomText(text: "Create call link", fontColor: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
              SizedBox(height: 5,),
              CustomText(text: "Share a link for your WhatsApp call", fontColor: Colors.grey.withOpacity(0.9), fontSize: 13, fontWeight: FontWeight.w500),
            ],)
        ],),);
    }

    Widget recentCalls(){
      return ListView.builder(shrinkWrap: true,
          itemCount: 8,
          physics: ScrollPhysics(),
          itemBuilder: (context,index){
            return Container(margin:EdgeInsets.only(bottom: 18),child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Container(height: 50,width: 50,decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),color: Colors.grey),),
                Container(decoration:BoxDecoration(borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: ColorCodes.light_green,width: 1.5)),child: CircleAvatar(backgroundImage: const AssetImage("assets/images/man_placeholder.png"),radius: 26 ,backgroundColor: Colors.white)),
                SizedBox(width: 15,),
                Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5,),
                    CustomText(text: "Flutter Friend", fontColor: Colors.red, fontSize: 15, fontWeight: FontWeight.w400),
                    SizedBox(height: 8,),
                   Row(mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.center,children: [
                     Icon(Icons.call_received,size: 19,color: Colors.red,),
                       SizedBox(width: 8,),
                       CustomText(text: "36 minutes ago", fontColor: Colors.black.withOpacity(0.5), fontSize: 13, fontWeight: FontWeight.w400),
                     ],),
                  ],),
                Spacer(),
                Icon(Icons.call,color: ColorCodes.teal_green,)
              ],),);
          });
    }


    return  Scaffold(
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.only(top: 20,right: 20,left: 20),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          createCallLink(),
          SizedBox(height: 20,),
          CustomText(text: "Recent", fontColor: Colors.grey.withOpacity(0.9), fontSize: 14, fontWeight: FontWeight.bold),
          SizedBox(height: 20,),
          recentCalls()

        ],),
      ),),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))
      ),
        child: Icon(Icons.add_call),
        backgroundColor: ColorCodes.teal_green,
        onPressed: () {
        },
      ),
    );
  }
}
