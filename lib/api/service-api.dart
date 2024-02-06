import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:send_sms_app/model/user-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // createUser(UserModel user)async{
  //    final docUser = FirebaseFirestore.instance.collection("users").doc();
  //    final json = user.toJson();
  //     await docUser.set(json);
  // }
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future createUser(UserModel user) async {
    final doc = FirebaseFirestore.instance.collection("users").doc();

    user.phoneNumber = doc.id;
    await doc.set(user.toJson());
  }
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(String number ) {
    
    return firestore
        .collection('users')
        .where('phoneNumber', isEqualTo: number)
        .snapshots();
  }
}
