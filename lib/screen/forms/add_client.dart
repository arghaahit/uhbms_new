import 'dart:convert';
import 'dart:developer';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:http/http.dart' as http;
import 'package:ahbmss/appsComoponent/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AddClintPage extends StatefulWidget {
  const AddClintPage({super.key});

  @override
  State<AddClintPage> createState() => _AddClintPageState();
}

class _AddClintPageState extends State<AddClintPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: Text(
          "Add Client",
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
      drawer: const MyDrawer(pageName: "AddClient"),
      body: const AddClintFormSection(),
    );
  }
}

class AddClintFormSection extends StatefulWidget {
  const AddClintFormSection({super.key});

  @override
  State<AddClintFormSection> createState() => _AddClintFormSectionState();
}

class _AddClintFormSectionState extends State<AddClintFormSection> {
  final TextEditingController controller = TextEditingController();
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final unverssityController = TextEditingController();
  final emailController = TextEditingController();
  String initialCountry = 'IN';
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  final _formKey = GlobalKey<FormState>();
  String iscode = "";
  bool lodar = false;
  @override
  Widget build(BuildContext context) {
    return lodar == true
        ? const Center(
            child: CircularProgressIndicator.adaptive(),
          )
        : Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                label: const Text("First Name"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.blue,
                                        style: BorderStyle.solid))),
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return "First Name is Required";
                              }
                              return null;
                            },
                          ),
                        )),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextFormField(
                            controller: lastNameController,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                label: const Text("Last Name"),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.blue,
                                        style: BorderStyle.solid))),
                            validator: (value) {
                              if (value!.isEmpty || value == null) {
                                return "Last Name is Required";
                              }
                              return null;
                            },
                          ),
                        ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                      padding: const EdgeInsets.all(10.0),
                      child: InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          setState(() {
                            iscode = number.dialCode.toString();
                          });
                        },
                        
                        onInputValidated: (bool value) {
                          log(value.toString());
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        ),
                        
                        ignoreBlank: false,
                        autoValidateMode: AutovalidateMode.disabled,
                        selectorTextStyle: const TextStyle(color: Colors.black),
                        initialValue: number,
                        textFieldController: controller,
                        formatInput: false,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: true, decimal: true),
                        inputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onSaved: (PhoneNumber number) {
                          log('On Saved: $number');
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: unverssityController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
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
                            setState(() {
                              lodar = true;
                            });
                            addClient(
                                nameController.text,
                                lastNameController.text,
                                emailController.text,
                                iscode,
                                controller.text,
                                unverssityController.text);
                          }
                        },
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 100,54,206),
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
            ),
          );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future addClient(
    String firstname,
    String lastName,
    String email,
    String isoCode,
    String phoneNumber,
    String university,
  ) async {
    final response = await http.post(
      Uri.parse('https://www.universitieshub.org/api/insertClientData'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': firstname,
        'last_name': lastName,
        'email': email,
        'country_code': iscode,
        'phone_number': phoneNumber,
        'univercity_name': university,
        'rm_id': LocalData.rmID,
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
      } else {
        setState(() {
          lodar = false;
        });
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar( const SnackBar(content: Text("Faild add Client")));
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to add album.');
    }
  }
}
