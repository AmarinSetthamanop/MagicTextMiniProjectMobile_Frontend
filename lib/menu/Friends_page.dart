import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Service.dart';
import 'package:frontend/menu/Menu_main.dart';
import 'package:frontend/models/friends.dart';
import 'package:frontend/models/index.dart';
import 'package:frontend/pages/Massage_page.dart';
import 'package:frontend/pages/SearchsFriends_page.dart';
import 'package:flutter/services.dart';

class Friends_Page extends StatefulWidget {
  const Friends_Page({Key? key}) : super(key: key);

  @override
  State<Friends_Page> createState() => _Friends_PageState();
}

class _Friends_PageState extends State<Friends_Page> {
  // เพื่อนทั้งหมดของ user คนนี้
  static late Friends friends;
  // ตัวแปลที่บอกว่า กำลังโหลดข้อมูล อยู่หรือไม่
  bool isLoading = false;

  // initState จะทำงานก่อนเสมอเมื่อสร้าง สร้าง class...
  // select รูปทั้งหมดของคนนั้น
  @override
  void initState() {
    super.initState();
    isLoading = true; // กำหลังโหลดข้อมูล
    friends = Friends();
    Service.getFriends().then((friendsFromServer) {
      setState(() {
        friends = friendsFromServer;
        isLoading = false; // โหลดข้อมูลเสร็จสิ้น
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //============================================================================ app Bar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 107, 135),
        automaticallyImplyLeading: false, // ไม่ให้แสดงปุ่มย้อนกลับ
        title: Text('Friends'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchsFriends_Page()));
            },
          ),
        ],
      ),
      //================================================================================= body
      body: Container(
        color: Color.fromARGB(255, 4, 54, 74),
        padding: const EdgeInsets.all(10.0),
        child: isLoading // ถ้าโหลดข้อมูลอยู่ (true) ให้แสดงการโหลด
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                // ถ้าโหลดข้อมูลเสร็จแล้ว (flase) จะแสดงข้อมูล
                children: <Widget>[
                  // แสดง list ของ รูปภาพ
                  listFriends(),
                ],
              ),
      ),
    );
  }

  //============================================================================ list Friends (Widget)
  Widget listFriends() {
    return Expanded(
      child: ListView.builder(
        itemCount: friends.friends == null ? 0 : friends.friends.length,
        itemBuilder: (BuildContext context, int index) {
          return rowFriend(index);
        },
      ),
    );
  }

  //============================================================================ row Friend (Widget)
  Widget rowFriend(int index) {
    return Card(
      color: Color.fromARGB(255, 218, 255, 251),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              // แสดง รูปภาพ เพื่อน
              leading: ClipOval(
                child: Image.memory(
                  base64Decode(friends!.friends[index].photo),
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              // แสดงชื่อของ เพื่อน
              title: Text(
                'Name: ${friends!.friends[index].name}',
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
              // ปุ่ม แชท และ ลบเพื่อน
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ปุ่ม แชท
                  IconButton(
                    icon: Icon(Icons.chat),
                    color: Color.fromARGB(255, 4, 54, 74),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Massage_Page(
                                  friend: friends!.friends[index])));
                      // Service.getMassages(friends!.friends[index].FID)
                      //     .then((massagesFromServer) {
                      //   setState(() {
                      //     Massages massages = massagesFromServer;
                      //     print(
                      //         "Massages is...${massages.massages[index].time}");
                      //   });
                      // });
                    },
                  ),
                  // ลบ เพื่อน คนนั้นๆ
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Color.fromARGB(255, 4, 54, 74),
                    onPressed: () {
                      setState(() {
                        Service.deleteFriend(friends!.friends[index].friendID);
                        Service.selectUserByID();
                      });
                      Service.getFriends().then((friendsFromServer) {
                        setState(() {
                          friends = friendsFromServer;
                        });
                      });
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
}
