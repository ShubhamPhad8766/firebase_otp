import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:number_ot/screen/otp_screen/otp_screen.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.grey,
          centerTitle: true,
          title: const Text("PhoneAuth"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              TextFormField(
                inputFormatters: [
                  LengthLimitingTextInputFormatter(13),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter Number';
                  }
                  return null;
                },
                controller: phoneController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.phone),
                    hintText: "Enter Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException ex) {},
                        codeSent: (String verificationId, int? resendingtoken) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    OtpScreen(verifacationid: verificationId),
                              ));
                        },
                        codeAutoRetrievalTimeout: (verificationId) {},
                        phoneNumber: phoneController.text,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: const Size(double.infinity, 40)),
                  child: const Text(
                    "Verify Phone Number",
                    style: TextStyle(color: Colors.black),
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
