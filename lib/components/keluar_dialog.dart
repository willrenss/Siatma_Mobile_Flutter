import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/api/mahasiswa_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/view/loginScreen.dart';

class KeluarDialog extends StatefulWidget {
  KeluarDialog();

  @override
  _KeluarDialog createState() => _KeluarDialog();
}

class _KeluarDialog extends State<KeluarDialog> {
  bool color;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        elevation: 10,
        title: const Text(
          'Keluar',
          textAlign: TextAlign.center,
          style: TextStyle(color: blueatmacolor),
        ),
        content: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Apakah Anda Yakin Keluar ?',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54)),
                SizedBox(
                  height: 10,
                ),
              ],
            )),
        actions: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            TextButton(
                onPressed: () => Navigator.pop(context, 'Batal'),
                child:
                    const Text('Batal', style: TextStyle(color: Colors.green))),
            TextButton(
                onPressed: () {
                  setState(() {
                    Provider.of<MahasiswaP>(context, listen: false).setTouch(0);
                    Provider.of<MahasiswaP>(context, listen: false).setIndex(0);
                    Provider.of<JadwalHariIni>(context, listen: false)
                        .fetchcek(true);
                    Provider.of<JadwalHariIni>(context, listen: false)
                        .fetchstatus(true);
                    clear();
                  });
                  Navigator.pop(context, 'Keluar');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                  final snackBar = SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: Colors.green[800],
                    duration: Duration(milliseconds: 800),
                    content: Text("Log Out Berhasil"),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child:
                    const Text('Keluar', style: TextStyle(color: Colors.red)))
          ]),
        ]);
  }

  clear() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.clear();
  }
}
