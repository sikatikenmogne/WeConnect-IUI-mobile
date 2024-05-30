import 'package:we_connect_iui_mobile/src/model/enum/privilege_enum.dart';

class Role{
  static const learner = Role._([
    PrivilegeEnum.CREATE_POST,
    PrivilegeEnum.DELETE_POST,
    PrivilegeEnum.LIKE_POST,
    PrivilegeEnum.COMMENT_POST,
    PrivilegeEnum.SEND_MESSAGE,
    PrivilegeEnum.DELETE_MESSAGE,
    PrivilegeEnum.READ_CALENDAR
  ]);
  static const instructor = Role._([
    PrivilegeEnum.CREATE_POST,
    PrivilegeEnum.DELETE_POST,
    PrivilegeEnum.LIKE_POST,
    PrivilegeEnum.COMMENT_POST,
    PrivilegeEnum.SEND_MESSAGE,
    PrivilegeEnum.DELETE_MESSAGE,
    PrivilegeEnum.READ_CALENDAR
  ]);
  static const admin = Role._([
    PrivilegeEnum.CREATE_POST,
    PrivilegeEnum.DELETE_POST,
    PrivilegeEnum.LIKE_POST,
    PrivilegeEnum.COMMENT_POST,
    PrivilegeEnum.SEND_MESSAGE,
    PrivilegeEnum.DELETE_MESSAGE,
    PrivilegeEnum.READ_CALENDAR,
    PrivilegeEnum.CREATE_CALENDAR,
  ]);

  final List<PrivilegeEnum> privileges;

  const Role._(this.privileges);

  static List<Role> get values => [learner, instructor, admin];
}