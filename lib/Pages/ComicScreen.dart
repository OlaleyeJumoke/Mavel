import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mavel/Network/ApiLinks.dart';
import 'package:mavel/Network/ApiModel.dart';

import 'DetailFlow.dart';

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
      body: comicList(),
    );
  }

  comicList() {
    var data = _fetchData.comic('/v1/public/comics');
    print(data);
    return FutureBuilder<List<ComicIssue>>(
        future: _fetchData.comic('/v1/public/comics'),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            List<ComicIssue> comicData = snapshot.data;
                          return new CustomComicView(comicData);
            
          }

          return new Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 16.0),
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ));
        });
  }

}
class CustomComicView extends StatelessWidget {
  final List<ComicIssue> comicIssueData;

  CustomComicView(this.comicIssueData);

//git push origin master
  Widget build(context) {
    return ListView.builder(
      physics: ClampingScrollPhysics(),
      shrinkWrap: true,
      itemCount: comicIssueData.length,
      itemBuilder: (context, int currentIndex) {
        return createItemView(comicIssueData[currentIndex], context);
      },
    );
  }

  Widget createItemView(
    ComicIssue comicIssueData,
    BuildContext context,
  ) {
    //print(comicIssueData.date[0]['date']);
    return Container(
        margin: EdgeInsets.only(left: 0.0, right: 0.0, top: 0.0, bottom: 0.0),
        child: ListTile(
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  comicIssueData.images.length == 0
                      ? new Container(
                          height: 60.0,
                          width: 60.0,
                          decoration: new BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                              borderRadius: new BorderRadius.all(
                                const Radius.circular(30.0),
                              )),
                          child: CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.white,
                            child: new Icon(
                              Icons.person,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      : new ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: CachedNetworkImage(
                            imageUrl: '${comicIssueData.images[0]['path']}' +
                                '.' +
                                '${comicIssueData.images[0]['extension']}',
                            //"${comicIssueData.image}",
                            width: 60.0,
                            height: 60.0, fit: BoxFit.cover,
                          ),
                        ),
                  SizedBox(
                    width: 4.0,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${comicIssueData.title}',
                        maxLines: 1,
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                      Text(
                        comicIssueData.date[0]['date'].replaceRange(10, 24, ""),
                        style: GoogleFonts.robotoCondensed(
                            color: Colors.black87,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  )),
                ],
              ),
            ),
            onTap: () {
              var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new DetailFlow(
                      image: comicIssueData.images.length == 0 ? '':
                      '${comicIssueData.images[0]['path']}' +
                          '.' +
                          '${comicIssueData.images[0]['extension']}',
                      issueNumber: comicIssueData.ups,
                      title: comicIssueData.title,
                      description: comicIssueData.description,
                      ups: comicIssueData.ups,
                      format: comicIssueData.format,
                      //series: comicIssueData.s,
                      date: comicIssueData.date,
                      prices: comicIssueData.prices,
                      images: comicIssueData.images,
                      creators: comicIssueData.creators,
                      characters: comicIssueData.characters,
                      stories: comicIssueData.stories,
                      events: comicIssueData.events));
              Navigator.of(context).push(route);
            }));
  }
}