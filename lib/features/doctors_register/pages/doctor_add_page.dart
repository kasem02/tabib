import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:AlMokhtar_Clinic/extensions/context_extensions.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/data/doctor_model.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/data/doctors_register_local_data_source.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/manager/doctors_register_bloc.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/manager/doctors_register_state.dart';
import 'package:AlMokhtar_Clinic/widgets/app_button.dart';
import 'package:AlMokhtar_Clinic/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DoctorAddPage extends StatelessWidget {
  DoctorAddPage();

  final TextEditingController _phone = TextEditingController();

  final TextEditingController _description = TextEditingController();

  final TextEditingController _period = TextEditingController();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _mail = TextEditingController();
  final TextEditingController _specialties = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DoctorsRegisterBloc(localDataSource: DoctorsRegisterDataSource()),
      child: BlocListener<DoctorsRegisterBloc, DoctorsRegisterState>(
        listenWhen: (previous, current) =>
            current.addState != previous.addState,
        listener: (context, state) {
          switch (state.addState) {
            case AppStatus.Loading:
              context.showLoadingDialog();
              break;
            case AppStatus.Failure:
              context.pop();
              context.showFailureAlert();
              break;
            case AppStatus.Success:
              context.pop(2);
              context.showSuccessAlert();
              break;
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text("إضافة طبيب"),
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(20).copyWith(top: 40),
                child: Column(
                  children: [
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل اسم صجيح";
                          }
                          return null;
                        },
                        controller: _name,
                        hintText: 'الاسم',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل رقم هاتف صجيح";
                          }
                          return null;
                        },
                        controller: _phone,
                        hintText: 'رقم الهاتف',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل بريد صجيح";
                          }
                          return null;
                        },
                        controller: _mail,
                        hintText: 'بريد الكتروني',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل وصف صحيح صجيح";
                          }
                          return null;
                        },
                        controller: _description,
                        hintText: 'الوصف',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل تخصص صجيح";
                          }
                          return null;
                        },
                        controller: _specialties,
                        hintText: 'التخصص',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    AppTextField(
                        validator: (p0) {
                          if (p0 == null || p0.isEmpty) {
                            return "ادخل فترة صجيحة";
                          }
                          return null;
                        },
                        controller: _period,
                        hintText: 'الفترة',
                        onChange: (text) {}),
                    SizedBox(
                      height: 10,
                    ),
                    Builder(
                      builder: (context) {
                        return AppButton(
                            title: "تسجيل",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.showConfirmDialog(
                                    message: "هل أنت متأكد؟",
                                    onConfirm: () => context
                                        .read<DoctorsRegisterBloc>()
                                        .onAddDoctor(
                                            doctor: DoctorModel(
                                                period: _period.text,
                                                description: _description.text,
                                                mail: _mail.text,
                                                image: "",
                                                phone: _phone.text,
                                                type: _specialties.text,
                                                name: _name.text)));
                              }
                            });
                      }
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
