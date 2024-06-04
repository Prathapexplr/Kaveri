import 'package:flutter/material.dart';
import 'package:kaveri/Screens/Order/Select_Client.dart';
import 'package:kaveri/Screens/Order/Items_Select_Product.dart';

class Neworder extends StatefulWidget {
  final String firstName;
  final String lastName;

  final String employeeId;
  final String profilePicture;
  const Neworder(
      {Key? key,
      required this.firstName,
      required this.employeeId,
      required this.profilePicture,
      required this.lastName})
      : super(key: key);

  @override
  State<Neworder> createState() => _NeworderState();
}

class _NeworderState extends State<Neworder> {
  final List<TextEditingController> quantityTxtCtrl = [];
  final List<TextEditingController> amountTxtCtrl = [];
  final TextEditingController totalValueController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
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
                        )
                      ],
                    )
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectClientScreen(
                                    employeeId: widget.employeeId,
                                    firstName: widget.firstName,
                                    lastName: widget.lastName,
                                    profilePicture: widget.profilePicture,
                                  )),
                        );
                      },
                      child: Container(
                        height: 70,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: const Color(0xff422BCF)),
                        ),
                        child: const Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_circle_outline,
                                  size: 25, color: Color(0xff422BCF)),
                              SizedBox(width: 3),
                              Text(
                                "Add Client",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black),
                              ),
                            ],
                          ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                                clientId: '',
                                                clientName: '',
                                              )),
                                    );
                                  },
                                  child: const Text(
                                    "Items",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                                                clientId: '',
                                                clientName: '',
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
                    const Text("Payment Made \u{20B9} 0.00"),
                    const Text("Balance Due  \u{20B9} 0.00"),
                  ],
                ),
                SizedBox(
                  height: height / 2.14,
                ),
                Container(
                  width: width,
                  height: height / 16,
                  decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(7))),
                  child: const Center(
                    child: Text("Place Order",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
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
