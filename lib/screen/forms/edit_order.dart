import 'package:flutter/material.dart';

class Editorder extends StatefulWidget {
  const Editorder({super.key});

  @override
  State<Editorder> createState() => _EditorderState();
}

class _EditorderState extends State<Editorder> {
  final _formKey = GlobalKey<FormState>();
  final modulecodeController = TextEditingController();
  final modulenameController = TextEditingController();
  final wordcountController = TextEditingController();
  final reportController = TextEditingController();
  final clinetamountController = TextEditingController();
  final iNRamountController = TextEditingController();
  final aUDamounitController = TextEditingController();
  final shortnoteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          title: const Text(
            "Edit order",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: Form(
                key: _formKey,
                child: Center(
                  child: ListView(
                      scrollDirection: Axis.vertical,
                      children: <Widget>[
                        TextFormField(
                          controller: modulecodeController,
                          decoration: InputDecoration(
                            labelText: 'Module code',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
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
                                borderRadius: BorderRadius.circular(20)),
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
                        TextFormField(
                          controller: wordcountController,
                          decoration: InputDecoration(
                            labelText: 'Word count',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
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
                                borderRadius: BorderRadius.circular(20)),
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
                        TextFormField(
                          controller: clinetamountController,
                          decoration: InputDecoration(
                            labelText: 'Client Amount',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
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
                                borderRadius: BorderRadius.circular(20)),
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
                                borderRadius: BorderRadius.circular(20)),
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
                                borderRadius: BorderRadius.circular(20)),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {}
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15),
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
      ),
    );
  }
}
