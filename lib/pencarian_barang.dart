import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/api_service.dart';

class PencarianBarangPage extends StatefulWidget {
  PencarianBarangPage({Key key}) : super(key: key);

  static String route = 'pencarian-barang';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _PencarianBarangPageState createState() => _PencarianBarangPageState();
}

class _PencarianBarangPageState extends State<PencarianBarangPage> {

  ApiService _apiService;
  Future<SampelFoto> _futureDetailBarang;

  TextEditingController _controllerCari;
  FocusNode _focusNodeCari;
  int status;

  void _cekPencarian(String cari)
  {

  }

  Widget _sampelItemTitipanSaya()
  {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(Icons.filter_frames, size: 90.0,),
            SizedBox(height: 7.0),
            Text('Sampel Sudah Saya Belikan', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            Row(
              children: <Widget>[
                Icon(Icons.person),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Requester: '),
                      Text('Fransiskus Xaverius Ananda Tri...', style: TextStyle(fontWeight: FontWeight.bold))
                    ]
                  )
                )
              ],
            ),
          ],
        )
      ),
      onTap:(){
        //Navigator.of(context).pushNamed(DetailBarangPage.route, arguments: satuData['id']);
      }
    );
  }

  Widget _isiTitipanSaya()
  {
    Orientation orientation = MediaQuery.of(context).orientation;
    return GridView.builder(
      itemCount: 10,
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3,
        childAspectRatio: 500.0 / 700.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _sampelItemTitipanSaya();
      },
    );
  }

  @override
  void initState()
  {
    super.initState();

    _focusNodeCari = FocusNode();
    _apiService = ApiService();
    status = 0;
  }

  @override
  void dispose()
  {
    _focusNodeCari.dispose();
    super.dispose();
  }

  Widget isi()
  {
    if(status == 0)
      return Container();
    else if(status == 1)
      return _isiTitipanSaya();
    else if(status == -1)
    {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.search, size: 50.0),
            Text(
              'Data Tidak Ditemukan',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
            Text('Data yang ditemukan tidak ada saat ini.', textAlign: TextAlign.center),
          ]
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    //Tentukan apakah ada tombol search atau tidak.
    Widget teksCari = TextField(
      focusNode: _focusNodeCari,
      controller: _controllerCari,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Mau mencari apa?',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        alignLabelWithHint: true,
        border: InputBorder.none,
        hoverColor: Colors.grey[400],
      ),
      onChanged: _cekPencarian,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.grey[600],
    );

    //Cek jika terjadi perubahan status
    //Status 1: dalam kondisi biasa
    //Status 2: dalam kondisi mencari

    Widget teksJudul = Text('Sudah Saya Belikan');

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.grey[600]),
          title: teksCari,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                setState((){
                  status = 1;
                });
              }
            )
          ],
        ),
        body: isi()
      )
    );
  }
}
