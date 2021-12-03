class Presensi {
  final String matakuliah;
  final String kls;
  final String p1;
  final String p2;
  final String p3;
  final String p4;
  final String p5;
  final String p6;
  final String p7;
  final String p8;
  final String p9;
  final String p10;
  final String p11;
  final String p12;
  final String p13;
  final String p14;
  final String p15;
  final String p16;
  final String p17;
  final String p18;
  final String p19;
  final String p20;
  final String p21;
  final String p22;
  final String p23;
  final String p24;
  final String p25;
  final String p26;
  final String p27;
  final String p28;
  final String hadir;
  final String alpha;
  final String ijin;
  final String total;

  Presensi({
    this.matakuliah,
    this.kls,
    this.total,
    this.hadir,
    this.alpha,
    this.ijin,
    this.p1,
    this.p2,
    this.p3,
    this.p4,
    this.p5,
    this.p6,
    this.p7,
    this.p8,
    this.p9,
    this.p10,
    this.p11,
    this.p12,
    this.p13,
    this.p14,
    this.p15,
    this.p16,
    this.p17,
    this.p18,
    this.p19,
    this.p20,
    this.p21,
    this.p22,
    this.p23,
    this.p24,
    this.p25,
    this.p26,
    this.p27,
    this.p28,
  });

  factory Presensi.fromJson(Map<List, dynamic> json) {
    return Presensi(
      matakuliah: json['MATA KULIAH'].toString(),
      kls: json['KLS'].toString(),
      hadir: json['hadir'].toString(),
      ijin: json['Ijin'].toString(),
      alpha: json['Alpha'].toString(),
      total: json['Total'].toString(),
      p1: json['1'].toString(),
      p2: json['2'].toString(),
      p3: json['3'].toString(),
      p4: json['4'].toString(),
      p5: json['5'].toString(),
      p6: json['6'].toString(),
      p7: json['7'].toString(),
      p8: json['8'].toString(),
      p9: json['9'].toString(),
      p10: json['10'].toString(),
      p11: json['11'].toString(),
      p12: json['12'].toString(),
      p13: json['13'].toString(),
      p14: json['14'].toString(),
      p15: json['15'].toString(),
      p16: json['16'].toString(),
      p17: json['17'].toString(),
      p18: json['18'].toString(),
      p19: json['19'].toString(),
      p20: json['20'].toString(),
      p21: json['21'].toString(),
      p22: json['22'].toString(),
      p23: json['23'].toString(),
      p24: json['24'].toString(),
      p25: json['25'].toString(),
      p26: json['26'].toString(),
      p27: json['27'].toString(),
      p28: json['28'].toString(),
    );
  }
}
