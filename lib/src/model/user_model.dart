import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/role_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';
import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart

class User extends AuditModel {
  String _id;
  String? _firstname;
  String? _lastname;
  String? _promotion;
  String? _phone;
  String? _dateOfBirth;
  String? _sex;
  String _email;
  String? _profilePicture;
  Role _role;

  User._({
    required String id,
    String? firstname,
    String? lastname,
    String? promotion,
    String? phone,
    String? dateOfBirth,
    String? sex,
    required String email,
    String? profilePicture,
    required Role role,
  })  : _id = id,
        _firstname = firstname,
        _lastname = lastname,
        _promotion = promotion,
        _phone = phone,
        _dateOfBirth = dateOfBirth,
        _sex = sex,
        _email = email,
        _profilePicture = profilePicture,
        _role = role,
        super();

  static Future<User> create({
    String? firstname,
    String? lastname,
    String? promotion,
    String? phone,
    String? dateOfBirth,
    String? sex,
    required String email,
    String? profilePicture,
    required Role role,
  }) async {
    final id = AutogenerateUtil().generateId();
    final newUser = User._(
      id: id,
      firstname: firstname,
      lastname: lastname,
      promotion: promotion,
      phone: phone,
      dateOfBirth: dateOfBirth,
      sex: sex,
      email: email,
      profilePicture: profilePicture,
      role: role
    );

    final response = await supabaseClient.from("users").insert({
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "promotion": promotion,
      "phone": phone,
      "dateOfBirth": dateOfBirth,
      "sex": sex,
      "email": email,
      "profilePicture": profilePicture,
      "roleid": role.id, // Assuming roleid is stored as a reference to the Role table
    });

    if (response.error != null) {
      print('Error inserting user: ${response.error!.message}');
    } else {
      print('User inserted successfully');
    }

    return newUser;
  }
  
  factory User.fromJson(Map<String, dynamic> json){
    return User._(
      id: json['id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      promotion: json['promotion'],
      phone: json['phone'],
      dateOfBirth: json['dateOfBirth'],
      sex: json['sex'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      role: Role.fromJson(json['role']),
    );
  }

  String get id => _id;
  set id(String value) => _id = value;

  String? get firstname => _firstname;
  set firstname(String? value) => _firstname = value;

  String? get lastname => _lastname;
  set lastname(String? value) => _lastname = value;

  String? get promotion => _promotion;
  set promotion(String? value) => _promotion = value;

  String? get phone => _phone;
  set phone(String? value) => _phone = value;

  String? get dateOfBirth => _dateOfBirth;
  set dateOfBirth(String? value) => _dateOfBirth = value;

  String? get sex => _sex;
  set sex(String? value) => _sex = value;

  String get email => _email;
  set email(String value) => _email = value;

  String? get profilePicture => _profilePicture;
  set profilePicture(String? value) => _profilePicture = value;

  Role get role => _role;
  set role(Role value) => _role = value;
}
