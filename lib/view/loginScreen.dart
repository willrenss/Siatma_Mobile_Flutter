import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:siatma_mobile/components/ProgressHUD.dart';
import 'package:siatma_mobile/components/background.dart';
import 'package:siatma_mobile/model/auth_model.dart';
import 'package:siatma_mobile/view/dashboardScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:siatma_mobile/api/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isHidePassword = true;
  var usernameController = TextEditingController();
  var passController = TextEditingController();
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel requestModel;
  bool isApiCallProcess = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void initState() {
    // init();
    super.initState();
    requestModel = new LoginRequestModel();
  }

  // init() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   prefs.setString('token', "");
  // }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _upInit(context), inAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _upInit(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundImage(),
              Center(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 40),
                  child: Column(
                    children: [
                      Expanded(
                        flex: !isKeyboard ? 4 : 2,
                        child: new Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                topLeft: Radius.circular(15)),
                          ),
                          width: 350,
                          padding: EdgeInsets.only(
                              top: 18.0, right: 18.0, left: 18.0),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/atma-logo.png",
                                width: !isKeyboard ? 300 : 250,
                              ),
                              if (!isKeyboard)
                                const SizedBox(
                                  height: 30,
                                ),
                              if (!isKeyboard)
                                Text(
                                  "SIATMA UAJY",
                                  style: GoogleFonts.getFont('Lato',
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                              if (!isKeyboard)
                                const SizedBox(
                                  height: 20,
                                ),
                              if (!isKeyboard)
                                Text(
                                  "Aplikasi ini adalah suatu aplikasi otentitakasi dokumen. Dokumen yang bersifat internal atau yang diasosiasikan internal UAJY akan diotentifikasi oleh aplikasi ini sehingga dijamin keotentikannya.",
                                  style: GoogleFonts.timmana(),
                                  textAlign: TextAlign.justify,
                                ),
                              if (!isKeyboard) Spacer(),
                              if (!isKeyboard)
                                Divider(
                                  thickness: 1,
                                  color: Colors.black38,
                                ),
                              if (!isKeyboard)
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.downloading,
                                              color: Colors.black,
                                              size: 14.0,
                                            ),
                                            Text(
                                                " Download Manual Siatma UAJY ",
                                                style: GoogleFonts.openSans(
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            InkWell(
                                                child: new Text('disini',
                                                    style: GoogleFonts.openSans(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Colors.lightBlue)),
                                                onTap: () => launch(
                                                    'https://docs.flutter.io/flutter/services/UrlLauncher-class.html')),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.phone,
                                                  color: Colors.black,
                                                  size: 14.0,
                                                ),
                                                Text(" KSI Helpdesk",
                                                    style: GoogleFonts.openSans(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    )),
                                                InkWell(
                                                    child: new Text(' disini',
                                                        style: GoogleFonts
                                                            .openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .lightBlue)),
                                                    onTap: () => launch(
                                                        'https://ksi.uajy.ac.id/helpdesk/')),
                                              ],
                                            )),
                                      ],
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      "assets/images/decoration-yellow.png",
                                      width: 38,
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: !isKeyboard ? 3 : 5,
                        child: new Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFeca81e),
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(15),
                                bottomLeft: Radius.circular(15)),
                          ),
                          width: 350,
                          padding: EdgeInsets.only(
                              top: 15.0, right: 18.0, left: 18.0),
                          child: Form(
                            key: globalFormKey,
                            child: Column(
                              children: [
                                Text(
                                  "LOGIN",
                                  style: GoogleFonts.getFont('Lato',
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25,
                                          color: Colors.white)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: usernameController,
                                  onSaved: (input) =>
                                      requestModel.username = input,
                                  autofocus: false,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFFeca81e),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    hintText: 'Nomor Induk Mahasiswa',
                                    labelStyle:
                                        TextStyle(color: Color(0xFFa67717)),
                                    prefixIcon: Icon(
                                      Icons.account_box,
                                      color: Color(0xFF00578f),
                                    ),
                                  ),
                                ),
                                if (!isKeyboard)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (isKeyboard)
                                  const SizedBox(
                                    height: 5,
                                  ),
                                TextFormField(
                                  controller: passController,
                                  onSaved: (input) =>
                                      requestModel.password = input,
                                  autofocus: false,
                                  obscureText: _isHidePassword ? true : false,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        _togglePasswordVisibility();
                                      },
                                      child: Icon(
                                        _isHidePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: _isHidePassword
                                            ? Colors.grey
                                            : Color(0xFF00578f),
                                      ),
                                    ),
                                    contentPadding: new EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10.0),
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(32.0)),
                                    hintText: 'Password',
                                    labelStyle:
                                        TextStyle(color: Color(0xFFeca81e)),
                                    prefixIcon: Icon(Icons.vpn_key,
                                        color: Color(0xFF00578f)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(30.0),
                                      ),
                                      primary: Color(0xFF00578f),
                                      padding:
                                          EdgeInsets.only(right: 30, left: 30),
                                      textStyle: const TextStyle(fontSize: 20)),
                                  onPressed: () {
                                    if (validateAndSave()) {
                                      print(requestModel.toJson());
                                      if (passController.text.isEmpty ||
                                          usernameController.text.isEmpty ||
                                          usernameController.text.length < 8) {
                                        if (passController.text.isEmpty) {
                                          final snackBar = SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red[800],
                                            duration:
                                                Duration(milliseconds: 800),
                                            content: Text(
                                                "Password Field Can't Be Empty"),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else if (usernameController
                                            .text.isEmpty) {
                                          final snackBar = SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red[800],
                                            duration:
                                                Duration(milliseconds: 800),
                                            content: Text(
                                                "Username Field Can't Be Empty"),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        } else if (usernameController
                                                .text.length <
                                            8) {
                                          final snackBar = SnackBar(
                                            behavior: SnackBarBehavior.floating,
                                            backgroundColor: Colors.red[800],
                                            duration:
                                                Duration(milliseconds: 800),
                                            content: Text(
                                                "Username must be 8 digits"),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      } else {
                                        setState(() {
                                          isApiCallProcess = true;
                                        });
                                        APIService apiService =
                                            new APIService();

                                        apiService
                                            .login(requestModel)
                                            .then((value) {
                                          if (value != null) {
                                            setState(() {
                                              isApiCallProcess = false;
                                            });
                                            if (value.token != "") {
                                              setState(() {
                                                savePref(
                                                    value.token,
                                                    value.prodi,
                                                    value.thnmasuk.toString());
                                                print(value.token);
                                                print(value.npm);
                                              });

                                              final snackBar = SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.green[800],
                                                duration:
                                                    Duration(milliseconds: 800),
                                                content: Text("Login Berhasil"),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DashboardScreen(false)),
                                              );
                                            } else {
                                              final snackBar = SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor:
                                                    Colors.red[800],
                                                content: Text("${value.pesan}"),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          }
                                        });
                                      }
                                    }
                                  },
                                  child: const Text('Login'),
                                ),
                                Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(bottom: 20),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "UNGGUL-INKLUSIF-HUMANIS-BERINTEGRITAS",
                                                    style: GoogleFonts.openSans(
                                                      color: Color(0xFF00578f),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                              ],
                                            )),
                                      ],
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      "assets/images/decoration-blue-tip-2.png",
                                      width: 38,
                                    ),
                                  ],
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
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                BackgroundImage(),
                SingleChildScrollView(
                  child: Center(
                    child: Container(
                      height: 700,
                      margin: EdgeInsets.symmetric(vertical: 40),
                      child: Center(
                        child: Column(
                          children: [
                            Expanded(
                              flex: !isKeyboard ? 4 : 2,
                              child: new Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      topLeft: Radius.circular(15)),
                                ),
                                width: 350,
                                padding: EdgeInsets.only(
                                    top: 18.0, right: 18.0, left: 18.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      "assets/images/atma-logo.png",
                                      width: !isKeyboard ? 300 : 250,
                                    ),
                                    if (!isKeyboard)
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    if (!isKeyboard)
                                      Text(
                                        "SIATMA UAJY",
                                        style: GoogleFonts.getFont('Lato',
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ),
                                    if (!isKeyboard)
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    if (!isKeyboard)
                                      Text(
                                        "Aplikasi ini adalah suatu aplikasi otentitakasi dokumen. Dokumen yang bersifat internal atau yang diasosiasikan internal UAJY akan diotentifikasi oleh aplikasi ini sehingga dijamin keotentikannya.",
                                        style: GoogleFonts.timmana(),
                                        textAlign: TextAlign.justify,
                                      ),
                                    if (!isKeyboard) Spacer(),
                                    if (!isKeyboard)
                                      Divider(
                                        thickness: 1,
                                        color: Colors.black38,
                                      ),
                                    if (!isKeyboard)
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.downloading,
                                                    color: Colors.black,
                                                    size: 14.0,
                                                  ),
                                                  Text(
                                                      " Download Manual Siatma UAJY ",
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  InkWell(
                                                      child: new Text('disini',
                                                          style: GoogleFonts
                                                              .openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .lightBlue)),
                                                      onTap: () => launch(
                                                          'https://docs.flutter.io/flutter/services/UrlLauncher-class.html')),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        color: Colors.black,
                                                        size: 14.0,
                                                      ),
                                                      Text(" KSI Helpdesk",
                                                          style: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          )),
                                                      InkWell(
                                                          child: new Text(
                                                              ' disini',
                                                              style: GoogleFonts.openSans(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .lightBlue)),
                                                          onTap: () => launch(
                                                              'https://ksi.uajy.ac.id/helpdesk/')),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          Spacer(),
                                          Image.asset(
                                            "assets/images/decoration-yellow.png",
                                            width: 38,
                                          ),
                                        ],
                                      )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: !isKeyboard ? 3 : 5,
                              child: new Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFeca81e),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(15),
                                      bottomLeft: Radius.circular(15)),
                                ),
                                width: 350,
                                padding: EdgeInsets.only(
                                    top: 15.0, right: 18.0, left: 18.0),
                                child: Form(
                                  key: globalFormKey,
                                  child: Column(
                                    children: [
                                      Text(
                                        "LOGIN",
                                        style: GoogleFonts.getFont('Lato',
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25,
                                                color: Colors.white)),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: usernameController,
                                        onSaved: (input) =>
                                            requestModel.username = input,
                                        autofocus: false,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              new EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10.0),
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Color(0xFFeca81e),
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                          border: new OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                          hintText: 'Nomor Induk Mahasiswa',
                                          labelStyle: TextStyle(
                                              color: Color(0xFFa67717)),
                                          prefixIcon: Icon(
                                            Icons.account_box,
                                            color: Color(0xFF00578f),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: passController,
                                        onSaved: (input) =>
                                            requestModel.password = input,
                                        autofocus: false,
                                        obscureText:
                                            _isHidePassword ? true : false,
                                        cursorColor: Colors.black,
                                        decoration: InputDecoration(
                                          suffixIcon: GestureDetector(
                                            onTap: () {
                                              _togglePasswordVisibility();
                                            },
                                            child: Icon(
                                              _isHidePassword
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: _isHidePassword
                                                  ? Colors.grey
                                                  : Color(0xFF00578f),
                                            ),
                                          ),
                                          contentPadding:
                                              new EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10.0),
                                          isDense: true,
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: new OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(32.0)),
                                          hintText: 'Password',
                                          labelStyle: TextStyle(
                                              color: Color(0xFFeca81e)),
                                          prefixIcon: Icon(Icons.vpn_key,
                                              color: Color(0xFF00578f)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                            primary: Color(0xFF00578f),
                                            padding: EdgeInsets.only(
                                                right: 30, left: 30),
                                            textStyle:
                                                const TextStyle(fontSize: 20)),
                                        onPressed: () {
                                          if (validateAndSave()) {
                                            print(requestModel.toJson());
                                            if (passController.text.isEmpty ||
                                                usernameController
                                                    .text.isEmpty ||
                                                usernameController.text.length <
                                                    8) {
                                              if (passController.text.isEmpty) {
                                                final snackBar = SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.red[800],
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                  content: Text(
                                                      "Password Field Can't Be Empty"),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              } else if (usernameController
                                                  .text.isEmpty) {
                                                final snackBar = SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.red[800],
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                  content: Text(
                                                      "Username Field Can't Be Empty"),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              } else if (usernameController
                                                      .text.length <
                                                  8) {
                                                final snackBar = SnackBar(
                                                  behavior:
                                                      SnackBarBehavior.floating,
                                                  backgroundColor:
                                                      Colors.red[800],
                                                  duration: Duration(
                                                      milliseconds: 800),
                                                  content: Text(
                                                      "Username must be 8 digits"),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            } else {
                                              setState(() {
                                                isApiCallProcess = true;
                                              });
                                              APIService apiService =
                                                  new APIService();

                                              apiService
                                                  .login(requestModel)
                                                  .then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    isApiCallProcess = false;
                                                  });
                                                  if (value.token != "") {
                                                    setState(() {
                                                      savePref(
                                                          value.token,
                                                          value.prodi,
                                                          value.thnmasuk
                                                              .toString());
                                                      print(value.token);
                                                      print(value.npm);
                                                    });

                                                    final snackBar = SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.green[800],
                                                      duration: Duration(
                                                          milliseconds: 800),
                                                      content: Text(
                                                          "Login Berhasil"),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DashboardScreen(
                                                                  false)),
                                                    );
                                                  } else {
                                                    final snackBar = SnackBar(
                                                      behavior: SnackBarBehavior
                                                          .floating,
                                                      backgroundColor:
                                                          Colors.red[800],
                                                      content: Text(
                                                          "${value.pesan}"),
                                                    );
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(snackBar);
                                                  }
                                                }
                                              });
                                            }
                                          }
                                        },
                                        child: const Text('Login'),
                                      ),
                                      Spacer(),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 20),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          "UNGGUL-INKLUSIF-HUMANIS-BERINTEGRITAS",
                                                          style: GoogleFonts
                                                              .openSans(
                                                            color: Color(
                                                                0xFF00578f),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          )),
                                                    ],
                                                  )),
                                            ],
                                          ),
                                          Spacer(),
                                          Image.asset(
                                            "assets/images/decoration-blue-tip-2.png",
                                            width: 38,
                                          ),
                                        ],
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
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  savePref(String value, String idProdi, String masuk) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', value);
    prefs.setString('prodi', idProdi);
    prefs.setString('masuk', masuk);
  }

  Future<void> loadPref() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';
    print(counter);
  }

  Future<void> login() async {
    if (passController.text.isNotEmpty && usernameController.text.isNotEmpty) {
      var body = {"username": "180709677", "password": "1234567"};
      var response = await http.post(
        Uri.parse("https://siatma-api.uajy.ac.id/api/auth/loginsiatma"),
        body: json.encode(body),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login")));
      } else {
        print(response.statusCode);
        print(response.body);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error")));
      }
    }
  }

  Future<void> mahasiswa() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';

    var response = await http.get(
      Uri.parse(
          "https://siatma-api.uajy.ac.id/api/info/presensi?tahun=Gasal TA 2018/2019"),
      headers: {
        'Authorization': 'Bearer $counter',
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      print(response.statusCode);
      final data = json.decode(response.body) as Map<String, dynamic>;
      print((data['data']));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login")));
    } else {
      print(response.statusCode);
      print(response.body);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }
  }
}
