import 'dart:convert';
import 'dart:developer';

import 'package:ahbmss/appsComoponent/drawer.dart';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:ahbmss/modals/orders_modals.dart';
import 'package:ahbmss/widegt/ordersTabs.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  Future<OrderModals>? futureAlbum;
  void initState() {
    super.initState();
    futureAlbum = fetch();
  }

  bool lodar = false;
  int pageIndex = 1;
  int latpage = 0;
  final color = const Color.fromARGB(255, 32, 41, 86);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(pageName: "Orders"),
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
            "Orders",
            style: GoogleFonts.montserrat(color: Colors.black, fontSize: 24),
          ),
          elevation: 0.0,
        ),
        body: lodar == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: () async {
                   await fetch();
                },
                child: FutureBuilder<OrderModals>(
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount:
                                        snapshot.data!.usersList.data.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12.0,
                                            bottom: 12,
                                            left: 15,
                                            right: 15),
                                        child: OrdersTabs(
                                            services: snapshot.data!.usersList
                                                .data[index].servicesName,
                                            clientName: snapshot.data!.usersList
                                                .data[index].clientName,
                                            enid: snapshot.data!.usersList
                                                .data[index].enId,
                                            orderDate: snapshot.data!.usersList
                                                .data[index].orderDate,
                                            orderNumber: snapshot
                                                .data!
                                                .usersList
                                                .data[index]
                                                .orderNumber,
                                            screenshot: snapshot.data!.usersList
                                                .data[index].screenshot,
                                            tranxid: snapshot.data!.usersList
                                                .data[index].tranxid,
                                            writerId: snapshot.data!.usersList
                                                .data[index].writerId),
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
                                                scrollDirection:
                                                    Axis.horizontal,
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
                                                        decoration:
                                                            BoxDecoration(
                                                          color: pageIndex -
                                                                      1 ==
                                                                  index
                                                              ? Colors.blue
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

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ));
  }

  Future<OrderModals> fetch() async {
    final response = await http.get(Uri.parse(
        'https://www.universitieshub.org/api/getOrderList/${LocalData.rmID}?page=$pageIndex'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      log(response.body.toString());
      Map data = jsonDecode(response.body);
      Map data2 = data["usersList"];
      setState(() {
        latpage = data2["last_page"];
      });
      logic();
      return OrderModals.fromJson(jsonDecode(response.body));
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
