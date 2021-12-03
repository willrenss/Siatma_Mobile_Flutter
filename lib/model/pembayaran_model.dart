class Pembayaran {
  final String keterangan;
  final int tagihan;
  final int sudahdibayar;
  final int kekurangan;
  final String status;

  Pembayaran({
    this.keterangan,
    this.tagihan,
    this.sudahdibayar,
    this.kekurangan,
    this.status,
  });

  factory Pembayaran.fromJson(Map<String, dynamic> json) {
    return Pembayaran(
      keterangan: json['Keterangan Pembayaran'].toString(),
      tagihan: json['Yang Harus Dibayar'],
      sudahdibayar: json['Sudah Dibayar'],
      kekurangan: json['Kekurangan'],
      status: json['Status'].toString(),
    );
  }
}
