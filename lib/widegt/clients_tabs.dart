import 'dart:convert';
import 'dart:developer';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClientsTabs extends StatefulWidget {
  final String userName;
  final String email;
  final String mobile;
  final String university;
  final String isApproved;
  final String isMultipal;
  final int id;
  final String iscode;
  const ClientsTabs({
    super.key,
    required this.email,
    required this.id,
    required this.mobile,
    required this.university,
    required this.userName,
    required this.iscode,
    required this.isApproved,
    required this.isMultipal,
  });

  @override
  State<ClientsTabs> createState() => _ClientsTabsState();
}

class _ClientsTabsState extends State<ClientsTabs> {
  final color = Color.fromARGB(255, 172, 0, 0);
  bool slider = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: slider == true ? 190 : 80,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 172, 0, 0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () => showMybottomSheet(
                widget.userName,
                widget.email,
                widget.mobile,
                widget.university,
                widget.id,
                widget.iscode,
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(top: 155.0, bottom: 5, left: 15, right: 5),
                child: Text(
                  "Edit",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
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
              color: Colors.grey.shade200,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
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
                            "Email",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Mobile: ",
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontStyle: FontStyle.normal,
                              letterSpacing: 1,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "University: ",
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
                              widget.email,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontStyle: FontStyle.normal,
                                letterSpacing: 1,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "${widget.iscode}-${widget.mobile}",
                              overflow: TextOverflow.ellipsis,
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
                                    widget.university,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontStyle: FontStyle.normal,
                                      letterSpacing: 1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                     
                      if (widget.isMultipal == "0")
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Auto-approved",
                                style: TextStyle(color: Colors.white,  fontSize: 10),
                              ),
                            ),
                          ),
                        )
                      else if (widget.isMultipal == "1")
                        if (widget.isApproved == "0")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Pending",
                                  style: TextStyle(color: Colors.white,
                                  fontSize: 10
                                  ),
                                ),
                              ),
                            ),
                          )
                        else if (widget.isApproved == "1")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Addmin-approved",
                                  style: TextStyle(color: Colors.white,fontSize: 10),
                                ),
                              ),
                            ),
                          )
                        else if (widget.isApproved == "2")
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Addmin-rejected",
                                  style: TextStyle(color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showMybottomSheet(String name, String email, String mobil,
      String university, int id, String isoCode) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController(text: email);
    TextEditingController univercityName =
        TextEditingController(text: university);
    showBottomSheet(
        enableDrag: true,
        elevation: 500,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        context: context,
        builder: (context) {
          return SizedBox(
            height: 700,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 10),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: widget.userName,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          label: const Text("Name"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid))),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "Name is Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          label: const Text("E-mail"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid))),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "E-mail is Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      readOnly: true,
                      initialValue: "+$mobil",
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          label: const Text("Mobile"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid))),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "Mobile is Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: univercityName,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          label: const Text("University"),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid))),
                      validator: (value) {
                        if (value!.isEmpty || value == null) {
                          return "University is Required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          editClient(id, name, emailController.text, isoCode,
                              mobil, univercityName.text);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 32, 41, 86),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                            child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future editClient(
    int userId,
    String firstname,
    String email,
    String isoCode,
    String phoneNumber,
    String university,
  ) async {
    final response = await http.post(
      Uri.parse('https://www.universitieshub.org/api/updateClientData'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'user_name': firstname,
        'email': email,
        'country_code': isoCode,
        'phone_number': phoneNumber,
        'univercity_name': university,
        'rm_id': LocalData.rmID,
        'client_id': userId,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      log(response.body.toString());
      var data = jsonDecode(response.body);
      if (data["status"] == 200) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Client data update")));
      } else {
        setState(() {
          // lodar = true;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Faild edit Client")));
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add album.');
    }
  }
}
