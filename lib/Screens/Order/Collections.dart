import 'package:flutter/material.dart';

class Collections extends StatefulWidget {
  const Collections({super.key, Key});

  @override
  State<Collections> createState() => _CollectionsState();
}

class _CollectionsState extends State<Collections> {
  List<Widget> containers = [];
  String selectedPaymentMethod = 'Credit Card';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Blue container with ListView to hold added containers
            Container(
              width: width / 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color(0xffD9D9D9),
              ),
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Collections"),
                        InkWell(
                          onTap: () {
                            addContainer();
                          },
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Space between title and containers
                  // Display all containers inside ListView with space between
                  ...containers
                      .map((container) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            child: container,
                          ))
                      .toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addContainer() {
    final width = MediaQuery.of(context).size.width;

    setState(() {
      containers.add(
        // New container with delete button
        Padding(
          padding: const EdgeInsets.only(left:5,right: 5 ),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5) ,  color: Colors.white,),
            height: 50,
            width: width / 1.1,
           
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 35,
                    width: width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 234, 232, 232),
                    ),
                    child: Center(
                      child: DropdownButton<String>(
                        value: selectedPaymentMethod,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedPaymentMethod = newValue;
                            });
                          }
                        },
                        items: <String>[
                          'Credit Card',
                          'Debit Card',
                          'PayPal',
                          'Apple Pay',
                          // Add more payment methods as needed
                        ].map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(
                                      color: Colors
                                          .black)), // Change text color to black
                            );
                          },
                        ).toList(),
                        underline: Container(), // Remove underline
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 35,
                    width: width / 2.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: const Color.fromARGB(255, 234, 232, 232),
                    ),
                    child: Center(
                      child: TextField(
                        controller: TextEditingController(),
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          prefixText: '₹', // Rupees symbol
                          border: InputBorder.none, // Remove default border
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 8), // Adjust padding
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/delete.png',
                      scale: 2.5,
                    ),
                    onPressed: () {  removeContainer(containers.length);},
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void removeContainer(int index) {
    setState(() {
      containers.removeAt(index - 1);
    });
  }
}
