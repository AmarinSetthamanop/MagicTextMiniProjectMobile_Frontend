import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Service.dart';
import 'package:frontend/models/friend.dart';
import 'package:frontend/models/index.dart';

class Massage_Page extends StatefulWidget {
  final Friend friend;
  const Massage_Page({super.key, required this.friend});

  @override
  State<Massage_Page> createState() => _ChatPageState(friend: friend);
}

class _ChatPageState extends State<Massage_Page> {
  // เพื่อน ที่จะคุย
  final Friend friend;
  _ChatPageState({required this.friend});
  // ข้อความที่คุยกัน
  static late Massages massages;
  // textField
  TextEditingController messageController = TextEditingController();
  // ตัวแปลที่บอกว่า กำลังโหลดข้อมูล อยู่หรือไม่
  bool isLoading = false;
  // Check if the message is sent by the user or the friend

  // initState จะทำงานก่อนเสมอเมื่อสร้าง สร้าง class...
  // select รูปทั้งหมดของคนนั้น
  @override
  void initState() {
    super.initState();
    isLoading = true; // กำหลังโหลดข้อมูล
    massages = Massages();
    Service.getMassages(friend.FID).then((massagesFromServer) {
      setState(() {
        massages = massagesFromServer;
        isLoading = false; // โหลดข้อมูลเสร็จสิ้น
      });
    });
  }

  //========================================================================================build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //================================================================================ app bar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 107, 135),
        title: Row(children: [
          ClipOval(
            child: Image.memory(
              base64Decode(friend.photo),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          Text('  ${friend.name}')
        ]),
        //======================================================================= ปุ่ม reload หน้า
        actions: [
          IconButton(
            icon: Icon(Icons.replay_circle_filled_rounded),
            onPressed: () => setState(() {
              // select ข้อมูลการพูดคุยใหม่
              Service.getMassages(friend.FID).then((massagesFromServer) {
                setState(() {
                  massages = massagesFromServer;
                });
              });
            }),
          )
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 219, 225, 226),
        padding: const EdgeInsets.all(10.0),
        child: isLoading // ถ้าโหลดข้อมูลอยู่ (true) ให้แสดงการโหลด
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                // ถ้าโหลดข้อมูลเสร็จแล้ว (flase) จะแสดงข้อมูล
                children: <Widget>[
                  // แสดง list ของ ข้อความที่คุยกัน
                  listMassage(),
                  //========================================================================= Text field ใส่ข้อมูล
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                            ),
                          ),
                        ),
                        //======================================================================== ปุ่มกดส่ง
                        IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            sendMessage(); // เรียก method ส่งข้อความ
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  //============================================================================ list Massages (Widget) เรียกใช้ตัวแสดงข้อความ
  Widget listMassage() {
    return Expanded(
      child: ListView.builder(
        itemCount: massages.massages == null ? 0 : massages.massages.length,
        itemBuilder: (BuildContext context, int index) {
          return rowMassage(index);
        },
      ),
    );
  }

  //============================================================================ row Massages (Widget) แสดงข้อความแต่ละแถว
  Widget rowMassage(int index) {
    bool isFriendMessage = massages!.massages[index].name == friend.name;
    return Container(
      child: SizedBox.fromSize(
        size: Size(60, 60),
        child: Row(
          children: <Widget>[
            //=========================================== ถ้าเป็นข้อความของเพื่อน
            if (isFriendMessage)
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft, // แสดงข้อความฝั่ง ซ้าย
                  child: Card(
                    color: Color.fromARGB(255, 200, 183, 183),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '${massages!.massages[index].massage}',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
            //=========================================== ถ้าเป็นข้อความของเราเอง
            if (isFriendMessage != true)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight, // แสดงข้อความฝั่ง ขวา
                  child: Card(
                    color: Color.fromARGB(255, 81, 173, 207),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        '${massages!.massages[index].massage}',
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  //==================================================================================== ส่งข้อความ
  void sendMessage() {
    String content = messageController.text.trim();
    if (content.isNotEmpty) {
      //Message newMessage = Message(sender: 'You', content: content);
      setState(() {
        // เพิ่มข้อมูลการพูดคุยลง database
        Service.sentMessage(
            friend.FID, friend.friendID, messageController.text);
        // select ข้อมูลการพูดคุยใหม่
        Service.getMassages(friend.FID).then((massagesFromServer) {
          setState(() {
            massages = massagesFromServer;
          });
        });
        messageController.clear();
      });
    }
  }
}
