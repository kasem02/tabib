import 'package:AlMokhtar_Clinic/app/constants/routes.dart';
import 'package:AlMokhtar_Clinic/app/manager/app_bloc.dart';
import 'package:AlMokhtar_Clinic/app/manager/app_state.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/Auth_bloc.dart';
import 'package:AlMokhtar_Clinic/widgets/app_button.dart';
import 'package:AlMokhtar_Clinic/widgets/navBarManager/nav_bar_manager.dart';
import 'package:AlMokhtar_Clinic/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppScaffold extends StatefulWidget {
  final AppNavBar? navBar;
  final List<Widget>? navBarRelatedChild;

  final Widget? child;

  const AppScaffold({this.child, this.navBar, this.navBarRelatedChild});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {

  @override
  void initState() {
    context.read<AppBloc>().onFetchUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavBarManager(),
      child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          drawer: Drawer(
            backgroundColor: Colors.white,
            child: BlocBuilder<AppBloc, AppState>(
              buildWhen: (previous, current) =>
                  current.fetchUserState != previous.fetchUserState,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    UserAccountsDrawerHeader(
                        decoration: BoxDecoration(color: Color(0xffa1d4ed)),
                        accountName: Text(state.userName),
                        accountEmail: Text(state.email)),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Color(0xffa1d4ed),
                        title: Text("الاعدادات"),
                        trailing: Icon(Icons.settings),
                        onTap: () => context.push(AppRoutes.settings.path),
                      ),
                    ),
                    Spacer(),
                    AppButton(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      icon: Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onPressed: context.read<AuthBloc>().onLogOut,
                      title: "تسجيل الخروج",
                      color: Colors.redAccent,
                    ),
                  ],
                );
              },
            ),
          ),
          backgroundColor: Colors.white,
          key: widget.key,
          body: Builder(
            builder: (context) {
              return widget.child ??
                  widget.navBarRelatedChild![Provider.of<NavBarManager>(context).index];
            },
          ),
          bottomNavigationBar: widget.navBar),
    );
  }
}
