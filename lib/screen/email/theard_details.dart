import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';


import 'package:ahbmss/modals/order_status_modal.dart';
import 'package:ahbmss/screen/email/forward.dart';
import 'package:path_provider/path_provider.dart';
import 'package:external_path/external_path.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../../core/dropbox/dropbox.dart';
import '../api/static_values.dart';

class TheardDetails extends StatefulWidget {
  final String trx;
  final String orderTitle;
  final String id;
  const TheardDetails(
      {super.key,
      required this.orderTitle,
      required this.trx,
      required this.id});

  @override
  State<TheardDetails> createState() => _TheardDetailsState();
}

class _TheardDetailsState extends State<TheardDetails> {
  bool addTohigheLite = false;
  late Future<OrderStatusModals> futureAlbum;
  List<String> status = [];
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    getStatus();
    futureAlbum = fetchAlbum();
  }

  final color = const Color.fromARGB(255, 32, 41, 86);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color.fromARGB(255, 47, 47, 47),
        backgroundColor: color,
        appBar: AppBar(
          backgroundColor: color,
          elevation: 0.0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.archive_rounded,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    addTohigheLite = addTohigheLite == false ? true : false;
                  });
                },
                icon: Icon(
                  addTohigheLite == false ? Icons.star_border : Icons.star,
                  color: addTohigheLite == false ? Colors.white : Colors.orange,
                )),
          ],
        ),
        body: FutureBuilder<OrderStatusModals>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              log(snapshot.data!.userData.workStatus.length.toString());
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: color,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0),
                          child: SizedBox(
                              height: 100,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      snapshot.data!.userData.orderTitle
                                          .toString(),
                                      overflow: TextOverflow.visible,
                                      maxLines: 3,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 24,
                                      ),
                                    ))
                                  ],
                                ),
                              )),
                        ),
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Tabs(
                                  filename: snapshot
                                      .data!
                                      .userData
                                      .workStatus[0]
                                      .filename,
                                  comment: snapshot
                                      .data!.userData.workStatus[0].comment,
                                  data: status,
                                  fileLink: snapshot
                                      .data!.userData.workStatus[0].fileLink,
                                  statusid: snapshot
                                      .data!.userData.workStatus[0].status,
                                  userType: snapshot
                                      .data!.userData.workStatus[0].userType,
                                  trx: snapshot.data!.userData.workStatus[0]
                                      .firstEnquaryId,
                                  title: snapshot.data!.userData.orderTitle
                                      .toString(),
                                  id: widget.id,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (snapshot.data!.userData.workStatus.length > 0)
                          if (isExpanded == false)
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    isExpanded = true;
                                  });
                                },
                                child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.black26,
                                  child: Center(
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          height: 10,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          color: Colors.black87,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(
                                              width: 35,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade400,
                                                borderRadius:
                                                    BorderRadius.circular(500),
                                              ),
                                              child: Center(
                                                child: Text(
                                                    "${snapshot.data!.userData.workStatus.length - 2}"),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        if (isExpanded == true)
                          ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    snapshot.data!.userData.workStatus.length -
                                        2,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Tabs(
                                      filename: snapshot
                                      .data!
                                      .userData
                                      .workStatus[index + 1]
                                      .filename,
                                        comment: snapshot.data!.userData
                                            .workStatus[index + 1].comment,
                                        data: status,
                                        fileLink: snapshot.data!.userData
                                            .workStatus[index + 1].fileLink,
                                        statusid: snapshot.data!.userData
                                            .workStatus[index + 1].status,
                                        userType: snapshot.data!.userData
                                            .workStatus[index + 1].userType,
                                        trx: snapshot.data!.userData
                                            .workStatus[index + 1].firstEnquaryId,
                                        title: snapshot.data!.userData.orderTitle
                                            .toString(),
                                        id: widget.id,
                                      ),
                                  );
                                }),
                        SizedBox(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Tabs(
                                  filename: snapshot
                                      .data!
                                      .userData
                                      .workStatus[snapshot.data!.userData
                                              .workStatus.length -
                                          1]
                                      .filename,
                                  comment: snapshot
                                      .data!
                                      .userData
                                      .workStatus[snapshot.data!.userData
                                              .workStatus.length -
                                          1]
                                      .comment,
                                  data: status,
                                  fileLink: snapshot
                                      .data!.userData.workStatus[snapshot.data!.userData
                                              .workStatus.length -
                                          1].fileLink,
                                  statusid: snapshot
                                      .data!.userData.workStatus[snapshot.data!.userData
                                              .workStatus.length -
                                          1].status,
                                  userType: snapshot
                                      .data!.userData.workStatus[snapshot.data!.userData
                                              .workStatus.length -
                                          1].userType,
                                  trx: snapshot.data!.userData.workStatus[snapshot.data!.userData
                                              .workStatus.length -
                                          1]
                                      .firstEnquaryId,
                                  title: snapshot.data!.userData.orderTitle
                                      .toString(),
                                  id: widget.id,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Future<OrderStatusModals> fetchAlbum() async {
    final response = await http.get(
        Uri.parse('https://${Api.testdomain}/api/trackstatus/${widget.trx}'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log(response.body);
      return OrderStatusModals.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  void getStatus() async {
    final response = await http
        .get(Uri.parse('https://${Api.testdomain}/api/orderStatusApi'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      Map data2 = data["orderStatus"];
      data2.forEach(
        (key, value) {
          status.add(value.toString());
        },
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

class Tabs extends StatefulWidget {
  final int statusid;
  final String id;
  final String? fileLink;
  final String comment;
  final String userType;
  final String trx;
  final String title;
  final List<String> data;
  final String filename;
  const Tabs(
      {super.key,
      required this.comment,
      required this.data,
      required this.fileLink,
      required this.statusid,
      required this.title,
      required this.trx,
      required this.id,
      required this.filename,
      required this.userType});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> with TickerProviderStateMixin {
  bool show = false;
  bool downloading  = false;
  String prograssString = '';
  String downloadedImagePath = '';

  Future <bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  // Future<String> getDownloadFolderPath() async {
  //   String path = (await getExternalStorageDirectory()) as String;
  //    return await path;
  // }

  Future downloadFile({required String filename, required String link})async{
   showBottom();
    Dio dio = Dio();
    var downloadedImagePath = '/storage/emulated/0/Download/$filename';
    try{
      await dio.download(
        link, 
        downloadedImagePath,
        onReceiveProgress: (rec, total) {
          log("REC: $rec , TOTAL: $total");
          setState(() {
            downloading = true;
            prograssString = ((rec / total) * 100).toStringAsFixed(0) + "%";
          });
        }
        );
    } catch (e){
      log(e.toString());
    }
    
    await Future.delayed(const Duration(seconds: 3));
    return downloadedImagePath;

  }

  Future <void> doDownloadFile({required String filename, required String link}) async {
    if( await getStoragePremission()){
     
      await downloadFile(filename: filename, link: link).then((imagePath) {
         displayImage(imagePath);
         Navigator.pop(context);
         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("File Downloaded sucess..")));
      });
    }
  }

  void displayImage(String  downloadDirectory){
    setState(() {
      downloading = false;
      prograssString = "COMPLETED";
      downloadedImagePath = downloadDirectory;
    });
  }
     
  @override
  Widget build(BuildContext context) {
    log(widget.fileLink.toString());
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => logic(),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(500),
                    ),
                    child: const Center(
                      child: Text(
                        "A",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => logic(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Allocation",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.data[widget.statusid - 1].toString(),
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 40,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/back.png")),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          ),
          if (show == true)
            SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 18, 18, 18),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Text(
                                    widget.comment,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            if (widget.fileLink != null)
                              GestureDetector(
                                onTap: () async {
                                 doDownloadFile(filename: widget.filename, link: widget.fileLink!);
                                },
                                child: Container(
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.blue.shade100,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.file_download,
                                          size: 50,
                                          color:
                                              Color.fromARGB(255, 89, 27, 27),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Download from here",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => Forward(
                                        orderid: widget.title,
                                        id: widget.id,
                                        trxid: widget.trx,
                                      )));
                        },
                        child: Container(
                          height: 50,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(500),
                            border: Border.all(color: Colors.white, width: 0.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 30,
                                width: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("assets/forward.png")),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                "Forward",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
        ],
      ),
    );
  }

  void logic() {
    setState(() {
      show = !show;
    });
  }

  void showBottom (){
    showBottomSheet(context: context, builder: (BuildContext context){
      return Container(
        height: 500,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const[
            Text(" Downloding ....", style: TextStyle(
              color: Colors.white,

            ),),
              SizedBox(height: 20,),
            CircularProgressIndicator(),
          ],
        ),
      );
    });
  }

  // Future<bool> getStoragePremission() async {
  //   log("hey");
  //   return await Permission.storage.request().isGranted;
  // }

  // Future<String> getDownloadFolderPath(
  //   String filename,
  // ) async {
  //   log("hey2");
  //   String path = await ExternalPath.getExternalStoragePublicDirectory(
  //       ExternalPath.DIRECTORY_DOWNLOADS);
  //   return "$path/$filename";
  // }

  // getAccesToken() async {
  //   final response = await http.post(
  //     Uri.parse('https://www.test.ahecounselling.com/api/getaccesstoken'),
  //     headers: <String, String>{
  //       'Authorization': 'Basic ',
  //       'Content-Type': 'application/json'
  //     },
  //     body: jsonEncode(<String, dynamic>{
  //       'refresh_token': DropBoxtoken.refreshToken,
  //       'appkey': 'ih12s882m849rfo',
  //       'secretkey': '7aw8pjk6du3hu2n',
  //     }),
  //   );
  //   if (response.statusCode == 200) {
  //     Map data = jsonDecode(response.body);
  //     setState(() {
  //       DropBoxtoken.token = data["data"]["access_token"].toString();
  //     });
  //     fileDownload(widget.fileLink!, widget.id);
  //   } else {
  //     log("somethin went wrong");
  //   }

  //   log(response.body);
  // }

  // void fileDownload(
  //   String path,
  //   String filename,
  // ) async {
  //   final response = await http.post(
  //     Uri.parse('https://content.dropboxapi.com/2/files/download'),
  //     headers: <String, String>{
  //       'Authorization': 'Bearer ${DropBoxtoken.token}',
  //       'Dropbox-API-Arg': '{"path":"$path"}'
  //     },
  //   );
  //   log(response.body.t);
  //   if (response.statusCode == 200) {
  //     log("hey3");
  //     log(response.body.toString());
  //     bool access = await getStoragePremission();
  //     if (access == true) {
  //       var data = jsonDecode(response.body);
  //       File file = File(await getDownloadFolderPath(filename)); // 1
  //       file.writeAsBytes(data); // 2
  //     } else {
  //       log("To upload file need permission");
  //     }
  //   } else if (response.statusCode == 401) {
  //     getAccesToken();
  //   } else {
  //     log("somethin went wrong");
  //   }

  //   log(response.body);
  // }
}
