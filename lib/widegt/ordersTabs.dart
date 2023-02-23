import 'package:ahbmss/screen/edit_order%20(1).dart';
import 'package:ahbmss/screen/email/theard_details.dart';
import 'package:ahbmss/screen/order_details.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class OrdersTabs extends StatefulWidget {
  final int enid;
  final String orderNumber;
  final String orderDate;
  final String clientName;
  final String services;
  final String tranxid;
  final String writerId;
  final String screenshot;
  const OrdersTabs(
      {super.key,
      required this.services,
      required this.clientName,
      required this.enid,
      required this.orderDate,
      required this.orderNumber,
      required this.screenshot,
      required this.tranxid,
      required this.writerId});

  @override
  State<OrdersTabs> createState() => _OrdersTabsState();
}

class _OrdersTabsState extends State<OrdersTabs> {
  final color = const Color.fromARGB(255, 32, 41, 86);
  bool slider = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: slider == true ? 185 : 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 172, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 135.0, bottom: 5, left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => EditOrder(
                                      orderId: widget.enid.toString(),
                                    )));
                      },
                      child: const Text(
                        "Edit",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 15,
                    width: 1,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => TheardDetails(orderTitle: widget.orderNumber, trx: widget.tranxid, id: widget.orderNumber,)));
                      },
                      child: const Text(
                        "Mail",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: 15,
                    width: 1,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => Orderdetails(
                                      orderid: widget.enid,
                                    )));
                      },
                      child: const Text(
                        "Details",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            )),
        GestureDetector(
          onTap: () {
            setState(() {
              slider = slider == true ? false : true;
            });
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.clientName,
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontStyle: FontStyle.normal,
                      letterSpacing: 1,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Order Id: ",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Deadline: ",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Serv Name: ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      /// data from orders tabs
                      SizedBox(
                        width: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.orderNumber,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              widget.orderDate,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.services,
                                    overflow: TextOverflow.visible,
                                    maxLines: 1,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () => showMybottomSheet(widget.screenshot),
                      child: Container(
                        height: 25,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 172, 0, 0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                            child: Text("View",
                                style: TextStyle(
                                  color: Colors.white,
                                ))),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showMybottomSheet(String screenshot) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        context: context,
        builder: (context) {
          return SizedBox(
            height: 400,
            width: 200,
            child: Center(
              child: Image.network(
                screenshot,
                fit: BoxFit.fill,
              ),
            ),
          );
        });
  }
}
