// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:kaveri/Screens/Order/Items_Select_Product.dart';

class SelectedClientScreen extends StatefulWidget {
  final String firstName;
  final String lastName;

  final String employeeId;
  final String profilePicture;
  final String clientId;
  final String clientName;

  const SelectedClientScreen({
    Key? key,
    required this.firstName,
    required this.lastName,

    required this.employeeId,
    required this.profilePicture,
    required this.clientId,
    required this.clientName,
  }) : super(key: key);

  @override
  State<SelectedClientScreen> createState() => _SelectedClientScreenState();
}

class _SelectedClientScreenState extends State<SelectedClientScreen> {
  final List<TextEditingController> quantityTxtCtrl = [];
  final List<TextEditingController> amountTxtCtrl = [];
  final TextEditingController totalValueController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic>? clientDetails;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchClientDetails();
  }

  Future<void> fetchClientDetails() async {
    final url = 'https://api.jaynaturals.com/client-by-id/${widget.clientId}';
    print('Fetching client details from URL: $url');

    final response = await http.get(Uri.parse(url));
    print('API Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print('Decoded JSON Response: $jsonResponse');

      setState(() {
        clientDetails = jsonResponse['client'];
        print('Client Details: $clientDetails');
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load client details');
    }
  }

  @override
  void dispose() {
    for (var controller in quantityTxtCtrl) {
      controller.dispose();
    }
    for (var controller in amountTxtCtrl) {
      controller.dispose();
    }
    totalValueController.dispose();
    super.dispose();
  }

  String selectedPaymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            icon: Image.asset("assets/images/drawer.png"),
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          backgroundColor: const Color(0xffEBF5FF),
          title: const Text('New Order'),
          titleTextStyle: const TextStyle(color: Colors.blue),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/profile_picture.png'),
                                  fit: BoxFit.cover,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: const CircleAvatar(
                                radius: 60,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(widget.firstName),
                            Text(widget.employeeId),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 3'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            height: 70,
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: const Color(0xff422BCF)),
                            ),
                            child: Center(
                              child: Text(
                                clientDetails?['clientName']?.toString() ??
                                    'Client Name',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: width,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffD9D9D9),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ItemsSelectProductScreen(
                                                  employeeId: widget.employeeId,
                                                  firstName: widget.firstName,
                                    lastName: widget.lastName,

                                                  profilePicture:
                                                      widget.profilePicture,
                                                      clientId: widget.clientId,
                                                      clientName:
                                                          widget.clientName,
                                                )),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Items",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            width: width,
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xffD9D9D9),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ItemsSelectProductScreen(
                                                      employeeId:
                                                          widget.employeeId,
                                                      firstName:
                                                          widget.firstName,
                                                      profilePicture:
                                                          widget.profilePicture, lastName: '', clientId: '', clientName: '',
                                                    )),
                                          );
                                        },
                                        child: const Text(
                                          "Collections",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Text(
                              "Payment Made \u{20B9} ${clientDetails?['paymentMade']?.toString() ?? '0.00'}"),
                          Text(
                              "Balance Due  \u{20B9} ${clientDetails?['balanceDue']?.toString() ?? '0.00'}"),
                        ],
                      ),
                      SizedBox(
                        height: height / 2.14,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: width,
                          height: height / 16,
                          decoration: const BoxDecoration(
                              color: Colors.blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7))),
                          child: const Center(
                            child: Text("Place Order",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
