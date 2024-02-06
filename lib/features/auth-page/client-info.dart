
import 'package:flutter/material.dart';
import 'package:send_sms_app/api/service-api.dart';
import 'package:send_sms_app/core/check-number.dart';

import 'package:send_sms_app/features/layout-page/layout-page.dart';
import 'package:send_sms_app/model/user-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Clientinfo extends StatefulWidget {
  const Clientinfo({super.key, required this.phoneNumber});
  final String phoneNumber;

  @override
  State<Clientinfo> createState() => _ClientinfoState();
}

class _ClientinfoState extends State<Clientinfo> {
  final formKey = GlobalKey<FormState>();

  TextEditingController name = new TextEditingController(text: "");
  TextEditingController familiya = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(children: [
            CheckNumber(
              status: 3,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Регистрация",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Имя",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade800))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextFormField(
                  controller: name,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    counterStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                    counter: Offstage(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Color(0xFFFFB800), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFD9D9D9),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Фамилия",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade800))),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: TextFormField(
                  controller: familiya,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade900),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    counterStyle: TextStyle(color: Colors.white),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
                    counter: Offstage(),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide:
                          BorderSide(color: Color(0xFFFFB800), width: 1.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: Color(0xFFD9D9D9),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () async {
                final data = UserModel(
                    phoneNumber: widget.phoneNumber,
                    name: name.text,
                    familiya: familiya.text,
                    image: "");
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('phoneNumber', widget.phoneNumber);
                UserService().createUser(data).then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LayoutPage();
                  }));
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xFFFFB800),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Center(
                        child: Text(
                      "Сохранить",
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
