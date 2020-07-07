import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mavel/Network/ApiLinks.dart';
import 'package:mavel/Network/ApiModel.dart';

class DetailFlow extends StatefulWidget {
  final image,
      issueNumber,
      title,
      description,
      ups,
      format,
      series,
      date,
      prices,
      images,
      creators,
      characters,
      stories,
      events;
  DetailFlow(
      {this.image,
      this.issueNumber,
      this.title,
      this.description,
      this.ups,
      this.format,
      this.series,
      this.date,
      this.prices,
      this.images,
      this.creators,
      this.characters,
      this.stories,
      this.events});
  @override
  _DetailFlowState createState() => _DetailFlowState();
}

class _DetailFlowState extends State<DetailFlow> {
  FetchData _fetchData;
  @override
  void initState() {
    _fetchData = FetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Characters:${widget.characters}");
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: '${widget.image}',
            width: double.infinity,
            height: 300.0,
            fit: BoxFit.cover,
          ),
          Container(
            child: Text(
              '${widget.title}',
              style: GoogleFonts.lato(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          widget.description == null
              ? Container()
              : Container(
                  child: Text(
                    '${widget.description}',
                    style: GoogleFonts.lato(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
          widget.issueNumber == null
              ? Container()
              : Text(
                  'Issue Number: ${widget.issueNumber}',
                  style: GoogleFonts.lato(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),
          Text(
            '${widget.prices[0]['type']}\n ${widget.prices[0]['price']}',
            style: GoogleFonts.lato(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.white),
          ),
          images(widget.images),
          Text(
            'Creators',
            textAlign: TextAlign.start,
            style: GoogleFonts.lato(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: Colors.white),
          ),
          creators(widget.creators),
          widget.characters.isEmpty
              ? Container()
              : Text(
                  'Characters',
                  style: GoogleFonts.lato(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
          widget.characters.isEmpty
              ? Container()
              : charactersList(widget.characters)
        ],
      )),
    );
  }

  images(final images) {
    print(images.length);
    print(images);
    return Container(
      margin: EdgeInsets.all(16.0),
      height: 200,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),

        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int currentIndex) {
          return imagesView(images[currentIndex], context);
        },
        //
      ),
    );
  }

  imagesView(final _image, BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${_image['path']}' + '.' + '${_image['extension']}',
      width: 80.0,
      height: 80.0,
      fit: BoxFit.cover,
    );
  }

  creators(final creators) {
    return Container(
      height: 80.0,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),

        itemCount: creators.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int currentIndex) {
          return creatorsView(creators[currentIndex], context);
        },
        //
      ),
    );
  }

  creatorsView(final creators, BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '${creators['name']}',
            style: GoogleFonts.lato(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
          Text(
            '(${creators['role']})',
            style: GoogleFonts.lato(
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  thumbnailView(final character, BuildContext context) {
    var link = (character['resourceURI']).replaceRange(0, 25, "");
    print(link);
    return FutureBuilder<dynamic>(
        future: _fetchData.characterOrStories(link),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            var characterData = snapshot.data;

            print('thumbnail: ${characterData[0]['thumbnail']['path']}');
            return CachedNetworkImage(
              imageUrl: '${characterData[0]['thumbnail']['path']}' +
                  '.' +
                  '${characterData[0]['thumbnail']['extension']}',
              //width: 80.0,
              height: 150.0,
              fit: BoxFit.cover,
            );
            //charactersView(characterData, context);
          }

          return new Center(
              // alignment: Alignment.topCenter,
              // padding: const EdgeInsets.only(top: 16.0),
              child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ));
        });
  }

  charactersList(final characters) {
    return Container(
      height: 200.0,
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: characters.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, int currentIndex) {
          return charactersView(characters[currentIndex], context);
        },
      ),
    );
  }

  charactersView(final characters, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.0)),
          color: Colors.white,
        ),
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            thumbnailView(characters, context),
            Container(
              width: 140,
              child: Text(
                '${characters['name']}',
                style: GoogleFonts.lato(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
              ),
            )
          ],
        ));
  }
}