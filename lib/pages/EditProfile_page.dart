import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Service.dart';
import 'package:frontend/menu/Menu_main.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile_Page extends StatefulWidget {
  const EditProfile_Page({super.key});
  @override
  State<EditProfile_Page> createState() => _EditProfile_Page();
}

class _EditProfile_Page extends State<EditProfile_Page> {
  // สร้างตัวแปล เพื่อเก็บข้อมูลที่ป้อนเข้ามา จาก TextField
  var _name_or_emailController = TextEditingController(
      text: Service.user.name); // กำหนดค่าเริ่มต้นของ name
  var _passwordController = TextEditingController();
  // รูปภาพ Base64
  // รูปภาพ Profile ที่มีอยู่แล้วของ user คนนั้น
  static late String _photoBase64 = Service.user.photo;

  //============================================================================== เลือกรูปจาก Gallery
  // เปิด Gallery เพื่อเลือกรูปภาพในเครื่อง
  final ImagePicker _picker = ImagePicker();
  Future<void> image_From_Gallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // อ่านไฟล์รูปภาพเป็น bytes
      List<int> imageBytes = await pickedFile.readAsBytes();
      // แปลง bytes เป็น Base64
      //ถ้าผู้ใช้เลือกรูปภาพจากเครื่องใหม่
      _photoBase64 = base64Encode(imageBytes);
      setState(() {});
      print('\n=====Base64 Image: $_photoBase64');
    } else {
      // ผู้ใช้ยกเลิกการเลือกรูป
      print('User cancelled image picker');
    }
    // รีหน้า
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //====================================================================== app Bar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 107, 135),
        title: Center(child: Text('Edit Profile')),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Color.fromARGB(255, 4, 54, 74),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //===================================================== รูป
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.memory(
                          base64Decode(Service.user.photo),
                          width: 170,
                          height: 170,
                          fit: BoxFit.cover,
                        ),
                      ),
                      // icon
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.mode_edit_outline_sharp),
                        onPressed: () {
                          image_From_Gallery();
                        },
                      )
                    ],
                  ),
                  //===================================================== card
                  Card(
                    color: Color.fromARGB(255, 255, 255, 255),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: SizedBox(
                        width: 350,
                        height: 250,
                        child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 5, 20, 0),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 20),
                                    decoration: const InputDecoration(
                                        labelText: 'Name'),
                                    controller:
                                        _name_or_emailController, // เก็บข้อมูลที่ป้อนเข้ามาไว้ในตัวแปล _name_or_emailController
                                  ),
                                ),
                                //============================================================ Password
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                              ]),
                        )),
                  ),
                  //====================================================================== ปุ่ม SAVE
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 56, 114, 110)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        onPressed: () async {
                          bool isSave = await Service.editProfile(
                              _name_or_emailController.text,
                              _passwordController.text,
                              _photoBase64);
                          // ถ้า update ข้อมูลได้ จะกลับไปหน้า Profile
                          if (isSave) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Menu_Main()));
                          } else {
                            // ถ้าใส่ข้อมูล Login ผืดก็ให้อยู่หน้าเดิม
                            setState(() {});
                          }
                        },
                        child: Text('SAVE'),
                      ),
                      //==================================================================== ปุ่ม Cancel
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 150, 69, 51)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Menu_Main()));
                        },
                        child: Text('CANCEL'),
                      ),
                    ],
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
