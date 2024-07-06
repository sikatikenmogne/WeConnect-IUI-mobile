import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/role_model.dart';
import 'package:we_connect_iui_mobile/src/model/setting_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

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
  Settings _settings;

  User(
      {String? id,
      String? firstname,
      String? lastname,
      String? promotion,
      String? phone,
      String? dateOfBirth,
      String? sex,
      required String email,
      String? profilePicture,
      required Role role})
      : _id = (id == null) ? AutogenerateUtil().generateId() : id,
        _firstname = firstname,
        _lastname = lastname,
        _promotion = promotion,
        _phone = phone,
        _dateOfBirth = dateOfBirth,
        _sex = sex,
        _email = email,
        _profilePicture = profilePicture,
        _role = role,
        _settings = Settings(),
        super();

  User.empty()
      : _id = "",
        _email = "",
        _role = Role.learner,
        _settings = Settings();

  String get id => this._id;
  set id(value) => this._id = value;

  String? get firstname => this._firstname;
  set firstname(String? value) => this._firstname = value;

  String? get lastname => this._lastname;
  set lastname(String? value) => this._lastname = value;

  String? get promotion => this._promotion;
  set promotion(String? value) => this._promotion = value;

  String? get phone => this._phone;
  set phone(String? value) => this._phone = value;

  String? get dateOfBirth => this._dateOfBirth;
  set dateOfBirth(String? value) => this._dateOfBirth = value;

  String? get sex => this._sex;
  set sex(String? value) => this._sex = value;

  String get email => this._email;
  set email(String value) => this._email = value;

  String? get profilePicture => this._profilePicture;
  set profilePicture(String? value) => this._profilePicture = value;

  Role get role => this._role;
  set role(Role value) => this._role = value;

  Settings get settings => this._settings;
  set settings(Settings value) => this._settings = value;

  static User createDefaultUser() {
    return User(
      id: 'defaultId',
      firstname: 'john',
      lastname: 'doe',
      promotion: 'X2025',
      profilePicture:
          'https://yojnxscjecnlltwblvrn.supabase.co/storage/v1/object/public/post_images/Image_placeholder.svg.png?t=2024-06-07T19%3A20%3A51.928Z',
      role: Role.learner, // Or any default role
      email: 'default@example.com', // Use a default email
    );
  }

  static User getCurrentUser() {
    return createDefaultUser();
  }
}
