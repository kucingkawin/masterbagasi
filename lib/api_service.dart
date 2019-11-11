import 'dart:io';

import 'package:dio/dio.dart';
import 'package:masterbagasi/data/order.dart';

class ApiService {
  Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://administratorbagasi.000webhostapp.com',
      connectTimeout: 5000,
      receiveTimeout: 5000
    )
  );

  Future<void> registerPenitip({String email, String password}) async
  {
    try {
      Response response = await _dio.post("/register",
        data: FormData.from(
          <String, dynamic>{
            'email': email,
            'password': password
          },
        ),
        options: Options(
          contentType: ContentType.parse("application/x-www-form-urlencoded")
        )
      );

      if(response.statusCode == 201)
        print('Berhasil daftar penitip');
      else
        print('Ada kendala');
    }
    on DioError catch (e) {
      throw e;
    }
  }

  Future<List<Order>> dapatkanOrderSaatIni() async
  {
    try {
      Response response = await _dio.get("/",
        queryParameters: <String, dynamic>{
          '_start': 10,
          '_limit': 10
        }
      );

      print('Data Response');
    }
    on DioError catch (e)
    {
      throw e;
    }
  }

  Future<List<SampelFoto>> dapatkanSampel() async
  {
    try {
      Response response = await _dio.get("/",
        queryParameters: <String, dynamic>{
          '_start': 10,
          '_limit': 10
        }
      );

      print('Data response');
      //print(response.data);
      return jsonKeSampelFoto(response.data);
    }
    on DioError catch (e) {
      throw e;
    }
  }

  Future<SampelFoto> dapatkanSatuSampel(String id) async
  {
    try
    {
      Response response = await _dio.get("/${id}");
      print('Satu sampel berhasil didapatkan.');
      return SampelFoto.dariJson(response.data);
    }
    on DioError catch (e) {
      throw e;
    }
  }
}

class SampelFoto
{
  String albumId;
  String id;
  String title;
  String url;
  String thumbnailUrl;

  SampelFoto(this.albumId, this.id, this.title, this.url, this.thumbnailUrl);

  factory SampelFoto.dariJson(Map<String, dynamic> response)
  {
    return SampelFoto(response['albumId'].toString(), response['id'].toString(), response['title'], response['url'], response['thumbnailUrl']);
  }
}

List<SampelFoto> jsonKeSampelFoto(dynamic response)
{
  List<dynamic> listResponse = response;
  return List<SampelFoto>.from(listResponse.map((item) => SampelFoto.dariJson(item)));
}