class KHS {
  final String kode;
  final String matakuliah;
  final int sks;
  final String nilai;
  final String bobot;
  final String remidi;
  final String nilaiRemidi;

  KHS(
      {this.kode,
      this.matakuliah,
      this.sks,
      this.nilai,
      this.bobot,
      this.remidi,
      this.nilaiRemidi});

  factory KHS.fromJson(Map<List, dynamic> json) {
    return KHS(
      kode: json['KODE'].toString(),
      matakuliah: json['MATAKULIAH'].toString(),
      sks: json['SKS'],
      nilai: json['NILAI'].toString(),
      bobot: json['BOBOT'].toString(),
      remidi: json['REMIDI'].toString(),
      nilaiRemidi: json['NILAI_REMIDI'].toString(),
    );
  }
}

class IPSE {
  final int sks;
  final double bobot;
  final double ips;

  IPSE({
    this.sks,
    this.bobot,
    this.ips,
  });

  factory IPSE.fromJson(Map<double, dynamic> json) {
    return IPSE(
      ips: json['IPS'],
      bobot: json['bobot'],
      sks: json['SKS'],
    );
  }
}
