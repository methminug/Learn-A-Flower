import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/common/app_layout.dart';
import 'package:learn_a_flower_app/screens/home/my_home_page.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/edit_question.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/new_question.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/new_quiz.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/questions_list.dart';import 'package:learn_a_flower_app/screens/disease/admin/add_disease.dart';
import 'package:learn_a_flower_app/screens/disease/admin/dashboard.dart';
import 'package:learn_a_flower_app/screens/disease/admin/edit_disease.dart';
import 'package:learn_a_flower_app/screens/disease/user/disease_details.dart';
import 'package:learn_a_flower_app/screens/disease/user/disease_list.dart';
import 'package:learn_a_flower_app/screens/flower/admin/add_flower.dart';
import 'package:learn_a_flower_app/screens/flower/admin/edit_flower.dart';
import 'package:learn_a_flower_app/screens/flower/admin/flower_dashboard.dart';
import 'package:learn_a_flower_app/screens/flower/user/flower_list.dart';
import 'package:learn_a_flower_app/screens/home/admin_dashboard.dart';
import 'package:learn_a_flower_app/screens/home/user_dashboard.dart';
import 'package:learn_a_flower_app/screens/my_plants/admin/add_my_flowers.dart';
import 'package:learn_a_flower_app/screens/my_plants/admin/dashboard.dart';
import 'package:learn_a_flower_app/screens/my_plants/admin/edit_my_flower.dart';
import 'package:learn_a_flower_app/screens/my_plants/user/my_flower_details.dart';
import 'package:learn_a_flower_app/screens/my_plants/user/my_flower_list.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_management/quiz_list.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_play/quiz_play.dart';
import 'package:learn_a_flower_app/screens/quiz/quiz_play/quiz_play_list.dart';

class RouteGenerator {
  static dynamic getRoute() {
    return {
      AppRoutes.HOME: (context) => const MyHomePage(title: 'Learn A Flower'),
      AppRoutes.USER_DASHBOARD: (context) =>  UserDashboard(),
      //FLOWERS PAGES
      AppRoutes.FLOWER_LIST: (context) => const FlowerList(),
      AppRoutes.ADMIN_FLOWER_LIST: (context) => const FlowerDashboardScreen(),
      AppRoutes.ADD_FLOWER: (context) => const AddFlowerScreen(),
      AppRoutes.EDIT_FLOWER: (context) => const EditFlowerScreen(),

      //DISEASES PAGES
      AppRoutes.DISEASE_LIST: (context) => const DiseaseList(),
      AppRoutes.DISEASE_DETAILS: (context) => const DiseaseDetails(),
      AppRoutes.ADMIN_DISEASE_LIST: (context) => const DiseaseDashboard(),
      AppRoutes.ADD_DISEASE: (context) => const AddDiseaseScreen(),
      AppRoutes.EDIT_DISEASE: (context) => const EditDiseaseScreen(),

      //MY FLOWERS PAGES
      AppRoutes.MY_FLOWERS_LIST: (context) => const MyFlowerList(),
      AppRoutes.MY_FLOWER_DETAILS: (context) => const MyFlowerDetails(),
      AppRoutes.ADMIN_MY_FLOWERS_LIST: (context) => const MyPlantsDashboard(),
      AppRoutes.ADD_MY_FLOWER: (context) => const AddMyFlowerScreen(),
      AppRoutes.EDIT_MY_FLOWER: (context) => const EditMyFlowerScreen(),

      //QUIZ PAGES
      AppRoutes.QUIZ_MANAGEMENT_LIST: (context) =>
          const AppLayout(child: QuizList(), title: 'Quiz Management'),
      AppRoutes.QUIZ_MANAGEMENT_QUESTIONS: (context) => const QuestionList(),
      AppRoutes.QUIZ_MANAGEMENT_NEW_QUESTION: (context) => const NewQuestion(),
      AppRoutes.QUIZ_MANAGEMENT_NEW_QUIZ: (context) => const NewQuiz(),
      AppRoutes.QUIZ_PLAY_LIST: (context) =>
          const AppLayout(child: QuizPlayList(), title: 'Play a Quiz'),
      AppRoutes.QUIZ_PLAY: (context) => const QuizPlay(),
      AppRoutes.QUIZ_MANAGEMENT_EDIT_QUESTION: (context) =>
          const EditQuestion(),
    };
  }
}
