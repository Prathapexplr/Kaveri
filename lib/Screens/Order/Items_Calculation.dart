import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kaveri/Screens/Order/Items_Select_Product.dart';

class AddItems extends StatefulWidget {
  final String firstName;
  final String employeeId;
  final String profilePicture;
  String productID;
  String productName;
  String amount;

  AddItems({
    super.key,
    required this.firstName,
    required this.employeeId,
    required this.profilePicture,
    required this.productID,
    required this.productName,
    required this.amount,
  });

  @override
  State<AddItems> createState() => _AddItemsState();
}

class _AddItemsState extends State<AddItems> {
  late TextEditingController sellingPriceController;
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController discountController = TextEditingController();

  double subTotal = 0;
  double discountAmount = 0;
  double total = 0;

  void calculateTotals() {
    double sellingPrice = double.tryParse(sellingPriceController.text) ?? 0;
    int quantity = int.tryParse(quantityController.text) ?? 0;
    double discountPercentage = double.tryParse(discountController.text) ?? 0;

    setState(() {
      subTotal = sellingPrice * quantity;
      discountAmount = (subTotal * discountPercentage) / 100;
      total = subTotal - discountAmount;
    });
  }

  @override
  void initState() {
    super.initState();
    sellingPriceController = TextEditingController(text: widget.amount);
    sellingPriceController.addListener(calculateTotals);
    quantityController.addListener(calculateTotals);
    discountController.addListener(calculateTotals);
  }

  @override
  void dispose() {
    sellingPriceController.dispose();
    quantityController.dispose();
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffEBEBEB),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Container(
                            width: width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Image.asset(
                                          'assets/images/delete.png',
                                          scale: 2.5,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            widget.productID = '';
                                            widget.productName = '';
                                            widget.amount = '';
                                          });
                                          Navigator.pop(context);
                                        },
                                      ),
                                      Container(
                                        width: width / 1.4,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: const Color.fromARGB(
                                              255, 227, 226, 233),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text(
                                                    widget.productName,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\u{20B9}${widget.amount}",
                                                    style: const TextStyle(
                                                      color: Color(0xff422BCF),
                                                      fontSize: 16,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                widget.productID,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 25),
                                  const Divider(
                                    color: Colors.grey,
                                    height: 2,
                                    thickness: 2,
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Selling Price"),
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: sellingPriceController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9.]')),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text("Quantity"),
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: quantityController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9]')),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      const Text("Discount(%)"),
                                      Container(
                                        margin: const EdgeInsets.all(8),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.black),
                                          borderRadius: BorderRadius.circular(4),
                                          color: Colors.white,
                                        ),
                                        child: TextFormField(
                                          controller: discountController,
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                          ),
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9.]')),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Sub Total",
                                style: TextStyle(
                                  color: Color(0xff696969),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\u{20B9}${subTotal.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Discount",
                                style: TextStyle(
                                  color: Color(0xff696969),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\u{20B9}${discountAmount.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(
                                  color: Color(0xff696969),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\u{20B9}${total.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SizedBox(),
                          // SelectedClientScreen(
                          //   employeeId: widget.employeeId,
                          //   firstName: widget.firstName,
                          //   profilePicture: widget.profilePicture,
                          // )
                        ),
                      );
                    },
                    child: Container(
                      height: 60,
                      width: width / 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                      ),
                      child: const Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
