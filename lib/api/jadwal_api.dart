import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/jadwal_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class JadwalKP with ChangeNotifier {
  List<JadwalK> _items = [];

  void initjadwal() {
    _items = [];
    notifyListeners();
  }

  List<JadwalK> get items {
    return [..._items];
  }

  JadwalK findById(String kodes) {
    return _items
        .firstWhere((jadwal) => jadwal.kode == kodes); // find the JadwalU
  }

  Future<void> fetchJadwalK() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    String tahun = prefs.getString('taj') ?? '0';

    Uri url = Uri.parse(
        "https://siatma-api.uajy.ac.id/api/jadwalk/kuliah?tahun=$tahun");
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
      final List<JadwalK> loadJadwal = [];
      final jadwalMenu = extractedData['data'];
      jadwalMenu.forEach(
        (jadwal) => loadJadwal.add(
          JadwalK(
            kode: jadwal['KODE'],
            matakuliah: jadwal['MATAKULIAH'],
            dosen: jadwal['DOSEN'],
            dosen2: jadwal['DOSEN2'],
            ruang: jadwal['RUANG'],
            kls: jadwal['KLS'],
            jadwal1: jadwal['Jadwal 1'],
            jadwal2: jadwal['Jadwal 2'],
            jadwal3: jadwal['Jadwal 3'],
            jadwal4: jadwal['Jadwal 4'],
          ),
        ),
      );
      _items = loadJadwal;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class JadwalHariIni with ChangeNotifier {
  List<JadwalK> _items = [];

  bool cek = true;
  bool status = true;

  bool get cekkondisi {
    return cek;
  }

  bool get statuscek {
    return status;
  }

  fetchstatus(bool variabel) {
    try {
      status = variabel;
    } catch (e) {
      throw (e);
    }

    notifyListeners();
  }

  fetchcek(bool variabel) {
    try {
      cek = variabel;
    } catch (e) {
      throw (e);
    }

    notifyListeners();
  }

  List<JadwalK> get items {
    return [..._items];
  }

  JadwalK findById(String kodes) {
    return _items
        .firstWhere((jadwal) => jadwal.kode == kodes); // find the JadwalU
  }

  String dayname() {
    String day = DateFormat("EEEE").format(DateTime.now());
    if (day == "Monday")
      return 'senin';
    else if (day == "Tuesday")
      return 'selasa';
    else if (day == "Wednesday")
      return 'rabu';
    else if (day == "Thursday")
      return 'kamis';
    else if (day == "Friday")
      return 'jumat';
    else if (day == "Saturday")
      return 'sabtu';
    else
      return 'Minggu';
  }

  Future<void> fetchJadwalK() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    String tahun = prefs.getString('tattp') ?? '0';

    Uri url = Uri.parse(
        "https://siatma-api.uajy.ac.id/api/jadwalk/kuliah?tahun=$tahun");
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
      final List<JadwalK> loadJadwal = [];
      final jadwalMenu = extractedData['data'];
      jadwalMenu.forEach(
        (jadwal) => loadJadwal.add(
          JadwalK(
            kode: jadwal['KODE'],
            matakuliah: jadwal['MATAKULIAH'],
            ruang: jadwal['RUANG'],
            jadwal1: jadwal['Jadwal 1'],
            jadwal2: jadwal['Jadwal 2'],
            jadwal3: jadwal['Jadwal 3'],
            jadwal4: jadwal['Jadwal 4'],
          ),
        ),
      );

      if (loadJadwal != []) {
        _items = loadJadwal
            .where((x) =>
                (x.jadwal1.length > 4
                    ? x.jadwal1
                        .substring(0, x.jadwal1.length - 4)
                        .toLowerCase()
                        .contains(dayname())
                    : false) ||
                (x.jadwal2.length > 4
                    ? x.jadwal2
                        .substring(0, x.jadwal2.length - 4)
                        .toLowerCase()
                        .contains(dayname())
                    : false) ||
                (x.jadwal3.length > 4
                    ? x.jadwal3
                        .substring(0, x.jadwal3.length - 4)
                        .toLowerCase()
                        .contains(dayname())
                    : false) ||
                (x.jadwal4.length > 4
                    ? x.jadwal4
                        .substring(0, x.jadwal4.length - 4)
                        .toLowerCase()
                        .contains(dayname())
                    : false))
            .toList();
      } else
        _items = loadJadwal;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class JadwalUP with ChangeNotifier {
  List<JadwalU> _items = [];

  void initjadwal() {
    _items = [];
    notifyListeners();
  }

  List<JadwalU> get items {
    return [..._items];
  }

  JadwalU findById(String kodes) {
    return _items
        .firstWhere((jadwal) => jadwal.kode == kodes); // find the JadwalU
  }

  Future<void> fetchJadwalU() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    String tahun = prefs.getString('taj') ?? '0';

    Uri url = Uri.parse(
        "https://siatma-api.uajy.ac.id/api/jadwalu/ujian?tahun=$tahun");

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
      final List<JadwalU> loadJadwalK = [];
      final jadwalMenu = extractedData['data'];
      jadwalMenu.forEach(
        (jadwal) => loadJadwalK.add(
          JadwalU(
            kode: jadwal['KODE'],
            matakuliah: jadwal['MATAKULIAH'],
            uts: jadwal['UTS'],
            uas: jadwal['UAS'],
          ),
        ),
      );
      _items = loadJadwalK;
      notifyListeners();
    } catch (error) {
      dispose();
      throw (error);
    }
  }
}

class WaktuUP with ChangeNotifier {
  List<WaktuU> _items = [];

  List<WaktuU> get items {
    return [..._items];
  }

  WaktuU findById(String sesis) {
    return _items
        .firstWhere((waktu) => waktu.sesi == sesis); // find the JadwalU
  }

  Future<void> fetchWaktuU() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/jadwalu/waktu");
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
      final List<WaktuU> loadJadwalK = [];
      final waktuMenu = extractedData['data'];
      waktuMenu.forEach(
        (waktu) => loadJadwalK.add(
          WaktuU(
            masuk: waktu['Masuk'].toString(),
            keluar: waktu['Keluar'].toString(),
            sesi: waktu['Sesi'].toString(),
          ),
        ),
      );
      _items = loadJadwalK;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class WaktuKP with ChangeNotifier {
  List<WaktuK> _items = [];

  List<WaktuK> get items {
    return [..._items];
  }

  WaktuK findById(String sesis) {
    return _items
        .firstWhere((waktu) => waktu.sesi == sesis); // find the JadwalU
  }

  Future<void> fetchWaktuK() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';

    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/jadwalk/waktu");
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
      final List<WaktuK> loadJadwalK = [];
      final waktuMenu = extractedData['data'];
      waktuMenu.forEach(
        (waktu) => loadJadwalK.add(
          WaktuK(
            masuk: waktu['Masuk'].toString(),
            keluar: waktu['Keluar'].toString(),
            sesi: waktu['Sesi'].toString(),
          ),
        ),
      );
      _items = loadJadwalK;
      notifyListeners();
    } catch (error) {
      dispose();
      throw (error);
    }
  }
}
