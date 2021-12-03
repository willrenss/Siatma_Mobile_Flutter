import 'package:flutter/material.dart';
import 'package:siatma_mobile/api/api_service.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/model/auth_model.dart';

class CustomDialog extends StatefulWidget {
  CustomDialog();

  @override
  _CustomDialog createState() => _CustomDialog();
}

class _CustomDialog extends State<CustomDialog> {
  bool color;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  var passwordlamaController = TextEditingController();
  var passwordbaruController = TextEditingController();
  var passwordconfirmController = TextEditingController();
  bool _isHidePassword = true;
  bool _isHidePassword1 = true;
  bool _isHidePassword2 = true;
  PasswordRequestModel requestModel;

  @override
  void initState() {
    super.initState();
    requestModel = new PasswordRequestModel();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  void _togglePasswordVisibility1() {
    setState(() {
      _isHidePassword1 = !_isHidePassword1;
    });
  }

  void _togglePasswordVisibility2() {
    setState(() {
      _isHidePassword2 = !_isHidePassword2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      elevation: 10,
      title: const Text(
        'Ganti Password',
        textAlign: TextAlign.center,
        style: TextStyle(color: blueatmacolor),
      ),
      content: Form(
        key: globalFormKey,
        child: Container(
          height: 212,
          child: Column(
            children: [
              Text(
                  'Minimal 8 karakter, kombinasi huruf, angka, symbol, kapital!',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54)),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordlamaController,
                onSaved: (input) => requestModel.passwordlama = input,
                autofocus: false,
                cursorColor: Colors.black,
                obscureText: _isHidePassword ? true : false,
                decoration: InputDecoration(
                  contentPadding:
                      new EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordVisibility();
                    },
                    child: Icon(
                      _isHidePassword ? Icons.visibility_off : Icons.visibility,
                      color: _isHidePassword ? Colors.grey : Color(0xFF00578f),
                    ),
                  ),
                  border: new OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(32.0)),
                  hintText: 'Password Lama',
                  labelStyle: TextStyle(color: Color(0xFFa67717)),
                  prefixIcon: Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF00578f),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordbaruController,
                onSaved: (input) => requestModel.password = input,
                autofocus: false,
                obscureText: _isHidePassword1 ? true : false,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordVisibility1();
                    },
                    child: Icon(
                      _isHidePassword1
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: _isHidePassword1 ? Colors.grey : Color(0xFF00578f),
                    ),
                  ),
                  contentPadding:
                      new EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(32.0)),
                  hintText: 'Password Baru',
                  labelStyle: TextStyle(color: Color(0xFFeca81e)),
                  prefixIcon:
                      Icon(Icons.lock_open_outlined, color: Color(0xFF00578f)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordconfirmController,
                autofocus: false,
                obscureText: _isHidePassword2 ? true : false,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _togglePasswordVisibility2();
                    },
                    child: Icon(
                      _isHidePassword2
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: _isHidePassword2 ? Colors.grey : Color(0xFF00578f),
                    ),
                  ),
                  contentPadding:
                      new EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: new OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(32.0)),
                  hintText: 'Confirm Password Baru',
                  labelStyle: TextStyle(color: Color(0xFFeca81e)),
                  prefixIcon:
                      Icon(Icons.lock_outlined, color: Color(0xFF00578f)),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Batal'),
                child:
                    const Text('Batal', style: TextStyle(color: Colors.green))),
            TextButton(
              onPressed: () {
                setState(() {
                  if (validateAndSave()) {
                    if (passwordlamaController.text.isEmpty ||
                        passwordbaruController.text.isEmpty ||
                        passwordconfirmController.text.isEmpty) {
                      if (passwordlamaController.text.isEmpty) {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[800],
                          duration: Duration(milliseconds: 800),
                          content: Text("Password Lama Tidak Boleh Kosong"),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordbaruController.text.isEmpty) {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[800],
                          duration: Duration(milliseconds: 800),
                          content: Text("Password Baru Tidak Boleh Kosong"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordconfirmController.text.isEmpty) {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[800],
                          duration: Duration(milliseconds: 800),
                          content: Text("Konfirm Password Tidak Boleh Kosong"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    } else {
                      if (!validateStructure(passwordbaruController.text)) {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[800],
                          duration: Duration(milliseconds: 800),
                          content: Text("Password Lemah"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (passwordconfirmController.text !=
                          passwordbaruController.text) {
                        final snackBar = SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red[800],
                          duration: Duration(milliseconds: 800),
                          content: Text(
                              "Password Baru dan Konfirm Password Tidak Sesuai"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else {
                        APIService apiService = new APIService();
                        setState(() {
                          apiService.gantipassword(requestModel).then((value) {
                            if (value != null) {
                              if (value.status) {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green[800],
                                  duration: Duration(milliseconds: 800),
                                  content: Text("Berhasil Ganti Password"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pop(context, 'Ganti');
                              } else {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.red[800],
                                  duration: Duration(milliseconds: 800),
                                  content: Text("${value.pesan}"),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            }
                          });
                        });
                      }
                    }
                  }
                });
              },
              child: const Text(
                'Ganti',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        )
      ],
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

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@.#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}
