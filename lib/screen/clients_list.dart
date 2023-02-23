import 'dart:convert';

import 'package:ahbmss/appsComoponent/drawer.dart';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:ahbmss/modals/clients_Modal.dart';
import 'package:ahbmss/widegt/clients_tabs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Clients extends StatefulWidget {
  const Clients({super.key});

  @override
  State<Clients> createState() => _ClientsState();
}

class _ClientsState extends State<Clients> {
  final color = Color.fromARGB(255, 54, 106, 248);
  bool lodar = false;
  int pageIndex = 1;
  int latpage = 0;
  Future<ClientsListMadal>? futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(pageName: "Clients"),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(
          color: color,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15),
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back_ios_outlined)),
          ),
        ],
        title: Text(
          "Clients",
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 24),
        ),
        elevation: 0.0,
      ),
      body: lodar == true
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await fetch();
              },
              child: FutureBuilder<ClientsListMadal>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0,
                                          bottom: 12,
                                          left: 15,
                                          right: 15),
                                      child: ClientsTabs(
                                        email: snapshot.data!.usersList
                                            .data[index].userEmail,
                                        id: snapshot
                                            .data!.usersList.data[index].userId,
                                        mobile: snapshot
                                            .data!.usersList.data[index].mobile,
                                        university: snapshot.data!.usersList
                                            .data[index].univercityName,
                                        userName: snapshot.data!.usersList
                                            .data[index].userName,
                                        iscode: snapshot.data!.usersList
                                            .data[index].phoneCode,
                                        isApproved: snapshot.data!.usersList
                                            .data[index].isApproved,
                                        isMultipal: snapshot.data!.usersList
                                            .data[index].isMultipal,
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, top: 20, bottom: 20),
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.shade500,
                                            spreadRadius: 1,
                                            blurRadius: 15,
                                            offset: const Offset(0, 4))
                                      ]),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (pageIndex != 1) {
                                              setState(() {
                                                pageIndex--;
                                                lodar = true;
                                                futureAlbum = fetch();
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: pageIndex != 1
                                                ? color
                                                : Colors.white,
                                          ),
                                        ),
                                        Container(
                                          height: 50,
                                          width: 235,
                                          color: color,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: latpage,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0,
                                                          bottom: 8.0,
                                                          left: 5,
                                                          right: 5),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        pageIndex = index + 1;
                                                        lodar = true;
                                                        futureAlbum = fetch();
                                                      });
                                                    },
                                                    child: Container(
                                                      height: 50,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                        color: pageIndex - 1 ==
                                                                index
                                                            ? Color.fromARGB(
                                                                255, 24, 23, 23)
                                                            : Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          "${index + 1}",
                                                          style: TextStyle(
                                                            color: pageIndex -
                                                                        1 ==
                                                                    index
                                                                ? Colors.white
                                                                : color,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (latpage != pageIndex) {
                                              setState(() {
                                                pageIndex++;
                                                lodar = true;
                                                futureAlbum = fetch();
                                              });
                                            }
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: latpage != pageIndex
                                                ? color
                                                : Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
              ),
            ),
    );
  }

  Future<ClientsListMadal> fetch() async {
    final response = await http.get(Uri.parse(
        'https://www.universitieshub.org/api/getClientList/${LocalData.rmID}?page=$pageIndex'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      Map data2 = data["usersList"];
      setState(() {
        latpage = data2["last_page"];
      });
      logic();
      return ClientsListMadal.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load ');
    }
  }

  logic() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        lodar = false;
      });
    });
  }
}
