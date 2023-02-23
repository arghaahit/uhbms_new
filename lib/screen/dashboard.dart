import 'dart:convert';
import 'dart:developer';

import 'package:ahbmss/appsComoponent/drawer.dart';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:ahbmss/modals/dashboard.dart';
import 'package:ahbmss/screen/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(202, 9, 14, 52),
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () => _showMyDialog(),
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.white,
            ),
          )
        ],
      ),
      drawer: const MyDrawer(
        pageName: "Dashboard",
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: const [
            UserInfoSection(),
            UserPaymentSection(),
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

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 9, 14, 52),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    LocalData.userName,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 1,
                        fontSize: 30,
                        shadows: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: const Offset(-4, 4),
                          )
                        ]),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        LocalData.symbol,
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1,
                            fontSize: 30,
                            shadows: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 1,
                                blurRadius: 12,
                                offset: const Offset(-4, 4),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    LocalData.empid,
                    style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 1,
                        fontSize: 30,
                        shadows: [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 1,
                            blurRadius: 12,
                            offset: const Offset(-4, 4),
                          )
                        ]),
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        LocalData.rmCode,
                        style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1,
                            fontSize: 30,
                            shadows: [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 1,
                                blurRadius: 12,
                                offset: const Offset(-4, 4),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              LocalData.email,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1,
                  fontSize: 20,
                  shadows: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1,
                      blurRadius: 12,
                      offset: const Offset(-4, 4),
                    )
                  ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              LocalData.typeName,
              style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1,
                  fontSize: 18,
                  shadows: [
                    BoxShadow(
                      color: Colors.black,
                      spreadRadius: 1,
                      blurRadius: 12,
                      offset: const Offset(-4, 4),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

class UserPaymentSection extends StatefulWidget {
  const UserPaymentSection({super.key});

  @override
  State<UserPaymentSection> createState() => _UserPaymentSectionState();
}

class _UserPaymentSectionState extends State<UserPaymentSection> {
  late Future<Dashbordmodal> futureAlbum;
  @override
  void initState() {
    futureAlbum = fetchDashbord();
    if (LocalData.empid != "" &&
        LocalData.empid != "" &&
        LocalData.empid.isNotEmpty) {
      fecthData();
    }

    super.initState();
  }

  DateTime monthDate = DateTime.now();

  List<String> month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec",
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Dashbordmodal>(
      future: futureAlbum,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.8,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.shade900,
                    offset: const Offset(0, -4),
                    spreadRadius: 2,
                    blurRadius: 12,
                  ),
                ]),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Payment",
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 1,
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PaymentsTab(
                          image: "assets/189672.png",
                          ammount:
                              "\$ ${0}",
                          symbol: "${month[monthDate.month - 1]} AUD"),
                      const SizedBox(
                        height: 22,
                      ),
                      PaymentsTab(
                          image: "assets/download.png",
                          ammount:
                              "₹ ${0}",
                          symbol: "${month[monthDate.month - 1]} INR"),
                      const SizedBox(
                        height: 22,
                      ),
                      const PaymentsTab(
                          image: "assets/189672.png",
                          ammount:
                              "\$ ${0}",
                          symbol: "This Week AUD"),
                      const SizedBox(
                        height: 22,
                      ),
                      const PaymentsTab(
                          image: "assets/download.png",
                          ammount:
                              "₹ ${0}",
                          symbol: "This Week INR"),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<Dashbordmodal> fetchDashbord() async {
    final response = await http.get(Uri.parse(
        'https://www.universitieshub.org/api/getDashboardData/${LocalData.rmID}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Dashbordmodal.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future fecthData() async {
    final response = await http.post(
      Uri.parse('https://a2rms.testwebs.in/adminapi/profileDetails'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'emp_id': LocalData.empid,
      },
      encoding: Encoding.getByName("utf-8"),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      log(data.toString());
      Map a = data["data"];
      String b = a["image"];
      setState(() {
        GlobalImage.image = b;
      });
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}

class PaymentsTab extends StatelessWidget {
  final String image;
  final String ammount;
  final String symbol;
  const PaymentsTab(
      {super.key,
      required this.image,
      required this.ammount,
      required this.symbol});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 3,
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              image:
                  DecorationImage(fit: BoxFit.fill, image: AssetImage(image)),
              borderRadius: BorderRadius.circular(500)),
        ),
        title: Text(
          symbol,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontStyle: FontStyle.normal,
            letterSpacing: 1,
            fontSize: 20,
          ),
        ),
        trailing: Text(
          ammount,
          style: GoogleFonts.montserrat(
            color: Colors.black,
            fontStyle: FontStyle.normal,
            letterSpacing: 1,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
