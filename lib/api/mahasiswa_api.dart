import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/mahasiswa_model.dart';

class MahasiswaP with ChangeNotifier {
  Mahasiswa _items = new Mahasiswa();

  Mahasiswa get items {
    return _items;
  }

  // Mahasiswa findById(String npms) {
  //   return _items
  //       .firstWhere((mahasiswa) => mahasiswa.npm == npms); // find the mahasiswa
  // }

  Future<void> fetchMahasiswa() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/mhs");
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

      final loadMahasiswa = extractedData['data'];

      _items = Mahasiswa.fromJson(loadMahasiswa);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class Info with ChangeNotifier {
  Infomhs _items = new Infomhs();

  Infomhs get items {
    return _items;
  }

  // Mahasiswa findById(String npms) {
  //   return _items
  //       .firstWhere((mahasiswa) => mahasiswa.npm == npms); // find the mahasiswa
  // }

  Future<void> fetchInfo() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/info/infomhs");
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

      final loadMahasiswa = extractedData['data'];

      _items = Infomhs.fromJson(loadMahasiswa);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class SKSMATP with ChangeNotifier {
  SKSMAT _items = new SKSMAT();

  SKSMAT get items {
    return _items;
  }

  // Mahasiswa findById(String npms) {
  //   return _items
  //       .firstWhere((mahasiswa) => mahasiswa.npm == npms); // find the mahasiswa
  // }

  Future<void> fetchSKSMAT() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/info/sksmat");
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

      final loadMahasiswa = extractedData['data'];

      _items = SKSMAT.fromJson(loadMahasiswa);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
