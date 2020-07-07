import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mavel/Network/ApiLinks.dart';
import 'package:mavel/Network/ApiModel.dart';

class ComicIssues extends StatefulWidget {
  @override
  _ComicIssuesState createState() => _ComicIssuesState();
}

class _ComicIssuesState extends State<ComicIssues> {
  bool _isSearching;
  String _searchText = "";

  Icon searchAction = new Icon(Icons.search);
 Widget appBarTitle = new Text("Mavel");

 
  final TextEditingController _searchTerm = new TextEditingController();
    FetchData _fetchData;
  @override
  void initState() {
    _fetchData = FetchData();
    _isSearching = false;
    super.initState();
  }
  



  void _handleSearchEnd() {
    setState(() {
      this.searchAction = new Icon(Icons.search, color: Colors.white,);
      this.appBarTitle =
      new Text(" Mavel ", style: new TextStyle(color: Colors.white),);
      _isSearching = false;
      _searchTerm.clear();
    });
  }

  _ComicIssuesState() {
    _searchTerm.addListener(() {
      if (_searchTerm.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      }
      else {
        setState(() {
          _isSearching = true;
          _searchText = _searchTerm.text;
        });
      }
    });
  }



  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: new AppBar(
          title: Text('Mavel'),
          elevation: 4.0,
          actions: <Widget>[new IconButton(icon: searchAction, onPressed: () {
            setState(() {
              if (this.searchAction.icon == Icons.search) {
                this.searchAction =
                new Icon(Icons.close, color: Colors.white, size: 24.0);
                this.appBarTitle = new TextField(style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w300,), controller: _searchTerm,
                  decoration: new InputDecoration(prefixIcon: new Icon(
                      Icons.search, color: Colors.white, size: 24.0),
                      hintText: "Search...",
                      border: UnderlineInputBorder(borderSide: new BorderSide(
                          color: Colors.white,
                          width: 2.0,
                          style: BorderStyle.solid), borderRadius:
                      const BorderRadius.all(const Radius.circular(8.0)),),
                      hintStyle: TextStyle(color: Colors.white,
                          fontSize: 16.0)), /*onChanged: (_)*/);
                _handleSearchStart();
              }
              else {
                _handleSearchEnd();
              }
            });
          })
          ],

    ),
    body: comicList(),
    );
  }
  comicList() {
    var data = _fetchData.comicIssue();
    print(data);
    return FutureBuilder<List<ComicIssue>>(
        future: _fetchData.comicIssue(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          print('SnapShot: ${snapshot.data}');
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            print('SnapShot1: ${snapshot.data}');
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
                            imageUrl: '${comicIssueData.images[0]['path']}'+'.'+'${comicIssueData.images[0]['extension']}',
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
                        style: GoogleFonts.robotoCondensed
                        (
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
            onTap: () {}
            // var route = new MaterialPageRoute(
            //     builder: (BuildContext context) =>
            // new UserProfile(
            //     isNetworkConnected: isNetworkConnected,
            //     name: uCommentData.name,
            //     uniqueId: uCommentData.uniqueId,
            //     username: uCommentData.username,
            //     email: uCommentData.email,
            //     profilePicture: uCommentData.userProfilePix,
            //     motto: uCommentData.motto,
            //     category: uCommentData.category,
            //     startTime: uCommentData.openingTime,
            //     endTime: uCommentData.closingTime,
            //     number: uCommentData.number,
            //     address: uCommentData.address,
            // ),
            //     );
            //     Navigator.of(context).push(route);
            // }),
            ));
  }


}