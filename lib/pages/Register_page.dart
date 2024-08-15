import 'package:flutter/material.dart';
import 'package:frontend/Service.dart';
import 'package:frontend/pages/Login_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class Register_Page extends StatefulWidget {
  const Register_Page({super.key});
  @override
  State<Register_Page> createState() => _Register_PageState();
}

class _Register_PageState extends State<Register_Page> {
  // สร้างตัวแปล เพื่อเก็บข้อมูลที่ป้อนเข้ามา จาก TextField
  var _nameController = TextEditingController();
  var _name_or_emailController = TextEditingController();
  var _passwordController = TextEditingController();
  // รูปภาพจาก Gallery ที่เป็น Base64
  static late String _photo = '';

  // เปิด Gallery เพื่อเลือกรูปภาพในเครื่อง
  final ImagePicker _picker = ImagePicker();
  Future<void> image_From_Gallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // อ่านไฟล์รูปภาพเป็น bytes
      List<int> imageBytes = await pickedFile.readAsBytes();
      // แปลง bytes เป็น Base64
      _photo = _photo + base64Encode(imageBytes);
      // ทำสิ่งที่คุณต้องการกับ base64Image
      print('Base64 Image: $_photo');
    } else {
      // ผู้ใช้ยกเลิกการเลือกรูป
      print('User cancelled image picker');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 4, 54, 74)),
        child: Center(
          child: ListView(
            shrinkWrap: true, // กลางหน้าจอ Row
            children: [
              Column(
                children: <Widget>[
                  //====================================================================== พื้นที่ขาว
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                    child: Card(
                      color: Color.fromARGB(255, 255, 255, 255),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              //============================================================ Name
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20),
                                  decoration:
                                      const InputDecoration(labelText: 'Name'),
                                  controller:
                                      _nameController, // เก็บข้อมูลที่ป้อนเข้ามาไว้ในตัวแปล _nameController
                                ),
                              ),
                              //============================================================ Email
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20),
                                  decoration:
                                      const InputDecoration(labelText: 'Email'),
                                  controller:
                                      _name_or_emailController, // เก็บข้อมูลที่ป้อนเข้ามาไว้ในตัวแปล _name_or_emailController
                                ),
                              ),
                              //============================================================ Password
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 0),
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 20),
                                  decoration: const InputDecoration(
                                      labelText: 'Password'),
                                  obscureText:
                                      true, // ป้องกันข้อความให้มองไม่เห็นหรือไม่: true = ใช่/ป้องกัน
                                  controller:
                                      _passwordController, // เก็บข้อมูลที่ป้อนเข้ามาไว้ในตัวแปล _passwordController
                                ),
                              ),
                              //============================================================ เกิด Gallery เพื่อเลือกรูปภาพ Photo
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
                                child: Center(
                                  child: IconButton(
                                    iconSize: 40.0,
                                    icon: Icon(Icons.photo),
                                    color: Color.fromARGB(255, 4, 54, 74),
                                    onPressed:
                                        image_From_Gallery, // เปิด Gallery ในเครื่อง
                                  ),
                                ),
                              ),
                              //====================================================================== ปุ่ม Register
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 56, 114, 110)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () async {
                                  bool isLogin = await Service.register(
                                      _nameController.text,
                                      _name_or_emailController.text,
                                      _passwordController.text,
                                      _photo);
                                  // ถ้าใส่ข้อมูลภูกต้อง ให้ไปหน้า Menu_Main (bottomNavigationBar) โดยจะแสดงหน้า Home_Page เป็นหน้าแรก
                                  if (isLogin) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Login_Page()));
                                  } else {
                                    // ถ้าใส่ข้อมูล Login ผืดก็ให้อยู่หน้าเดิม
                                    setState(() {});
                                  }
                                },
                                child: Text('REGISTER'),
                              ),
                              //====================================================================== ปุ่ม Cancle
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 150, 69, 51)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login_Page()));
                                },
                                child: Text('CANCEL'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
