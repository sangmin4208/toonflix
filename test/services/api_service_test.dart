import 'package:flutter_test/flutter_test.dart';
import 'package:toonflix/services/api_service.dart';

void main() {
  group("ApiService", () {
    test("getTodaysToons", () async {
      final apiService = ApiService();
      apiService.getTodaysToons();
    });
  });
}
