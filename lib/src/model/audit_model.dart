import 'package:we_connect_iui_mobile/src/model/role_model.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';

class AuditModel {
  DateTime _createdAt;
  User? _createdBy;
  DateTime _updatedAt;
  User? _updatedBy;

  AuditModel(
  )  :  _createdAt = DateTime.now(),
        // _createdBy = User(
        //   id: "0", 
        //   firstname: "Jordan",
        //   lastname: "TCHOUNGA",
        //   email: "jt@gmail.com",
        //   role: Role.learner
        // ),
        _updatedAt = DateTime.now();
        // _updatedBy = new User.empty();
        

  DateTime get createdAt => _createdAt;
  set createdAt(DateTime value) => _createdAt = value;

  User? get createdBy => _createdBy;
  set createdBy(User? value) => _createdBy = value;

  DateTime get updatedAt => _updatedAt;
  set updatedAt(DateTime value) => _updatedAt = value;

  User? get updatedBy => _updatedBy;
  set updatedBy(User? value) => _updatedBy = value;
}