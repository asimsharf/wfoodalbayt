import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class callCenter extends StatefulWidget {
  @override
  _callCenterState createState() => _callCenterState();
}

class _callCenterState extends State<callCenter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "مركز الإتصال والدعم الفني",
          style: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/icon/girlcallcenter.png",
                height: 175.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 14.0),
                child: Text(
                  "تسرنا خدمتكم أي وقت!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 5.0, right: 20.0, left: 20.0),
                child: Text(
                  "إذا كانت هنالك اي مشكلة مع التطبيق يمكنك مراسلتنا...",
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontFamily: ArabicFonts.El_Messiri,
                    package: 'google_fonts_arabic',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: InkWell(
                  onTap: () {
//                Navigator.of(context).push(PageRouteBuilder(
//                    pageBuilder: (_, __, ___) => new chatItem()));
                  },
                  child: Center(
                    child: Container(
                      height: 50.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        color: Colors.brown,
                        borderRadius: BorderRadius.all(
                          Radius.circular(25.0),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "راسلنا الأن",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.0,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
