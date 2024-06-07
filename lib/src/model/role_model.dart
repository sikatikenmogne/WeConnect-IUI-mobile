import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Role {
  String _id;
  String _name;

  Role({
    required String id,
    required String name,
  })  : _id = id,
        _name = name;
  
  static Role? getById(String id) {
    for (var role in roleData) {
      if (role.id == id) {
        return role;
      }
    }
    }

  // static Future<Role> getById(String id) async {
  //   final data = await supabaseClient
  //       .from('role')
  //       .select()
  //       .eq('id', id)
  //       .single();

  //   return Role.fromJson(data);
  // }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  String get id => _id;
  set id(String value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;
}
