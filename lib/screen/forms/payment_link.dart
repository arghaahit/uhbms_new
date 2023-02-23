import 'dart:convert';
import 'dart:developer';

import 'package:ahbmss/localData/login_local_data.dart';
import 'package:ahbmss/modals/add_order_all_Modals.dart';
import 'package:ahbmss/widegt/searchableDropdown/clientsSearchDropDoen.dart';
import 'package:ahbmss/widegt/searchableDropdown/curreny_search.dart';
import 'package:ahbmss/widegt/searchableDropdown/service_search_abble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Paymentlink extends StatefulWidget {
  const Paymentlink({super.key});

  @override
  State<Paymentlink> createState() => _PaymentlinkState();
}

class _PaymentlinkState extends State<Paymentlink> {
  final _formKey = GlobalKey<FormState>();
  final modulecodeController = TextEditingController();
  final amonutController = TextEditingController();
  // late String valueChoose;
  // List listItem = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"];
  List<ServicesModals> serviceList = [];

  List<UserClients> clientLsit = [];
  List<Curreny> currencyList = [];
  final color = const Color.fromARGB(255, 32, 41, 86);
  String clientMail = "";
  String serviceId = "0";
  String currencyCode = "0";
  String cid = "0";
  String sid = "0";
  bool permisson = false;
  @override
  void initState() {
    super.initState();
    fetchClients();
    fetchCurrency();
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          iconTheme: IconThemeData(
            color: color,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_outlined)),
            ),
          ],
          title: Text(
            "Create Payment Link",
            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 24),
          ),
          elevation: 0.0,
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: clientLsit.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : permisson == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Center(
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: ListView(
                                scrollDirection: Axis.vertical,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  ClientsSearch(
                                      myfunction: (value) {
                                        setState(() {
                                          clientMail = value;
                                        });
                                      },
                                      items: clientLsit),
                                  const SizedBox(height: 20),
                                  ServicesSearch(
                                    myfunction: (value) {
                                      setState(() {
                                        serviceId = value;
                                      });
                                    },
                                    items: serviceList,
                                    sid: sid,
                                  ),
                                  const SizedBox(height: 20),
                                  CurrenySearch(
                                      myfunction: (value) {
                                        setState(() {
                                          currencyCode = value;
                                        });
                                      },
                                      items: currencyList,
                                      dataID: cid),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(left: 8.0, bottom: 8),
                                    child: Text("Enter amount"),
                                  ),
                                  TextFormField(
                                    controller: amonutController,
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "Amount is required";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (_formKey.currentState!.validate() &&
                                          clientMail.isNotEmpty &&
                                          currencyCode != "0" &&
                                          serviceId != "0") {
                                        setState(() {
                                          permisson = true;
                                        });
                                        addPaymentLink(
                                            clientMail,
                                            amonutController.text,
                                            serviceId,
                                            currencyCode);
                                      }
                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 100,54,206),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: const Center(
                                        child: Text(
                                          "Submit",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Future fetchCurrency() async {
    final response = await http.post(
      Uri.parse('https://www.universitieshub.org/api/get-payment-getwaykey'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'rm_id': LocalData.rmID.toString(),
        'type': '1',
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      Map data = jsonDecode(response.body);

      List data2 = data["paymentGetwayKeyList"];
      for (int i = 0; i < data2.length; i++) {
        setState(() {
          currencyList.add(Curreny(
              data2[i]["id"].toString(), data2[i]["type"].toString(), ""));
        });
        log(data2[i].toString());
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future fetchClients() async {
    final response = await http.get(Uri.parse(
        'https://universitieshub.org/api/getClientListfullByRm/${LocalData.rmID}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // log(response.body.toString());
      Map data = jsonDecode(response.body);

      List data2 = data["usersList"];

      log(data2.toString());
      for (int i = 0; i < data2.length; i++) {
        setState(() {
          clientLsit.add(UserClients(data2[i]["user_id"].toString(),
              data2[i]["user_name"].toString()));
        });
        log(data2[i].toString());
      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future fetchServices() async {
    final response = await http
        .get(Uri.parse('https://universitieshub.org/api/services-list'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // log(response.body.toString());
      Map data = jsonDecode(response.body);
      Map data2 = data["serviceList"];
      data2.forEach((key, value) {
        setState(() {
          serviceList.addAll([ServicesModals(key, value)]);
        });
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future addPaymentLink(String clientid, String ammount, String serviceId,
      String currencttype) async {
    final response = await http.post(
      Uri.parse('https://universitieshub.org/api/create-payment-link'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'rm_id': LocalData.rmID.toString(),
        'type': '1',
        'client_id': clientid,
        'amount': ammount,
        'service_id': serviceId,
        'currenct_type': currencttype,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      if (data["status"] == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data["message"])));
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        setState(() {
          permisson = true;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data["message"])));
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
