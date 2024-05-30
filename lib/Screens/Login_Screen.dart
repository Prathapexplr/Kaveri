// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kaveri/Screens/HomeScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool isvisible = true;
  bool showFields = false;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      animationBehavior: AnimationBehavior.preserve,
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // Check if user is already logged in
    _checkLoginStatus();

    // Start a timer after 2 seconds to gradually show the fields
    Timer(const Duration(seconds: 2), () {
      setState(() {
        showFields = true;
        _animationController.forward();
      });
    });
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? password = prefs.getString('password');

    if (username != null && password != null) {
      _handleLogin(savedCredentials: true);
    }
  }

  Future<void> _handleLogin({bool savedCredentials = false}) async {
    final Uri url = Uri.parse('https://api.jaynaturals.com/employee-login');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'username': savedCredentials
              ? (await SharedPreferences.getInstance()).getString('username')!
              : usernameController.text,
          'password': savedCredentials
              ? (await SharedPreferences.getInstance()).getString('password')!
              : passwordController.text,
        }),
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final Map<String, dynamic> employeeData = responseData['employee'];

        final String firstName = employeeData['firstName'] ?? '';
        final String employeeId = employeeData['employeeId'] ?? '';
        final String profilePicture = employeeData['profilePicture'] ?? '';

        if (firstName.isEmpty || employeeId.isEmpty || profilePicture.isEmpty) {
          throw Exception('Missing data in the response');
        }

        // Save credentials for future logins
        if (!savedCredentials) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', usernameController.text);
          await prefs.setString('password', passwordController.text);
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationScreen(
              firstName: firstName,
              employeeId: employeeId,
              profilePicture: profilePicture,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
          ),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error occurred while logging in'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/image1.png",
                  scale: 4,
                ),
                const SizedBox(
                  height: 65,
                ),
                AnimatedSwitcher(
                  duration: const Duration(seconds: 2),
                  child: showFields
                      ? SizeTransition(
                          axis: Axis.vertical,
                          sizeFactor: _animationController,
                          axisAlignment: -1.0,
                          child: Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color:
                                      const Color.fromARGB(255, 236, 235, 235),
                                ),
                                child: TextFormField(
                                  controller: usernameController,
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintText: "Username",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                margin: const EdgeInsets.all(8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color:
                                      const Color.fromARGB(255, 236, 235, 235),
                                ),
                                child: TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  obscureText: isvisible,
                                  decoration: InputDecoration(
                                    icon: const Icon(Icons.lock),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isvisible = !isvisible;
                                        });
                                      },
                                      icon: Icon(isvisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Enter 6 Digit password",
                                style: GoogleFonts.roboto(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Container(
                                height: 60,
                                width: width * .6,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Colors.blue,
                                ),
                                child: TextButton(
                                  onPressed: _handleLogin,
                                  child: Text(
                                    "Log In",
                                    style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ),
                Visibility(
                    visible: !showFields,
                    child: Text(
                      "Sales and Marketing",
                      style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
