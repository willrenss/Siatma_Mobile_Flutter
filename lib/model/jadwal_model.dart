class JadwalK {
  final String kode;
  final String matakuliah;
  final String kls;
  final String dosen;
  final String dosen2;
  final String ruang;
  final String jadwal1;
  final String jadwal2;
  final String jadwal3;
  final String jadwal4;

  JadwalK({
    this.kode,
    this.matakuliah,
    this.kls,
    this.dosen,
    this.dosen2,
    this.ruang,
    this.jadwal1,
    this.jadwal2,
    this.jadwal3,
    this.jadwal4,
  });

  factory JadwalK.fromJson(Map<List, dynamic> json) {
    return JadwalK(
        kode: json['KODE'].toString(),
        matakuliah: json['MATAKULIAH'].toString(),
        kls: json['KLS'].toString(),
        dosen: json['DOSEN'].toString(),
        dosen2: json['DOSEN2'].toString(),
        ruang: json['RUANG'].toString(),
        jadwal1: json['Jadwal 1'].toString(),
        jadwal2: json['Jadwal 2'].toString(),
        jadwal3: json['Jadwal 3'].toString(),
        jadwal4: json['Jadwal 4'].toString());
  }
}

class JadwalU {
  final String kode;
  final String matakuliah;
  final String uts;
  final String uas;

  JadwalU({
    this.kode,
    this.matakuliah,
    this.uts,
    this.uas,
  });

  factory JadwalU.fromJson(Map<List, dynamic> json) {
    return JadwalU(
        kode: json['KODE'].toString(),
        matakuliah: json['MATAKULIAH'].toString(),
        uts: json['UTS'].toString(),
        uas: json['UAS'].toString());
  }
}

class WaktuU {
  final String sesi;
  final String masuk;
  final String keluar;

  WaktuU({
    this.sesi,
    this.masuk,
    this.keluar,
  });

  factory WaktuU.fromJson(Map<List, dynamic> json) {
    return WaktuU(
        sesi: json['Sesi'].toString(),
        masuk: json['Masuk'].toString(),
        keluar: json['Keluar'].toString());
  }
}

class WaktuK {
  final String sesi;
  final String masuk;
  final String keluar;

  WaktuK({
    this.sesi,
    this.masuk,
    this.keluar,
  });

  factory WaktuK.fromJson(Map<List, dynamic> json) {
    return WaktuK(
        sesi: json['Sesi'].toString(),
        masuk: json['Masuk'].toString(),
        keluar: json['Keluar'].toString());
  }
}
