import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersStatusTabs extends StatefulWidget {
  List statusList = [];
  DateTime date;
  int statusId;
  String comment;
  String userType;
  OrdersStatusTabs({
    super.key,
    required this.statusList,
    required this.date,
    required this.comment,
    required this.statusId,
    required this.userType,
  });

  @override
  State<OrdersStatusTabs> createState() => _OrdersStatusTabsState();
}

class _OrdersStatusTabsState extends State<OrdersStatusTabs> {
  bool tabheightchanger = false;
  bool logic = false;
  void myLogic() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        logic = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${widget.date.day}-${widget.date.month}-${widget.date.year}",
              style: GoogleFonts.montserrat(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 18.0, left: 18.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: tabheightchanger == false ? 140 : 170,
                  width: 3,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(13, 0, 0, 0),
                  ),
                ),
                Container(
                  height: 7,
                  width: 4,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
            child: AnimatedContainer(
              height: tabheightchanger == false ? 110 : 140,
              width: 235,
              duration: const Duration(milliseconds: 200),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(13, 0, 0, 0),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.statusList[widget.statusId - 1],
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                        bottom: 15.0,
                      ),
                      child: Container(
                        height: 2,
                        width: 260,
                        color: Colors.black12,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Text(
                            widget.comment,
                            style: GoogleFonts.montserrat(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                tabheightchanger =
                                    tabheightchanger == false ? true : false;
                              });
                              if (tabheightchanger == true) {
                                myLogic();
                              } else {
                                logic = false;
                              }
                            },
                            child: Icon(
                              tabheightchanger == false
                                  ? Icons.more_vert_outlined
                                  : Icons.close,
                              color: Colors.black54,
                            ),
                          ),
                        )
                      ],
                    ),
                    if (logic == true)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(widget.userType,
                            style: GoogleFonts.montserrat(
                              color: Colors.black54,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            )),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
