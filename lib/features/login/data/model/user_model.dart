class UserModel {
  final String birthDate;

  final String password;

  final String name;

  final String email;

  final String bio;


  final String phone;

  final String city;

  final String userType ;

  UserModel(
      {required this.birthDate,
      required this.password,
      required this.name,
      required this.email,
      required this.bio,
      required this.userType,
      required this.phone,
      required this.city});


  Map<String , dynamic> toJson() {
    return {
      "bio" : this.bio ,
      "birthDate" : this.birthDate ,
      "city" : this.city ,
      "email" : this.email ,
      "name" : this.name ,
      "phone" : this.phone ,
      "userType" : this.userType ,
    } ;
  }
}
