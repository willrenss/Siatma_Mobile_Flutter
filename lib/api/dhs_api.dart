import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/daftarhasilstudi_model.dart';

class DaftarHS with ChangeNotifier {
  List<DHS> _items = [];

  List<DHS> get items {
    return [..._items];
  }

  DHS findById(String cek) {
    return _items.firstWhere((dhs) => dhs.kode == cek); // find the dhs
  }

  Future<void> fetchDHS() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/daftarhs/dhs");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $counter'
        },
      );
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<DHS> loadDHS = [];
      final dhsMenu = extractedData['data'];
      dhsMenu.forEach(
        (dhs) => loadDHS.add(
          DHS(
            kode: dhs['KODE'],
            matakuliah: dhs['MATAKULIAH'],
            sks: dhs['SKS'],
            nilai: dhs['NILAI'],
          ),
        ),
      );
      _items = loadDHS;
      notifyListeners();
    } catch (error) {
      dispose();
      throw (error);
    }
  }
}
