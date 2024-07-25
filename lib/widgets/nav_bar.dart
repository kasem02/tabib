import 'package:AlMokhtar_Clinic/model/gbutton_model.dart';
import 'package:AlMokhtar_Clinic/widgets/navBarManager/nav_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons_null_safety/flutter_icons_null_safety.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

class AppNavBar extends StatelessWidget {
  final List<GButtonModel> tabs;

  const AppNavBar({required this.tabs});

  @override
  Widget build(BuildContext context) {
    final int _selectedIndex = Provider.of<NavBarManager>(context).index;
    return GNav(
      curve: Curves.easeOutExpo,
      color: Colors.lightBlue,
      tabBorderRadius: 20,
      backgroundColor: Color(0xffa1d4ed),
      gap: 5,
      activeColor: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      duration: Duration(milliseconds: 300),
      tabBackgroundColor: Colors.blue.withOpacity(0.7),
      textStyle: GoogleFonts.lato(
        color: Theme.of(context).canvasColor,
      ),
      tabs: tabs.map((e) {
        if (e.index == _selectedIndex) {
          return GButton(
            icon: e.selectedIcon!,
            text: e.title,
            iconSize: 25,
          );
        }
        return GButton(
          icon: e.nonSelectedIcon,
          text: e.title,
          iconSize: 28,
        );
      }).toList(),
      selectedIndex: _selectedIndex,
      onTabChange: (index) =>  _onItemTapped(index , context),
    );
  }

  void _onItemTapped(int index , BuildContext context) {
    context.read<NavBarManager>().update(index: index);
  }
}
