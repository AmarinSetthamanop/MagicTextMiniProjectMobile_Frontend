import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Service.dart';
import 'package:frontend/menu/Friends_page.dart';
import 'package:frontend/models/notFriend.dart';
import 'package:frontend/models/notFriends.dart';

class SearchsFriends_Page extends StatefulWidget {
  const SearchsFriends_Page({super.key});
  @override
  State<SearchsFriends_Page> createState() => _SearchsFriends_Page();
}

class _SearchsFriends_Page extends State<SearchsFriends_Page> {
  // หน่วงเวลา
  final debouncer = Debouncer(milliseconds: 1000);
  // คนที่ไม่ใช่เพื่อน user คนนี้
  static late NotFriends notFriends;
  // ตัวแปลที่บอกว่า กำลังโหลดข้อมูล อยู่หรือไม่
  bool isLoading = false;

  // initState จะทำงานก่อนเสมอเมื่อสร้าง สร้าง class...
  // select รูปทั้งหมดของคนนั้น
  @override
  void initState() {
    super.initState();
    isLoading = true; // กำหลังโหลดข้อมูล
    notFriends = NotFriends();
    Service.getNotFriends().then((notFriendsFromServer) {
      setState(() {
        notFriends = notFriendsFromServer;
        isLoading = false; // โหลดข้อมูลเสร็จสิ้น
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //============================================================================= app bar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 107, 135),
        title: Text('Searchs Friends'),
      ),
      //============================================================================== body
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
                  searchFriends(),
                  // แสดง list ของ รูปภาพ
                  listNotFriends(),
                ],
              ),
      ),
    );
  }

  //============================================================================textField ค้นหาเพื่อน
  Widget searchFriends() {
    return TextField(
      decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(15.0),
          hintText: 'name or email'),
      onChanged: (string) {
        debouncer.run(() {
          print('Searching...');
        });
        Service.getNotFriends().then((notFriendseFromServer) {
          setState(() {
            notFriends = filterList(notFriendseFromServer, string);
          });
        });
      },
    );
  }

  // ค้นหา คนที่ไม่ใช่เพื่อด้วยชื่อ หรือ email
  static NotFriends filterList(NotFriends notFriends, String filterString) {
    NotFriends tempNotFriends = notFriends;
    List<NotFriend> notFriendsList = tempNotFriends.notFriends
        .where((nf) =>
            (nf.name.toLowerCase().contains(filterString.toLowerCase())) ||
            (nf.email.toLowerCase().contains(filterString.toLowerCase())))
        .toList();
    notFriends.notFriends = notFriendsList;
    return notFriends;
  }

  //============================================================================ lis Not Friends (Widget)
  Widget listNotFriends() {
    return Expanded(
      child: ListView.builder(
        itemCount:
            notFriends.notFriends == null ? 0 : notFriends.notFriends.length,
        itemBuilder: (BuildContext context, int index) {
          return rowNotFriend(index);
        },
      ),
    );
  }

  //============================================================================ row Not Friend (Widget)
  Widget rowNotFriend(int index) {
    return Card(
      color: Color.fromARGB(255, 218, 255, 251),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              // แสดง รูปภาพ
              leading: Image.memory(
                base64Decode(notFriends!.notFriends[index].photo),
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
              // แสดงชื่อ
              title: Text(
                // 'Name: ${notFriends!.notFriends[index].name}',
                '${notFriends!.notFriends[index].name}',
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
              // ปุ่มเพิ่มเพื่อน
              trailing: IconButton(
                icon: Icon(Icons.add_circle),
                color: Color.fromARGB(255, 4, 54, 74),
                onPressed: () {
                  Service.addFriend(notFriends!.notFriends[index].UID);
                  Service.getNotFriends().then((notFriendsFromServer) {
                    setState(() {
                      notFriends = notFriendsFromServer;
                    });
                  });
                  Service.selectUserByID();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// delay รอเวลาเมื่อค้นหา
class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;
  Debouncer({required this.milliseconds});
  run(VoidCallback action) {
    if (null != _timer) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
