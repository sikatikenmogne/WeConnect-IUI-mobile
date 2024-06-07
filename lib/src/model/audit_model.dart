import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';

class AuditModel {
  late DateTime _createdAt;
  late User? _createdBy;
  late DateTime _updatedAt;
  late User? _updatedBy;

  AuditModel({DateTime? createdAt, User? createdBy, DateTime? updatedAt, User? upatedBy}){
    _createdAt = createdAt ?? DateTime.now();
    _updatedAt = updatedAt ?? DateTime.now();
    loadUserAndSettings();
    _createdBy = createdBy ?? currentUser;
    // (updatedBy != null) ? _updatedBy = updatedBy : currentUser;
  }

  DateTime get createdAt => _createdAt;
  set createdAt(DateTime value) => _createdAt = value;

  User? get createdBy => _createdBy;
  set createdBy(User? value) => _createdBy = value;

  DateTime get updatedAt => _updatedAt;
  set updatedAt(DateTime value) => _updatedAt = value;

  User? get updatedBy => _updatedBy;
  set updatedBy(User? value) => _updatedBy = value;
}