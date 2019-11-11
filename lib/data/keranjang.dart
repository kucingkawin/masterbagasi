import 'dart:typed_data';

class Keranjang
{
  String id;
  String nama;
  int harga;
  double berat;
  bool dicentang;
  Uint8List gambar;

  Keranjang({this.id, this.nama, this.harga, this.berat, this.dicentang, this.gambar});

  static List<String> totalBerat(List<Keranjang> keranjang)
  {
    double angkaTotalBerat = 0.0;
    for(int i = 0; i < keranjang.length; i++)
      angkaTotalBerat += keranjang[i].berat;

    return <String>[
      'Total Berat', '${angkaTotalBerat.round().toString()} kg'
    ];
  }

  static List<String> totalHarga(List<Keranjang> keranjang)
  {
    double angkaTotalHarga = 0.0;
    for(int i = 0; i < keranjang.length; i++)
      angkaTotalHarga += keranjang[i].harga;

    return <String>[
      'Total Harga', 'Rp. ${angkaTotalHarga.toString()}'
    ];
  }
}