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

  User({
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
      "dat_of_birth": dateOfBirth,
      "sex": sex,
      "email": email,
      "profile_picture": profilePicture,
      "role_id": role.id, 
    });

    if (response.error != null) {
      print('Error inserting user: ${response.error!.message}');
    } else {
      print('User inserted successfully');
    }

    return newUser;
  }

  static Future<List<User>> load() async {
    try {
      final response = await supabaseClient.from("users")
          .select();
      
      final data = response as List<dynamic>;
      for(var item in data){
        userData.add(await User.fromMap(item));
      }
    } catch (e) {
      print("Error loading user: $e");      
    }
    
    return userData;
  }

  static User? getById(String id) {
    if (userData != null){
      for(var user in userData!){
        if(user.id == id){
          return user;
        }
      }
    }
  }
  

  static User fromMap(Map<String, dynamic> map){
    return User(
      id: map['id'] as String,
      firstname: map['firstname'] as String?,
      lastname: map['lastname'] as String?,
      promotion: map['promotion'] as String?,
      phone: map['phone'] as String?,
      dateOfBirth: map['date_of_birth'] as String?,
      sex: map['sex'] as String?,
      email: map['email'] as String,
      profilePicture: map['profile_picture'] as String?,
      role: Role.getById(map['role_id'] as String)!
    );
  }
  

  factory User.fromJson(Map<String, dynamic> data) {    
    return User._(
      id: data['id'] as String,
      firstname: data['firstname'] as String?,
      lastname: data['lastname'] as String?,
      promotion: data['promotion'] as String?,
      phone: data['phone'] as String?,
      dateOfBirth: data['date_of_birth'] as String?,
      sex: data['sex'] as String?,
      email: data['email'] as String,
      profilePicture: data['profile_picture'] as String?,
      role: Role.fromJson(data['role_id']),
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
