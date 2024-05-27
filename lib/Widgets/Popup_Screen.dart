// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class PopupScreen extends StatefulWidget {
  const PopupScreen({super.key});

  @override
  State<PopupScreen> createState() => _PopupScreenState();
}

class _PopupScreenState extends State<PopupScreen> {
  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: Container(
            // height: 200,
            width: width / 1.3,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3))
                ]),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Text(
                    "Do you want to reschedule this task?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      print("yes button taped");
                    },
                    child: Container(
                      height: 50,
                      width: width / 1.6,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        "yes",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )),
                    ),
                  ),
                  SizedBox(
                    height: width * 0.02,
                  ),
                  InkWell(
                    onTap: () {
                      print("cancel button taped");
                    },
                    child: Container(
                      height: 50,
                      width: width / 1.6,
                      decoration: BoxDecoration(
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                          child: Text(
                        "Cancel",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
