import 'package:flutter/material.dart';

class BannerModel {
  String text;
  List<Color> cardBackground;
  String image;

  BannerModel(this.text, this.cardBackground, this.image);
}

List<BannerModel> bannerCards = [
  new BannerModel(
      "الخدمات والاسعار",
      [
        Color(0xffa1d4ed),
        Color(0xffc0eaff),
      ],
      "assets/515.png"),




];
