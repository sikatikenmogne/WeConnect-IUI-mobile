import 'package:we_connect_iui_mobile/src/constants/app_image.dart';
import 'package:we_connect_iui_mobile/src/model/user_model.dart';
import 'package:we_connect_iui_mobile/src/model/role_model.dart';


final Map<String, User> userDataSet ={
  "1": User(
    id: "1",
    firstname: 'John',
    lastname: 'Doe',
    email: 'john.doe@example.com',
    promotion: 'X2025',
    profilePicture: AppImage.onboardingFifthImage,
    role: Role.admin,
  ),

  "2" : User(
    id: "2",
    firstname: 'Jane',
    lastname: 'Smith',
    email: 'jane.smith@example.com',
    promotion: 'O2028',
    profilePicture: AppImage.onboardingFirstImage,
    role: Role.instructor,
  ),

  "3" : User(
    firstname: 'Alice',
    lastname: 'Johnson',
    promotion: 'IP2025',
    email: 'alice.johnson@example.com',
    profilePicture: AppImage.onboardingThirdImage,
    role: Role.learner,
  )
};