import 'dart:convert';
import 'package:frontend/models/index.dart';
import 'package:http/http.dart' as http;

class Service {
  // api สำหรับทดสอบบนเครื่องตัวเอง ต้องเป็น IP ของ เน็จที่เชื่อมต่อ ณ ขณะนั้น (แนะนำให้ใช้ IP เน็ตมือถือ)
  // static String url = 'http://192.168.124.29:8000';

  // IP ของ api ที่ run บน server
  static String url = 'https://magic-text-mini-project-mobile-backend.onrender.com';

  // user แบบ static (statip คือ public)
  static late User user;

  // แปลง Json เป็น Object ของ user
  static User parseUser(String responseBody) {
    final Map<String, dynamic> parsed = json.decode(responseBody);
    User user = User.fromJson(parsed);
    return user;
  }

  // แปลง Json รูปภาพทั้งหมดของผู้ใช้คนนั้นที่ดึงมา ให้เป็น list
  static Photos parsePhotos(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<Photo> photos =
        parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
    // สร้าง object  มีของ class Users
    Photos p = Photos();
    p.photos = photos;
    return p;
  }

  // แปลง Json เป็น Object ของ ocr
  static Ocr parseOcr(String responseBody) {
    final Map<String, dynamic> parsed = json.decode(responseBody);
    Ocr ocr = Ocr.fromJson(parsed);
    return ocr;
  }

  // แปลง Json ทุกคนที่เป็นเพื่อนกับ User ให้เป็น list
  static Friends parseFriends(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<Friend> friends =
        parsed.map<Friend>((json) => Friend.fromJson(json)).toList();
    // สร้าง object  มีของ class Users
    Friends f = Friends();
    f.friends = friends;
    return f;
  }

  // แปลง Json ทุกคนที่ไม่ได้เป็นเพื่อนกับ User ให้เป็น list
  static NotFriends parseNotFriends(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<NotFriend> notFriends =
        parsed.map<NotFriend>((json) => NotFriend.fromJson(json)).toList();
    // สร้าง object  มีของ class Users
    NotFriends nf = NotFriends();
    nf.notFriends = notFriends;
    return nf;
  }

  // แปลง Json Massage ที่ User คุยกับเพื่อน ให้เป็น list
  static Massages parseMassages(String reponseBody) {
    final parsed = json.decode(reponseBody).cast<Map<String, dynamic>>();
    List<Massage> massages =
        parsed.map<Massage>((json) => Massage.fromJson(json)).toList();
    // สร้าง object  มีของ class Users
    Massages m = Massages();
    m.massages = massages;
    return m;
  }

  //================================================================================ Login เข้าสู่ระบบ
  static Future<bool> login(String name_or_email, String password) async {
    // สร้าง json
    Map<String, String> data = {
      "name_or_email": name_or_email,
      "password": password,
    };
    // เรียก API
    try {
      final response = await http.post(
        Uri.parse(url + '/user/LogIn'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        user = parseUser(response.body);
        print('User name: ${user.name}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return false;
    }
  }

  //================================================================================ Register ผู้ใช้สมัครสมาชิก
  static Future<bool> register(
      String name, String name_or_email, String password, String photo) async {
    if (name != '' && name_or_email != '' && password != '') {
      // สร้าง json
      Map<String, String> data = {
        "name": name,
        "email": name_or_email,
        "password": password,
        "photo": photo
      };
      // เรียก api
      try {
        final response = await http.post(
          Uri.parse(url + '/user'),
          body: json.encode(data),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
        );
        if (response.statusCode == 200) {
          print('User name: ${response.body}');
          return true;
        } else {
          return false;
        }
      } catch (e) {
        print('Error ${e.toString()}');
        return false;
      }
    } else {
      return false;
    }
  }

  //================================================================================ select รูปภาพทั้งหมดของผู้ใช้คนนั้น
  static Future<Photos> getPhotos() async {
    try {
      final response =
          await http.get(Uri.parse(url + '/user/image/' + user.UID.toString()));
      if (200 == response.statusCode) {
        return parsePhotos(response.body);
      } else {
        return Photos();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Photos();
    }
  }

  //================================================================================ เพิ่มรูปภาพที่ผูใช้เลือกจาก Gallery
  static Future<bool> savePhoto(String photoName, String photoBase64) async {
    // สร้าง json
    Map<String, dynamic> data = {
      "name": photoName,
      "base64": photoBase64,
      "UID": user.UID
    };
    // เรียก api
    try {
      final response = await http.post(
        Uri.parse(url + '/user/image'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        print('Saved photo: ${response.body}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return false;
    }
  }

  //================================================================================ ลบรูปภาพ
  static Future<bool> deletePhoto(num MID) async {
    try {
      final response =
          await http.delete(Uri.parse(url + '/user/image/' + MID.toString()));
      if (200 == response.statusCode) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return false;
    }
  }

  //================================================================================ ocr แปลงข้อความที่อยู่ในรูปภาพ
  static Future<Ocr> ocrMethod(String photoBase64) async {
    // สร้าง json
    Map<String, dynamic> data = {"image_base64": photoBase64};
    // เรียก api
    try {
      final response = await http.post(
        Uri.parse(url + '/ocr'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        print(response.body);
        return parseOcr(response.body);
      } else {
        return Ocr();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Ocr();
    }
  }

  //================================================================================ Edit profile
  static Future<bool> editProfile(
      String name, String password, String photoBase64) async {
    // สร้าง json
    Map<String, dynamic> data = {
      "name": name,
      "password": password,
      "photo": photoBase64
    };
    // เรียก api
    try {
      final response = await http.put(
        Uri.parse(url + '/update/user/' + user.UID.toString()),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      // ถ้า update ข้อมูลได้ // จะทำการ select user คนนี้มาใหม่ เพื่อเปลี่ยนข้อมูลบนหน้า ui
      if (response.statusCode == 200) {
        print('Edit profile: ${response.body}');

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return false;
    }
  }

  //=============================================================================== get My Friends เพื่อนของฉันทั้งหมด
  static Future<Friends> getFriends() async {
    try {
      final response =
          await http.get(Uri.parse(url + '/friend/' + user.UID.toString()));
      if (200 == response.statusCode) {
        return parseFriends(response.body);
      } else {
        return Friends();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Friends();
    }
  }

  //=============================================================================== get not Friends คนที่ไม่ใช่เพื่อนฉัน
  static Future<NotFriends> getNotFriends() async {
    try {
      final response =
          await http.get(Uri.parse(url + '/user/' + user.UID.toString()));
      if (200 == response.statusCode) {
        return parseNotFriends(response.body);
      } else {
        return NotFriends();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return NotFriends();
    }
  }

  //================================================================================ เพิ่มเพื่อน
  static Future<bool> addFriend(num friendID) async {
    // สร้าง json
    Map<String, dynamic> data = {"friendID": friendID, "UID": user.UID};
    // เรียก api
    try {
      final response = await http.post(
        Uri.parse(url + '/friend'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        print(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return false;
    }
  }

  //================================================================================= select User ด้วย ID
  static Future<void> selectUserByID() async {
    try {
      final response = await http
          .get(Uri.parse(url + '/select/user/' + user.UID.toString()));
      if (200 == response.statusCode) {
        user = await parseUser(response.body);
        print('User update');
      } else {
        print('User no update');
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  //================================================================================= ลบเพื่อน
  static Future<void> deleteFriend(num friendID) async {
    // สร้าง json
    Map<String, dynamic> data = {"friendID": friendID, "UID": user.UID};
    // เรียก api
    try {
      final response = await http.delete(
        Uri.parse(url + '/friend'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print(response.body);
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }

  //================================================================================= select chat การพูดคุย ของเรา และเพื่อนคนนั้น
  static Future<Massages> getMassages(num FID) async {
    try {
      final response =
          await http.get(Uri.parse(url + '/friend/massage/' + FID.toString()));
      if (200 == response.statusCode) {
        return parseMassages(response.body);
      } else {
        return Massages();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Massages();
    }
  }

  //================================================================================= sent Message ส่งข้อความหาเพื่อน
  static Future<void> sentMessage(num FID, num friendID, String massage) async {
    // สร้าง json
    Map<String, dynamic> data = {
      "FID": FID,
      "friendID": friendID,
      "UID": user.UID,
      "name": user.name,
      "massage": massage
    };
    // เรียก api
    try {
      final response = await http.post(
        Uri.parse(url + '/massage/sent'),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
      );
      if (response.statusCode == 200) {
        print('sent Meaaged...');
      } else {
        print("sent Message Error...");
      }
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}
