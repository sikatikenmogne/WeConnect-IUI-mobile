import 'package:we_connect_iui_mobile/main.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';

class AuditModel {
  late DateTime _createdAt;
  late User? _createdBy;
  late DateTime _updatedAt;
  late User? _updatedBy;

  AuditModel() {
    _createdAt = DateTime.now();
    _updatedAt = DateTime.now();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async{
    final user = await supabaseClient.from("users")
        .select()
        .eq("id", supabaseClient.auth.currentUser!.id)
        .single();
    _createdBy = User.fromJson(user);
    _updatedBy = User.fromJson(user);
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