
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/disease/admin/add_disease.dart';
import 'package:learn_a_flower_app/screens/disease/admin/dashboard.dart';
import 'package:learn_a_flower_app/screens/disease/admin/edit_disease.dart';
import 'package:learn_a_flower_app/screens/disease/user/disease_details.dart';
import 'package:learn_a_flower_app/screens/disease/user/disease_list.dart';
import 'package:learn_a_flower_app/screens/flower/admin/add_flower.dart';
import 'package:learn_a_flower_app/screens/flower/admin/edit_flower.dart';
import 'package:learn_a_flower_app/screens/flower/admin/flower_dashboard.dart';
import 'package:learn_a_flower_app/screens/flower/user/flower_details.dart';
import 'package:learn_a_flower_app/screens/flower/user/flower_list.dart';
import 'package:learn_a_flower_app/screens/home/admin_dashboard.dart';
import 'package:learn_a_flower_app/screens/home/my_home_page.dart';
import 'package:learn_a_flower_app/screens/home/user_dashboard.dart';
import 'package:learn_a_flower_app/screens/my_plants/admin/add_my_flowers.dart';
import 'package:learn_a_flower_app/screens/my_plants/admin/dashboard.dart';
import 'package:learn_a_flower_app/screens/my_plants/admin/edit_my_flower.dart';
import 'package:learn_a_flower_app/screens/my_plants/user/my_flower_details.dart';
import 'package:learn_a_flower_app/screens/my_plants/user/my_flower_list.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/quiz_list.dart';

class RouteGenerator {
  static dynamic getRoute() {
    return {
      AppRoutes.HOME: (context) => const MyHomePage(title: 'Learn A Flower'),
      AppRoutes.ADMIN_DASHBOARD: (context) => AdminDashboard(),
      AppRoutes.USER_DASHBOARD: (context) =>  UserDashboard(),

      AppRoutes.QUIZ_MANAGEMENT_LIST: (context) => const QuizList(),

      AppRoutes.FLOWER_LIST: (context) => const FlowerList(),
      AppRoutes.FLOWER_DETAILS: (context) => const FlowerDetails(),
      AppRoutes.ADMIN_FLOWER_LIST: (context) =>  const FlowerDashboardScreen(),
      AppRoutes.ADD_FLOWER: (context) => const AddFlowerScreen(),
      AppRoutes.EDIT_FLOWER: (context) => const EditFlowerScreen(),

      AppRoutes.DISEASE_LIST: (context) => const DiseaseList(),
      AppRoutes.DISEASE_DETAILS: (context) => const DiseaseDetails(),
      AppRoutes.ADMIN_DISEASE_LIST: (context) => const DiseaseDashboard(),
      AppRoutes.ADD_DISEASE: (context) => const AddDiseaseScreen(),
      AppRoutes.EDIT_DISEASE: (context) => const EditDiseaseScreen(),

      AppRoutes.MY_FLOWERS_LIST: (context) => const MyFlowerList(),
      AppRoutes.MY_FLOWER_DETAILS: (context) => const MyFlowerDetails(),
      AppRoutes.ADMIN_MY_FLOWERS_LIST: (context) => const MyPlantsDashboard(),
      AppRoutes.ADD_MY_FLOWER: (context) => const AddMyFlowerScreen(),
      AppRoutes.EDIT_MY_FLOWER: (context) => const EditMyFlowerScreen(),
    };
  }
}
