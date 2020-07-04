import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mavel/CustomDesign/arcBanner.dart';
import 'package:mavel/CustomDesign/customButton.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final heroImage = Image.network(
    "https://terrigen-cdn-dev.marvel.com/content/prod/1x/008cmv_ons_mas_dsk_02.jpg",
    fit: BoxFit.fitHeight,
    height: 300.0,
  );
  final secondImage = Image.network(
      "https://terrigen-cdn-dev.marvel.com/content/prod/1x/008cmv_ons_cut_dsk_03.jpg",
      fit: BoxFit.scaleDown);

  @override
  void didChangeDependencies() {
    precacheImage(heroImage.image, context);
    precacheImage(secondImage.image, context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[Container(child: firstSpace(), color: Colors.black),
        Container(child: secondSpace(), color: Colors.white)],
      )),
    );
  }

  Widget firstSpace() {
    return Stack(
      children: <Widget>[
        ArcBannerImage(heroImage, 250.0),
        Positioned(bottom: 8.0, left: 8.0,right: 8.0,
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'CAROL DANVERS',textAlign: TextAlign.left,
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 24.0,color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'CAPTAIN MARVEL',textAlign: TextAlign.left,
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 32.0,color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Carol Danvers becomes one of the universe\'s most powerful heroes when Earth is caught in the middle of a galactic war between two alien races.',textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget secondSpace() {
    return Stack(
      children: <Widget>[
        ArcBannerImage(secondImage, 300.0),
        Positioned(bottom: 8.0, left: 8.0,right: 8.0,
          child: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 4.0),
                Text(
                  'CAPTAIN MARVEL',textAlign: TextAlign.left,
                  style: GoogleFonts.robotoCondensed(
                    fontSize: 32.0,color: Colors.black,
                    fontWeight: FontWeight.bold,letterSpacing: .5
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Near death, Carol Danvers was transformed into a powerful warrior for the Kree. Now, returning to Earth years later, she must remember her past in order to to prevent a full invasion by shapeshifting aliens, the Skrulls.',textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 14.0,color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 16.0),
                CustomButton(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
