import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:wfoodalbayt/Account/customviews/progress_dialog.dart';
import 'package:wfoodalbayt/Account/utils/app_futures.dart';
import 'package:wfoodalbayt/Account/utils/app_shared_preferences.dart';
import 'package:wfoodalbayt/Account/utils/constants.dart';
import 'package:wfoodalbayt/ui_widgets/SizedText.dart';

class Book extends StatefulWidget {
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

  Book({
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
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  var userName;
  var patientId;

  final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_BOOKING);

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    if (userName == null || patientId == null) {
      await initUserProfile();
    }
  }

  Future<void> initUserProfile() async {
    String name = await AppSharedPreferences.getFromSession('userName');
    String userId = await AppSharedPreferences.getFromSession('userId');

    setState(() {
      userName = name;
      patientId = userId;
    });
  }

  DateTime _date = new DateTime.now();
  TimeOfDay _time = new TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2050),
    );
    if (picked != null && picked != _date) {
      print('Date selected: ${_date.toString()}');
      setState(() {
        _date = picked;
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _time);
    if (picked != null && picked != _time) {
      print('Time selected: ${_time.toString()}');
      setState(() {
        _time = picked;
      });
    }
  }

  String _myInsuranceSelection;

  bool loading = false;

  var rating = 1.2;

  @override
  void initState() {
    super.initState();
  }

  String tryParse(double rating) {
    return rating.toString();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      body: new CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            title: Text(
              'حجز موعد في قسم ${widget.name}',
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
                          rating: 3.2,
                          size: 25,
                          color: Colors.yellow,
                          borderColor: Colors.grey,
                          starCount: 5,
                          onRatingChanged: (value) {
                            setState(() {
                              rating = value;
                            });
                          },
                        )),
                  ),
                ],
              ),
            ),
          ),
          new SliverList(
            delegate: SliverChildListDelegate(
              [
                new Padding(
                  padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                        child: Text(
                          '${widget.name}',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                          ),
                          textAlign: TextAlign.center,
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
                          '${widget.description}',
                          style: TextStyle(
                            fontFamily: ArabicFonts.El_Messiri,
                            fontSize: 14.0,
                            package: 'google_fonts_arabic',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new SliverList(
            delegate: SliverChildListDelegate(
              [
                //committee
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "الخدمات",
                          style: TextStyle(
                            color: Colors.brown,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            fontSize: EventSizedConstants.TextTitleFontSized,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: new FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 80.0, right: 80.0),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            errorText: state.hasError ? state.errorText : null,
                          ),
                          // ignore: unrelated_type_equality_checks
                          isEmpty: widget.service == '',
                          child: new DropdownButtonHideUnderline(
                            child: new DropdownButton(
                              isDense: true,
                              isExpanded: true,
                              items: widget.service.map((dynamic item) {
                                return new DropdownMenuItem(
                                  child: new Text(
                                    item['service_type'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: ArabicFonts.El_Messiri,
                                      package: 'google_fonts_arabic',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  value: item['id'].toString(),
                                );
                              }).toList(),
                              onChanged: (newVal) {
                                setState(() {
                                  _myInsuranceSelection = newVal;
                                  state.didChange(newVal);
                                });
                              },
                              value: _myInsuranceSelection,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                new SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          new SliverList(
            delegate: SliverChildListDelegate(
              [
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "الاسم ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                      Text(
                        '${userName}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "إسم الوكالة",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                      Text(
                        '${widget.name}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "اسم القسم ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                      Text(
                        '${widget.name}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "التاريخ ",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                      Text(
                        '${_date.toString().substring(0, 10)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                      new RaisedButton(
                        child: Text(
                          "إختيار",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            fontSize: EventSizedConstants.TextTitleFontSized,
                          ),
                        ),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "الوقت",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                      Text(
                        '${_time.toString().substring(10, 15)}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: ArabicFonts.El_Messiri,
                          package: 'google_fonts_arabic',
                          fontWeight: FontWeight.bold,
                          fontSize: EventSizedConstants.TextTitleFontSized,
                        ),
                      ),
                      new RaisedButton(
                        child: Text(
                          "إختيار",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: ArabicFonts.El_Messiri,
                            package: 'google_fonts_arabic',
                            fontWeight: FontWeight.bold,
                            fontSize: EventSizedConstants.TextTitleFontSized,
                          ),
                        ),
                        onPressed: () => _selectTime(context),
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
                  child: new Text("التقيمات",
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
                          ])),
                ),
              ),
            ),
            SizedBox(
              width: 2.0,
            ),
            new Expanded(
              child: new MaterialButton(
                onPressed: () => _bookingButtonAction(),
                color: Colors.brown,
                splashColor: Colors.brown[200],
                textColor: Colors.white,
                elevation: 0.2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "تأكيد الحجز",
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
                "عرض التقيمات",
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
                        rating: 3.2,
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
                        "التقييم الكلي",
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
//                  Expanded(
//                    child: loading
//                        ? Center(child: CircularProgressIndicator())
//                        : _buildRatingList(),
//                  ),
                ],
              ),
            ),
          );
        });
  }

  //Show builder for #Rating list
//  Widget _buildRatingList() {
//    Widget _ratingList;
//    if (_modelRating.length > 0) {
//      _ratingList = new ListView.builder(
//        padding: EdgeInsets.all(1.0),
//        itemExtent: 80.0,
//        shrinkWrap: true,
//        itemCount: _modelRating.length,
//        itemBuilder: (BuildContext context, index) {
//          final _ratingObj = _modelRating[index];
//          return Padding(
//            padding: const EdgeInsets.all(0.0),
//            child: new Card(
//              elevation: 0.0,
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.all(Radius.circular(5.0)),
//              ),
//              child: Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                child: Container(
//                  height: 50.0,
//                  child: Padding(
//                    padding: const EdgeInsets.all(1.0),
//                    child: Row(
//                      children: <Widget>[
//                        new Container(
//                          height: 50.0,
//                          width: 50.0,
//                          child: ClipRRect(
//                            borderRadius: BorderRadius.circular(20),
//                            child: FadeInImage.assetNetwork(
//                              fit: BoxFit.fill,
//                              placeholder: 'assets/logo.png',
//                              image:
//                                  '${_ratingObj.logo.filename}',
//                            ),
//                          ),
//                        ),
//                        new SizedBox(
//                          width: 5.0,
//                        ),
//                        new Expanded(
//                          child: Container(
//                            padding: const EdgeInsets.all(0.0),
//                            child: Padding(
//                              padding: const EdgeInsets.all(8.0),
//                              child: Column(
//                                mainAxisAlignment:
//                                    MainAxisAlignment.spaceEvenly,
//                                crossAxisAlignment: CrossAxisAlignment.start,
//                                children: <Widget>[
//                                  new Row(
//                                    children: <Widget>[
//                                      Expanded(
//                                        child: Text(
//                                          '${_ratingObj.client.first + ' ' + _ratingObj.client.last}',
//                                          overflow: TextOverflow.ellipsis,
//                                          style: TextStyle(
//                                            fontSize: 12.0,
//                                            fontWeight: FontWeight.bold,
//                                            fontFamily: ArabicFonts.El_Messiri,
//                                            package: 'google_fonts_arabic',
//                                          ),
//                                        ),
//                                      ),
//                                      Text(
//                                        'عدد التقيمات ${_ratingObj.rate.substring(0, 3)}',
//                                        style: TextStyle(
//                                          fontSize: 15.0,
//                                          color: Colors.green,
//                                          fontFamily: ArabicFonts.El_Messiri,
//                                          package: 'google_fonts_arabic',
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  new Row(
//                                    children: <Widget>[
//                                      Expanded(
//                                        child: Text(
//                                          '${_ratingObj.comment}',
//                                          style: TextStyle(
//                                            fontSize: 10.0,
//                                            color: Colors.pinkAccent,
//                                            fontFamily: ArabicFonts.El_Messiri,
//                                            package: 'google_fonts_arabic',
//                                          ),
//                                          textAlign: TextAlign.center,
//                                          overflow: TextOverflow.ellipsis,
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          );
//        },
//      );
//    } else {
//      _ratingList = Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Container(
//              child: Icon(Icons.hourglass_empty),
//            ),
//            Text(
//              "عفواَ لا توجد تقيمات حالياً",
//              style: TextStyle(
//                  fontFamily: ArabicFonts.El_Messiri,
//                  package: 'google_fonts_arabic',
//                  fontSize: 20.0,
//                  color: Colors.red,
//                  fontWeight: FontWeight.bold),
//            ),
//          ],
//        ),
//      );
//    }
//    return _ratingList;
//  }

//------------------------------------------------------------------------------
  Future _bookingButtonAction() async {
    var now = new DateTime.now();
    var now_year = now.year;
    var now_month = now.month;
    var now_day = now.day;
    var now_hour = now.hour;
    var now_minutes = now.minute;

    var givenTime = DateTime.parse(_date.toString());
    var givenTime_year = givenTime.year;
    var givenTime_month = givenTime.month;
    var givenTime_day = givenTime.day;
    var givenTime_hour = _time.hour;
    var givenTime_minutes = _time.minute;

    var flag = true;
    var message = '';

    if (givenTime_year < now_year) {
      flag = false;

      message += 'عفوا سنة ماضية';
      message += 'المعطى ${givenTime_year} الحالي  ${now_year}';
    }
    if (givenTime_month < now_month) {
      flag = false;
      message += ' عفوا شهر سابق';
      message += 'المعطى ${givenTime_month} الحالي  ${now_month}';
    }
    if (givenTime_day < now_day) {
      flag = false;
      message += ' عفوا يوم سابق';
      message += 'المعطى ${givenTime_day} الحالي  ${now_day}';
    }
    if (givenTime_hour < now_hour) {
      flag = false;
      message += '  عفوا ساعة سابقة';
      message += 'المعطى ${givenTime_hour} الحالي  ${now_hour}';
    }
    if (givenTime_minutes < now_minutes) {
      flag = false;
      message += ' عفوا دقائق سابقة ';
      message += 'المعطى ${givenTime_minutes} الحالي  ${now_minutes}';
    }
//    bool warn = _date.isBefore(now);
    if (!flag) {
      setState(
        () {
          globalKey.currentState.showSnackBar(
            new SnackBar(
              content: new Text(
                'لقد قمت باختيار تاريخ او وقت سابق',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    } else {
      FocusScope.of(context).requestFocus(
        new FocusNode(),
      );
      String str = _date.toString().substring(0, 10) +
          ' ' +
          _time.toString().substring(10, 15);
      print('##############@@@@@@@@ str ' + str.toString());
      var eventObject = await patientAppointment(
          widget.name, widget.name, patientId, _myInsuranceSelection, str);

      switch (eventObject.id) {
        case 1:
          {
            setState(
              () {
                globalKey.currentState.showSnackBar(
                  new SnackBar(
                    content: new Text(
                      'تم الحجز بنجاح ',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: ArabicFonts.El_Messiri,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.blueAccent,
                  ),
                );
              },
            );
          }
          break;
        case 2:
          {
            setState(
              () {
                globalKey.currentState.showSnackBar(
                  new SnackBar(
                    content: new Text(
                      'عفواً لم تتم عملية الحجز',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: ArabicFonts.El_Messiri,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          }
          break;
        case 0:
          {
            setState(
              () {
                globalKey.currentState.showSnackBar(
                  new SnackBar(
                    content: new Text(
                      'عفواً هنالك خظأ في النظام يرجى المحاولة مرة اخرى',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: ArabicFonts.El_Messiri,
                        package: 'google_fonts_arabic',
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              },
            );
          }
          break;
      }
    }
  }
}
