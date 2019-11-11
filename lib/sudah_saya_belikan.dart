import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/api_service.dart';

class SudahSayaBelikanPage extends StatefulWidget {
  SudahSayaBelikanPage({Key key}) : super(key: key);

  static String route = 'utama/sudah-saya-belikan';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _SudahSayaBelikanPageState createState() => _SudahSayaBelikanPageState();
}

class _SudahSayaBelikanPageState extends State<SudahSayaBelikanPage> {

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
    status = 1;
  }

  @override
  void dispose()
  {
    _focusNodeCari.dispose();
    super.dispose();
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
    if(status == 2)
      FocusScope.of(context).requestFocus(_focusNodeCari);
    else
      _focusNodeCari.unfocus();

    Widget teksJudul = Text('Sudah Saya Belikan');

    return WillPopScope(
      onWillPop: () async {
        if(status == 2)
        {
          setState((){
            status = 1;
          });

          return false;
        }
        else
          return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: status == 1 ? Theme.of(context).appBarTheme.color : Colors.white,
          iconTheme: IconThemeData(color: status == 2 ? Colors.grey[600] : Colors.white),
          title: status == 1 ? teksJudul : teksCari,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                setState((){
                  status = 2;
                });
              }
            )
          ],
        ),
        body: _isiTitipanSaya()
      )
    );
  }
}
