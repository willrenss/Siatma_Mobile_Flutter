import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/api_service.dart';
import 'package:siatma_mobile/api/formevaluasi_api.dart';
import 'package:siatma_mobile/components/ProgressHUD.dart';

import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/model/formevaluasi_model.dart';
import 'package:siatma_mobile/view/formEvaluasiScreen.dart';
import 'package:siatma_mobile/widget/detailFormEvaluasiWidget.dart';

class DetailEvaluasiScreen extends StatefulWidget {
  final int idkrs;
  DetailEvaluasiScreen(this.idkrs);
  @override
  _DetailEvaluasiScreenState createState() => _DetailEvaluasiScreenState();
}

class _DetailEvaluasiScreenState extends State<DetailEvaluasiScreen> {
  JawabanFormRequestModel requestModel = new JawabanFormRequestModel();
  bool isApiCallProcess = false;
  @override
  void initState() {
    super.initState();
    print(widget.idkrs);
    requestModel.idkrs = widget.idkrs.toString();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
        child: _upInit(context), inAsyncCall: isApiCallProcess, opacity: 0.3);
  }

  Widget _upInit(BuildContext context) {
    final evaluasi = Provider.of<MatakuliahEP>(context, listen: false)
        .findById(widget.idkrs);
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: blueatmacolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: blueatmacolor,
        title: AutoSizeText(
          "${evaluasi.matakuliah}",
          textAlign: TextAlign.center,
          maxLines: 2,
          maxFontSize: 16,
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: _detailevaluasi(isKeyboard)),
    );
  }

  Container _detailevaluasi(final isKeyboard) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.only(top: 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Container(
        padding: EdgeInsets.only(right: 5, left: 5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Container(
            child: Column(
          children: [
            Expanded(
              flex: 12,
              child: DetailEvaluasiView(),
            ),
            if (!isKeyboard)
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white24,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        primary: Color(0xFF00578f),
                        padding: EdgeInsets.only(right: 30, left: 30),
                        textStyle: const TextStyle(fontSize: 20)),
                    onPressed: () {
                      APIService apiService = new APIService();
                      setState(() {
                        if (Provider.of<DetailJawabanEP>(context, listen: false)
                                .hitungjawbaan ==
                            Provider.of<PertanyaanEP>(context, listen: false)
                                .hitungpertanyaan) {
                          requestModel.jawaban = Provider.of<DetailJawabanEP>(
                                  context,
                                  listen: false)
                              .items;

                          isApiCallProcess = true;

                          apiService.inputjawaban(requestModel).then((value) {
                            if (value != null) {
                              isApiCallProcess = false;
                              if (value.status) {
                                final snackBar = SnackBar(
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green[800],
                                  duration: Duration(milliseconds: 800),
                                  content: Text("Berhasil Submit Jawaban"),
                                );
                                Provider.of<DetailJawabanEP>(context,
                                        listen: false)
                                    .initJawaban();
                                Provider.of<MatakuliahEP>(context,
                                        listen: false)
                                    .fetchMatakuliahEP();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FormEvaluasiScreen()));
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
                        } else {
                          final snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.red[800],
                            duration: Duration(milliseconds: 800),
                            content:
                                Text("Pertanyaan Tidak Boleh Ada yang Kosong"),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    },
                    child: Text("Submit"),
                  ),
                ),
              )
          ],
        )),
      ),
    );
  }
}
