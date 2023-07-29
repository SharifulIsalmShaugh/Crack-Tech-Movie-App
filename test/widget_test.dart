
import 'package:crack_tech_app/app/modules/home/controllers/home_controller.dart';
import 'package:crack_tech_app/app/modules/home/views/home_view.dart';
import 'package:crack_tech_app/app/repository/appRepository.dart';
import 'package:crack_tech_app/utils/network/connectionManagerController.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/mockito.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await Hive.openBox("movieDataList");
  test("Fetch Api data", () async {
    bool done = false;
    await Repo.movieDataResponseApi().then((response) {
      if(response != null) {
        done = true;
      }else{
        done = false;
      }
    });
    expect(done, true);
  });

  testWidgets('HomeView displays "No Internet Connection" when there is no network connection', (WidgetTester tester) async {
    // Create a mock instance of ConnectionManagerController
    final mockConnectionManagerController = ConnectionManagerController();

    // Set the connectionType value to 0 to simulate no network connection
    when(mockConnectionManagerController.connectionType).thenReturn(0.obs);

    // Bind the mock instance to Get to allow the widget to access it
    Get.put(mockConnectionManagerController);

    // Build the HomeView widget
    await tester.pumpWidget(const GetMaterialApp(
      home: HomeView(),
    ));

    // Verify that "No Internet Connection" text is displayed on the screen
    expect(find.text("No Internet Connection"), findsOneWidget);

    // Clean up the mock instance after the test
    Get.reset();
  });

  testWidgets('HomeView displays "Movie data not found." when movieData has no genres', (WidgetTester tester) async {
    // Create a mock instance of HomeController
    final mockHomeController = HomeController();

    // Set the movieData value to null to simulate no genres
    mockHomeController.movieData.value;

    // Bind the mock instance to Get to allow the widget to access it
    Get.put<HomeController>(mockHomeController);

    // Build the HomeView widget
    await tester.pumpWidget(const GetMaterialApp(
      home: HomeView(),
    ));

    // Verify that "Movie data not found." text is displayed on the screen
    expect(find.text("Movie data not found."), findsOneWidget);

    // Clean up the mock instance after the test
    Get.reset();
  });

testWidgets('HomeView displays "Movie data not found." when movieData has no genres', (WidgetTester tester) async {
    // Create a mock instance of HomeController
    final mockHomeController = HomeController();

    // Set the movieData value to null to simulate no genres
    mockHomeController.movieData.value;

    // Bind the mock instance to Get to allow the widget to access it
    Get.put<HomeController>(mockHomeController);

    // Build the HomeView widget
    await tester.pumpWidget(const GetMaterialApp(
      home: HomeView(),
    ));

    // Verify that "Movie data not found." text is displayed on the screen
    expect(find.text("Movie data not found."), findsOneWidget);

    // Clean up the mock instance after the test
    Get.reset();
  });
}
