import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:AlMokhtar_Clinic/extensions/context_extensions.dart';
import 'package:AlMokhtar_Clinic/features/login/data/auth_data_source.dart';
import 'package:AlMokhtar_Clinic/features/login/data/model/user_model.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/Auth_bloc.dart';
import 'package:AlMokhtar_Clinic/features/login/manager/auth_state.dart';
import 'package:AlMokhtar_Clinic/widgets/app_button.dart';
import 'package:AlMokhtar_Clinic/widgets/app_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl ;

class UserRegisterPage extends StatelessWidget {
  UserRegisterPage();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  final TextEditingController _birthdate = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  String _userType = "doctor";


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(loginDataSource: AuthDataSource()),
      child: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            previous.registerState != current.registerState,
        listener: (context, state) {
          switch (state.registerState) {
            case AppStatus.Loading:
              context.showLoadingDialog();
              break;
            case AppStatus.Failure:
              context.pop();
              context.showFailureAlert(message: "حدث خطأ عند تسجيل المستخدم");
              break;
            case AppStatus.Success:
              context.pop();
              context.pop();
              context.showSuccessAlert(message: "تم تسجيل المستخدم بنجاح");
              break;
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Column(
                  children: [
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
                        'التسجيل',
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
                      onChange: (p0) {},
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                      hintText: 'كلمة المرور',
                      //keyboardType: TextInputType.visiblePassword,
                      controller: _passwordController,
                      onChange: (p0) {},
                      validator: (value) {
                        if (value!.isEmpty) return 'نرجو منك ادخال كلمه السر';
                        return null;
                      },
                      isPasswordField: true,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل وصف صجيح";
                          }
                          return null;
                        },
                        controller: _bio,
                        hintText: 'الوصف',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        prefixIcon: Icon(Icons.calendar_month),
                        onTap: () => showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1930),
                                    lastDate: DateTime(2026))
                                .then((value) {
                              _birthdate.text = intl.DateFormat('yyyy-MM-dd').format(value!) ;
                            }),
                        controller: _birthdate,
                        hintText: 'تاريخ الميلاد',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل المدينة صجيح";
                          }
                          return null;
                        },
                        controller: _city,
                        hintText: 'المدينة',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل اسم صحيح";
                          }
                          return null;
                        },
                        controller: _name,
                        hintText: 'الاسم',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       StatefulBuilder(
                    //         builder: (context , setState) {
                    //           return DropdownButton<String>(
                    //             alignment: Alignment.centerRight,
                    //             value: _userType,
                    //             items: ["doctor", "patient",]
                    //                 .map<DropdownMenuItem<String>>(
                    //                     (e) => DropdownMenuItem<String>(child: Text(e) , value: e,))
                    //                 .toList(),
                    //             onChanged: (value) {
                    //               setState((){
                    //                 _userType = value!;
                    //               }) ;
                    //             },
                    //           );
                    //         }
                    //       ),
                    //       SizedBox(width: 15,) ,
                    //       Text("نوع المستخدم" , style: TextStyle(fontSize: 14),) ,
                    //
                    //     ],
                    //   ),
                    // ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل رقم هاتف صحيح";
                          }
                          return null;
                        },
                        controller: _phone,
                        hintText: 'رقم الهاتف',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: BlocBuilder<AuthBloc, AuthState>(
                          buildWhen: (previous, current) =>
                              current.registerState != previous.registerState,
                          builder: (context, state) {
                            return state.registerState.isLoading
                                ? Center(child: CircularProgressIndicator())
                                : AppButton(
                                    title: "التسجيل",
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.read<AuthBloc>().onRegisterUser(
                                            user: UserModel(
                                                birthDate: _birthdate.text,
                                                password:
                                                    _passwordController.text,
                                                name: _name.text,
                                                email: _emailController.text,
                                                bio: _bio.text,
                                                userType: "patient",
                                                phone: _phone.text,
                                                city: _city.text));
                                      }
                                    });
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
