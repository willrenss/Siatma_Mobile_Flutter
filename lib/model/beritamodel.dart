class Berita {
  final int idberita;
  final String judul;
  final String gambar;
  final String deskripsi;
  final String prodi;
  final int fakultas;
  final String tglmulai;
  final String tglselesai;
  final String link;

  Berita(
      {this.idberita,
      this.fakultas,
      this.judul,
      this.deskripsi,
      this.link,
      this.prodi,
      this.gambar,
      this.tglmulai,
      this.tglselesai});

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      idberita: json['ID_BERITA'],
      judul: json['JUDUL'].toString(),
      gambar: json['GAMBAR'],
      deskripsi: json['DESKRIPSI'].toString(),
      prodi: json['ID_PRODI'].toString(),
      fakultas: json['ID_FAKULTAS'],
      tglmulai: json['TGL_MULAI'].toString(),
      tglselesai: json['TGL_SELESAI'].toString(),
      link: json['LINK'].toString(),
    );
  }
}
