import 'dart:convert';
import 'package:frontend/Service.dart';
import 'package:flutter/material.dart';
import 'package:frontend/pages/EditProfile_page.dart';
import 'package:frontend/pages/Login_page.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({Key? key}) : super(key: key);

  @override
  State<Profile_Page> createState() => _Profile_PageState();
}

class _Profile_PageState extends State<Profile_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 107, 135),
        automaticallyImplyLeading: false, // ไม่ให้แสดงปุ่มย้อนกลับ
        title: Center(child: Text('Profile')),
      ),
      body: Container(
        color: Color.fromARGB(255, 4, 54, 74),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                color: Color.fromARGB(255, 218, 255, 251),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                ),
                child: SizedBox(
                    width: 350,
                    height: 300,
                    child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //=================================================================== แถวที่ 1
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // รูป
                                ClipOval(
                                  child: Image.memory(
                                    base64Decode(Service.user.photo),
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // ชื่อ
                                Text('${Service.user.name}'),
                                // ปุ่ม edit
                                IconButton(
                                  icon: Icon(Icons.edit_document),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EditProfile_Page()));
                                  },
                                )
                              ],
                            ),
                            //============================================================================= แถวที่ 2
                            Padding(padding: EdgeInsets.all(10.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // icon email
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Icon(Icons.email_outlined),
                                ),
                                // user email
                                Text('     ${Service.user.email}')
                              ],
                            ),
                            //=========================================================================== แถวที่ 3
                            Padding(padding: EdgeInsets.all(10.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // icon
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                                  child: Icon(Icons.family_restroom),
                                ),
                                // user friends
                                Text('     ${Service.user.friend_count}')
                              ],
                            ),
                            //=========================================================================== แถวที่ 4
                            Padding(padding: EdgeInsets.all(10.0)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // icon Exit
                                Padding(
                                  padding: EdgeInsets.fromLTRB(18, 0, 0, 0),
                                  child: IconButton(
                                    color: Color.fromARGB(255, 182, 43, 43),
                                    icon: Icon(Icons.exit_to_app),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Login_Page()));
                                    },
                                  ),
                                ),
                                // text Exit
                                TextButton(
                                  child: Text('Log out'),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromARGB(
                                                  255, 182, 43, 43))),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Login_Page()));
                                  },
                                )
                              ],
                            ),
                          ]),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
