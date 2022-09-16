import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:outlet/model/auth_user.dart';
import 'package:outlet/utils/routes/route_url.dart';

import '../constant/collection_path.dart';
import '../constant/constant.dart';

class Api {
  final dio.Dio _dio = dio.Dio();

  /*  Future<void> uploadFile(
    String filePath, {
    String folder = 'items/',
    String? fileName,
  }) async {
    final dio.MultipartFile _file = await dio.MultipartFile.fromFile(
      filePath,
      filename: fileName,
    );
    try {
      await _dio.post(
        "$baseUrl$folder",
        data: dio.FormData.fromMap(
          {
            'file': _file,
          },
        ),
      );
    } catch (e) {
      print("file upload error is $e");
    }
  } */

  //Send Notificaiton After order uploaded
  static Future<void> sendOrder(
    String title,
    String message,
  ) async {
    FirebaseFirestore.instance
        .collection(userCollection)
        .withConverter<AuthUser>(
          fromFirestore: (data, __) => AuthUser.fromJson(data.data()!),
          toFirestore: (user, __) => user.toJson(),
        )
        .where("status", isEqualTo: 2)
        .get()
        .then((value) async {
      final users = value.docs;
      for (var user in users) {
        final jsonBody = <String, dynamic>{
          "notification": <String, dynamic>{
            "title": title,
            "body": message,
          },
          "data": <String, dynamic>{
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "route": orderScreen,
          },
          "to": user.data().token,
        };
        await Dio().post("https://fcm.googleapis.com/fcm/send",
            data: jsonBody,
            options: Options(headers: {
              "Authorization": "key=$fcmKey",
              "Content-Type": "application/json"
            }));
      }
    });
  }
}
