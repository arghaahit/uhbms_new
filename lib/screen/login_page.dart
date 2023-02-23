import 'dart:convert';
import 'dart:developer';
import 'package:ahbmss/core/fingerprint_login.dart';
import 'package:ahbmss/localData/login_local_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:ahbmss/screen/dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final color = const Color.fromARGB(255, 9, 14, 52);
  String? loginerror;
  bool changer = false;
  bool changer2 = false;
  bool changer3 = false;
  bool changer4 = false;
  bool passwordSecure = true;
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginLogic();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: changer4 == true
                ? Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                changer = false;
                              });
                              changer2 = false;
                              Future.delayed(const Duration(milliseconds: 500),
                                  () {
                                setState(() {
                                  changer3 = false;
                                  changer4 = false;
                                });
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              height: changer == false ? 0 : 200,
                              width: changer == false ? 0 : 200,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 172, 0, 0),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(600))),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (changer2 == true)
                                        SizedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 50.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.white,
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "Back",
                                                  style: GoogleFonts.montserrat(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 1,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      if (changer2 == true)
                                        Text(
                                          "Log In",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 1,
                                            fontSize: 28,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Expanded(child: SizedBox())
                      ],
                    ))
                : Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 90,
                        ),
                        Text(
                          "UHBMS",
                          style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 172, 0, 0),
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1,
                            fontSize: 45,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          "Know yourself better",
                          style: GoogleFonts.montserrat(
                            color: const Color.fromARGB(255, 21, 125, 210),
                            fontStyle: FontStyle.normal,
                            letterSpacing: 1,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          Expanded(
              flex: changer3 == false ? 1 : 2,
              child: Container(
                color: Colors.white,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: changer == false ? 400 : 700,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(12, 26, 26, 26),
                          borderRadius: BorderRadiusDirectional.vertical(
                              top: Radius.elliptical(300, 150))),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      height: changer == false ? 300 : 510,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(12, 26, 26, 26),
                          borderRadius: BorderRadiusDirectional.vertical(
                              top: Radius.elliptical(350, 180))),
                    ),
                    AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: changer == false ? 200 : 450,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.elliptical(190, 110))),
                        child: changer == false
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      setState(() {
                                        changer4 = true;
                                      });
                                      await Future.delayed(
                                          const Duration(milliseconds: 5), () {
                                        changer =
                                            changer == false ? true : false;
                                        changer3 = true;
                                        Future.delayed(
                                            const Duration(milliseconds: 500),
                                            () {
                                          setState(() {
                                            changer2 = true;
                                          });
                                        });
                                      });
                                    },
                                    child: Center(
                                      child: Container(
                                        height: 50,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Log In",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 100, 54, 206)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (LocalData.rmID != 0)
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          loginLogic();
                                        },
                                        child: const Icon(
                                          Icons.fingerprint_rounded,
                                          color: Colors.white,
                                          size: 55,
                                        ),
                                      ),
                                    )
                                ],
                              )
                            : SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 80.0,
                                      bottom: 8.0,
                                      left: 30.0,
                                      right: 30.0),
                                  child: Form(
                                    key: _formkey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Email",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 1,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: emailcontroller,
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              hintText: "Type here...",
                                              hintStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      97, 0, 0, 0)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      style:
                                                          BorderStyle.none))),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value == null) {
                                              return "Email Required";
                                            }
                                            return null;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Password",
                                          style: GoogleFonts.montserrat(
                                            color: Colors.white,
                                            fontStyle: FontStyle.normal,
                                            letterSpacing: 1,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: passwordcontroller,
                                          obscureText: passwordSecure,
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)),
                                          decoration: InputDecoration(
                                              suffixIcon: GestureDetector(
                                                  onTap: (() => setState(() {
                                                        passwordSecure =
                                                            passwordSecure ==
                                                                    false
                                                                ? true
                                                                : false;
                                                      })),
                                                  child: Icon(
                                                    passwordSecure == true
                                                        ? Icons
                                                            .visibility_off_outlined
                                                        : Icons
                                                            .visibility_outlined,
                                                    color: Colors.grey.shade700,
                                                  )),
                                              filled: true,
                                              fillColor: const Color.fromARGB(
                                                  255, 255, 255, 255),
                                              hintText: "Type here...",
                                              hintStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      97, 0, 0, 0)),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: const BorderSide(
                                                      color: Colors.transparent,
                                                      style:
                                                          BorderStyle.none))),
                                          validator: (value) {
                                            if (value!.isEmpty ||
                                                value == null) {
                                              return "Password Required";
                                            }
                                            return null;
                                          },
                                        ),
                                        if (loginerror != null)
                                          Center(
                                            child: Text(
                                              loginerror!,
                                              style: const TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 30),
                                          child: GestureDetector(
                                            onTap: () async {
                                              var token = "klmkhnygujihg7uuyuy";
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                checkLogin(
                                                    emailcontroller.text,
                                                    passwordcontroller.text,
                                                    token);
                                              }
                                            },
                                            child: Center(
                                              child: Container(
                                                height: 50,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: const Color.fromARGB(
                                                      255, 247, 247, 247),
                                                  borderRadius:
                                                      BorderRadius.circular(35),
                                                ),
                                                child: const Center(
                                                  child: Text(
                                                    "Log In",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20,
                                                        color: Color.fromARGB(
                                                            255, 100, 54, 206)),
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
                              )),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  void loginLogic() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      LocalData.rmID = sharedPreferences.getInt("rmID")!;
      LocalData.empid = sharedPreferences.getString("empid")!;
      LocalData.symbol = sharedPreferences.getString("symbol")!;
      LocalData.email = sharedPreferences.getString("email")!;
      LocalData.rmCode = sharedPreferences.getString("rmCode")!;
      LocalData.teamid = sharedPreferences.getString("teamid")!;
      LocalData.userName = sharedPreferences.getString("userName")!;
      LocalData.typeName = sharedPreferences.getString("typeName")!;
    });
    if (LocalData.rmID != 0) {
      final isAuthenticated = await LocalAuthApi.authenticate();
      if (isAuthenticated == true) {
        log("Login");
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (context) => Dashboard()),
            (route) => false);
      } else {
        log("not Login");
      }
    }
  }

  void checkLogin(String email, String password, token) async {
    final response = await http.post(
        Uri.parse('https://www.universitieshub.org/api/checklogin'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'type': '2',
          'email': email,
          'password': password,
          'token': 'bhdbsdhybdhiedhfbadhc',
        }));
    log(response.body.toString());
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      Map data = jsonDecode(response.body);
      log(data.toString());

      if (data["status"] != 302) {
        Map data2 = data["data"];
        log(data2.toString());
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            CupertinoPageRoute(builder: (contrext) => const Dashboard()),
            (route) => false);
        final String name = data2["team_name"].toString();
        final String typeName = data2["type_name"].toString();
        final String symbol = data2["symbol"];
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        setState(() {
          sharedPreferences.setInt("rmID", data2["rm_id"]);
          sharedPreferences.setString("empid", data2["empid"].toString());
          sharedPreferences.setString("symbol", symbol);
          sharedPreferences.setString("email", data2["team_email"].toString());
          sharedPreferences.setString("rmCode", data2["rm_code"].toString());
          sharedPreferences.setString("teamid", data2["empid"].toString());
          sharedPreferences.setString("userName", name);
          sharedPreferences.setString("typeName", typeName);
          LocalData.rmID = data2["rm_id"];
          LocalData.empid = data2["empid"].toString();
          LocalData.symbol = symbol;
          LocalData.userName = name;
          LocalData.typeName = typeName;
          LocalData.rmCode = data2["rm_code"].toString();
          LocalData.email = data2["team_email"].toString();
        });
      } else if (data["status"] == 302) {
        setState(() {
          loginerror = data["message"];
        });
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
