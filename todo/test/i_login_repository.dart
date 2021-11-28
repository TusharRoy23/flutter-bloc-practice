import 'package:todo/model/user.dart';

abstract class ILoginRepository {
  Future<User?> doLogin(String username, String password);

  Future<void> doLogout();
}
