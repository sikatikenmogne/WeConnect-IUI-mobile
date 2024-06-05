import 'package:we_connect_iui_mobile/main.dart'; // Assuming supabaseClient is defined in main.dart
import 'package:we_connect_iui_mobile/src/utils/autogenerate_util.dart';

class Role {
  String _id;
  String _name;

  Role._({
    required String id,
    required String name,
  })  : _id = id,
        _name = name;

  static Future<Role> create({
    required String name,
  }) async {
    final id = AutogenerateUtil().generateId();
    final newRole = Role._(
      id: id,
      name: name,
    );

    final response = await supabaseClient.from("roles").insert({
      "id": id,
      "name": name,
    });

    if (response.error != null) {
      print('Error inserting role: ${response.error!.message}');
    } else {
      print('Role inserted successfully');
    }

    return newRole;
  }

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role._(
      id: json['id'],
      name: json['name'],
    );
  }

  String get id => _id;
  set id(String value) => _id = value;

  String get name => _name;
  set name(String value) => _name = value;
}

// Example usage of the Role class
void main() async {
  // Example usage
  Role newRole = await Role.create(
    name: "Admin",
  );

  // Use the newRole object as needed
  print('New role created with ID: ${newRole.id}');
}
