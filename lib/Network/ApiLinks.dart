import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'ApiModel.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

class FetchData {
  String ts =
      new DateTime.now().millisecondsSinceEpoch.toString(); //.now().toString();
  String privateKey = 'b59e70c8a32840143f3bf5dcb6e8f24bc65c0b34';
  String publicKey = 'e07bad3feb1c42674e74585c8d8924c8';

  //String generateMd5 =
  //md5.convert(utf8.encode('ts' + 'privateKey' + 'publicKey')).toString();
  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  int itemsPerPage = 20;
  var offset = 0;
  var page = 0;

  Future<List<ComicIssue>> comicIssue() async {
    final hash = generateMd5('$ts' + '$privateKey' + '$publicKey').toString();

    offset = (page * itemsPerPage);
    final jsonEndpoint = "http://gateway.marvel.com/v1/public/comics";
    //Map<String, String> 
  final  queryParameters = {
      "apikey": publicKey,
      "ts": ts,
      "hash": hash,
      "limit": itemsPerPage.toString(),
      "offset": offset.toString(),
      "format": "comic",
      "title": "captain marvel"
    };
    
    print(ts);
    print(hash);
    print(jsonEndpoint);

     final uri = Uri.http(
         'gateway.marvel.com', '/v1/public/comics', queryParameters);
     final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    return await http.get(uri, headers: headers).then((http.Response res) {
      dynamic response = res.body;
      final int statusCode = res.statusCode;

      if (statusCode == 200) {
        var comics = json.decode(response);
        //print('${comics['data']['results']}');
        List comicsData = comics['data']['results'];
        //print(comicsData[3]['images'][0]['path']);
        print(comicsData[10]['characters']['items']);

        return comicsData
            .map((questions) => new ComicIssue.fromJson(questions))
            .toList();
        //.shuffle();
      } else
        throw Exception(
            'We were not able to successfully download the json data.');
    });
  }
}


