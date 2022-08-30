import 'package:hawker_geo/core/model/user.dart';
import 'package:hawker_geo/core/services/register_service.dart';

class RegisterController {
  final user = User();
  final _service = RegisterService();

  registerUser() async {
    try {
      await _service.registerUser(user);
          // .then((_) => {}); // TODO - Ir para outra tela e continuar o cadastro;
    } catch (e) {
      print(e); // TODO - tratar
    }
  }
}
