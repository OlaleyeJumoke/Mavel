import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'ApiModel.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;

import 'Keys.dart';

class FetchData {

  String ts =
      new DateTime.now().millisecondsSinceEpoch.toString();
  String privateKey = Keys.privateKey;
  String publicKey = Keys.publicKey;

  generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }

  int itemsPerPage = 20;
  var offset = 0;
  var page = 0;

  Future<List<ComicIssue>> comicIssue(String path, String title) async {
    final hash = generateMd5('$ts' + '$privateKey' + '$publicKey').toString();
    //String title1 = title;
    offset = (page * itemsPerPage);
    final queryParameters = {
      "apikey": publicKey,
      "ts": ts,
      "hash": hash,
      "limit": itemsPerPage.toString(),
      "offset": offset.toString(),
      "format": "comic",
      "title": 'captain marvel'
    };

    final uri =
        Uri.http('gateway.marvel.com', '$path', queryParameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    return await http.get(uri, headers: headers).then((http.Response res) {
      dynamic response = res.body;
      final int statusCode = res.statusCode;

      if (statusCode == 200) {
        var comics = json.decode(response);
        List comicsData = comics['data']['results'];

        return comicsData
            .map((questions) => new ComicIssue.fromJson(questions))
            .toList();
      } else
        throw Exception(
            'We were not able to successfully download the json data.');
    });
  }


Future<List<ComicIssue>> comic(String path) async {
    final hash = generateMd5('$ts' + '$privateKey' + '$publicKey').toString();
    //String title1 = title;
    offset = (page * itemsPerPage);
    final queryParameters = {
      "apikey": publicKey,
      "ts": ts,
      "hash": hash,
      "limit": itemsPerPage.toString(),
      "offset": offset.toString(),
      "format": "comic",
    };

    final uri =
        Uri.http('gateway.marvel.com', '$path', queryParameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    return await http.get(uri, headers: headers).then((http.Response res) {
      dynamic response = res.body;
      final int statusCode = res.statusCode;

      if (statusCode == 200) {
        var comics = json.decode(response);
        List comicsData = comics['data']['results'];

        return comicsData
            .map((questions) => new ComicIssue.fromJson(questions))
            .toList();
      } else
        throw Exception(
            'We were not able to successfully download the json data.');
    });
  }

  characterOrStories(String baseUrl) async {
    final hash = generateMd5('$ts' + '$privateKey' + '$publicKey').toString();

    offset = (page * itemsPerPage);

    final queryParameters = {
      "apikey": publicKey,
      "ts": ts,
      "hash": hash,
      "limit": itemsPerPage.toString(),
      "offset": offset.toString(),
    };

    final uri = Uri.http('gateway.marvel.com', '$baseUrl', queryParameters);
    final headers = {HttpHeaders.contentTypeHeader: 'application/json'};

    return await http.get(uri, headers: headers).then((http.Response res) {
      dynamic response = res.body;
      final int statusCode = res.statusCode;

      if (statusCode == 200) {
        var comics = json.decode(response);
        var comicData = comics['data']['results'];

        return comicData;
        // return comicsData
        //     .map((questions) => new Character.fromJson(questions))
        //     .toList();
      } else
        throw Exception(
            'We were not able to successfully download the json data.');
    });
  }
}
