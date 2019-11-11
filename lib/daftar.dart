import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/api_service.dart';
import 'package:masterbagasi/verifikasi.dart';

class DaftarPage extends StatefulWidget {
  DaftarPage({Key key, this.title}) : super(key: key);

  static String route = 'daftar';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {

  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerNomorTelepon = TextEditingController();
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerUsername = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerKonfirmasiPassword = TextEditingController();

  int _emailValid = 0; int _emailValidTerakhir = 0;
  int _nomorTeleponValid = 0; int _nomorTeleponValidTerakhir = 0;
  int _namaValid = 0; int _namaValidTerakhir = 0;
  int _usernameValid = 0; int _usernameValidTerakhir = 0;
  int _alamatValid = 0; int _alamatValidTerakhir = 0;
  int _passwordValid = 0; int _passwordValidTerakhir = 0;
  int _konfirmasiPasswordValid = 0; int _konfirmasiPasswordValidTerakhir = 0;

  ApiService _apiService;
  Future<void> _futureDaftarPenitip;

  @override
  void initState()
  {
    _apiService = ApiService();
  }

  void _cekEmail(String teks)
  {
    _emailValidTerakhir = _emailValid;

    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _emailValid = -1;
    else
      _emailValid = 1;

    if(_emailValidTerakhir != _emailValid)
      setState((){});
  }

  void _cekNomorTelepon(String teks)
  {
    _nomorTeleponValidTerakhir = _nomorTeleponValid;
    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _nomorTeleponValid = -1;
    else
      _nomorTeleponValid = 1;

    if(_nomorTeleponValidTerakhir != _nomorTeleponValid)
      setState((){});
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

  void _cekUsername(String teks)
  {
    _usernameValidTerakhir = _usernameValid;

    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _usernameValid = -1;
    else
      _usernameValid = 1;

    if(_usernameValidTerakhir != _usernameValid)
      setState((){});
  }

  void _cekAlamat(String teks)
  {
    _alamatValidTerakhir = _alamatValid;

    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _alamatValid = -1;
    else
      _alamatValid = 1;

    if(_alamatValidTerakhir != _alamatValid)
      setState((){});
  }

  void _cekPassword(String teks)
  {
    _passwordValidTerakhir = _passwordValid;

    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _passwordValid = -1;
    else
      _passwordValid = 1;

    if(_passwordValidTerakhir != _passwordValid)
      setState((){});
  }

  void _cekKonfirmasiPassword(String teks)
  {
    _konfirmasiPasswordValidTerakhir = _konfirmasiPasswordValid;

    // Cek jika teksnya ada atau tidak
    if (teks.length == 0)
      _konfirmasiPasswordValid = -1;
    else
      _konfirmasiPasswordValid = 1;

    if(_konfirmasiPasswordValidTerakhir != _konfirmasiPasswordValid)
      setState((){});
  }

  Widget _fieldEmail()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Email:'),
        TextField(
          controller: _controllerEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Masukan email.',
            errorText: _emailValid == -1 ? 'Email dibutuhkan.' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekEmail,
        ),
      ]
    );
  }

  Widget _fieldNomorTelepon()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Nomor Telepon:'),
        TextField(
          controller: _controllerNomorTelepon,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Masukan nomor telepon.',
            errorText: _nomorTeleponValid == -1 ? 'Nomor telepon dibutuhkan.' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekNomorTelepon,
        ),
      ]
    );
  }

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

  Widget _fieldUsername()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Username:'),
        TextField(
          controller: _controllerUsername,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Masukan username.',
            errorText: _usernameValid == -1 ? 'Username dibutuhkan.' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekUsername,
        ),
      ]
    );
  }

  Widget _fieldAlamat()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Alamat:'),
        TextField(
          controller: _controllerAlamat,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Masukan alamat.',
            errorText: _alamatValid == -1 ? 'Alamat dibutuhkan.' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekEmail,
        ),
      ]
    );
  }

  Widget _fieldPassword()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Password:'),
        TextField(
          controller: _controllerPassword,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Masukkan password.',
            errorText: _passwordValid == -1 ? 'Password dibutuhkan.' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekEmail,
        ),
      ]
    );
  }

  Widget _fieldKonfirmasiPassword()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Konfimasi Password:'),
        TextField(
          controller: _controllerKonfirmasiPassword,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Masukan konfirmasi password.',
            errorText: _konfirmasiPasswordValid == -1 ? 'Konfirmasi password harus sama dengan password.' : null,
            contentPadding: EdgeInsets.symmetric(vertical: 8.0),
            alignLabelWithHint: true,
          ),
          onChanged: _cekEmail,
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
      appBar: AppBar(title: Text('Daftar')),
      body: Stack(
        children: <Widget>[
          Center(
            child: Scrollbar(
              child: ListView(
                // Center is a layout widget. It takes a single child and positions it
                // in the middle of the parent.
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
                shrinkWrap: false,
                children: <Widget>[
                  _fieldEmail(),
                  /*SizedBox(height: 15.0),
                  _fieldNomorTelepon(),
                  SizedBox(height: 15.0),
                  _fieldUsername(),*/
                  SizedBox(height: 15.0),
                  _fieldNama(),
                  SizedBox(height: 15.0),
                  _fieldPassword(),
                  SizedBox(height: 15.0),
                  _fieldKonfirmasiPassword(),
                  SizedBox(height: 15.0),
                  FlatButton(
                    child: Text('Daftar'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    onPressed: (){
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState((){
                        _futureDaftarPenitip = _apiService.registerPenitip(
                          email: _controllerEmail.text,
                          password: _controllerPassword.text
                        ).then(
                          (hasil){
                            print('Berhasil');
                            Navigator.of(context).pushNamed(VerifikasiPage.route);
                          }, onError: (error){
                            DioError dioError = error;
                            Map<String, Object> errorResponse = dioError.response.data;
                            AlertDialog alertDialog = AlertDialog(
                              title: Text('Error'),
                              content: Text('${dioError.response.data.toString()} (${dioError.response.statusCode})'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );

                            showDialog(
                              context: context,
                              builder: (context){
                                return alertDialog;
                              }
                            );
                          }
                        );
                      });
                    },
                  ),
                ],
              ),
            )
          ),
          FutureBuilder(
            future: _futureDaftarPenitip,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting)
              {
                return Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(height: 15.0),
                        Text(
                          'Sedang Memproses',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          'Harap menunggu proses...',
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    )
                  ),
                );
              }
              else
                return Container();
            }
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
