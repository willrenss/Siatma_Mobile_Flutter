import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/pembayaran_model.dart';

class PembayaranP with ChangeNotifier {
  List<Pembayaran> _items = [];
  int cek = 0;

  List<Pembayaran> get items {
    return [..._items];
  }

  // Pembayaran findById(String kodes) {
  //   return _items.firstWhere((pembayaranjson) => pembayaranjson.kode == kodes); // find the pembayaranjson
  // }

  Future<void> fetchPembayaran() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/info/pembayaran");
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
      final List<Pembayaran> loadKHS = [];
      final khsMenu = extractedData['data'];
      khsMenu.forEach(
        (pembayaranjson) => loadKHS.add(
          Pembayaran(
            keterangan: pembayaranjson['Keterangan Pembayaran'].toString(),
            tagihan: pembayaranjson['Yang Harus Dibayar'],
            sudahdibayar: pembayaranjson['Sudah Dibayar'],
            kekurangan: pembayaranjson['Kekurangan'],
            status: pembayaranjson['Status'].toString(),
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
