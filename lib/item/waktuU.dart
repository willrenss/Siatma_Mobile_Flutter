import 'package:flutter/material.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/model/jadwal_model.dart';

class WaktuUItem extends StatelessWidget {
  final WaktuU waktuU;

  WaktuUItem(this.waktuU);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Text(
        "Sesi ${waktuU.sesi} : ${waktuU.masuk} - ${waktuU.keluar}",
        style: TextStyle(color: blueatmacolor, fontWeight: FontWeight.w600),
      ),
    );
  }
}
