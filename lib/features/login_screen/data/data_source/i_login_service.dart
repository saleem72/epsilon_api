//

abstract class ILoginService {
  Future<String> login({required String username, required String password});
}
