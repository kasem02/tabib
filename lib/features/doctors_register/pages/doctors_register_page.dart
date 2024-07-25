import 'package:AlMokhtar_Clinic/app/constants/routes.dart';
import 'package:AlMokhtar_Clinic/app_status.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/data/doctors_register_local_data_source.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/manager/doctors_register_bloc.dart';
import 'package:AlMokhtar_Clinic/features/doctors_register/manager/doctors_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DoctorsRegisterPage extends StatelessWidget {
  const DoctorsRegisterPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DoctorsRegisterBloc(localDataSource: DoctorsRegisterDataSource())
            ..onFetchDoctors(),
      child: BlocBuilder<DoctorsRegisterBloc, DoctorsRegisterState>(
        buildWhen: (previous, current) =>
            current.fetchState != previous.fetchState,
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                context.push(AppRoutes.doctorAddPage.path);
              },
            ),
            body: Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Container(
                color: Colors.white,
                child: state.fetchState.isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : SingleChildScrollView(
                        child: Column(
                          children: state.doctors.map((e) {
                            return ListTile(
                              leading: Image.network(e.image),
                              title: Text(e.name),
                              subtitle: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(e.description),
                                  Text(e.phone),
                                ],
                              ),
                              trailing: Text(e.period),
                            );
                          }).toList(),
                        ),
                      ),
              ),
            ),
          );
        },
      ),
    );
  }
}
