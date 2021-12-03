import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:siatma_mobile/api/jadwal_api.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/model/jadwal_model.dart';
import 'package:intl/intl.dart';

class JadwalItem extends StatefulWidget {
  final JadwalK jadwal;

  JadwalItem(this.jadwal);

  @override
  _JadwalItemState createState() => _JadwalItemState();
}

class _JadwalItemState extends State<JadwalItem> {
  bool color;
  String day;

  @override
  void initState() {
    setState(() {
      day = dayname();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: blueatmacolor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
            child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AutoSizeText(
                "${widget.jadwal.matakuliah} / Sesi${cekSesi(widget.jadwal, day)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                maxFontSize: 13,
                maxLines: 2,
              ),
            ],
          ),
        )));
  }
}

String dayname() {
  var day = DateFormat("EEEE").format(DateTime.now());
  if (day == "Monday")
    return 'Senin';
  else if (day == "Tuesday")
    return 'Selasa';
  else if (day == "Wednesday")
    return 'Rabu';
  else if (day == "Thursday")
    return 'Kamis';
  else if (day == "Friday")
    return 'Jumat';
  else if (day == "Saturday")
    return 'Sabtu';
  else
    return 'Minggu';
}

String cekSesi(JadwalK jadwal, String day) {
  var temp = "";
  if (jadwal.jadwal1 != "-") {
    if (jadwal.jadwal1.substring(0, jadwal.jadwal1.length - 4) == day) {
      temp = temp + "-" + jadwal.jadwal1.substring(jadwal.jadwal1.length - 1);
    }
  }

  if (jadwal.jadwal2 != "-") {
    if (jadwal.jadwal2.substring(0, jadwal.jadwal2.length - 4) == day &&
        jadwal.jadwal2 != "-") {
      temp = temp + "-" + jadwal.jadwal2.substring(jadwal.jadwal2.length - 1);
    }
  }

  if (jadwal.jadwal3 != "-") {
    if (jadwal.jadwal3.substring(0, jadwal.jadwal3.length - 4) == day) {
      temp = temp + "-" + jadwal.jadwal3.substring(jadwal.jadwal3.length - 1);
    }
  }

  if (jadwal.jadwal4 != "-") {
    if (jadwal.jadwal4.substring(0, jadwal.jadwal4.length - 4) == day) {
      temp = temp + "-" + jadwal.jadwal4.substring(jadwal.jadwal4.length - 1);
    }
  }
  return temp;
}

class JadwalKosongItem extends StatefulWidget {
  @override
  _JadwalKItemState createState() => _JadwalKItemState();
}

class _JadwalKItemState extends State<JadwalKosongItem> {
  String cekloading;

  @override
  void initState() {
    if (Provider.of<JadwalHariIni>(context, listen: false).statuscek == true)
      cekloading = "Loading...";
    else
      cekloading = "Tidak Ada Perkuliahan Wajib";

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (Provider.of<JadwalHariIni>(context, listen: false).statuscek == true) {
      Provider.of<JadwalHariIni>(context, listen: false)
          .fetchJadwalK()
          .then((value) {
        cekloading = "Tidak Ada Perkuliahan Wajib";
        Provider.of<JadwalHariIni>(context, listen: false).fetchstatus(false);
      });
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: blueatmacolor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
            child: Center(
          child: AutoSizeText(
            cekloading,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13, color: Colors.white, fontWeight: FontWeight.w600),
            maxLines: 1,
          ),
        )));
  }
}
