// import 'package:we_connect_iui_mobile/src/model/data/user_dataset.dart';
// import 'package:we_connect_iui_mobile/src/model/user_model.dart';

// class UserService{
//   UserService();

//   List<User> getAllUsers() {
//     return userDataSet.values.toList();
//   }
  
  
//   User? getUserById(String id) {
//     return userDataSet[id] ?? null;
//   }

//   User getUserByEmail(String email){
//     return userDataSet.values
//         .where((user) => user.email.contains(email))
//         .first;
//   }
//   List<User> getUserByRole(String role){
//     return userDataSet.values
//         .where((user) => user.role == role)
//         .toList();
//   }
//   List<User> getUserByPromotion(String promotion){
//     return userDataSet.values
//         .where((user) => user.promotion == promotion)
//         .toList();
//   }
// }