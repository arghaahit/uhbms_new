
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:ahbmss/screen/clients_list.dart';
import 'package:ahbmss/screen/dashboard.dart';
import 'package:ahbmss/screen/forms/add_client.dart';
import 'package:ahbmss/screen/forms/add_order.dart';
import 'package:ahbmss/screen/login_page.dart';
import 'package:ahbmss/screen/orders_list.dart';
import 'package:ahbmss/screen/quick_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MyDrawer extends StatefulWidget {
  final String pageName;
  const MyDrawer({super.key, required this.pageName});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final color = const Color.fromARGB(255, 9, 14, 52);
  final _key = GlobalKey<ScaffoldState>();

  @override
  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: _key,
      backgroundColor: Colors.white,
      width: 330,
      child: Padding(
        padding: const EdgeInsets.only(top: 55, left: 35),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(right: 160),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 9, 14, 52),
                  border: Border.all(color: const Color.fromARGB(255, 9, 14, 52), style: BorderStyle.solid, width: 3),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: NetworkImage(GlobalImage.image.toString(), )),
                  borderRadius:
                      BorderRadius.circular(MediaQuery.of(context).size.width)),
              child: Center(
                child: Text(
                  GlobalImage.image == null? "UHBMS":"",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 1,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        LocalData.userName,
                        style: GoogleFonts.montserrat(
                            color: Colors.black, fontSize: 28),
                      ),
                    ),
                  ],
                )),
            const SizedBox(
              height: 40,
            ),

            // Dashboard
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const Dashboard()));
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color:
                        widget.pageName == "Dashboard" ? color : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dashboard_outlined,
                        color: widget.pageName != "Dashboard"
                            ? color
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Dashboard",
                        style: GoogleFonts.montserrat(
                          color: widget.pageName != "Dashboard"
                              ? color
                              : Colors.white,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // myorders ----------------------
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const Orders()));
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: widget.pageName == "Orders" ? color : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color:
                            widget.pageName != "Orders" ? color : Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Orders",
                        style: GoogleFonts.montserrat(
                          color: widget.pageName != "Orders"
                              ? color
                              : Colors.white,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // MyClients ----------------------

            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const Clients()));
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: widget.pageName == "Clients" ? color : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        color:
                            widget.pageName != "Clients" ? color : Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Clients",
                        style: GoogleFonts.montserrat(
                          color: widget.pageName != "Clients"
                              ? color
                              : Colors.white,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // add clients ------------
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoModalPopupRoute(
                        builder: (context) => const AddClintPage()));
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color:
                        widget.pageName == "AddClient" ? color : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        color: widget.pageName != "AddClient"
                            ? color
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Clients",
                        style: GoogleFonts.montserrat(
                          color: widget.pageName != "AddClient"
                              ? color
                              : Colors.white,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // add orders -------------
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const Addorder()));
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: widget.pageName == "AddOrder" ? color : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: widget.pageName != "AddOrder"
                            ? color
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add Orders",
                        style: GoogleFonts.montserrat(
                          color: widget.pageName != "AddOrder"
                              ? color
                              : Colors.white,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            //Quick payment --------
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const PaymentList()));
              },
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: widget.pageName == "Payment" ? color : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.currency_rupee_outlined,
                        color:
                            widget.pageName != "Payment" ? color : Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Quick Pay",
                        style: GoogleFonts.montserrat(
                          color: widget.pageName != "Payment"
                              ? color
                              : Colors.white,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () => _showMyDialog(),
              child: Container(
                height: 70,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: widget.pageName == "Logout" ? color : Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15))),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 8.0,
                    left: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color:
                            widget.pageName != "Logout" ? color : Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Logout",
                        style: GoogleFonts.montserrat(
                          color: widget.pageName != "Logout"
                              ? color
                              : Colors.white,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout Warrning'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Are You sure to Logout'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  LocalData.rmID = 0;
                  LocalData.empid = "";
                  LocalData.symbol = "";
                  LocalData.rmCode = "";
                  LocalData.teamid = "";
                  LocalData.userName = "";
                  LocalData.typeName = "";
                  LocalData.email = "";
                });
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
