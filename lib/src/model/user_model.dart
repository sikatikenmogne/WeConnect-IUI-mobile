import 'package:we_connect_iui_mobile/src/model/audit_model.dart';
import 'package:we_connect_iui_mobile/src/model/role_model.dart';
import 'package:we_connect_iui_mobile/src/model/setting_model.dart';
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class User extends AuditModel{
  String _id;
  String? _firstname;
  String? _lastname;
  String? _promotion;
  String? _phone;
  String? _dateOfBirth;
  String? _sex;
  String _email;
  String _password;
  String? _profilePicture;
  Role _role;
  Settings _settings;

  User({
    String? firstname,
    String? lastname,
    String? promotion,
    String? phone,
    String? dateOfBirth,
    String? sex,
    required String email,
    required String password,
    String? profilePicture,
    required Role role,
    required Settings settings
  }) :  _id = AutogenerateUtil().generateId(),
        _firstname = firstname, 
        _lastname = lastname, 
        _promotion = promotion, 
        _phone = phone, 
        _dateOfBirth = dateOfBirth, 
        _sex = sex, 
        _email = email,
        _password = password, 
        _profilePicture = profilePicture, 
        _role = role, 
        _settings = settings,
        super();

  User.empty()
  : _id = "",
    _email = "",
    _password = "",
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

  String get password => this._password;
  set password(String value) => this._password = value;

  String? get profilePicture => this._profilePicture;
  set profilePicture(String? value) => this._profilePicture = value;

  Role get role => this._role;
  set role(Role value) => this._role = value;

  Settings get settings => this._settings;
  set settings(Settings value) => this._settings = value;
  
}