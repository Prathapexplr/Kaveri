import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:kaveri/Screens/Order/Neworder.dart';
import 'package:kaveri/Screens/Order/Order_Screen.dart';
import 'package:kaveri/Widgets/inoutbutton.dart';

class NavigationScreen extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String employeeId;
  final String profilePicture;

  const NavigationScreen({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.employeeId,
    required this.profilePicture,
  }) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int myIndex = 0;

  List<Widget> get _BtmNavigationScreens => [
        HomeScreen(
          firstName: widget.firstName,
          lastName: widget.lastName,
          employeeId: widget.employeeId,
          profilePicture: widget.profilePicture,
        ),
        Neworder(
          firstName: widget.firstName,
          lastName: widget.lastName,
          employeeId: widget.employeeId,
          profilePicture: widget.profilePicture,
        ),
        AddItems(
            employeeId: widget.employeeId,
            firstName: widget.firstName,
            profilePicture: widget.profilePicture,
            amount: 'widget.amount',
            productID: 'widget.productID',
            productName: 'widget.productName'),
        OrderScreen(
            employeeId: widget.employeeId,
            firstName: widget.firstName,
            lastName: widget.lastName,
            profilePicture: widget.profilePicture),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _BtmNavigationScreens[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.task), label: 'Task'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Client'),
          BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined), label: 'Order'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String firstName;
  final String lastName;

  final String employeeId;
  final String profilePicture;

  const HomeScreen({
    Key? key,
    required this.firstName,
    required this.employeeId,
    required this.profilePicture,
    required this.lastName,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset("assets/images/drawer.png"),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        backgroundColor: const Color(0xffEBF5FF),
        title: const Text('Home'),
        titleTextStyle: const TextStyle(color: Colors.black),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xffB7DBFF),
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
                                image: AssetImage('assets/profile_picture.png'),
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
                          Text(
                            widget.firstName,
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.employeeId,
                            style: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Container(
                height: 392,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      focusedDay: _focusedDay,
                      calendarFormat: _calendarFormat,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        _focusedDay = focusedDay;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                height: 140,
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                "09:40 AM",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Punch In Time",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                "06:55 PM",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Punch Out Time",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Monthly Present",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 30),
                          Text(
                            "23",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                  height: 130,
                  child: InOutButton(
                    firstName: widget.firstName,
                    lastName: widget.lastName,
                    employeeId: widget.employeeId,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
