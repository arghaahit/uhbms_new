// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:ahbmss/core/dropbox/dropbox.dart';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:ahbmss/modals/status_list.dart';
import 'package:ahbmss/screen/api/static_values.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../widegt/searchableDropdown/search_able_dropdown.dart';

class Forward extends StatefulWidget {
  final String trxid;
  final String orderid;
  final String id;

  const Forward({
    super.key,
    required this.orderid,
    required this.id,
    required this.trxid,
  });

  @override
  State<Forward> createState() => _ForwardState();
}

class _ForwardState extends State<Forward> {
  final color = const Color.fromARGB(255, 32, 41, 86);
  bool isExpanded = false;
  String email = "hdark6336@gmail.com";
  List<WriterModal> mailArray = [];
  List<WriterModal> mailList = [];
  final TextEditingController _controller = TextEditingController();
  String? dropboxPath;
  String? dropboxlink;
  List<StatusList> status = [];
  String statusKey = "";
  bool permission = false;
  @override
  void initState() {
    log(LocalData.rmID.toString());
    fetchAlbum();
    super.initState();
    if (LocalData.rmID == 0) {
      fetchdata();
    }
    log(LocalData.rmID.toString());
  }

  FilePickerResult? result;
  String? _fileName;
  PlatformFile? pickedfile;
  bool isLoading = false;
  File? fileToDisplay;
  Future? response;
  bool loader = false;

  // uploadFile(String path) async {
  //   final response = Dropbox.upload(path, "/data");
  //   log(response.toString());
  // }

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );
      if (result != null) {
        _fileName = result!.files.first.name;
        pickedfile = result!.files.first;
        fileToDisplay = File(pickedfile!.path.toString());
        log("File name $_fileName");
      }

      setState(() {
        isLoading = false;
        loader = true;
      });

      log("hey");
      if (dropboxPath == null) {
        createFoldar();
      } else {
        deleteFile(dropboxPath!);
        createFoldar();
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: const Color.fromARGB(255, 47, 47, 47),
        backgroundColor: color,
        elevation: 0.0,
        title: const Text(
          "Forward",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () => pickFile(),
                icon: const Icon(
                  Icons.attachment_rounded,
                  color: Colors.white,
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
                onPressed: () {
                  // createFoldar();
                  if (dropboxlink != null) {
                    setState(() {
                      permission = true;  
                    });
                    addData(widget.trxid, _controller.text, dropboxlink!, _fileName!);
                  }
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                )),
          ),
        ],
      ),
      backgroundColor: color,
      body: loader
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "This process take some time do not turn off screen",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ],
              ),
            )
          : permission == false?Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 12.0, right: 12.0),
                                  child: Text(
                                    widget.orderid,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 22,
                                    ),
                                  ),
                                ))
                              ],
                            )),
                        Container(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 10, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "From",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  LocalData.email.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                )
                              ],
                            )),
                        Container(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (LocalData.rmID == 0) {
                                isExpanded = !isExpanded;
                              }
                            });
                          },
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "To",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    if (LocalData.rmID == 0)
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            isExpanded = !isExpanded;
                                          });
                                        },
                                        child: Container(
                                          height: 30,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              71,
                                          color: Colors.transparent,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemCount: mailArray.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 0,
                                                          bottom: 0,
                                                          left: 4,
                                                          right: 4),
                                                  child: Container(
                                                    height: 30,
                                                    width: 200,
                                                    decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              500),
                                                      border: Border.all(
                                                          color: Colors
                                                              .grey.shade300),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4),
                                                          child: Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade400,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          500),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          mailArray[index].name,
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        Expanded(
                                                            child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      mailArray
                                                                          .removeAt(
                                                                              index);
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Padding(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            right:
                                                                                5),
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 20,
                                                                    ),
                                                                  )),
                                                            ],
                                                          ),
                                                        ))
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                    if (LocalData.rmID != 0)
                                      const Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Text(
                                          "work.allocation@gmail.com",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                              )),
                        ),
                        if (isExpanded == true)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 200,
                                width: 200,
                                child: ListView.builder(
                                    itemCount: mailList.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return myEmailTabs(
                                          index,
                                          mailList[index].id,
                                          mailList[index].name);
                                    }),
                              ),
                            ],
                          ),
                        Container(
                          height: 0.5,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey.shade200,
                        ),
                        MySearcAbleDropDown(
                          myfunction: (value) {
                            setState(() {
                              statusKey = value;
                            });
                          },
                          items: status,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: _controller,
                            maxLength: 3000,
                            maxLines: 50,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (fileToDisplay != null)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade600,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  deleteFile(dropboxPath!);
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.black,
                                                ))
                                          ],
                                        ),
                                        const Icon(
                                          Icons.attach_file,
                                          color: Colors.white,
                                          size: 35,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          _fileName!,
                                          style: const TextStyle(
                                              color: Colors.black),
                                        )
                                      ],
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          )
                      ],
                    ),
                  )),
            ) : const Center(
              child: CircularProgressIndicator(),
            )
    );
  }

  Widget myEmailTabs(int index, String id, String value) {
    return InkWell(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;

          mailArray.add(WriterModal(id, value));
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 10),
        child: Container(
          height: 40,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(500),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(500),
                  ),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                value,
                style: const TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  myDialo() {
    showDialog(
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(
                left: 50.0, right: 50.0, top: 450, bottom: 450),
            child: Material(
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          width: 30,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Wait a while",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Dont turn off your screen",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void searchUser(String query) {
    final data = mailList.where((user) {
      final title = user.name.toLowerCase();
      final input = query.toLowerCase();
      return title.contains(input);
    }).toList();
  }

  fetchdata() async {
    final response = await http
        .get(Uri.parse('https://${Api.testdomain}/api/getwriteslist'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      Map data2 = data["orderStatus"];
      data2.forEach((key, value) {
        setState(() {
          mailList.addAll([WriterModal(key, value.toString())]);
        });
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  createFoldar() async {
    log("hello");
    String token = DropBoxtoken.token;
    final response = await http.post(
      Uri.parse('https://api.dropboxapi.com/2/files/create_folder_v2'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token,
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'autorename': false,
        'path': '/${widget.id}',
      }),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      Map data2 = data["metadata"];
      String path = data2["path_display"].toString();
      log(response.body);

      uploadData(_fileName!, "/$path");
    } else if (response.statusCode == 401) {
      log("from creatFoldar");
      log(response.body);

      getAccesToken();
    } else {
      log(response.body);
      uploadData(_fileName!, "/${widget.id}");
    }
  }

  getAccesToken() async {
    final response = await http.post(
      Uri.parse('https://www.test.ahecounselling.com/api/getaccesstoken'),
      headers: <String, String>{
        'Authorization': 'Basic ',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, dynamic>{
        'refresh_token': DropBoxtoken.refreshToken,
        'appkey': 'ih12s882m849rfo',
        'secretkey': '7aw8pjk6du3hu2n',
      }),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      setState(() {
        DropBoxtoken.token = data["data"]["access_token"].toString();
      });
      createFoldar();
    } else {
      log("somethin went wrong");
    }

    log(response.body);
  }

  uploadData(String filename, String path) async {
    log("hello");
    final file = File(fileToDisplay!.path.toString());
    Uint8List data = await file.readAsBytes();
    String token = DropBoxtoken.token;
    final response = await http.post(
      Uri.parse('https://content.dropboxapi.com/2/files/upload'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + token,
        'Content-Type': 'application/octet-stream',
        'Dropbox-API-Arg':
            '{"autorename" : false, "mode":"add", "mute": false,  "path": "$path/$filename", "strict_conflict": false}'
      },
      body: data,
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      setState(() {
        dropboxPath = data["path_display"].toString();
      });
      getDropoxlink();
      log(response.body.toString());

      showNotifaction("Attachment added");
    } else {
      log(response.body.toString());

      showNotifaction("Please try again");
    }
  }

  getDropoxlink() async {
    final response = await http.post(
      Uri.parse('https://api.dropboxapi.com/2/sharing/create_shared_link'),
      headers: <String, String>{
        'Authorization': 'Bearer ${DropBoxtoken.token}',
        'Content-Type': 'application/json'
      },
      body: jsonEncode(<String, dynamic>{
        'path': dropboxPath!,
        'short_url': false,
      }),
    );
    if (response.statusCode == 200) {
      Map data = jsonDecode(response.body);
      dropboxlink = data["url"].toString();

      setState(() {
        final dropboxlink1 =
            dropboxlink!.substring(0, dropboxlink!.indexOf('dl=0'));
        dropboxlink = "${dropboxlink1}dl=1";

        loader = false;
      });
      log(dropboxlink!);
    } else if (response.statusCode == 401) {
      getAccesToken();
    } else {
      log("somethin went wrong");
    }

    log(response.body);
  }

  deleteFile(String path) async {
    String token = DropBoxtoken.token;
    final response = await http.post(
        Uri.parse("https://api.dropboxapi.com/2/files/delete_v2"),
        headers: <String, String>{
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json"
        },
        body: jsonEncode(<String, String>{"path": path}));
    if (response.statusCode == 200) {
      setState(() {
        fileToDisplay = null;
      });
      log(response.body.toString());
    } else {
      log(response.body.toString());
    }
  }

  Future addData(String tranxid, String comment, String filelink, String addfilename) async {
    final response = await http.post(
      Uri.parse('https://www.test.ahecounselling.com/api/updateOrderStatus'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'tranxid': tranxid,
        'comment': comment,
        'status': statusKey,
        'file_link': filelink,
        'file_name': addfilename,
      }),
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      showNotifaction("Status Added Sucess");
      Navigator.pop(context);
      log(response.body.toString());
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://${Api.testdomain}/api/orderStatusApi'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map a = jsonDecode(response.body);
      Map b = a["orderStatus"];
      b.forEach((key, value) {
        setState(() {
          status.addAll([StatusList(key, value)]);
        });
      });
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void showNotifaction(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}

class WriterModal {
  final String id;
  final String name;

  WriterModal(this.id, this.name);
}
