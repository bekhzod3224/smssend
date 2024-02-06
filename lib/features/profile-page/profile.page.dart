import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:send_sms_app/api/service-api.dart';
import 'package:send_sms_app/model/user-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String phoneNumber = "";
  getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    phoneNumber = prefs.getString('phoneNumber')!;
    setState(() {});
  }

  @override
  void initState() {
    getId();
    // TODO: implement initState
    super.initState();
  }

  Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 50,
        maxHeight: 300,
        maxWidth: 300,
      );
      if (image == null) return;
      File? img = File(image.path);
      setState(() {});
      // Uint8List imagebytes = await _image!.readAsBytes();
      // userimage = base64Encode(imagebytes);
      // prefs.setString(SharedPrefKeys.USERIMAGE, userimage);
      // context.read<GetInfoCubit>().get_info_state();
    } on PlatformException catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }
  List<UserModel> _list = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Аккаунт"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(0.0),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: const Radius.circular(50),
                            bottomLeft: const Radius.circular(50),
                            bottomRight: const Radius.circular(50),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: CircleAvatar(
                            child: Icon(
                              Icons.person,
                              size: 35,
                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: InkWell(
                      onTap: () {
                        // selectphoto();
                      },
                      child: Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 12,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text("apollo@gmail.com"),
          SizedBox(
            height: 40,
          ),
          StreamBuilder(
              stream: UserService.getUserInfo("wa2zhFrLACwdG3W4bLei"),
              builder: (context, snapshot) {
                 final data = snapshot.data?.docs;
                 if (snapshot.hasData){
                   _list =
              data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];

              // print(list[0].name);
                 }
                  
              
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("Имя", style: TextStyle(fontSize: 16)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${_list.isNotEmpty ? _list[0].name : ""}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                            ListTile(
                              title:
                                  Text("Фамилия", style: TextStyle(fontSize: 16)),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${_list.isNotEmpty ? _list[0].familiya : ""}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  
              })
        ],
      ),
    );
  }
}
