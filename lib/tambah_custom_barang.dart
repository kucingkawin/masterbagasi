import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:masterbagasi/data/keranjang.dart';
import 'package:masterbagasi/data/sampel.dart';
import 'package:masterbagasi/pengaturan_awal/pengaturan_awal.dart';
import 'package:image_cropper/image_cropper.dart';


class TambahCustomBarangPage extends StatefulWidget {
  TambahCustomBarangPage({Key key, this.title}) : super(key: key);

  static String route = 'tambah-custom-barang';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _TambahCustomBarangPageState createState() => _TambahCustomBarangPageState();
}

class _TambahCustomBarangPageState extends State<TambahCustomBarangPage> {

  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerDeskripsi = TextEditingController();
  TextEditingController _controllerHarga = TextEditingController();
  TextEditingController _controllerBerat = TextEditingController();

  int _namaValid = 0; int _namaValidTerakhir = 0;
  int _deskripsiValid = 0; int _deskripsiValidTerakhir = 0;
  int _hargaValid = 0; int _hargaValidTerakhir = 0;
  int _beratValid = 0; int _beratValidTerakhir = 0;

  //File _fileGambar;
  Future<Uint8List> _futureFileGambar;
  Uint8List _fileGambar;

  Widget _fieldNama()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Nama:'),
        TextField(
          controller: _controllerNama,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Masukan nama.',
            errorText: _namaValid == -1 ? 'Nama dibutuhkan.' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekNama,
        ),
      ]
    );
  }

  void _cekNama(String teks)
  {
    _namaValidTerakhir = _namaValid;

    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _namaValid = -1;
    else
      _namaValid = 1;

    if(_namaValidTerakhir != _namaValid)
      setState((){});
  }

  Widget _fieldHarga()
  {
    String errorTeks = null;
    if(_hargaValid == -1)
      errorTeks = 'Harga dibutuhkan.';
    else if(_hargaValid == -2)
      errorTeks = 'Harga harus berupa angka.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Harga:'),
        TextField(
          controller: _controllerHarga,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Masukan harga.',
            errorText: errorTeks,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekHarga,
        ),
      ]
    );
  }

  void _cekHarga(String teks)
  {
    _hargaValidTerakhir = _hargaValid;

    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _hargaValid = -1;
    else
    {
      if(int.tryParse(teks) == null)
        _hargaValid = -2;
      else
        _hargaValid = 1;
    }

    if(_hargaValidTerakhir != _hargaValid)
      setState((){});
  }

  Widget _fieldBerat()
  {
    String errorTeks = null;
    if(_beratValid == -1)
      errorTeks = 'Berat dibutuhkan.';
    else if(_beratValid == -2)
      errorTeks = 'Berat harus berupa angka.';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Berat:'),
        TextField(
          controller: _controllerBerat,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Masukan berat.',
            errorText: errorTeks,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekBerat,
        ),
      ]
    );
  }

  void _cekBerat(String teks)
  {
    _beratValidTerakhir = _beratValid;

    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _beratValid = -1;
    else
    {
      if(int.tryParse(teks) == null)
        _beratValid = -2;
      else
        _beratValid = 1;
    }

    if(_beratValidTerakhir != _beratValid)
      setState((){});
  }

  Widget _fieldUploadGambar()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Gambar:'),
        SizedBox(height: 5.0),
        Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: FlatButton(
                color: Colors.orange,
                onPressed: () async {
                  File croppedFile = await ImageCropper.cropImage(
                    //sourcePath: widget.imageFile.path,
                    aspectRatioPresets: [
                      CropAspectRatioPreset.square,
                      CropAspectRatioPreset.ratio3x2,
                      CropAspectRatioPreset.original,
                      CropAspectRatioPreset.ratio4x3,
                      CropAspectRatioPreset.ratio16x9
                    ],
                    androidUiSettings: AndroidUiSettings(
                      hideBottomControls: false,
                      toolbarTitle: 'Cropper',
                      toolbarColor: Colors.deepOrange,
                      toolbarWidgetColor: Colors.white,
                      initAspectRatio: CropAspectRatioPreset.original,
                      lockAspectRatio: false
                    ),
                    iosUiSettings: IOSUiSettings(
                      minimumAspectRatio: 1.0,
                    )
                  );
                },
                child: Text(
                  'Pilih Gambar',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.0),
            FutureBuilder(
              future: _futureFileGambar,
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done)
                {
                  Uint8List byteGambar = snapshot.data;
                  return Image.memory(byteGambar);
                }
                else if(snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();
                else
                  return Text(
                    'Gambar belum dipilih.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
              },
            )
          ]
        ),
      ]
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
    return Scaffold(
      appBar: AppBar(title: Text('Tambah Custom Barang')),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        children: <Widget>[
          _fieldNama(),
          SizedBox(height: 15.0),
          _fieldHarga(),
          SizedBox(height: 15.0),
          _fieldBerat(),
          SizedBox(height: 15.0),
          _fieldUploadGambar(),
          SizedBox(height: 15.0),
          FlatButton(
            child: Text('Tambah'),
            color: Colors.blue,
            textColor: Colors.white,
            onPressed: (){
              //Tambah list keranjang
              listKeranjang.add(
                Keranjang(
                  nama: _controllerNama.text,
                  harga: int.parse(_controllerHarga.text),
                  berat: double.parse(_controllerBerat.text),
                  gambar: _fileGambar,
                  dicentang: false,
                )
              );

              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }
}
