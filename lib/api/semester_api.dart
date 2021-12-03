import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siatma_mobile/model/semester_model.dart';

class AkademikSemester with ChangeNotifier {
  List<Semester> _items = [];

  List<Semester> get items {
    return [..._items];
  }

  Semester findById(String semesteraka) {
    return _items.firstWhere((semester) =>
        semester.semesterakademik == semesteraka); // find the semester
  }

  Future<void> fetchSemester() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    String idprodi = prefs.getString('prodi') ?? '0';
    String masuk = prefs.getString('masuk') ?? '0';
    Uri url = Uri.parse(
        "https://siatma-api.uajy.ac.id/api/info/akademik?masuk=$masuk&prodi=$idprodi");
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
      final List<Semester> loadSemester = [];
      final semester = extractedData['data'];
      semester.forEach(
        (semester) => loadSemester.add(
          Semester(
            semesterakademik: semester['SEMESTER_AKADEMIk'],
          ),
        ),
      );
      _items = loadSemester;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

class SemesterJadwal with ChangeNotifier {
  List<Semester> _items = [];

  List<Semester> get items {
    return [..._items];
  }

  Semester findById(String semesteraka) {
    return _items.firstWhere((semester) =>
        semester.semesterakademik == semesteraka); // find the semester
  }

  Future<void> fetchSemesterJadwal() async {
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    String idprodi = prefs.getString('prodi') ?? '0';
    String masuk = prefs.getString('masuk') ?? '0';
    Uri url = Uri.parse(
        "https://siatma-api.uajy.ac.id/api/info/akademik?masuk=$masuk&prodi=$idprodi");
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
      final List<Semester> loadSemester = [];
      final semester = extractedData['data'];
      semester.forEach(
        (semester) => loadSemester.add(
          Semester(
            semesterakademik: semester['SEMESTER_AKADEMIk'],
          ),
        ),
      );
      _items = loadSemester;
      notifyListeners();
    } catch (error) {
      dispose();
      throw (error);
    }
  }
}
