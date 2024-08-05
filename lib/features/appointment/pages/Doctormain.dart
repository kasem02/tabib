import 'package:AlMokhtar_Clinic/features/appointment/data/appointments_data_source.dart';
import 'package:AlMokhtar_Clinic/features/appointment/manager/appoinents_bloc.dart';
import 'package:AlMokhtar_Clinic/features/appointment/manager/appointments_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'doctorCancledappointment.dart';
import 'doctorapprovedApoinemt.dart';
import 'mydoctorappoinment.dart';

class DoctorMain extends StatefulWidget {
  const DoctorMain({Key? key}) : super(key: key);

  @override
  State<DoctorMain> createState() => _DoctorMainState();
}

class _DoctorMainState extends State<DoctorMain> {
  final RefreshController _controller = RefreshController();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: BlocProvider(
        create: (context) =>
        AppointmentsBloc(dataSource: AppointmentsDataSource())
          ..onFetchAppointments(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('لوحة تحكم الطبيب'),
            bottom: const TabBar(tabs: [
              Tab(icon: Icon(Icons.pending), text: 'مواعيد في الانتظار'),
              Tab(icon: Icon(Icons.done), text: 'مواعيد المقبوله'),
              Tab(icon: Icon(Icons.done), text: 'المواعيد المرفوضة'),
            ]),
          ),
          body: Builder(
            builder: (context) {
              return const TabBarView(children: [
                MyDoctorAppointment(),
                DoctorApprovedAppointments(),
                DoctorDeclinedAppointments()
              ]);
            },
          ),
        ),
      ),
    );
  }
}
