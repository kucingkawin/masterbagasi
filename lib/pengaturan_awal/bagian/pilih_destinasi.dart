import 'package:flutter/material.dart';
import 'package:masterbagasi/pengaturan_awal/pengaturan_awal.dart';
import 'package:masterbagasi/utama/utama.dart';

enum TipeDestinasi
{
  indonesiaKorea,
  koreaIndonesia
}

class PilihDestinasi extends StatefulWidget {
  PilihDestinasi({Key key, this.title}) : super(key: key);

  static String route = 'pengaturan-awal';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _PilihDestinasiState createState() => _PilihDestinasiState();
}

class _PilihDestinasiState extends State<PilihDestinasi> {

  Widget _pilihanDestinasi({String teks, String deskripsi, TipeDestinasi tipeDestinasi, void Function() onTap})
  {
    Image _benderaIndonesia = Image.asset("assets/bendera_indonesia.png", width: 50);
    Image _benderaKoreaSelatan = Image.asset("assets/bendera_korea_selatan.png", width: 50);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                tipeDestinasi == TipeDestinasi.indonesiaKorea ? _benderaIndonesia : _benderaKoreaSelatan,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Icon(Icons.arrow_forward)
                ),
                tipeDestinasi == TipeDestinasi.indonesiaKorea ? _benderaKoreaSelatan : _benderaIndonesia,
              ]
            ),
            SizedBox(height: 10.0),
            Text(
              teks,
              style: TextStyle(
                fontSize: 20.0
              )
            ),
            SizedBox(height: 5.0),
            Text(deskripsi),
          ]
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return SafeArea(
      child: ListView(
        controller: ScrollController(),
        children: <Widget>[
          SizedBox(height: 20.0),
          Padding(
            padding: EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 0.0),
            child: Text(
              'Pilih Destinasi',
              style: TextStyle(
                fontSize: 30.0
              ),
            )
          ),
          SizedBox(height: 15.0),
          _pilihanDestinasi(
            teks: "Indonesia - Korea Selatan",
            deskripsi: "Titip barang dengan destinasi tujuan ke Korea Selatan.",
            tipeDestinasi: TipeDestinasi.indonesiaKorea,
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UtamaPage.route);
            }
          ),
          _pilihanDestinasi(
            teks: "Korea Selatan - Indonesia",
            deskripsi: "Titip barang dengan destinasi tujuan ke Indonesia.",
              tipeDestinasi: TipeDestinasi.koreaIndonesia,
            onTap: (){
              Navigator.of(context).pushReplacementNamed(UtamaPage.route);
            }
          ),
          SizedBox(height: 15.0),
          Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 0.0, bottom: 0.0),
            child: Row(
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Sebelumnya',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17.0
                    ),
                  ),
                  color: Colors.blue,
                  onPressed: (){
                    PengaturanAwalPage.of(context).sebelumnya();
                  }
                )
              ]
            )
          )
        ]
      )
    );
  }
}
