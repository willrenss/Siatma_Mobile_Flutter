class MatakuliahE {
  final String semester;
  final String kode;
  final String matakuliah;
  final String kelas;
  final String dosen;
  final String dosen2;
  final int idkrs;
  final bool status;

  MatakuliahE(
      {this.semester,
      this.kode,
      this.matakuliah,
      this.kelas,
      this.dosen,
      this.dosen2,
      this.idkrs,
      this.status});

  factory MatakuliahE.fromJson(Map<List, dynamic> json) {
    return MatakuliahE(
      semester: json['SEMESTER'].toString(),
      kode: json['KODE'].toString(),
      matakuliah: json['MATAKULIAH'].toString(),
      kelas: json['KELAS'].toString(),
      dosen: json['DOSEN'].toString(),
      dosen2: json['DOSEN_2'].toString(),
      idkrs: json['ID_KRS'],
      status: json['Status'],
    );
  }
}

class JawabanFormRequestModel {
  String idkrs;
  List<DetailJawabanE> jawaban;

  JawabanFormRequestModel({
    this.idkrs,
    this.jawaban,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'idkrs': idkrs.toString(),
      'Jawaban': jawaban.map((tag) => tag.toJson()).toList()
    };

    return map;
  }
}

class DetailJawabanE {
  final String detailjawaban;
  final int idpertanyaan;
  final int detailjawabannilai;

  DetailJawabanE(
      {this.detailjawaban, this.idpertanyaan, this.detailjawabannilai});

  Map<String, dynamic> toJson() => {
        'DETAIL_JAWABAN': detailjawaban,
        'ID_PERTANYAAN': idpertanyaan,
        'DETAIL_JAWABAN_NILAI': detailjawabannilai
      };

  factory DetailJawabanE.fromJson(Map<List, dynamic> json) {
    return DetailJawabanE(
      detailjawaban: json['DETAIL_JAWABAN'].toString(),
      idpertanyaan: json['ID_PERTANYAAN'],
      detailjawabannilai: json['DETAIL_JAWABAN_NILAI'],
    );
  }
}

class JawabanFormResponseModel {
  final bool status;
  final String pesan;

  JawabanFormResponseModel({
    this.status,
    this.pesan,
  });

  factory JawabanFormResponseModel.fromJson(Map<String, dynamic> json) {
    return JawabanFormResponseModel(
      status: json["status"],
      pesan: json["pesan"],
    );
  }
}

class FormE {
  final String namaform;
  final String tglmulai;
  final String tglselesai;
  final String jammulai;
  final String jamselesai;
  final int idform;

  FormE(
      {this.namaform,
      this.tglmulai,
      this.tglselesai,
      this.jammulai,
      this.jamselesai,
      this.idform});

  factory FormE.fromJson(Map<String, dynamic> json) {
    return FormE(
      namaform: json['NAMA_FORM'].toString(),
      tglmulai: json['TGL_MULAI'].toString(),
      tglselesai: json['TGL_SELESAI'].toString(),
      jammulai: json['JAM_MULAI'].toString(),
      jamselesai: json['JAM_SELESAI'].toString(),
      idform: json['ID_FORM_EVALUASI'],
    );
  }
}

class Pertanyaan {
  final int idjenispertanyaan;
  final String nomor;
  final int idpertanyaan;
  final String soal;
  final List<Jawaban> jawaban;

  Pertanyaan(
      {this.idjenispertanyaan,
      this.idpertanyaan,
      this.soal,
      this.jawaban,
      this.nomor});

  factory Pertanyaan.fromJson(Map<String, dynamic> json) => Pertanyaan(
      jawaban:
          List<Jawaban>.from(json["jawaban"].map((x) => Jawaban.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "jawaban": List<dynamic>.from(jawaban.map((x) => x.toJson())),
      };
}

class Jawaban {
  final String text;
  final int nilai;

  Jawaban({this.text, this.nilai});

  factory Jawaban.fromJson(Map<String, dynamic> json) => Jawaban(
        text: json['text'].toString(),
        nilai: json['nilai'],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "nilai": nilai,
      };
}
