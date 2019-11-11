import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:masterbagasi/chat_room.dart';
import 'package:masterbagasi/data/keranjang.dart';
import 'package:masterbagasi/data/sampel.dart';
import 'package:masterbagasi/keranjang.dart';
import 'package:masterbagasi/pencarian_barang.dart';
import 'package:masterbagasi/tambah_custom_barang.dart';
import 'package:masterbagasi/utama/akun_saya.dart';
import 'package:masterbagasi/utama/beranda.dart';
import 'package:masterbagasi/utama/history.dart';
import 'package:masterbagasi/utama/notifikasi.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UtamaPage extends StatefulWidget {
  UtamaPage({Key key, this.title}) : super(key: key);

  static String route = 'utama';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _UtamaPageState createState() => _UtamaPageState();
}

class _UtamaPageState extends State<UtamaPage> {

  TextEditingController _controllerPencarian = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey<ScaffoldState>();
  int _bottomNavCurrentIndex = 0;
  FirebaseMessaging _fcm;

  @override
  void initState() {
    _fcm = FirebaseMessaging();
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );

    dapatkanTokenFcm();
  }

  void dapatkanTokenFcm() async
  {
    String token = await _fcm.getToken();
    print('Token: ${token}');
  }

  Widget _title()
  {
    if(_bottomNavCurrentIndex == 0)
      return Text('Masterbagasi');
    else if (_bottomNavCurrentIndex == 1)
      return Text('History');
    else if (_bottomNavCurrentIndex == 2)
      return Text('Notifikasi');
    else if (_bottomNavCurrentIndex == 3)
      return Text('Akun Saya');
  }

  Widget _buatSampelItem({Keranjang keranjang})
  {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.0,
              child: Placeholder(
                fallbackWidth: double.infinity,
              )
            ),
            SizedBox(height: 10.0),
            Text(keranjang.nama, style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 4.0),
            Text('${keranjang.berat} kg'),
            SizedBox(height: 4.0),
            Text('Rp. ${keranjang.harga}'),
          ],
        )
      ),
      onTap:(){
        //print('Id: ${satuData.id}');
        //Navigator.of(context).pushNamed(DetailBarangPage.route, arguments: satuData.id);
      }
    );
  }

  Widget _bottomNavigationMenuUtama()
  {
    return new BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _bottomNavCurrentIndex = index;
        });
      },
      currentIndex: _bottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: Theme.of(context).appBarTheme.color,
          ),
          icon: new Icon(
            Icons.home,
            color: Theme.of(context).appBarTheme.color,
          ),
          title: new Text(
            'Beranda',
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.chat,
            color: Theme.of(context).appBarTheme.color,
          ),
          icon: new Icon(
            Icons.chat,
            color: Colors.grey,
          ),
          title: new Text('History'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.notifications,
            color: Theme.of(context).appBarTheme.color,
          ),
          icon: new Icon(
            Icons.notifications,
            color: Colors.grey,
          ),
          title: new Text('Notifikasi'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.account_circle,
            color: Theme.of(context).appBarTheme.color,
          ),
          icon: new Icon(
            Icons.account_circle,
            color: Colors.grey,
          ),
          title: new Text('Akun Saya'),
        ),
      ],
    );
  }

  Widget _keranjangBelanja()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Keranjang', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Lihat keranjang saat ini.'),
            ],
          )
        ),
        Builder(
          builder: (context) {
            //List<SampelFoto> hasil = snapshot.data;

            List<Widget> kolom = <Widget>[
              SizedBox(
                //color: Colors.black,
                height: listKeranjang.length > 0 ? 200.0 : 100.0,
                child: listKeranjang.length > 0 ? ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  shrinkWrap: true,
                  itemBuilder: (context, index){
                    return _buatSampelItem(keranjang: listKeranjang[index]);
                  },

                  itemCount: listKeranjang.length,
                  scrollDirection: Axis.horizontal,
                  itemExtent: 130.0,
                ) : Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Text(
                      'Belum ada data keranjang saat ini. Tekan tombol tambah barang custom untuk menambahkan keranjang baru.',
                      textAlign: TextAlign.center,
                      style: TextStyle(

                      )
                    )
                  ),
                ),
              ),
            ];

            return Column(
              children: kolom,
              crossAxisAlignment: CrossAxisAlignment.start,
            );
          }
        )
      ]
    );
  }

  Widget _satuPerintahBottomNavigationDrawer({IconData iconData, String teks, void Function() onTap})
  {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 90.0,
        height: 100.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  iconData,
                  size: 30.0,
                ),
                SizedBox(height: 5.0),
                Text(
                  teks,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {

    TextField teksPencarian = TextField(
      controller: _controllerPencarian,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'Mencari apa?',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            style: BorderStyle.none
          )
        ),
        filled: true,
        fillColor: Colors.white
      ),
    );

    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        title: _title(),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: (){
              Navigator.of(context).pushNamed(PencarianBarangPage.route);
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _bottomNavCurrentIndex,
        children: <Widget>[
          Beranda(),
          History(),
          Notifikasi(),
          AkunSaya(),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.more_horiz),
        onPressed: (){ 
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _keranjangBelanja(),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        _satuPerintahBottomNavigationDrawer(
                          teks: 'Keranjang Belanja',
                          iconData: Icons.shopping_cart,
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(KeranjangPage.route);
                          }
                        ),
                        _satuPerintahBottomNavigationDrawer(
                          teks: 'Custom Barang',
                          iconData: Icons.add,
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(TambahCustomBarangPage.route);
                          }
                        ),
                        _satuPerintahBottomNavigationDrawer(
                          teks: 'Sampel Chat',
                          iconData: Icons.chat,
                          onTap: (){
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(ChatRoomPage.route);
                          }
                        )
                      ]
                    ),
                  )
                ]
              );
            }
          );
        },
      ),
      bottomNavigationBar: _bottomNavigationMenuUtama(),
    );
  }
}

