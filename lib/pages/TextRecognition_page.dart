import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/Service.dart';
import 'package:frontend/models/index.dart';

class TextRecognition_page extends StatefulWidget {
  final Photo photo;
  const TextRecognition_page({Key? key, required this.photo}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>
      _TextRecognitionPageState(photo: photo);
}

class _TextRecognitionPageState extends State<TextRecognition_page> {
  final Photo photo;
  static late Ocr ocr;
  // ตัวแปลที่บอกว่า กำลังโหลดข้อมูล อยู่หรือไม่
  bool isLoading = false;

  _TextRecognitionPageState({Key? key, required this.photo});

  // กำหนดค่าให้กับ ocr เมื่อเปิดหน้านี้ขึ้นมา
  @override
  void initState() {
    super.initState();
    isLoading = true; // กำหลังโหลดข้อมูล
    ocr = Ocr(); // ตั้งค่าเริ่มต้นให้ ocr
    Service.ocrMethod(photo.base64).then(
      (ocrFromServer) {
        setState(() {
          ocr = ocrFromServer;
          isLoading = false; // โหลดข้อมูลเสร็จสิ้น
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //======================================================================== AppBar
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 23, 107, 135),
          title: const Text('Text Recognition')),
      //========================================================================= Body
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  // แสดงรูปภาพ
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0), //ขอบโค้ง
                      child: Image.memory(
                        base64Decode(photo.base64),
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // แสดงข้อความ
                  Container(
                    child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child:
                            isLoading // ถ้าโหลดข้อมูลอยู่ (true) ให้แสดงการโหลด
                                ? Center(
                                    child:
                                        CircularProgressIndicator(), // แสดงการโหลด
                                  )
                                : Text('${ocr.ocr_text_delete_spaces}')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
