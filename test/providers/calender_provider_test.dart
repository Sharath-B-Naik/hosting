import 'package:flutter_test/flutter_test.dart';
import 'package:form_project/model/posts.dart';
import 'package:form_project/providers/calender_provider.dart';
import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';

class MockHttp extends Mock implements Client {}

void main() {
  late final MockHttp mockHttp;

  setUpAll(() {
    mockHttp = MockHttp();
  });
  test("Calender Test - getWeekDates", () {
    // Arrange
    final provider = CalendarProvider();
    // Act

    // Assert
    expect(provider.getWeekDates, isA<List>());
  });

  test("Calender Test - isExpanded", () {
    // Arrange
    final provider = CalendarProvider();
    // Act
    expect(provider.isExpanded, true);

    provider.isExpanded = false;

    // Assert
    expect(provider.isExpanded, false);
  });

  test("Calender Test - Future api test", () async {
    // Arrange
    final provider = CalendarProvider();
    // Act
    when(
      () {
        return mockHttp.get(
          Uri.parse('https://jsonplaceholder.typicode.com/posts'),
        );
      },
    ).thenAnswer((_) async {
      return Response(
        '''
        {
          "id":1,
          "title": "Hello",
          "body": "Hello world!"
        }
        ''',
        200,
      );
    });

    final result = await provider.getPosts();

    // Assert
    expect(result, isA<List<Posts>>());
  });
}
