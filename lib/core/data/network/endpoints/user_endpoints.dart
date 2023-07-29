import 'package:mealorder/core/data/network/network_config.dart';

class UserEndPoints {
  static String login = NetworkConfig.getFullApiRout('user/login');
  static String rigester = NetworkConfig.getFullApiRout('User/Register');
}
