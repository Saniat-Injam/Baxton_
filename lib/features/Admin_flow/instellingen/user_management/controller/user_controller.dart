import 'package:baxton/features/Admin_flow/instellingen/user_management/model/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var users =
      <UserModel>[
        UserModel(
          name: 'Jane Smith',
          email: 'janesmith@email.com',
          role: 'Beheerder',
          avatarUrl: 'https://i.pravatar.cc/150?img=1',
        ),
        UserModel(
          name: 'John Doe',
          email: 'johndoe@email.com',
          role: 'Werknemer',
          avatarUrl: 'https://i.pravatar.cc/150?img=2',
        ),
        UserModel(
          name: 'Alice Johnson',
          email: 'alicejohnson@email.com',
          role: 'Klant',
          avatarUrl: 'https://i.pravatar.cc/150?img=3',
        ),
        UserModel(
          name: 'Michael Brown',
          email: 'michaelbrown@email.com',
          role: 'Beheerder',
          avatarUrl: 'https://i.pravatar.cc/150?img=4',
        ),
        UserModel(
          name: 'Sarah Davis',
          email: 'sarahdavis@email.com',
          role: 'Werknemer',
          avatarUrl: 'https://i.pravatar.cc/150?img=5',
        ),
        UserModel(
          name: 'David Wilson',
          email: 'davidwilson@email.com',
          role: 'Werknemer',
          avatarUrl: 'https://i.pravatar.cc/150?img=6',
        ),
        UserModel(
          name: 'David Wilson',
          email: 'davidwilson@email.com',
          role: 'Werknemer',
          avatarUrl: 'https://i.pravatar.cc/150?img=7',
        ),
        UserModel(
          name: 'David Wilson',
          email: 'davidwilson@email.com',
          role: 'Werknemer',
          avatarUrl: 'https://i.pravatar.cc/150?img=8',
        ),
      ].obs;
}
