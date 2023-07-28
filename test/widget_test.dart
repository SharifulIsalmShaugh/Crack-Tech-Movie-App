import 'dart:convert';

import 'package:crack_tech_app/app/data/movieDataResponse.dart';
import 'package:crack_tech_app/app/modules/details/controllers/details_controller.dart';
import 'package:crack_tech_app/app/modules/home/controllers/home_controller.dart';
import 'package:crack_tech_app/app/routes/app_pages.dart';
import 'package:crack_tech_app/utils/constrains.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';


class MockBox extends Mock implements Box<dynamic> {}

class MockAppRepository extends Mock {
}
void main() {

  group('HomeController Test', () {
    late HomeController controller;
    late MockBox mockBox;
    late MockAppRepository mockRepository;

    setUp(() {
      controller = HomeController();
      mockBox = MockBox();
      mockRepository = MockAppRepository();

      // Inject the mocked instances into the controller and repository
      Get.put<Box<dynamic>>(mockBox);
    });

    tearDown(() {
      Get.reset(); // Reset the dependencies after each test
    });

    test('localDataCall loads data from Hive if available', () async {
      final mockResponse = {
        "movies": [
          {
            "title": "Mock Movie 1",
            "genres": ["Action", "Adventure"],
            "year": "2023",
            "director": "John Doe",
            "posterUrl": "https://example.com/mock_poster_1.jpg",
          },
          {
            "title": "Mock Movie 2",
            "genres": ["Drama"],
            "year": "2022",
            "director": "Jane Smith",
            "posterUrl": "https://example.com/mock_poster_2.jpg",
          },
        ]
      };

      // Mocking Hive box behavior
      when(mockBox.get(any)).thenReturn(jsonEncode(mockResponse));

      // Call the localDataCall method
      controller.localDataCall();

      // Verify that the correct data is loaded from Hive
      expect(controller.movieData.value.movies!.length, 2);
      expect(controller.movieData.value.movies![0].title, "Mock Movie 1");
      expect(controller.movieData.value.movies![1].title, "Mock Movie 2");
      expect(controller.isLoading.value, false);
    });

    test('localDataCall calls movieDataCall if data is not available in Hive', () async {
      // Mocking Hive box behavior to return null
      when(mockBox.get(any)).thenReturn(null);

      // Mocking the movieDataResponseApi function to return a mock response
      final mockResponse = MovieDataResponse(
        movies: [
          Movie(
            title: "Mock Movie 3",
            genres: ["Comedy"],
            year: "2024",
            director: "Mike Johnson",
            posterUrl: "https://example.com/mock_poster_3.jpg",
          ),
        ],
      );
      when(controller.localDataCall()).thenAnswer((_) => Future.value(mockResponse));

      // Call the localDataCall method
      controller.localDataCall();

      // Verify that the movieDataCall method is called and data is updated correctly
      verify(controller.localDataCall()).called(1);
      expect(controller.movieData.value.movies!.length, 1);
      expect(controller.movieData.value.movies![0].title, "Mock Movie 3");
      expect(controller.isLoading.value, false);
    });

    test('selectedGenres filters movies by genre', () {
      // Set up movieData with some mock movies
      final mockMovies = [
        Movie(
          title: "Mock Movie 1",
          genres: ["Action", "Adventure"],
          year: "2023",
          director: "John Doe",
          posterUrl: "https://example.com/mock_poster_1.jpg",
        ),
        Movie(
          title: "Mock Movie 2",
          genres: ["Drama"],
          year: "2022",
          director: "Jane Smith",
          posterUrl: "https://example.com/mock_poster_2.jpg",
        ),
        Movie(
          title: "Mock Movie 3",
          genres: ["Comedy"],
          year: "2024",
          director: "Mike Johnson",
          posterUrl: "https://example.com/mock_poster_3.jpg",
        ),
      ];
      controller.movieData.value = MovieDataResponse(movies: mockMovies);

      // Call the selectedGenres method to filter by genre "Action"
      controller.selectedGenres(0, "Action");

      // Verify that only movies with genre "Action" are in filteredMovies
      expect(controller.selectedIndex.value, 0);
      expect(controller.selectedName.value, "Action");
      expect(controller.filteredMovies.length, 1);
      expect(controller.filteredMovies[0].title, "Mock Movie 1");
    });

    test('navigateToDetails navigates to Details page', () {
      final mockMovie = Movie(
        title: "Mock Movie",
        genres: ["Action", "Adventure"],
        year: "2023",
        director: "John Doe",
        posterUrl: "https://example.com/mock_poster.jpg",
      );

      // Call the navigateToDetails method
      controller.navigateToDetails(mockMovie);

      // Verify that Get.toNamed is called with the correct route and arguments
      verify(Get.toNamed(Routes.DETAILS, arguments: {Constants.MOVIE: mockMovie})).called(1);
    });
  });
  group('DetailsController Test', () {
    // Test case for argumentData method
    test('argumentData assigns correct movie data from arguments', () {
      final mockMovie = Movie(
        title: 'Mock Movie',
        genres: ['Action', 'Adventure'],
        year: '2023',
        director: 'John Doe',
        posterUrl: 'https://example.com/mock_poster.jpg',
      );


      final controller = DetailsController();

      // Call the argumentData method with the mock movie object
      controller.argumentData();

      // Verify that the movieData is correctly assigned from the arguments
      expect(controller.movieData.value.title, 'Mock Movie');
      expect(controller.movieData.value.genres, ['Action', 'Adventure']);
      expect(controller.movieData.value.year, '2023');
      expect(controller.movieData.value.director, 'John Doe');
      expect(controller.movieData.value.posterUrl, 'https://example.com/mock_poster.jpg');
    });

    // Test case for onInit method
    test('onInit initializes the controller correctly', () {
      final controller = DetailsController();
      controller.onInit();
      // Ensure that the initial value of movieData is set correctly
      expect(controller.movieData.value, Movie());
    });
  });
}
