import 'package:flutter/material.dart';
import 'package:masterbagasi/api_service.dart';
import 'package:masterbagasi/chat_room.dart';
import 'package:masterbagasi/indikator_bar.dart';
import 'package:masterbagasi/indikator_proses.dart';
import 'package:masterbagasi/transaksi/bagian/negosiasi.dart';
import 'package:masterbagasi/transaksi/bagian/pengiriman.dart';
import 'package:masterbagasi/transaksi/bagian/transaksi.dart';

class ProsesTransaksiPage extends StatefulWidget {
  ProsesTransaksiPage({Key key, this.title, this.id}) : super(key: key);

  static String route = 'utama/detail-barang/transaksi';

  static ProsesTransaksiPageState of(BuildContext context)
  {
    return context.ancestorStateOfType(TypeMatcher<ProsesTransaksiPageState>());
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String id;
  final String title;

  @override
  ProsesTransaksiPageState createState() => ProsesTransaksiPageState();
}

class ProsesTransaksiPageState extends State<ProsesTransaksiPage> {

  //Daftar proses
  List<String> daftarProses;
  int indeksProses;

  //Untuk daftar persetujuan negosiasi.
  int nilaiPersetujuanNegosiasi;
  int maxNilaiPersetujuanNegosiasi;
  Color warnaMinimalNilaiPersetujuanNegosiasi;
  Color warnaMaksimalNilaiPersetujuanNegosiasi;

  @override
  void initState()
  {
    super.initState();
    daftarProses = <String>[
      'Negosiasi', 'Transaksi', 'Pengiriman', 'Konfirmasi', 'Selesai'
    ];
    indeksProses = 0;

    //Untuk daftar persetujuan negosiasi.
    nilaiPersetujuanNegosiasi = 0;
    maxNilaiPersetujuanNegosiasi = 2;
    warnaMinimalNilaiPersetujuanNegosiasi = Colors.blue;
    warnaMaksimalNilaiPersetujuanNegosiasi = Colors.green;
  }

  Color warnaBerdasarkanIndeks()
  {
    double normalisasi = nilaiPersetujuanNegosiasi / maxNilaiPersetujuanNegosiasi;
    if(indeksProses == 0)
      return Color.lerp(warnaMinimalNilaiPersetujuanNegosiasi, warnaMaksimalNilaiPersetujuanNegosiasi, normalisasi);
    else
      return Colors.blue;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text(daftarProses[indeksProses]),
        backgroundColor: warnaBerdasarkanIndeks(),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.chat_bubble),
            onPressed: (){
              Navigator.of(context).pushNamed(ChatRoomPage.route);
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          IndikatorProses(
            warna: warnaBerdasarkanIndeks(),
            daftarProses: daftarProses,
            indeksProses: indeksProses,
          ),
          Expanded(
            child: IndexedStack(
              index: indeksProses,
              children: <Widget>[
                Negosiasi(),
                Transaksi(),
                Pengiriman(),
              ],
            )
          )
        ]
      )
    );
  }
}