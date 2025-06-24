import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_clone/Controller/auth.dart';
import 'package:whatsapp_clone/view/CustomUI/custom_text_field.dart';


class VerificationScreen extends StatefulWidget {
  final String userID;
  const VerificationScreen({super.key, required this.userID});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Verify your number',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text:
                          //TODO :: add email here in the text
                      "You've tried to register +251935838471. before requesting an SMS or Call with your code.",
                    ),
                    TextSpan(
                      text: "Wrong email ?",
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer(builder: (context,ref, _) {
              bool isLoading = ref.watch(authNotifierProvider);
              return isLoading ? const CircularProgressIndicator():
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: CustomTextField(
                  hintText: "- -  - -",
                  fontSize: 30,
                  autoFocus: true,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.length == 4) {
                      Timer(Duration(milliseconds: 300), () {
                        ref.read(authNotifierProvider.notifier).otpVerivication(otp: value, userID: widget.userID , context: context);

                      });


                      // return verifySmsCode(context, ref, value);
                    }
                  },
                ),
              );
            }),

            const SizedBox(height: 20),
            Text(
              'Enter 6-digit code',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 10),

            Text(
              'Didn\'t receive code?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).indicatorColor,
              ),
            ),

          ],
        ),
      ),
    );
  }

}
