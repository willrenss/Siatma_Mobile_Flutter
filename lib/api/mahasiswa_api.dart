import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/beritamodel.dart';
import 'package:siatma_mobile/model/mahasiswa_model.dart';

class MahasiswaP with ChangeNotifier {
  Mahasiswa _items = new Mahasiswa();

  Mahasiswa get items {
    return _items;
  }

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

class BeritaP with ChangeNotifier {
  List<Berita> _items = [];

  List<Berita> get items {
    return [..._items];
  }

  Berita findById(int cek) {
    return _items.firstWhere((E) => E.idberita == cek); // find the matakuliah
  }

  Future<void> fetchBerita() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/info/berita");
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
      final List<Berita> loadKHS = [];
      final khsMenu = extractedData['data'];
      khsMenu.forEach(
        (beri) => loadKHS.add(
          Berita(
            idberita: beri['ID_BERITA_MHS'],
            judul: beri['JUDUL'].toString(),
            gambar: beri['GAMBAR'],
            deskripsi: beri['DESKRIPSI'].toString(),
            prodi: beri['ID_PRODI'].toString(),
            fakultas: beri['ID_FAKULTAS'],
            tglmulai: beri['TGL_MULAI'].toString(),
            tglselesai: beri['TGL_SELESAI'].toString(),
            link: beri['LINK'].toString(),
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

class SKSMATP with ChangeNotifier {
  SKSMAT _items = new SKSMAT();

  SKSMAT get items {
    return _items;
  }

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
