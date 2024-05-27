import 'package:flutter/material.dart';
import 'package:kaveri/Screens/Description.dart';
import 'package:kaveri/Screens/Order/Add_Items.dart';
import 'package:kaveri/Screens/Order/Neworder.dart';
import 'package:kaveri/Screens/Order/Order_Screen.dart';
import 'package:kaveri/Widgets/inoutbutton.dart';

class NavigationScreen extends StatefulWidget {
  final String firstName;
  final String employeeId;
  final String profilePicture;

  const NavigationScreen({
    Key? key,
    required this.firstName,
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
          employeeId: widget.employeeId,
          profilePicture: widget.profilePicture,
        ),
        OrderScreen(
            employeeId: widget.employeeId,
            firstName: widget.firstName,
            profilePicture: widget.profilePicture),
        Neworder(
          firstName: widget.firstName,
          employeeId: widget.employeeId,
          profilePicture: widget.profilePicture,
        ),
        AddItems(
            employeeId: widget.employeeId,
            firstName: widget.firstName,
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
          BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined), label: 'Order'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Client'),
          BottomNavigationBarItem(
              icon: Icon(Icons.wb_iridescent), label: 'Expense'),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String firstName;
  final String employeeId;
  final String profilePicture;

  const HomeScreen({
    Key? key,
    required this.firstName,
    required this.employeeId,
    required this.profilePicture,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class Todo {
  String title;
  bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Todo> todos = [
    Todo(title: 'Visit saravana hardware ', isDone: false),
    Todo(title: 'Complete payment', isDone: false),
    Todo(title: 'visit Arul Traders', isDone: false),
    Todo(title: 'check TMT delivery ', isDone: false),
  ];

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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Container(
                height: 500,
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
                    const Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        'Daily Task',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemCount: todos.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return const Divider();
                        },
                        itemBuilder: (context, index) {
                          final todo = todos[index];
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DescriptionScreen(),
                                ),
                              );
                            },
                            leading: Checkbox(
                              value: todo.isDone,
                              onChanged: (bool? value) {
                                setState(() {
                                  todo.isDone = value!;
                                });
                              },
                            ),
                            title: Text(todo.title),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 130,
                  child: InOutButton(
                    firstName: widget.firstName,
                    employeeId: widget.employeeId,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
