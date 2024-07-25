import 'package:AlMokhtar_Clinic/features/doctors_register/data/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorsRegisterDataSource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<DoctorModel>> fetchDoctors() async {
    final result = await _firestore.collection('doctors').get();

    return result.docs
        .map((e) => DoctorModel(
            period: e.data()['Period'] ?? "",
            description: e.data()["description"] ?? "",
            mail: e.data()["doctormail"] ?? "",
            image: e.data()["image"] ?? "",
            phone: e.data()["phone"] ?? "",
            type: e.data()["type"] ?? "",
            name: e.data()["name"] ?? ""))
        .toList();
  }

  Future<void> deleteDoctor({required String email}) async {
    final result = await _firestore
        .collection('doctors')
        .where("dotormail", isEqualTo: email)
        .get();

    result.docs.forEach((element) {
      element.reference.delete();
    });
  }

  Future<void> addDoctor({required DoctorModel doctor}) async {
    await _firestore.collection('doctors').add(doctor.toJson());
  }
}
