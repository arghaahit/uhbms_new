import 'dart:convert';
import 'dart:developer';

import 'package:ahbmss/modals/status_list.dart';
import 'package:ahbmss/widegt/searchableDropdown/search_able_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AddOrederStatus extends StatefulWidget {
  final String tranxid;
  final String writerID;
  const AddOrederStatus(
      {super.key, required this.tranxid, required this.writerID});

  @override
  State<AddOrederStatus> createState() => _AddOrederStatusState();
}

class _AddOrederStatusState extends State<AddOrederStatus> {
  final shortNoteController = TextEditingController();
  List<StatusList> statusList = [];
  String? id;
  bool feildPermisson = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    fectchStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.5,
          title: Text(
            "Add Status",
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
        body: statusList.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MySearcAbleDropDown(
                              myfunction: (value) {
                                setState(() {
                                  id = value;
                                });
                              },
                              items: statusList),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: shortNoteController,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: InputDecoration(
                              labelText: 'Short Note',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                            maxLines: 5,
                            minLines: 5,
                            maxLength: 500,
                            validator: ((value) {
                              if (value!.isEmpty || value == null) {
                                return "short not required";
                              }
                              return null;
                            }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate() &&
                                  id != null) {
                                addStatus(
                                    widget.tranxid,
                                    shortNoteController.text,
                                    id!,
                                    widget.writerID);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Select Status")));
                              }
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 9, 14, 52),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Center(
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }

  Future fectchStatus() async {
    final response = await http
        .get(Uri.parse('https://www.universitieshub.org/api/orderStatusApi'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      Map data2 = data["orderStatus"];
      data2.forEach((key, value) {
        setState(() {
          statusList.addAll([StatusList(key, value)]);
        });
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load data');
    }
  }

  Future addStatus(
      String tranxid, String comment, String status, String writerId) async {
    final response = await http.post(
      Uri.parse('https://www.universitieshub.org/api/updateOrderStatus'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'tranxid': tranxid,
        'comment': comment,
        'status': status,
        'writer_id': writerId,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log(response.body.toString());
      Map data = jsonDecode(response.body);
      if (data["status"] == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(data["message"])));
        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.pop(context);
        });
      } else {
        setState(() {
          feildPermisson = false;
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
