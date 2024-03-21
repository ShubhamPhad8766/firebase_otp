// ignore_for_file: must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:number_ot/screen/home/home.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  String verifacationid;
  OtpScreen({super.key, required this.verifacationid});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          centerTitle: true,
          title: const Text("Otp Screen"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Pinput(
              length: 6,
              controller: otpController,
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verifacationid,
                            smsCode: otpController.text);
                    FirebaseAuth.instance.signInWithCredential(credential).then(
                      (value) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Home(),
                            ));
                      },
                    );
                  } catch (ex) {
                    // log();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: const Size(double.infinity, 40)),
                child: const Text(
                  'Verify otp',
                  style: TextStyle(color: Colors.black),
                ))
          ]),
        ),
      ),
    );
  }
}
