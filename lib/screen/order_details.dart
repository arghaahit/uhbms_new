import 'dart:convert';

import 'package:ahbmss/modals/order_details_modal.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Orderdetails extends StatefulWidget {
  final int orderid;
  const Orderdetails({super.key, required this.orderid});

  @override
  State<Orderdetails> createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  final _formKey = GlobalKey<FormState>();
  final clientnameController = TextEditingController(text: "Krishna");
  final clientEmailController =
      TextEditingController(text: "Krishna.sarkar.ahit@gmail.com");
  final mobileController = TextEditingController(text: "565656565656");
  final modulecodeController = TextEditingController(text: "d5d8e8wfs");
  final modulenameController = TextEditingController();
  final deadlineController = TextEditingController();
  final wordcountController = TextEditingController();
  final assignmenttypeController = TextEditingController();
  final paytypeController = TextEditingController();
  final currencyController = TextEditingController();
  final clinetamountController = TextEditingController();
  final iNRamountController = TextEditingController();
  final aUDamounitController = TextEditingController();
  final shortnoteController = TextEditingController();
  Future<OrderDetailsModals>? _futureAlbum;
  @override
  void initState() {
    super.initState();
    _futureAlbum = getDataOrder(widget.orderid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            "Order Details",
            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 24),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_outlined)),
        ),
        body: FutureBuilder<OrderDetailsModals>(
          future: _futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child:
                            ListView(scrollDirection: Axis.vertical, children: <
                                Widget>[
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.enFirstName,
                            decoration: InputDecoration(
                              labelText: 'Client Name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.enEmail,
                            decoration: InputDecoration(
                              labelText: 'Client Email',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                "${snapshot.data!.userData.phoneCode}-${snapshot.data!.userData.enMobile}",
                            decoration: InputDecoration(
                              labelText: 'Mobile',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.enSubject,
                            decoration: InputDecoration(
                              labelText: 'Module code',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.moduleName,
                            decoration: InputDecoration(
                              labelText: 'Module name',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                "${snapshot.data!.userData.deadline.day}-${snapshot.data!.userData.deadline.month}-${snapshot.data!.userData.deadline.year}",
                            decoration: InputDecoration(
                              labelText: 'Dead Line',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.wordCount,
                            decoration: InputDecoration(
                              labelText: 'Word count',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue:
                                snapshot.data!.userData.assignmentType,
                            decoration: InputDecoration(
                              labelText: 'Assignment type',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.paymentType,
                            decoration: InputDecoration(
                              labelText: 'Pay Type',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.currencyType,
                            decoration: InputDecoration(
                              labelText: 'Currency',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.clientAmount,
                            decoration: InputDecoration(
                              labelText: 'Client Amount',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.inrAmount,
                            decoration: InputDecoration(
                              labelText: 'INR Amount',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            initialValue: snapshot.data!.userData.audAmount,
                            decoration: InputDecoration(
                              labelText: 'AUD Amount',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            readOnly: true,
                            textAlignVertical: TextAlignVertical.top,
                            initialValue: snapshot.data!.userData.enQuery,
                            decoration: InputDecoration(
                              labelText: 'Short Note',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            maxLines: 5,
                            minLines: 5,
                            maxLength: 500,
                          ),
                          Container(
                            height: 150,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: snapshot.data!.screenshot == "-"
                                  ? const Text("Image not Found")
                                  : Image.network(snapshot.data!.screenshot),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ]),
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Future<OrderDetailsModals> getDataOrder(int orderid) async {
    final response = await http.post(
      Uri.parse('https://www.universitieshub.org/api/getOrderData'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'order_id': orderid,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return OrderDetailsModals.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
