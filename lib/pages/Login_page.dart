import 'package:flutter/material.dart';
import 'package:frontend/Service.dart';
import 'package:frontend/menu/Menu_main.dart';
import 'package:frontend/pages/Register_page.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});
  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  // สร้างตัวแปล เพื่อเก็บข้อมูลที่ป้อนเข้ามา จาก TextField
  var _name_or_emailController = TextEditingController();
  var _passwordController = TextEditingController();

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
                              //============================================================ Image
                              Image(
                                image: AssetImage('images/image_login.png'),
                                height: 90,
                                width: 90,
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
                                    const EdgeInsets.fromLTRB(20, 10, 20, 50),
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
                              //====================================================================== ปุ่ม Login
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
                                  bool isLogin = await Service.login(
                                      _name_or_emailController.text,
                                      _passwordController.text);
                                  // ถ้าใส่ข้อมูลภูกต้อง ให้ไปหน้า Menu_Main (bottomNavigationBar) โดยจะแสดงหน้า Home_Page เป็นหน้าแรก
                                  if (isLogin) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Menu_Main()));
                                  } else {
                                    // ถ้าใส่ข้อมูล Login ผืดก็ให้อยู่หน้าเดิม
                                    setState(() {});
                                  }
                                },
                                child: Text('LOGIN'),
                              ),
                              //====================================================================== ปุ่ม Register
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color.fromARGB(255, 23, 107, 135)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                    ))),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Register_Page()));
                                },
                                child: Text('REGISTER'),
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
