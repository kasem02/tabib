import 'package:AlMokhtar_Clinic/app/constants/routes.dart';
import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/Auth_bloc.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/auth_state.dart';
import 'package:AlMokhtar_Clinic/widgets/app_button.dart';
import 'package:AlMokhtar_Clinic/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Builder(builder: (BuildContext context) {
        return SafeArea(
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: withEmailPassword(),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget withEmailPassword() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: Container(
                child: Image.asset(
                  'assets/vector-doc2.jpg',
                  scale: 3.5,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(bottom: 25),
              child: Text(
                'تسجيل الدخول',
                style: GoogleFonts.lato(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            AppTextField(
                controller: _emailController,
                hintText: 'البريد الالكتروني',
                textInputType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'نرجو منك ادخال البريد الالكتروني';
                  } else if (!emailValidate(value!)) {
                    return 'البريد الالكتروني غير صحيح';
                  } else {
                    return null;
                  }
                },
                onChange: (value) =>
                    context.read<AuthBloc>().onChangeUserName(value: value)),
            SizedBox(
              height: 25.0,
            ),
            AppTextField(
              hintText: 'كلمة المرور',
              //keyboardType: TextInputType.visiblePassword,
              controller: _passwordController,
              onChange: (value) =>
                  context.read<AuthBloc>().onChangePassword(value: value),
              validator: (value) {
                if (value!.isEmpty) return 'نرجو منك ادخال كلمه السر';
                return null;
              },
              isPasswordField: true,
            ),
            Container(
              padding: const EdgeInsets.only(top: 25.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: BlocBuilder<AuthBloc, AuthState>(
                  buildWhen: (previous, current) =>
                      current.loginStatus != previous.loginStatus,
                  builder: (context, state) {
                    return state.loginStatus.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : AppButton(
                            title: "تسجيل الدخول",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthBloc>().onLogin();
                              }
                            });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () => context.push(AppRoutes.registerPage.path),
              child: Text(
                "ليس لديك حساب ؟ سجل الان",
                style: TextStyle(
                    fontSize: 16, decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool emailValidate(String email) {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }
}
