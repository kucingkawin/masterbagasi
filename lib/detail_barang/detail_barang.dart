import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masterbagasi/api_service.dart';
import 'package:masterbagasi/indikator_proses.dart';
import 'package:masterbagasi/transaksi/proses_transaksi.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DetailBarangPage extends StatefulWidget {
  DetailBarangPage({Key key, this.title, this.id}) : super(key: key);

  static String route = 'utama/detail-barang';

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
  _DetailBarangPageState createState() => _DetailBarangPageState();
}

class _DetailBarangPageState extends State<DetailBarangPage> {

  ApiService _apiService;
  Future<SampelFoto> _futureDetailBarang;
  RefreshController _refreshController = RefreshController(initialRefresh: false);

  Widget _infoRequester()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.person),
        SizedBox(width: 15.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Requester:'),
              //SizedBox(height: 2.0),
              Text(
                'Fransiskus Xaverius Ananda Tri Prasetio',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )
              ),
            ]
          )
        )
      ]
    );
  }

  Widget _infoDibelikanDi()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.shopping_basket),
        SizedBox(width: 15.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Dibelikan:'),
              //SizedBox(height: 2.0),
              Text(
                'Jawa',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )
              ),
            ]
          )
        )
      ]
    );
  }

  Widget _infoDiantarkanKe()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.local_shipping),
        SizedBox(width: 15.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Diantarkan:'),
              //SizedBox(height: 2.0),
              Text(
                'Jakarta',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )
              ),
            ]
          )
        )
      ]
    );
  }

  Widget _infoTransaksi()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.location_on),
        SizedBox(width: 15.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Transaksi:'),
              //SizedBox(height: 2.0),
              Text(
                'Indonesia',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )
              ),
            ]
          )
        )
      ]
    );
  }

  Widget _infoBanyak()
  {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.scatter_plot),
        SizedBox(width: 15.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Banyak:'),
              //SizedBox(height: 2.0),
              Text(
                '10',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )
              ),
            ]
          )
        )
      ]
    );
  }

  Widget _isiDetailBarang(BuildContext context, AsyncSnapshot snapshot)
  {
    if(!snapshot.hasError)
    {
      SampelFoto sampelFoto = snapshot.data;
      final String sampelLoremIpsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque a tellus efficitur, tempor erat et, interdum leo. Duis blandit lacus ac augue mollis eleifend. Aenean sed purus sed nibh rutrum volutpat eget sit amet purus. Aenean ullamcorper non nunc luctus ultricies. Curabitur luctus sit amet nisi nec eleifend. Mauris et nisi eget nisi auctor laoreet.';

      return Column(
        children: <Widget>[
          Expanded(
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              controller: _refreshController,
              onRefresh: () async { await Future.delayed(Duration(seconds: 3)); },
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: MediaQuery.of(context).size.width,
                    floating: false,
                    pinned: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    iconTheme: IconThemeData(color: Colors.black),
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      background: Image.network(
                        sampelFoto.thumbnailUrl,
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: IndikatorProses(
                      warna: Colors.blue,
                      daftarProses: <String>[
                        'Negosiasi', 'Transaksi', 'Pengiriman', 'Konfirmasi', 'Selesai'
                      ],
                      indeksProses: 0,
                    )
                  ),
                  SliverPadding(
                    padding: EdgeInsets.all(15.0),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate(
                        <Widget>[
                          Text(
                            'Detail Barang ${widget.id}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0
                            )
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Text(
                                    'Buka',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white
                                    )
                                  )
                                ),
                                color: Colors.green,
                                width: 50.0,
                                height: 25.0
                              )
                            ],
                          ),
                          SizedBox(height: 10.0),
                          _infoRequester(),
                          SizedBox(height: 10.0),
                          Text(sampelLoremIpsum),
                          Text(sampelLoremIpsum),
                          SizedBox(height: 10.0),
                          _infoDibelikanDi(),
                          SizedBox(height: 10.0),
                          _infoTransaksi(),
                          SizedBox(height: 10.0),
                          _infoDiantarkanKe(),
                          SizedBox(height: 10.0),
                          _infoBanyak(),
                          SizedBox(height: 10.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Card(
                                  child: Container(
                                    height: 190.0,
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Dibelikan Oleh',
                                          textAlign: TextAlign.center,
                                        ),
                                        Icon(Icons.account_circle, size: 100.0),
                                        Text(
                                          'Fransiskus Xaverius Ananda Tri Prasetio',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )
                                      ]
                                    ),
                                  )
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  child: Container(
                                    height: 190.0,
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'Requester Barang',
                                          textAlign: TextAlign.center,
                                        ),
                                        Icon(Icons.account_circle, size: 100.0),
                                        Text(
                                          'Space Idea',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        )
                                      ]
                                    ),
                                  )
                                ),
                              )
                            ],
                          )
                        ]
                      ),
                    ),
                  )
                ]
              ),
            ),
          ),
          InkWell(
            child: Container(
              margin: EdgeInsets.all(0.0),
              child: Center(
                child: Text(
                  'Titip',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              height: 45.0,
              color: Colors.orange,
            ),
            onTap: (){
              Navigator.of(context).pushNamed(ProsesTransaksiPage.route);
            }
          )
        ]
      );
    }
    else
    {
      DioError error = snapshot.error;
      return CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            pinned: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.error, size: 50.0),
                  SizedBox(height: 10.0),
                  Text(
                    'Ada Masalah Dengan Koneksi Data',
                    style: TextStyle(fontWeight: FontWeight.bold)
                  ),
                  Text(
                    error.message,
                  ),
                ]
              )
            ),
            hasScrollBody: false,
          )
        ]
      );
    }
  }

  @override
  void initState()
  {
    super.initState();
    _apiService = ApiService();
    _futureDetailBarang = _apiService.dapatkanSatuSampel(widget.id);
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
      body: FutureBuilder(
        future: _futureDetailBarang,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done)
          {
            print('Has data: ${snapshot.hasData}, Has error: ${snapshot.hasError}');
            return _isiDetailBarang(context, snapshot);
          }
          else
          {
            return Center(
              child: CircularProgressIndicator()
            );
          }
        }
      )
    );
  }
}