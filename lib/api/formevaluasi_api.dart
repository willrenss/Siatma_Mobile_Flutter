import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/formevaluasi_model.dart';

class MatakuliahEP with ChangeNotifier {
  List<MatakuliahE> _items = [];
  List<MatakuliahE> cek = [];
  bool status = false;

  List<MatakuliahE> get items {
    return [..._items];
  }

  MatakuliahE findById(int cek) {
    return _items.firstWhere((E) => E.idkrs == cek); // find the matakuliah
  }

  bool statuscek() {
    return status;
  }

  Future<void> fetchMatakuliahEP() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/forme/evaluasi");
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
      final List<MatakuliahE> loadMatakuliahE = [];
      final matakuliahjson = extractedData['data'];
      matakuliahjson.forEach(
        (matak) => loadMatakuliahE.add(
          MatakuliahE(
            semester: matak['SEMESTER'].toString(),
            kode: matak['KODE'].toString(),
            matakuliah: matak['MATAKULIAH'].toString(),
            kelas: matak['KELAS'].toString(),
            dosen: matak['DOSEN'].toString(),
            dosen2: matak['DOSEN_2'].toString(),
            idkrs: matak['ID_KRS'],
            status: matak['Status'],
          ),
        ),
      );
      _items = loadMatakuliahE;

      if (loadMatakuliahE.length > 0) {
        cek = loadMatakuliahE
            .where((x) => x.status.toString().contains("false"))
            .toList();
        if (cek.length > 0) {
          status = false;
        } else
          status = true;
      } else {
        status = false;
      }

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class PertanyaanEP with ChangeNotifier {
  List<Pertanyaan> _items = [];

  List<Pertanyaan> get items {
    return [..._items];
  }

  int get hitungpertanyaan {
    return _items.length;
  }

  Pertanyaan findById(int cek) {
    return _items
        .firstWhere((E) => E.idpertanyaan == cek); // find the matakuliah
  }

  Future<void> fetchPertanyaan() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/forme/pertanyaan");
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
      final List<Pertanyaan> loadPertanyaanE = [];

      final pertanyaanjson = extractedData['data'];

      pertanyaanjson.forEach(
        (soal) => loadPertanyaanE.add(
          Pertanyaan(
              nomor: soal['nomor'],
              idjenispertanyaan: soal['iD_Jenis_Pertanyaan'],
              idpertanyaan: soal['iD_PERTANYAAN'],
              soal: soal['soal'].toString(),
              jawaban: List<Jawaban>.from(
                  soal["jawaban"].map((x) => Jawaban.fromJson(x)))),
        ),
      );
      _items = loadPertanyaanE;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class DetailJawabanEP with ChangeNotifier {
  List<DetailJawabanE> _items = [];

  int get hitungjawbaan {
    return _items.length;
  }

  List<DetailJawabanE> get items {
    return [..._items];
  }

  void initJawaban() {
    _items = [];

    notifyListeners();
  }

  DetailJawabanE findById(int cek) {
    return _items.firstWhere((E) => E.idpertanyaan == cek,
        orElse: () => null); // find the matakuliah
  }

  int nilai(int cek) {
    return _items.firstWhere((e) => e.idpertanyaan == cek).detailjawabannilai;
  }

  void fetchJawaban(final DetailJawabanE items) {
    if (findById(items.idpertanyaan) != null)
      _items[_items.indexWhere((e) => e.idpertanyaan == items.idpertanyaan)] =
          items;
    else
      _items.add(items);

    notifyListeners();
  }
}

class FormEP with ChangeNotifier {
  FormE _items = new FormE();

  FormE get items {
    return _items;
  }

  Future<void> fetchKusioner() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/forme/form");
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

      final loadKusioner = extractedData['data'];

      _items = FormE.fromJson(loadKusioner);

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
