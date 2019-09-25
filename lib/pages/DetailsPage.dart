import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';
import 'package:wfoodalbayt/pages/Booking/Book.dart';
import 'package:wfoodalbayt/pages/Booking/TripsBook.dart';
import 'package:wfoodalbayt/pages/Booking/appartmentBook.dart';
import 'package:wfoodalbayt/pages/Booking/flightSeaBooking.dart';
import 'package:wfoodalbayt/pages/Booking/hotelBooking.dart';
import 'package:wfoodalbayt/pages/Rating.dart';
import 'package:wfoodalbayt/ui_widgets/SizedText.dart';

class DetailsPage extends StatefulWidget {
  final int id;
  final int fieldId;
  final String field;
  final int cityId;
  final String cityName;
  final String name;
  final String description;
  final String addressText;
  final String latitude;
  final String longitude;
  final List service;
  final List review;
  final double rating;
  final String profileImg;
  final int isActive;

  DetailsPage({
    this.id,
    this.fieldId,
    this.field,
    this.cityId,
    this.cityName,
    this.name,
    this.description,
    this.addressText,
    this.latitude,
    this.longitude,
    this.service,
    this.review,
    this.rating,
    this.profileImg,
    this.isActive,
  });

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  bool loading = false;

  @override
  initState() {
    super.initState();
    setState(
      () {
        _goToMaps();
        setState(
          () {
            loading = true;
          },
        );
      },
    );
  }

  double tryParse(String rating) {
    return double.parse(rating);
  }

  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition = CameraPosition(target: LatLng(0, -0));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _goToMaps() async {
    double lat =
        double.parse("${widget.latitude == null ? 0.0 : widget.latitude}");
    double long =
        double.parse("${widget.longitude == null ? 0.0 : widget.longitude}");
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(
      () {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: MarkerId("${widget.id}"),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: '${widget.description}', snippet: '${widget.name}'),
            icon: BitmapDescriptor.defaultMarker,
          ),
        );
      },
    );
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  var rating = 1.2;

  List getServiceList(List str) {
    List<String> _listOfServiceType = [];
    for (var i = 0; i < str.length; i++) {
      _listOfServiceType.add(str[i]['service_type']);
    }
    return _listOfServiceType;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            title: Text(
              '${widget.name}',
              overflow: TextOverflow.ellipsis,
              style: new TextStyle(
                fontSize: EventSizedConstants.TextappBarSize,
                fontWeight: FontWeight.bold,
                fontFamily: ArabicFonts.El_Messiri,
                package: 'google_fonts_arabic',
                color: Colors.white,
                shadows: <Shadow>[
                  new Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 3.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  new Shadow(
                    offset: Offset(3.0, 3.0),
                    blurRadius: 8.0,
                    color: Color.fromARGB(125, 0, 0, 255),
                  ),
                ],
              ),
            ),
            centerTitle: true,
            pinned: true,
            floating: false,
            expandedHeight: 256,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/logo.png',
                    image: '${widget.profileImg}',
                  ),
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: <Color>[Colors.black54, Color(0x00000000)],
                          stops: [0.0, 2.0],
                          begin: FractionalOffset.bottomCenter,
                          end: FractionalOffset.topCenter,
                          tileMode: TileMode.mirror),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 0.9],
                          colors: [
                            Colors.white10,
                            Colors.white12,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      //color: Color.fromRGBO(255, 255, 255, 0.5),
                      child: SmoothStarRating(
                        rating: widget.rating,
                        size: 25,
                        color: Colors.yellow,
                        borderColor: Colors.grey,
                        starCount: 5,
                        onRatingChanged: (value) {
                          setState(
                            () {
                              rating = value;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: SliverChildListDelegate(
              [
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                        child: Text(
                          '${widget.name}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                      ),
                      new FlatButton(
                        onPressed: _handleTapEventRating,
                        child: new Text(
                          "إضافة تقييم",
                          style: TextStyle(
                              fontFamily: ArabicFonts.El_Messiri,
                              package: 'google_fonts_arabic',
                              color: Color(0xFFE91E63),
                              fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                //address
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'العنوان',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            fontSize: EventSizedConstants.TextTitleFontSized,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 12.0,
                      ),
                      Expanded(
                        child: Text(
                          '${widget.addressText}',
                          style: TextStyle(
                            fontFamily: ArabicFonts.El_Messiri,
                            fontSize: 10.0,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //descriptions
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "الوصف",
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            fontSize: EventSizedConstants.TextTitleFontSized,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "${widget.description}",
                          style: TextStyle(
                              fontFamily: ArabicFonts.El_Messiri,
                              package: 'google_fonts_arabic',
                              fontSize: 10.0),
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'المجال والخدمات',
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //committee
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "${widget.field}",
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            fontSize: EventSizedConstants.TextTitleFontSized,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    spacing: 3.0,
                    runSpacing: 0.0,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    children: widget.service
                        .map(
                          (service) => InkWell(
                            onTap: () {
                              _tappedCategoryCell(
                                widget.fieldId.toString(),
                                service['id'].toString(),
                                service['img'].toString(),
                                service['service_type'].toString(),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              padding: EdgeInsets.all(5.0),
                              width: 100.0,
                              height: 110.0,
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                    service['img'],
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    service['service_type'],
                                    style: TextStyle(
                                      fontFamily: ArabicFonts.El_Messiri,
                                      package: 'google_fonts_arabic',
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                new SizedBox(
                  width: 5.0,
                ),
                //map
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'الموقع',
                          style: TextStyle(
                            color: Colors.lightBlueAccent,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            fontSize: EventSizedConstants.TextTitleFontSized,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new SizedBox(
                  width: 2.0,
                ),
                new Container(
                  height: 400.0,
                  child: new Stack(
                    children: <Widget>[
                      new GoogleMap(
                        markers: _markers,
                        mapType: _defaultMapType,
                        myLocationEnabled: true,
                        initialCameraPosition: _initialPosition,
                        onMapCreated: _onMapCreated,
                        zoomGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        compassEnabled: true,
                        tiltGesturesEnabled: true,
                        rotateGesturesEnabled: true,
                      ),
                      new Container(
                        margin: EdgeInsets.only(top: 80, right: 10),
                        alignment: Alignment.topRight,
                        child: Column(
                          children: <Widget>[
                            FloatingActionButton(
                                child: Icon(Icons.layers),
                                elevation: 5,
                                backgroundColor: Colors.teal[200],
                                onPressed: () {
                                  _changeMapType();
                                  print('Changing the Map Type');
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            new Expanded(
              child: new MaterialButton(
                onPressed: _showModalSheet,
                color: Colors.brown,
                splashColor: Colors.brown[200],
                textColor: Colors.white,
                elevation: 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "التقيمات",
                    style: TextStyle(
                      fontFamily: ArabicFonts.El_Messiri,
                      package: 'google_fonts_arabic',
                      fontSize: EventSizedConstants.TextButtonFontSized,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: <Shadow>[
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 3.0,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        Shadow(
                          offset: Offset(3.0, 3.0),
                          blurRadius: 8.0,
                          color: Color.fromARGB(125, 0, 0, 255),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _tappedCategoryCell(String subfieldId, String serviceId,
      String serviceImg, String serviceTyp) {
    switch ('$serviceId') {
      case '1': //flightSeaBooking.dart
        /// Booking for flight
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => flightSeaBooking(
              id: widget.id,
              fieldId: widget.fieldId,
              field: widget.field,
              cityId: widget.cityId,
              cityName: widget.cityName,
              name: widget.name,
              description: widget.description,
              addressText: widget.addressText,
              latitude: widget.latitude,
              longitude: widget.longitude,
              service: widget.service,
              review: widget.review,
              rating: widget.rating,
              profileImg: widget.profileImg,
              isActive: widget.isActive,
              serviceImg: serviceImg,
              serviceTyp: serviceTyp,
            ),
          ),
        );
        break;
      case '2': //SeeBooking
        /// Booking for sea
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => flightSeaBooking(
              id: widget.id,
              fieldId: widget.fieldId,
              field: widget.field,
              cityId: widget.cityId,
              cityName: widget.cityName,
              name: widget.name,
              description: widget.description,
              addressText: widget.addressText,
              latitude: widget.latitude,
              longitude: widget.longitude,
              service: widget.service,
              review: widget.review,
              rating: widget.rating,
              profileImg: widget.profileImg,
              isActive: widget.isActive,
            ),
          ),
        );
        break;
      case '3':

        /// Rental Car Booking
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Book(
              id: widget.id,
              fieldId: widget.fieldId,
              field: widget.field,
              cityId: widget.cityId,
              cityName: widget.cityName,
              name: widget.name,
              description: widget.description,
              addressText: widget.addressText,
              latitude: widget.latitude,
              longitude: widget.longitude,
              service: widget.service,
              review: widget.review,
              rating: widget.rating,
              profileImg: widget.profileImg,
              isActive: widget.isActive,
            ),
          ),
        );
        break;
      case '4':

        /// Hotel Booking
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HotelBooking(
              id: widget.id,
              fieldId: widget.fieldId,
              field: widget.field,
              cityId: widget.cityId,
              cityName: widget.cityName,
              name: widget.name,
              description: widget.description,
              addressText: widget.addressText,
              latitude: widget.latitude,
              longitude: widget.longitude,
              service: widget.service,
              review: widget.review,
              rating: widget.rating,
              profileImg: widget.profileImg,
              isActive: widget.isActive,
            ),
          ),
        );
        break;
      case '5':

        /// Appartment Book
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AppartmentBook(
              id: widget.id,
              fieldId: widget.fieldId,
              field: widget.field,
              cityId: widget.cityId,
              cityName: widget.cityName,
              name: widget.name,
              description: widget.description,
              addressText: widget.addressText,
              latitude: widget.latitude,
              longitude: widget.longitude,
              service: widget.service,
              review: widget.review,
              rating: widget.rating,
              profileImg: widget.profileImg,
              isActive: widget.isActive,
            ),
          ),
        );
        break;
      case '6':

        /// Trips Booking
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TripsBook(
              id: widget.id,
              fieldId: widget.fieldId,
              field: widget.field,
              cityId: widget.cityId,
              cityName: widget.cityName,
              name: widget.name,
              description: widget.description,
              addressText: widget.addressText,
              latitude: widget.latitude,
              longitude: widget.longitude,
              service: widget.service,
              review: widget.review,
              rating: widget.rating,
              profileImg: widget.profileImg,
              isActive: widget.isActive,
            ),
          ),
        );
        break;
      case '7':
        //خدمات افراد
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Book(
              id: widget.id,
              fieldId: widget.fieldId,
              field: widget.field,
              cityId: widget.cityId,
              cityName: widget.cityName,
              name: widget.name,
              description: widget.description,
              addressText: widget.addressText,
              latitude: widget.latitude,
              longitude: widget.longitude,
              service: widget.service,
              review: widget.review,
              rating: widget.rating,
              profileImg: widget.profileImg,
              isActive: widget.isActive,
            ),
          ),
        );
        break;
    }
  }

  //Show Modal Sheet that Display all the #Rating about specific Fields
  void _showModalSheet() {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "التقيمات",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: ArabicFonts.El_Messiri,
                  color: Colors.white,
                  package: 'google_fonts_arabic',
                  fontSize: EventSizedConstants.TextappBarSize,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 3.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    Shadow(
                      offset: Offset(3.0, 3.0),
                      blurRadius: 8.0,
                      color: Color.fromARGB(125, 0, 0, 255),
                    ),
                  ]),
            ),
          ),
          body: new Container(
            padding: EdgeInsets.only(top: 5.0, bottom: 3.0),
            color: Colors.white,
            child: Column(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SmoothStarRating(
                      rating: widget.rating,
                      size: 30,
                      color: Colors.yellow,
                      borderColor: Colors.grey,
                      starCount: 5,
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'التقييم الكلي',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: ArabicFonts.El_Messiri,
                        package: 'google_fonts_arabic',
                      ),
                    ),
                  ],
                ),
                Expanded(child: _buildRatingList()),
              ],
            ),
          ),
        );
      },
    );
  }

  /*
   *  here I just make Widget name it _buildRatingList
   *  to to fetch all the ratting and loop inside it
   */
  Widget _buildRatingList() {
    Widget _ratingList;

    if (widget.review.length > 0) {
      _ratingList = new ListView.builder(
        padding: EdgeInsets.all(1.0),
        itemExtent: 80.0,
        shrinkWrap: true,
        itemCount: widget.review.length,
        itemBuilder: (BuildContext context, index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Card(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Container(
                  height: 50.0,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Row(
                      children: <Widget>[
                        new Container(
                          height: 50.0,
                          width: 50.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage.assetNetwork(
                              fit: BoxFit.fill,
                              placeholder: 'assets/logo.png',
                              image: '${widget.review[0]['image']}',
                            ),
                          ),
                        ),
                        new SizedBox(
                          width: 5.0,
                        ),
                        new Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(0.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '${widget.review[0]['reviewer']}',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: ArabicFonts.El_Messiri,
                                            package: 'google_fonts_arabic',
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'عدد التقيمات',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.green,
                                          fontFamily: ArabicFonts.El_Messiri,
                                          package: 'google_fonts_arabic',
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '${widget.review[0]['star']}',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.red,
                                          fontFamily: ArabicFonts.El_Messiri,
                                          package: 'google_fonts_arabic',
                                        ),
                                      ),
                                    ],
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                          '${widget.review[0]['review']}',
                                          style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.pinkAccent,
                                            fontFamily: ArabicFonts.El_Messiri,
                                            package: 'google_fonts_arabic',
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${widget.review[0]['created_at'].toString().substring(0, 10)}',
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 8.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: ArabicFonts.El_Messiri,
                                      package: 'google_fonts_arabic',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    } else {
      _ratingList = Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Icon(Icons.hourglass_empty),
            ),
            Text(
              'عفواً لا توجد تقيمات الان!',
              style: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontSize: 20.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }
    return _ratingList;
  }

  void _handleTapEventRating() async {
    bool isLoggedIn = await AppSharedPreferences.isUserLoggedIn();
    if (this.mounted) {
      setState(
        () {
          if (isLoggedIn != null && isLoggedIn) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Rating(
                  id: widget.id,
                  fieldId: widget.fieldId,
                  name: widget.name,
                  profileImg: widget.profileImg,
                  rating: widget.rating,
                ),
              ),
            );
          } else {
            Navigator.pushNamed(context, '/SplashLogin');
          }
        },
      );
    }
  }
}

class MyButton extends StatelessWidget {
  final text;

  MyButton(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      child: OutlineButton(
        padding: EdgeInsets.all(0.0),
        borderSide: BorderSide(color: Colors.brown, style: BorderStyle.solid),
        disabledBorderColor: Colors.grey,
        highlightedBorderColor: Colors.brown,
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontSize: 8.0,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
