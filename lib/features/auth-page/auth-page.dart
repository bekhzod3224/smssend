import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:send_sms_app/core/check-number.dart';
import 'package:send_sms_app/features/auth-page/cheack-sms-page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  authPhone(String number) async {
    print(number);
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      verificationCompleted: (phoneAuthCredential) {
        print("Code ${phoneAuthCredential}");
      },
      verificationFailed: (error) {
        print("error _ code : ${error}");
      },
      codeSent: (verificationId, forceResendingToken) {
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CheackSmsPage(phoneNumber: number, verificationId: verificationId,);
        }));
      },
      phoneNumber: '+7${number}',
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  final formKey = GlobalKey<FormState>();

  String buttonStatus = "";
  TextEditingController controller = new TextEditingController(text: "");


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            status: 1,
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
          Container(
            width: 240,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Введите номер телефона для регистрации",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Номер телефона",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade800))),
          ),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextFormField(
                controller: controller,
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: "(###) ### ## ##",
                    type: MaskAutoCompletionType.eager,
                  )
                ],
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade900),
                maxLength: 15,
                keyboardType: TextInputType.number,
                
                decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  counterStyle: TextStyle(color: Colors.white),
                  contentPadding: EdgeInsets.symmetric(vertical: 15.0),
                  counter: Offstage(),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 10,
                    ),
                    child: Text(
                      "+7",
                      style: TextStyle(
                          color: Colors.grey.shade900,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color(0xFFFFB800), width: 1.5),
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
      
          SizedBox(height: 40,),
      
          InkWell(
            onTap: (){
              authPhone(
              controller.text
              );
        //       Navigator.push(context, MaterialPageRoute(builder: (context){
        //   return CheackSmsPage(phoneNumber: controller.text, verificationId: "a",);
        // }));
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color:  Color(0xFFFFB800),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Center(child: Text("Отправить смс-код", style: TextStyle(fontSize: 18),)),
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: 320,
            child: Text("Нажимая на данную кнопку, вы даете согласие на обработку персональных данных", textAlign: TextAlign.center,))
      
      
        ]),
      ),
    );
  }
}
