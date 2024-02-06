import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:send_sms_app/core/check-number.dart';
import 'package:send_sms_app/features/auth-page/client-info.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:timer_count_down/timer_count_down.dart';

class CheackSmsPage extends StatefulWidget {
  const CheackSmsPage(
      {super.key, required this.phoneNumber, required this.verificationId});
  final String phoneNumber;
  final String verificationId;

  @override
  State<CheackSmsPage> createState() => _CheackSmsPageState();
}

class _CheackSmsPageState extends State<CheackSmsPage> {
  final formKey = GlobalKey<FormState>();
  String _code = "";
  bool new_send_sms = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
  }

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
        child: Column(children: [
          CheckNumber(
            status: 2,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Подтверждение",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Введите код, который мы отправили в SMS на +7${widget.phoneNumber}",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
          ),

          // const Spacer(),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: PinFieldAutoFill(
                    decoration: UnderlineDecoration(
                      textStyle: TextStyle(fontSize: 20, color: Colors.black),
                      colorBuilder:
                          FixedColorBuilder(Colors.black.withOpacity(0.3)),
                    ),
                    autoFocus: true,
                    codeLength: 5,
                    currentCode: _code,
                    onCodeSubmitted: (code) {},
                    onCodeChanged: (code) async {
                      if (code!.length == 5) {
                        FocusScope.of(context).requestFocus(FocusNode());

                        // try {
                        //   PhoneAuthCredential credential =
                        //       await PhoneAuthProvider.credential(
                        //           verificationId: widget.phoneNumber,
                        //           smsCode: _code);
                        //   FirebaseAuth.instance
                        //       .signInWithCredential(credential)
                        //       .then((value) {
                            
                        //   });
                        // } catch (e) {}
                        Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Clientinfo(phoneNumber: widget.phoneNumber,);
                            }));
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                new_send_sms
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            new_send_sms = false;
                          });
                        },
                        child: Text(
                          "Отправить код еще раз",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xFFFFB800)),
                        ),
                      )
                    : Countdown(
                        seconds: 5,
                        build: (BuildContext context, double time) => Text(
                          time.toInt().toString() +
                              " сек до повтора отправки кода",
                          style: TextStyle(
                              fontSize: 16, color: Colors.grey.shade700),
                        ),
                        onFinished: () {
                          setState(() {
                            new_send_sms = true;
                          });
                        },
                      ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
