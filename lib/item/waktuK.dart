import 'package:flutter/material.dart';
import 'package:siatma_mobile/components/colors.dart';
import 'package:siatma_mobile/model/jadwal_model.dart';

class WaktuKItem extends StatelessWidget {
  final WaktuK waktuK;

  WaktuKItem(this.waktuK);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Text(
        "Sesi ${waktuK.sesi} : ${waktuK.masuk} - ${waktuK.keluar} WIB",
        style: TextStyle(color: blueatmacolor, fontWeight: FontWeight.w600),
      ),
    );
  }
}
