import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/home/my_home_page.dart';

class RouteGenerator {
  static dynamic getRoute() {
    return {
      AppRoutes.HOME: (context) => const MyHomePage(title: 'Learn A Flower'),
    };
  }
}
