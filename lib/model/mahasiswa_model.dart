class Mahasiswa {
  final String npm;
  final String nama;
  final String alamat;
  final String alamatortu;
  final String tmpLahir;
  final String tglLahir;
  final String lama;
  final String idprodi;
  final String thnMasuk;
  final String agama;
  final String sma;
  final String kdStatus;
  final String foto;
  final String namadosen;
  final String prodi;
  final String fakultas;
  final String namaortu;
  final String panggilan;

  Mahasiswa({
    this.npm,
    this.nama,
    this.sma,
    this.panggilan,
    this.alamat,
    this.namadosen,
    this.alamatortu,
    this.agama,
    this.tmpLahir,
    this.tglLahir,
    this.lama,
    this.idprodi,
    this.namaortu,
    this.thnMasuk,
    this.kdStatus,
    this.foto,
    this.prodi,
    this.fakultas,
  });

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(
      npm: json['NPM'].toString(),
      panggilan: json['PANGGILAN'].toString(),
      nama: json['NAMA_MHS'].toString(),
      agama: json['AGAMA'].toString(),
      alamat: json['ALAMAT_JOGJA'].toString(),
      alamatortu: json['ALAMAT_ORTU'].toString(),
      tmpLahir: json['TMP_LAHIR'].toString(),
      tglLahir: json['TGL_LAHIR'].toString(),
      namadosen: json['NAMA_DOSEN_LENGKAP'].toString(),
      lama: json['LAMA'].toString(),
      idprodi: json['ID_PRODI'].toString(),
      thnMasuk: json['THN_MASUK'].toString(),
      kdStatus: json['KD_STATUS_MHS'].toString(),
      foto: json['FOTO'],
      namaortu: json['NAMA_ORTU'].toString(),
      sma: json['SMA'].toString(),
      prodi: json['PRODI'].toString(),
      fakultas: json['FAKULTAS'].toString(),
    );
  }
}

class Infomhs {
  final double ipk;
  final String dosen;

  Infomhs({this.ipk, this.dosen});

  factory Infomhs.fromJson(Map<String, dynamic> json) {
    return Infomhs(
      ipk: json['ipk'],
      dosen: json['NAMA_DOSEN_LENGKAP'].toString(),
    );
  }
}

class SKSMAT {
  final String totalsks;
  final String totalmatkul;
  final String nilaiE;

  SKSMAT({this.nilaiE, this.totalsks, this.totalmatkul});

  factory SKSMAT.fromJson(Map<String, dynamic> json) {
    return SKSMAT(
      totalmatkul: json['totalmatkul'].toString(),
      totalsks: json['totalsks'].toString(),
      nilaiE: json['nilaiE'].toString(),
    );
  }
}
