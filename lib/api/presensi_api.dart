import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/presensi_model.dart';

class PresensiP with ChangeNotifier {
  List<Presensi> _items = [];

  List<Presensi> get items {
    return [..._items];
  }

  void initpresensi() {
    _items = [];
    notifyListeners();
  }

  Future<void> fetchPresensi() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    final tahun = prefs.getString('ta') ?? '0';

    Uri url = Uri.parse(
        "https://siatma-api.uajy.ac.id/api/info/presensi?tahun=$tahun");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Presensi> presensiload = [];
      final presensitemp = extractedData['data'];
      presensitemp.forEach(
        (presensitemp) => presensiload.add(
          Presensi(
            matakuliah: presensitemp['MATA KULIAH'],
            kls: presensitemp['KLS'],
            hadir: presensitemp['hadir'].toString(),
            ijin: presensitemp['Ijin'].toString(),
            alpha: presensitemp['Alpha'].toString(),
            total: presensitemp['Total'].toString(),
            p1: presensitemp['1'],
            p2: presensitemp['2'],
            p3: presensitemp['3'],
            p4: presensitemp['4'],
            p5: presensitemp['5'],
            p6: presensitemp['6'],
            p7: presensitemp['7'],
            p8: presensitemp['8'],
            p9: presensitemp['9'],
            p10: presensitemp['10'],
            p11: presensitemp['11'],
            p12: presensitemp['12'],
            p13: presensitemp['13'],
            p14: presensitemp['14'],
            p15: presensitemp['15'],
            p16: presensitemp['16'],
            p17: presensitemp['17'],
            p18: presensitemp['18'],
            p19: presensitemp['19'],
            p20: presensitemp['20'],
            p21: presensitemp['21'],
            p22: presensitemp['22'],
            p23: presensitemp['23'],
            p24: presensitemp['24'],
            p25: presensitemp['25'],
            p26: presensitemp['26'],
            p27: presensitemp['27'],
            p28: presensitemp['28'],
          ),
        ),
      );
      _items = presensiload;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
