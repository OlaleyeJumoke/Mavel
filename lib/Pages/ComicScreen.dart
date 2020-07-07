import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mavel/Network/ApiLinks.dart';
import 'package:mavel/Network/ApiModel.dart';

class Comics extends StatefulWidget {
  @override
  _ComicsState createState() => _ComicsState();
}

class _ComicsState extends State<Comics> {
  FetchData _fetchData;
  @override
  void initState() {
    _fetchData = FetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: comicList(),
    );
  }

}