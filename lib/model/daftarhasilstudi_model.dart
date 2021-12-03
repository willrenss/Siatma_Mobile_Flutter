class DHS {
  final String kode;
  final String matakuliah;
  final int sks;
  final String nilai;

  DHS({
    this.kode,
    this.matakuliah,
    this.sks,
    this.nilai,
  });

  factory DHS.fromJson(Map<List, dynamic> json) {
    return DHS(
      kode: json['KODE'].toString(),
      matakuliah: json['MATAKULIAH'].toString(),
      sks: json['SKS'],
      nilai: json['NILAI'].toString(),
    );
  }
}
