import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:siatma_mobile/model/auth_model.dart';
import 'package:siatma_mobile/model/daftarhasilstudi_model.dart';
import 'package:siatma_mobile/model/formevaluasi_model.dart';
import 'package:siatma_mobile/model/mahasiswa_model.dart';
import 'package:siatma_mobile/model/semester_model.dart';

class APIService {
  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/auth/loginsiatma");

    var response = await http.post(
      url,
      body: json.encode(requestModel.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<PasswordResponseModel> gantipassword(
      PasswordRequestModel requestModel) async {
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/auth/change");
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    var response = await http.post(
      url,
      body: json.encode(requestModel.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return PasswordResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<JawabanFormResponseModel> inputjawaban(
      JawabanFormRequestModel requestModel) async {
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/forme/submit");
    final prefs = await SharedPreferences.getInstance();

    String token = prefs.getString('token') ?? '0';
    var response = await http.post(
      url,
      body: json.encode(requestModel.toJson()),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == 200) {
      return JawabanFormResponseModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<Mahasiswa> mahasiswa() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/mhs");

    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $counter'
      },
    );
    if (response.statusCode == 200) {
      return Mahasiswa.fromJson(
        (json.decode(response.body))['data'],
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<DHS> dhs() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';
    Uri url = Uri.parse("https://siatma-api.uajy.ac.id/api/daftarhs/dhs");

    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $counter'
      },
    );
    if (response.statusCode == 200) {
      return DHS.fromJson(
        (json.decode(response.body))['data'],
      );
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<String> semesterShared() async {
    final prefs = await SharedPreferences.getInstance();

    String counter = prefs.getString('token') ?? '0';

    String idprodi = prefs.getString('prodi') ?? '0';
    String masuk = prefs.getString('masuk') ?? '0';
    Uri url = Uri.parse(
        "https://siatma-api.uajy.ac.id/api/info/akademik?masuk=$masuk&prodi=$idprodi");

    var response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $counter'
      },
    );
    if (response.statusCode == 200) {
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

      return loadSemester[0].semesterakademik;
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
