abstract class AuthRepository {
  Future<dynamic> registerUser(dynamic body);
  Future<dynamic> loginUser(dynamic body);
  Future<dynamic> forgetPassword(dynamic body);
  Future<dynamic> resetPassword(dynamic body);


}
