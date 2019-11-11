import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/api_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoomPage extends StatefulWidget {
  ChatRoomPage({Key key}) : super(key: key);

  static String route = 'utama/chat-room';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ChatRoomPageState createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {

  ApiService _apiService;
  Future<SampelFoto> _futureDetailBarang;
  List<Chat> daftarChat;

  TextEditingController _controllerCari = TextEditingController();
  TextEditingController _controllerChat = TextEditingController();
  ScrollController _scrollController = ScrollController();
  FocusNode _focusNodeCari;
  FocusNode _focusNodeChat;
  int status;
  int statusKirim;

  void _cekPencarian(String cari)
  {

  }

  Widget _isiChat()
  {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('chats').orderBy('tanggal_dikirim', descending: false).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Center(
            child: Text('Error: ${snapshot.error}')
          );
        else if (snapshot.connectionState == ConnectionState.waiting) {
          return new Center(
            child: CircularProgressIndicator()
          );
        }
        else
        {
          List<DocumentSnapshot> documentSnapshot = snapshot.data.documents;
          print('Banyak document snapshot: ${documentSnapshot.length}');
          WidgetsBinding.instance.addPostFrameCallback((duration){
            _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
          });

          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
            itemBuilder: (context, index){
              Timestamp timeStamp = documentSnapshot[index]['tanggal_dikirim'];
              Chat satuChat = Chat(
                tanggal: timeStamp.toDate(),
                pelakuChat: documentSnapshot[index]['user_id'] == '1' ? PelakuChat.saya : PelakuChat.orangLain,
                isi: documentSnapshot[index]['isi']
              );

              if(satuChat.pelakuChat == PelakuChat.orangLain)
                return _teksChatOrangLain(satuChat.isi);
              else
                return _teksChatSaya(satuChat.isi);
            },

            itemCount: documentSnapshot.length
          );
        }
      },
    );

    /*return ListView.builder(
      controller: _scrollController,
      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      itemBuilder: (context, index){
        Chat satuChat = daftarChat[index];
        if(satuChat.pelakuChat == PelakuChat.orangLain)
          return _teksChatOrangLain(satuChat.isi);
        else
          return _teksChatSaya(satuChat.isi);
      },
      itemCount: daftarChat.length
    );*/
  }

  Widget _teksChatOrangLain(String teks)
  {
    Widget row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.grey[300],
          radius: 18.0,
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.grey[300]
                ),
                padding: EdgeInsets.all(10.0),
                child: Text(teks),
              )
            ],
          ),
        ),
        SizedBox(
          width: 30.0
        ),
      ]
    );

    row = Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: row
    );

    return row;
  }

  Widget _teksChatSaya(String teks) {
    Widget row = Row(
      children: <Widget>[
        SizedBox(
          width: 30.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: Colors.blue
                ),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  teks,
                  style: TextStyle(
                    color: Colors.white,
                  )
                ),
              )
            ],
          ),
        ),
      ]
    );

    row = Padding(
      padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
      child: row
    );

    return row;
  }

  @override
  void initState()
  {
    super.initState();

    _focusNodeCari = FocusNode();
    _apiService = ApiService();
    status = 1;
    statusKirim = 0;
    daftarChat = List<Chat>();
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

    Widget teksChat = TextField(
      focusNode: _focusNodeChat,
      controller: _controllerChat,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Ketikan pesan.',
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 0.0
        ),
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

    Widget teksJudul = Text('Orang Lain');
    Widget containerIsiChat = _isiChat();

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _isiChat()
            ),
            Container(
              height: kToolbarHeight - 5.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: teksChat
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.blue,
                    onPressed: () async {
                      statusKirim = 1;
                      await Firestore.instance.collection('chats').add(<String, dynamic>{
                        'dibaca': false,
                        'isi': _controllerChat.text,
                        'tanggal_dikirim': Timestamp.fromDate(DateTime.now()),
                        'transaksi_id': '1',
                        'user_id': '1'
                      });
                    },
                  )
                ]
              )
            )
          ]
        )
      )
    );
  }
}

enum PelakuChat
{
  saya,
  orangLain
}

class Chat
{
  String isi;
  DateTime tanggal;
  PelakuChat pelakuChat;

  Chat({this.isi, this.tanggal, this.pelakuChat});
}
