class DoctorModel {
  final String period;

  final String description;

  final String mail;

  final String image;

  final String phone;

  final String type;

  final String name;

  DoctorModel(
      {required this.period,
      required this.description,
      required this.mail,
      required this.image,
      required this.phone,
      required this.type,
      required this.name});

  Map<String, dynamic> toJson() {
    return {
      "Period": this.period,
      "description": this.description,
      "mail": this.mail,
      "image": this.image,
      "phone": this.phone,
      "type": this.type,
      "name": this.name,
    };
  }
}
