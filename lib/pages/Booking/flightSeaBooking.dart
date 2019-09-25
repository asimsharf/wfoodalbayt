import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

class flightSeaBooking extends StatefulWidget {
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
  final String serviceImg;
  final String serviceTyp;

  flightSeaBooking({
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
    this.serviceImg,
    this.serviceTyp,
  });

  @override
  _RegisterPlayerState createState() => _RegisterPlayerState();
}

class _RegisterPlayerState extends State<flightSeaBooking> {
  final globalKey = new GlobalKey<ScaffoldState>();

  List<PlayerCenter> _PlayerCenters = PlayerCenter.getPlayerCenters();
  List<DropdownMenuItem<PlayerCenter>> _dropdownPlayerCenterMenuItems;
  PlayerCenter _selectedPlayerCenter;

  List<PlayerCity> _PlayerCity = PlayerCity.getPlayerCity();
  List<DropdownMenuItem<PlayerCity>> _dropdownPlayerCityMenuItems;
  PlayerCity _selectedPlayerCity;

  @override
  void initState() {
    super.initState();
    _dropdownPlayerCenterMenuItems =
        buildDropdownPlayerCenterMenuItems(_PlayerCenters);
    _selectedPlayerCenter = _dropdownPlayerCenterMenuItems[0].value;
    _dropdownPlayerCityMenuItems =
        buildDropdownPlayerCityMenuItems(_PlayerCity);
    _selectedPlayerCity = _dropdownPlayerCityMenuItems[0].value;
  }

  List<DropdownMenuItem<PlayerCenter>> buildDropdownPlayerCenterMenuItems(
      List playerCenters) {
    List<DropdownMenuItem<PlayerCenter>> items = List();
    for (PlayerCenter playerCenter in playerCenters) {
      items.add(
        DropdownMenuItem(
          value: playerCenter,
          child: Text(playerCenter.name),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<PlayerCity>> buildDropdownPlayerCityMenuItems(
      List playerCitys) {
    List<DropdownMenuItem<PlayerCity>> items = List();
    for (PlayerCity playerCity in playerCitys) {
      items.add(
        DropdownMenuItem(
          value: playerCity,
          child: Text(playerCity.name),
        ),
      );
    }
    return items;
  }

  TextEditingController nameController = new TextEditingController(text: "");
  TextEditingController ageController = new TextEditingController(text: "");
  TextEditingController areaController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: globalKey,
      backgroundColor: Colors.brown,
      body: new Stack(
        children: <Widget>[
          _loginContainer(),
        ],
      ),
    );
  }

  /// Login Container
  Widget _loginContainer() {
    return new Container(
      child: new ListView(
        children: <Widget>[
          new Center(
            child: new Column(
              children: <Widget>[
                _appImage(),
                _appIcon(),
                _formContainer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Image or Logo Container
  Widget _appImage() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Image.network(
        "${widget.serviceImg}",
        height: 120.0,
        width: 120.0,
      ),
    );
  }

  /// App Icon Container
  Widget _appIcon() {
    return new Container(
      margin: EdgeInsets.only(top: 5.0),
      padding: const EdgeInsets.only(top: 10.0),
      child: new Text(
        "${widget.serviceTyp}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: ArabicFonts.El_Messiri,
          fontSize: 25.0,
          package: 'google_fonts_arabic',
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  /// Form Container With all inputs fields return
  Widget _formContainer() {
    return new Container(
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
      child: new Form(
        child: new Theme(
          data: new ThemeData(primarySwatch: Colors.lightBlue),
          child: Container(
            padding: const EdgeInsets.only(left: 40.0, right: 40.0),
            child: new Column(
              children: <Widget>[
                _nameContainer(),
                _ageContainer(),
                _dropDownCenterContainer(),
                _dropDownCityContainer(),
                _areaContainer(),
                _registerButtonContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Name Container
  Widget _nameContainer() {
    return new Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: new TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Color(0xFF193096),
          ),
          labelText: "الإسم",
          labelStyle: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            color: Color(0xFF193096),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  /// Age Container
  Widget _ageContainer() {
    return new Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: new TextFormField(
        controller: ageController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.group,
            color: Color(0xFF193096),
          ),
          labelText: "العمر",
          labelStyle: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
            fontWeight: FontWeight.bold,
            color: Color(0xFF193096),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }

  /// DropDown Center Container
  Widget _dropDownCenterContainer() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
              prefixIcon: const Icon(
                Icons.filter_center_focus,
                color: Color(0xFF193096),
              ),
              labelStyle: TextStyle(
                color: Color(0xFF193096),
                fontWeight: FontWeight.bold,
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
              ),
              errorText: state.hasError ? state.errorText : null,
            ),
            child: new DropdownButtonHideUnderline(
              child: DropdownButton(
                style: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF193096),
                ),
                value: _selectedPlayerCenter,
                items: _dropdownPlayerCenterMenuItems,
                onChanged: (PlayerCenter selectedPlayerCenter) {
                  setState(() {
                    _selectedPlayerCenter = selectedPlayerCenter;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  /// City DropDown Container
  Widget _dropDownCityContainer() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
              prefixIcon: const Icon(
                Icons.location_city,
                color: Color(0xFF193096),
              ),
              labelStyle: TextStyle(
                color: Color(0xFF193096),
                fontWeight: FontWeight.bold,
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
              ),
              errorText: state.hasError ? state.errorText : null,
            ),
            child: new DropdownButtonHideUnderline(
              child: DropdownButton(
                style: TextStyle(
                  fontFamily: ArabicFonts.El_Messiri,
                  package: 'google_fonts_arabic',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF193096),
                ),
                value: _selectedPlayerCity,
                items: _dropdownPlayerCityMenuItems,
                onChanged: (PlayerCity selectedPlayerCity) {
                  setState(() {
                    _selectedPlayerCity = selectedPlayerCity;
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  /// Area Container
  Widget _areaContainer() {
    return new Container(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 5.0),
      child: new TextFormField(
          controller: areaController,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.home,
              color: Color(0xFF193096),
            ),
            labelText: "الحي",
            labelStyle: TextStyle(
              fontFamily: ArabicFonts.El_Messiri,
              package: 'google_fonts_arabic',
              fontWeight: FontWeight.bold,
              color: Color(0xFF193096),
            ),
          ),
          keyboardType: TextInputType.text),
    );
  }

  /// Register Button Container
  Widget _registerButtonContainer() {
    return new Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 10.0),
      //decoration: new BoxDecoration(color: Colors.deepOrange),
      child: new MaterialButton(
        height: 40.0,
        minWidth: 200.0,
        color: Color(0xFF193096),
        textColor: Colors.white,
        child: new Text(
          "إنشاء",
          style: TextStyle(
            fontFamily: ArabicFonts.El_Messiri,
            package: 'google_fonts_arabic',
            color: Colors.white,
          ),
        ),
        padding: EdgeInsets.all(15.0),
        onPressed: null,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white),
          borderRadius: new BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}

/// Player Center [Class]
class PlayerCenter {
  int id;
  String name;

  PlayerCenter(this.id, this.name);

  static List<PlayerCenter> getPlayerCenters() {
    return <PlayerCenter>[
      PlayerCenter(1, 'المركز الاول'),
      PlayerCenter(2, 'المركز الثاني'),
      PlayerCenter(3, 'المركز الثالث'),
      PlayerCenter(4, 'المركز الرابع'),
      PlayerCenter(5, 'المركز الخامس'),
    ];
  }
}

/// Player City [Class]
class PlayerCity {
  int id;
  String name;

  PlayerCity(this.id, this.name);

  static List<PlayerCity> getPlayerCity() {
    return <PlayerCity>[
      PlayerCity(1, 'السعودية'),
      PlayerCity(2, 'السودان'),
      PlayerCity(3, 'مصر'),
      PlayerCity(4, 'لبنان'),
      PlayerCity(5, 'نيجيريا'),
    ];
  }
}
