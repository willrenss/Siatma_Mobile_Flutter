import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siatma_mobile/components/ProgressHUD.dart';
import 'package:siatma_mobile/components/background.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/model/auth_model.dart';
import 'package:siatma_mobile/view/dashboardScreen.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:siatma_mobile/api/api_service.dart';
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
  var group = AutoSizeGroup();
  bool isApiCallProcess = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  void initState() {
    super.initState();
    requestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _upInit(context), inAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _upInit(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              BackgroundImage(),
              Scrollbar(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 40),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      height: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? MediaQuery.of(context).size.height - 100
                          : MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: !isKeyboard ? 4 : 2,
                              child: Stack(
                                children: [
                                  new Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          topLeft: Radius.circular(15)),
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 18.0, right: 18.0, left: 18.0),
                                    child: ListView(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Image.asset(
                                              "assets/images/atma-logo.png",
                                              fit: BoxFit.fill),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        AutoSizeText(
                                          "SIATMA UAJY",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.getFont('Lato',
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          group: group,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        AutoSizeText(
                                          "Aplikasi ini adalah suatu aplikasi otentitakasi dokumen. Dokumen yang bersifat internal atau yang diasosiasikan internal UAJY akan diotentifikasi oleh aplikasi ini sehingga dijamin keotentikannya.",
                                          style: GoogleFonts.timmana(),
                                          textAlign: TextAlign.justify,
                                          maxLines: 4,
                                          group: group,
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: Colors.black38,
                                        ),
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
                                                    AutoSizeText(
                                                      " Download Manual Siatma UAJY ",
                                                      style:
                                                          GoogleFonts.openSans(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                      maxLines: 1,
                                                      group: group,
                                                    ),
                                                    InkWell(
                                                        child: new AutoSizeText(
                                                            'disini',
                                                            group: group,
                                                            style: GoogleFonts.openSans(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .lightBlue)),
                                                        onTap: () => launch(
                                                            'https://docs.flutter.io/flutter/services/UrlLauncher-class.html')),
                                                  ],
                                                ),
                                                SizedBox(
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
                                                        AutoSizeText(
                                                          " KSI Helpdesk",
                                                          style: GoogleFonts
                                                              .openSans(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          group: group,
                                                        ),
                                                        InkWell(
                                                            child: new AutoSizeText(
                                                                ' disini',
                                                                group: group,
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
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 10,
                                    child: Container(
                                      width: 30,
                                      height: 30,
                                      child: Image.asset(
                                          "assets/images/decoration-yellow.png",
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: !isKeyboard ? 3 : 4,
                              child: Stack(
                                children: [
                                  new Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFFeca81e),
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15)),
                                    ),
                                    padding: EdgeInsets.only(
                                        top: 15.0, right: 18.0, left: 18.0),
                                    child: Form(
                                      key: globalFormKey,
                                      child: ListView(
                                        children: [
                                          AutoSizeText(
                                            "LOGIN",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.getFont(
                                                'Raleway',
                                                textStyle: TextStyle(
                                                    fontSize: 25,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            child: TextFormField(
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
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFFeca81e),
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    32.0)),
                                                border: new OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0)),
                                                hintText:
                                                    'Nomor Induk Mahasiswa',
                                                labelStyle: TextStyle(
                                                    color: Color(0xFFa67717)),
                                                prefixIcon: Icon(
                                                  Icons.account_box,
                                                  color: Color(0xFF00578f),
                                                ),
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
                                                      BorderRadius.circular(
                                                          32.0)),
                                              hintText: 'Password',
                                              labelStyle: TextStyle(
                                                  color: Color(0xFFeca81e)),
                                              prefixIcon: Icon(Icons.vpn_key,
                                                  color: Color(0xFF00578f)),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 40),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  minimumSize:
                                                      const Size(100, 40),
                                                  maximumSize:
                                                      const Size(200, 50),
                                                  shape:
                                                      new RoundedRectangleBorder(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                  ),
                                                  primary: Color(0xFF00578f),
                                                  textStyle: const TextStyle(
                                                      fontSize: 15)),
                                              onPressed: () {
                                                if (validateAndSave()) {
                                                  print(requestModel.toJson());
                                                  if (passController
                                                          .text.isEmpty ||
                                                      usernameController
                                                          .text.isEmpty ||
                                                      usernameController
                                                              .text.length <
                                                          8) {
                                                    if (passController
                                                        .text.isEmpty) {
                                                      final snackBar = SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.red[800],
                                                        duration: Duration(
                                                            milliseconds: 800),
                                                        content: Text(
                                                            "Password Field Can't Be Empty"),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    } else if (usernameController
                                                        .text.isEmpty) {
                                                      final snackBar = SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.red[800],
                                                        duration: Duration(
                                                            milliseconds: 800),
                                                        content: Text(
                                                            "Username Field Can't Be Empty"),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
                                                    } else if (usernameController
                                                            .text.length <
                                                        8) {
                                                      final snackBar = SnackBar(
                                                        behavior:
                                                            SnackBarBehavior
                                                                .floating,
                                                        backgroundColor:
                                                            Colors.red[800],
                                                        duration: Duration(
                                                            milliseconds: 800),
                                                        content: Text(
                                                            "Username must be 8 digits"),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              snackBar);
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
                                                          isApiCallProcess =
                                                              false;
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

                                                          final snackBar =
                                                              SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            backgroundColor:
                                                                Colors
                                                                    .green[800],
                                                            duration: Duration(
                                                                milliseconds:
                                                                    800),
                                                            content: Text(
                                                                "Login Berhasil"),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    DashboardScreen(
                                                                        false)),
                                                          );
                                                        } else {
                                                          final snackBar =
                                                              SnackBar(
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating,
                                                            backgroundColor:
                                                                Colors.red[800],
                                                            content: Text(
                                                                "${value.pesan}"),
                                                          );
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        }
                                                      }
                                                    });
                                                  }
                                                }
                                              },
                                              child: const AutoSizeText(
                                                'Login',
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    10,
                                                child: AutoSizeText(
                                                    "UNGGUL-INKLUSIF-HUMANIS-BERINTEGRITAS",
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    maxFontSize: 12,
                                                    style: TextStyle(
                                                      color: blueatmacolor,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 10,
                                    child: Container(
                                      width: 38,
                                      height: 38,
                                      child: Image.asset(
                                          "assets/images/decoration-blue-tip-2.png",
                                          fit: BoxFit.contain),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
}

class SizeConfig {
  double heightSize(BuildContext context, double value) {
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(BuildContext context, double value) {
    value /= 100;
    return MediaQuery.of(context).size.width * value;
  }
}
