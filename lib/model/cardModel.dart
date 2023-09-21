import 'package:flutter/material.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

class CardModel {
  String doctor;
  int cardBackground;
  var cardIcon;

  CardModel(this.doctor, this.cardBackground, this.cardIcon);
}

List<CardModel> cards6 = [
  new CardModel("طبيب قلب", 0xFFec407a, FlutterIcons.heart_ant),


];

List<CardModel> cards = [
  CardModel("طبيب قلب", 0xFFec407a, Icons.favorite),
  CardModel("طبيب اسنان", 0xFF5c6bc0, FlutterIcons.tooth_mco),
  CardModel("طبيب عيون", 0xFFfbc02d, Icons.remove_red_eye),
  CardModel("طباء عظام", 0xFF1565C0, Icons.healing),
  CardModel("اطباء الأطفال", 0xFF2E7D32, Icons.child_care),
  CardModel("طبيب اذن وانف وحنجرة", 0xFF000000, Icons.hearing),
  CardModel("طبيب جلدية", 0xFF000000, Icons.grain),
  CardModel("طبيب غدد صماء", 0xFF000000, Icons.trending_up),
  CardModel("طبيب المخ والأعصاب", 0xFF000000, Icons.healing),
  CardModel("جهاز U/S", 0xFF000000, Icons.computer),
  CardModel("طبيب امراض باطنة", 0xFF000000, Icons.local_pharmacy),
  CardModel("طبيب امراض صدرية", 0xFF000000, Icons.sick),
  CardModel("طبيب جراحة اليد والأطراف", 0xFF000000, Icons.healing),
  CardModel("طبيب امراض الدم والأورام", 0xFF000000, Icons.opacity),
  CardModel("طبيب تغذية صحية", 0xFF000000, Icons.fastfood),
  CardModel("طبيب نساء وولادة", 0xFF000000, Icons.pregnant_woman),
  CardModel("طبيب باطنة", 0xFF000000, Icons.assignment),
  CardModel("طبيب اطفال", 0xFF000000, Icons.child_friendly),
  CardModel("طبيب عام", 0xFF000000, Icons.vaccines),
  CardModel("طبيب أسنان", 0xFF000000, FlutterIcons.teeth_faw5s),
  CardModel("طبيب جراح", 0xFF000000, Icons.vaccines),
  CardModel("أخصائي نساء وتوليد", 0xFF000000, Icons.vaccines),
  CardModel("أخصائي أمراض جلدية", 0xFF000000, Icons.vaccines),
];
