import 'package:flutter/material.dart';
import 'package:masterbagasi/indikator_bar.dart';
import 'package:masterbagasi/transaksi/proses_transaksi.dart';

class Transaksi extends StatefulWidget {
  Transaksi({Key key}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _TransaksiState createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {

  @override
  void initState()
  {
    super.initState();
  }

  Widget _cardLakukanTransaksi(ProsesTransaksiPageState prosesTransaksiPageState)
  {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Metode Transaksi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 5),
                Text(
                  'Pilih metode transaksi.',
                ),
              ]
            ),
          ),
          SizedBox(height: 8.0),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('Kartu Kredit',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan Visa, MasterCard, JCB, dan Amex.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('ATM/Bank Transfer',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran melalui ATM bersama atau transfer melalui bank.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('GO-PAY',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan dompet GO-PAY.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('KlikBCA',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan KlikBCA.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('BCA KlikPay',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan BCA KlikPay.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('Mandiri Clickpay',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan Mandiri Clickpay.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('CIMB Clicks',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan CIMB Clicks.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('Danamon Online Banking',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan Danamon Online Banking.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('Danamon Online Banking',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan Danamon Online Banking.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('e-Pay BRI',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan E-Pay BRI.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('LINE Pay e-cash | Mandiri e-cash',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan LINE Pay / Mandiri e-cash.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('Telkomsel Cash',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan telkomsel cash.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('Indomaret',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dari Indomaret.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('Alfamart',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dari Alfamart/Alfamidi.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
          ListTile(
            leading: CircleAvatar(radius: 30.0, backgroundColor: Colors.grey[300]),
            title: Text('Akulaku',
              style: TextStyle(
                fontWeight: FontWeight.bold
              )
            ),
            subtitle: Text('Pembayaran dengan Akulaku account.'),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          ),
        ]
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
    ProsesTransaksiPageState prosesTransaksiPageState = ProsesTransaksiPage.of(context);

    return Column(
      children: <Widget>[
        Expanded(
          child: ListView(
            controller: ScrollController(),
            children: <Widget>[
              _cardLakukanTransaksi(prosesTransaksiPageState),
            ],
          )
        )
      ]
    );
  }
}