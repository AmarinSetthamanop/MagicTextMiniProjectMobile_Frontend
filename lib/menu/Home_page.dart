import 'package:flutter/material.dart';
import 'package:frontend/Service.dart';
import 'package:frontend/menu/Menu_main.dart';
import 'package:frontend/models/index.dart';
import 'package:frontend/pages/TextRecognition_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);
  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  // รูปภาพ Base64
  static late String _photoBase64;
  // ชื่อของรูปภาพที่ถูกเลือกจาก Gallery
  static late String _photoName = '';
  // รูปภาพทั้งหมดของ User คนนั้น
  static late Photos photos;
  // ตัวแปลที่บอกว่า กำลังโหลดข้อมูล อยู่หรือไม่
  bool isLoading = false;

  // initState จะทำงานก่อนเสมอเมื่อสร้าง สร้าง class...
  // select รูปทั้งหมดของคนนั้น
  @override
  void initState() {
    super.initState();
    isLoading = true; // กำหลังโหลดข้อมูล
    photos = Photos();
    Service.getPhotos().then((photosFromServer) {
      setState(() {
        photos = photosFromServer;
        isLoading = false; // โหลดข้อมูลเสร็จสิ้น
      });
    });
  }

  //============================================================================== เลือกรูปจาก Gallery
  // เปิด Gallery เพื่อเลือกรูปภาพในเครื่อง
  final ImagePicker _picker = ImagePicker();
  Future<void> image_From_Gallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // อ่านไฟล์รูปภาพเป็น bytes
      List<int> imageBytes = await pickedFile.readAsBytes();
      // แปลง bytes เป็น Base64
      _photoBase64 = base64Encode(imageBytes);
      // ชื่อรูปภาพที่ถูกเลือกจาก Gallery
      _photoName = pickedFile.name;
      // เรียก service เพิ่มรูปลง database
      if (await Service.savePhoto(_photoName, _photoBase64)) {
        // รีหน้า
        setState(() {
          Service.getPhotos().then((photosFromServer) {
            setState(() {
              photos = photosFromServer;
            });
          });
        });
      }
      print('\n=====Base64 Image: $_photoBase64');
      print('\n=====Image Name: $_photoName');
    } else {
      // ผู้ใช้ยกเลิกการเลือกรูป
      print('User cancelled image picker');
    }
    // รีหน้า
    setState(() {});
  }

  //=========================================================================== build ทำงาน
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //======================================================================== AppBar ปุ่มเพิ่มรูปภาพ
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 23, 107, 135),
        title: const Text('Home'),
        automaticallyImplyLeading: false, // ไม่ให้แสดงปุ่มย้อนกลับ
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: image_From_Gallery),
        ],
      ),
      //========================================================================= Body
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
                  listPhotos(),
                ],
              ),
      ),
    );
  }

  //============================================================================ lis Photos (Widget)
  Widget listPhotos() {
    return Expanded(
      child: ListView.builder(
        itemCount: photos.photos == null ? 0 : photos.photos.length,
        itemBuilder: (BuildContext context, int index) {
          return rowPhoto(index);
        },
      ),
    );
  }

  //============================================================================ row Photo (Widget)
  Widget rowPhoto(int index) {
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
                base64Decode(photos!.photos[index].base64),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
              // แสดงชื่อของรูปภาพ
              title: Text(
                'Name: ${photos!.photos[index].name}',
                style: TextStyle(color: Colors.black, fontSize: 10),
              ),
              // ปุ่มแปลงข้อความในภาพ และ ลบภาพ
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ปุ่มแปลงข้อความในภาพ
                  IconButton(
                    icon: Icon(Icons.send_time_extension),
                    color: Color.fromARGB(255, 4, 54, 74),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TextRecognition_page(
                                  photo: photos!.photos[index])));
                    },
                  ),
                  // ลบภาพ นั้นๆ
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Color.fromARGB(255, 4, 54, 74),
                    onPressed: () {
                      Service.deletePhoto(photos!.photos[index].MID);
                      setState(() {
                        Service.getPhotos().then((photosFromServer) {
                          setState(() {
                            photos = photosFromServer;
                          });
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
