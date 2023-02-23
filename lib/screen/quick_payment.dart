import 'dart:convert';

import 'package:ahbmss/appsComoponent/drawer.dart';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:ahbmss/modals/quick_payment_models.dart';
import 'package:ahbmss/screen/forms/payment_link.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class PaymentList extends StatefulWidget {
  const PaymentList({super.key});

  @override
  State<PaymentList> createState() => _PaymentListState();
}

class _PaymentListState extends State<PaymentList> {
  Future<Quickpaymentmodel>? futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetch();
  }

  final color = const Color.fromARGB(255, 54, 106, 248);
  bool lodar = false;
  int pageIndex = 1;
  int latpage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Quick Payment",
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 24),
        ),
        elevation: 0.0,
      ),
      drawer: const MyDrawer(pageName: "Payment"),
      body: lodar == true
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await fetch();
              },
              child: FutureBuilder<Quickpaymentmodel>(
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
                                  itemCount: snapshot
                                      .data!.getpaymentlinkList.data.length,
                                  itemBuilder: (context, index) {
                                    return QuickpaymentTabs(
                                      amount: snapshot.data!.getpaymentlinkList
                                          .data[index].amount,
                                      email: snapshot.data!.getpaymentlinkList
                                          .data[index].email,
                                      name: snapshot.data!.getpaymentlinkList
                                          .data[index].firstname,
                                      pageload: snapshot
                                          .data!
                                          .getpaymentlinkList
                                          .data[index]
                                          .clcikCount,
                                      status: snapshot.data!.getpaymentlinkList
                                          .data[index].paymentStatus,
                                      txnid: snapshot.data!.getpaymentlinkList
                                          .data[index].txnid,
                                      url: snapshot.data!.getpaymentlinkList
                                          .data[index].encodeurl,
                                    );
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 9, right: 9, top: 20, bottom: 20),
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
                                                            ? Color.fromARGB(255, 18, 18, 19)
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 65),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                CupertinoPageRoute(builder: (context) => const Paymentlink()));
          },
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 83,48,80),
                borderRadius: BorderRadius.circular(500),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 12,
                    spreadRadius: 1,
                    offset: const Offset(0, 0),
                  )
                ]),
            child: const Center(
                child: Icon(
              Icons.add,
              size: 38,
              color: Colors.white,
            )),
          ),
        ),
      ),
    );
  }

  Future<Quickpaymentmodel> fetch() async {
    final response = await http.get(Uri.parse(
        'https://www.universitieshub.org/api/get-payment-link/${LocalData.rmID}?page=$pageIndex'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      Map data2 = data["getpaymentlinkList"];
      setState(() {
        latpage = data2["last_page"];
      });
      logic();
      return Quickpaymentmodel.fromJson(jsonDecode(response.body));
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

class QuickpaymentTabs extends StatefulWidget {
  final String name;
  final String email;
  final String amount;
  final String txnid;
  final String status;
  final String pageload;
  final String url;

  const QuickpaymentTabs(
      {super.key,
      required this.amount,
      required this.email,
      required this.name,
      required this.pageload,
      required this.status,
      required this.txnid,
      required this.url});

  @override
  State<QuickpaymentTabs> createState() => _QuickpaymentTabsState();
}

class _QuickpaymentTabsState extends State<QuickpaymentTabs> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6, left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            " Full Name :",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.name,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            " Email :",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: SizedBox(
                            // height: 20,
                            width: 180,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.email,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            " Amount :",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.amount,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            " Txn-ID : ",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.txnid,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: InkWell(
                            onTap: () {
                              Clipboard.setData(
                                      ClipboardData(text: widget.txnid))
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        content:
                                            Text("Copyed ${widget.txnid}")));
                              });
                            },
                            child: const Icon(
                              Icons.copy_all,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          if (widget.status == "pending") {
                            Clipboard.setData(ClipboardData(text: widget.url))
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      content: Text("Copyed ${widget.url}")));
                            });
                          }
                        },
                        child: Container(
                          height: 20,
                          width: 60,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 83, 48, 80),
                              borderRadius: BorderRadius.circular(5)),
                          child: const Center(
                            child: Text(
                              "Copy",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Text(
                            "Status:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            widget.status,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            "Page-Load:",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            widget.pageload,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
