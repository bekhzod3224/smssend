import 'package:flutter/material.dart';

class CheckNumber extends StatelessWidget {
  final int status;

  const CheckNumber({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: status == 1 ? Color(0xFFFFB800) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: status == 2 ? Icon(Icons.check, color: Colors.green,) : status == 3 ? Icon(Icons.check, color: Colors.green,)  : Text(
                  "1",
                  style: TextStyle(fontSize: 18),
                )) ,
              ),
            ),
            Container(
              width: 40,
              height: 1,
              decoration: BoxDecoration(color: Colors.grey.shade300),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: status == 2 ? Color(0xFFFFB800) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Center(
                    child: status == 3  ? Icon(Icons.check, color: Colors.green,) : Text(
                  "2",
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ),
            Container(
              width: 40,
              height: 1,
              decoration: BoxDecoration(color: Colors.grey.shade300),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color:status == 3? Color(0xFFFFB800) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child:  Center(
                    child:  Text(
                  "3",
                  style: TextStyle(fontSize: 18),
                )),
              ),
            ),
          ],
        );
  }
}