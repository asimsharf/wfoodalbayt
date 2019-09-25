import 'package:flutter/material.dart';

class AppartmentBook extends StatefulWidget {
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

  AppartmentBook({
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
  _AppartmentBookState createState() => _AppartmentBookState();
}

class _AppartmentBookState extends State<AppartmentBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
