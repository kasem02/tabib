

import 'package:flutter/cupertino.dart';

class NavBarManager extends ChangeNotifier {

  int index = 0 ;

  void update({required int index}){
    this.index = index ;
    notifyListeners() ;
  }
}