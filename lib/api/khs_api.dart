import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/kartuhasilstudi_model.dart';

class KartuHS with ChangeNotifier {
  List<KHS> _items = [];

  String tahun = "";

  String get tahunsemester {
    return tahun;
  }

  void inittahun(semester) {
    tahun = semester;
    notifyListeners();
  }

  List<KHS> get items {
    return [..._items];
  }

  void initkhs() {
    _items = [];
    notifyListeners();
  }

  KHS findById(String kodes) {
    return _items.firstWhere((khs) => khs.kode == kodes); // find the khs
  }

  Future<void> fetchKHS() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    String tahun = prefs.getString('ta') ?? '0';

    Uri url =
        Uri.parse("https://siatma-api.uajy.ac.id/api/kartuhs/khs?tahun=$tahun");
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
      final List<KHS> loadKHS = [];
      final khsMenu = extractedData['data'];
      khsMenu.forEach(
        (khs) => loadKHS.add(
          KHS(
            kode: khs['KODE'],
            matakuliah: khs['MATAKULIAH'],
            sks: khs['SKS'],
            nilai: khs['NILAI'],
            bobot: khs['BOBOT'],
            remidi: khs['REMIDI'],
            nilaiRemidi: khs['NILAI_REMIDI'],
          ),
        ),
      );
      _items = loadKHS;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class IPSP with ChangeNotifier {
  List<IPSE> _items = [];

  List<IPSE> get items {
    return [..._items];
  }

  void initipsks() {
    _items = [];
    notifyListeners();
  }
  // IPSE findById(String bobot) {
  //   return _items.firstWhere((khs) => khs.BOBOT == bobot); // find the khs
  // }

  Future<void> fetchIps() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    String tahun = prefs.getString('ta') ?? '0';

    Uri url =
        Uri.parse("https://siatma-api.uajy.ac.id/api/kartuhs/ips?tahun=$tahun");
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
      final List<IPSE> loadKHS = [];
      final khsMenu = extractedData['data'];
      loadKHS.add(
        IPSE(
          ips: khsMenu['IPS'],
          sks: khsMenu['SKS'],
          bobot: khsMenu['BOBOT'],
        ),
      );
      _items = loadKHS;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
