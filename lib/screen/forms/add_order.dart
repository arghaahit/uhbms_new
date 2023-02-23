import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ahbmss/appsComoponent/drawer.dart';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:ahbmss/modals/add_order_all_Modals.dart';
import 'package:ahbmss/widegt/searchableDropdown/clientsSearchDropDoen.dart';
import 'package:ahbmss/widegt/searchableDropdown/clients_orders_search.dart';
import 'package:ahbmss/widegt/searchableDropdown/curreny_search.dart';
import 'package:ahbmss/widegt/searchableDropdown/service_search_abble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Addorder extends StatefulWidget {
  const Addorder({super.key});

  @override
  State<Addorder> createState() => _AddorderState();
}

class _AddorderState extends State<Addorder> {
  final _formKey = GlobalKey<FormState>();
  final modulecodeController = TextEditingController();
  final modulenameController = TextEditingController();
  final wordcountController = TextEditingController();
  final reportController = TextEditingController();
  final clinetamountController = TextEditingController();
  final iNRamountController = TextEditingController();
  final aUDamounitController = TextEditingController();
  final shortnoteController = TextEditingController();

  List<UserClients> clientLsit = [];
  List<Curreny> currencyList = [];
  List<ServicesModals> serviceList = [];
  List<ClientOrders> clientsOrderList = [];

  String clientMail = "";
  String orderType = "1";
  String orderTypeOnString = "Select Order Type";
  String selectPaymentType = "Select Payment type";
  String serviceId = "0";
  String currencyCode = "0";
  String clientOrderID = "";

  String cid = "0";
  String sid = "0";

  DateTime? date = DateTime.now();

  bool changer = false;
  bool selectPaymentBool = false;
  bool permisson = false;
  bool lodar = false;
  @override
  void initState() {
    super.initState();
    fetchClients();
    fetchCurrency();
    fetchServices();
  }

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Faild to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "Add Order",
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 24),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_outlined)),
        ],
      ),
      drawer: const MyDrawer(pageName: "AddOrder"),
      body: clientLsit.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : lodar == true
              ? const Center(child: CircularProgressIndicator())
              : permisson == false?
              SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 0, right: 10, left: 10),
                      child: Center(
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 20),
                                  ClientsSearch(
                                      myfunction: (value) {
                                        setState(() {
                                          clientMail = value;
                                        });
                                        if (orderType == "2") {
                                          fecthClientsOrder(clientMail);
                                        }
                                      },
                                      items: clientLsit),
                                  const SizedBox(height: 20),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        changer = true;
                                      });
                                    },
                                    child: Container(
                                        height: changer == false ? 60 : 80,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey.shade500,
                                                style: BorderStyle.solid)),
                                        child: changer == false
                                            ? Center(
                                                child: Text(
                                                  orderTypeOnString,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          orderType = "1";
                                                          changer = false;
                                                          orderTypeOnString =
                                                              "New Order";
                                                        });
                                                      },
                                                      child: const Text(
                                                        "New Order",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: InkWell(
                                                      onTap: (() {
                                                        setState(() {
                                                          orderType = "2";
                                                          changer = false;
                                                          orderTypeOnString =
                                                              "Existing Order";
                                                        });
                                                        fecthClientsOrder(
                                                            clientMail);
                                                      }),
                                                      child: const Text(
                                                        "Existing Order",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  if (orderType == "2")
                                    ClientsOrderSearch(
                                        myfunction: (value) {
                                          setState(() {
                                            clientOrderID = value;
                                            lodar = true;
                                          });
                                          fecthOrderDAta(value);
                                        },
                                        items: clientsOrderList),
                                  if (orderType == "2")
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
                                  TextFormField(
                                    controller: modulecodeController,
                                    decoration: InputDecoration(
                                      labelText: 'Module code',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please enter Module code";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: modulenameController,
                                    decoration: InputDecoration(
                                      labelText: 'Module name',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please enter Module name";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      date = await showDatePicker(
                                          context: context,
                                          initialDate: date!,
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2023));
                                      setState(() {});
                                    },
                                    child: Container(
                                      height: 50,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          border: Border.all(
                                              color: Colors.grey.shade400,
                                              style: BorderStyle.solid)),
                                      child: Center(
                                        child: Text(
                                            "${date!.day}/${date!.month}/${date!.year}"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: wordcountController,
                                    decoration: InputDecoration(
                                      labelText: 'Word count',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please enter Word count";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: reportController,
                                    decoration: InputDecoration(
                                      labelText: 'Report/PPT',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please fill this field";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectPaymentBool = true;
                                      });
                                    },
                                    child: Container(
                                        height: selectPaymentBool == false
                                            ? 60
                                            : 120,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                color: Colors.grey.shade400,
                                                style: BorderStyle.solid)),
                                        child: selectPaymentBool == false
                                            ? Center(
                                                child: Text(
                                                  selectPaymentType,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )
                                            : Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            selectPaymentBool =
                                                                false;
                                                            selectPaymentType =
                                                                "Full Payment";
                                                          });
                                                        },
                                                        child: const Text(
                                                            "Full Payment")),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            selectPaymentBool =
                                                                false;
                                                            selectPaymentType =
                                                                "Partial Payment";
                                                          });
                                                        },
                                                        child: const Text(
                                                            "Partial Payment")),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            selectPaymentBool =
                                                                false;
                                                            selectPaymentType =
                                                                "Remaining Payment";
                                                          });
                                                        },
                                                        child: const Text(
                                                            "Remaining Payment")),
                                                  ),
                                                ],
                                              )),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
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
                                  TextFormField(
                                    controller: clinetamountController,
                                    decoration: InputDecoration(
                                      labelText: 'Client Amount',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please fill Client Amount";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: iNRamountController,
                                    decoration: InputDecoration(
                                      labelText: 'INR Amount',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please fill INR Amount";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: aUDamounitController,
                                    decoration: InputDecoration(
                                      labelText: 'AUD Amount',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please fill AUD Aomunt";
                                      }

                                      return null;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    textAlignVertical: TextAlignVertical.top,
                                    controller: shortnoteController,
                                    decoration: InputDecoration(
                                      labelText: 'Short Note',
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    maxLines: 5,
                                    minLines: 5,
                                    maxLength: 500,
                                    validator: (value) {
                                      if (value!.isEmpty || value == null) {
                                        return "please fill Short Note";
                                      }

                                      return null;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 20,
                                        left: 10,
                                        right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        pickImage();
                                      },
                                      child: Container(
                                        height: 150,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                            child: image == null
                                                ? Icon(
                                                    Icons.add_a_photo_rounded,
                                                    color: Colors.grey.shade400,
                                                    size: 35,
                                                  )
                                                : Image.file(image!)),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        log("pass");
                                        if (permisson == false) {
                                          
                                        }
                                        if (orderType == "2") {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                clientMail.isNotEmpty &&
                                                serviceId != "0" &&
                                                currencyCode != "0" &&
                                                clientOrderID != "0") {
                                                  log("test");
                                              addOrderApi(
                                                  clientMail,
                                                  orderType,
                                                  clientOrderID,
                                                  selectPaymentType,
                                                  serviceId,
                                                  modulecodeController.text,
                                                  modulenameController.text,
                                                  "${date!.day.toString()}-${date!.month.toString()}-${date!.year.toString()}",
                                                  wordcountController.text,
                                                  reportController.text,
                                                  clinetamountController.text,
                                                  iNRamountController.text,
                                                  aUDamounitController.text,
                                                  shortnoteController.text,
                                                  currencyCode);
                                              setState(() {
                                                permisson = true;
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Select all Feilds")));
                                            }
                                          }


                                          if (orderType == "1") {
                                            if (_formKey.currentState!
                                                    .validate() &&
                                                clientMail.isNotEmpty &&
                                                serviceId != "0" &&
                                                currencyCode != "0") {
                                                  log("test2");
                                              addOrderApi(
                                                  clientMail,
                                                  orderType,
                                                  "",
                                                  selectPaymentType,
                                                  serviceId,
                                                  modulecodeController.text,
                                                  modulenameController.text,
                                                  "${date!.day.toString()}-${date!.month.toString()}-${date!.year.toString()}",
                                                  wordcountController.text,
                                                  reportController.text,
                                                  clinetamountController.text,
                                                  iNRamountController.text,
                                                  aUDamounitController.text,
                                                  shortnoteController.text,
                                                  currencyCode);
                                              setState(() {
                                                permisson = true;
                                              });
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          "Select all Feilds")));
                                            }
                                          }
                                      },
                                      child: Container(
                                        height: 50,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 100,54,206),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade200,
                                                spreadRadius: 1,
                                                blurRadius: 15,
                                                offset: const Offset(4, 4),
                                              )
                                            ]),
                                        child: const Center(
                                          child: Text(
                                            "Submit",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ) : const Center(
                  child: CircularProgressIndicator(),
                )
    );
  }

  Future fetchClients() async {
    final response = await http.get(Uri.parse(
        'https://www.universitieshub.org/api/addOrderClientList/${LocalData.rmID}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // log(response.body.toString());
      Map data = jsonDecode(response.body);
      Map data2 = data["usersList"];
      data2.forEach((key, value) {
        setState(() {
          clientLsit.addAll([UserClients(key, value)]);
        });
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future fetchCurrency() async {
    final response = await http
        .get(Uri.parse('https://www.universitieshub.org/api/currency-list'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      Map data = jsonDecode(response.body);

      List data2 = data["currencyList"];
      for (int i = 0; i < data2.length; i++) {
        setState(() {
          currencyList.add(Curreny(
              data2[i]["currency_id"].toString(),
              data2[i]["currency_code"].toString(),
              data2[i]["currency_symbol"].toString()));
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
        .get(Uri.parse('https://www.universitieshub.org/api/services-list'));

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

  Future fecthClientsOrder(String email) async {
    final response = await http.post(
      Uri.parse('https://www.universitieshub.org/api/searcholduser'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'modal_en_email': email,
        'rm_id': LocalData.rmID,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      List data2 = data["userData"];
      log(data2.toString());
      for (int i = 0; i < data2.length; i++) {
        setState(() {
          clientsOrderList.add(ClientOrders(
              data2[i]["order_number"].toString(), data2[i]["id"].toString()));
        });
      }
      log(clientsOrderList[1].orderNumber.toString());
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future fecthOrderDAta(String orderId) async {
    final response = await http.post(
      Uri.parse('https://www.universitieshub.org/api/getOrderData'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'order_id': orderId,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      Map data2 = data["userData"];
      setState(() {
        modulecodeController.text = data2["en_subject"].toString();
        modulenameController.text = data2["module_name"].toString();
        date = DateTime.parse(data2["deadline"]);
        wordcountController.text = data2["word_count"];
        reportController.text = data2["assignment_type"];
        clinetamountController.text = data2["client_amount"];
        iNRamountController.text = data2["inr_amount"];
        aUDamounitController.text = data2["aud_amount"];
        shortnoteController.text = data2["en_query"];
        currencyCode = data2["currency_type"];
        serviceId = data2["en_service"];
        sid = data2["en_service"];
        cid = data2["currency_type"];
        lodar = false;
      });
      setState(() {});
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future addOrderApi(
      String email,
      String orderType,
      String preOrder,
      String paymenttype,
      String enservice,
      String modalensubject,
      String modalenmodulename,
      String deadline,
      String wordcount,
      String assignmenttype,
      String clientamount,
      String inramount,
      String audamount,
      String modalenquery,
      String currencytype) async {
    var request = http.MultipartRequest(
        "POST", Uri.parse("https://www.universitieshub.org/api/addOrder"));
    request.fields['user_email'] = email;
    request.fields['order_type'] = orderType;
    request.fields['pre_order_id'] = preOrder;
    request.fields['payment_type'] = paymenttype;
    request.fields['en_service'] = enservice;
    request.fields['modal_en_subject'] = modalensubject;
    request.fields['modal_en_module_name'] = modalenmodulename;
    request.fields['deadline'] = deadline;
    request.fields['word_count'] = wordcount;
    request.fields['assignment_type'] = assignmenttype;
    request.fields['client_amount'] = clientamount;
    request.fields['inr_amount'] = inramount;
    request.fields['aud_amount'] = audamount;
    request.fields['rm_id'] = LocalData.rmID.toString();
    request.fields['modal_en_query'] = modalenquery;
    request.fields['currency_type'] = currencytype;
    log("hey");
    if (image != null) {
      request.files
          .add(await http.MultipartFile.fromPath('Screenshot', image!.path));
      request.send().then((response) {
        http.Response.fromStream(response).then((onValue) {
          try {
            log(onValue.body);
            Map data = jsonDecode(onValue.body);
            if (data["status"] == 200) {
               setState(() {
                lodar = true;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Order Placed")));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order Placed faild")));
              setState(() {
                lodar = false;
              });
            }
          } catch (e) {
            // handle exeption
          }
        });
      });
    } else {
      request.send().then((response) {
        http.Response.fromStream(response).then((onValue) {
          try {
            Map data = jsonDecode(onValue.body);
            if (data["status"] == 200) {
               setState(() {
                lodar = true;
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Order Placed")));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order Placed faild")));
              setState(() {
                lodar = false;
              });
            }
          } catch (e) {
            // handle exeption
          }
        });
      }); 
    }
  }
}
