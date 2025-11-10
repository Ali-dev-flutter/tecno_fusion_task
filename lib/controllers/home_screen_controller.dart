import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/home_screen_data.dart';

class HomeScreenController extends GetxController {
  final RxList<HomeScreenData> projects = <HomeScreenData>[].obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    loadHomeScreenData();
    super.onInit();
  }
  Future<void> loadHomeScreenData() async {
    try {
      isLoading.value = true;
      var url = Uri.parse(
          'https://www.propstake.ai/api/dld?page=1&page_size=10&location_country=PK');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonDecoded = json.decode(response.body);
        final List<dynamic> items = jsonDecoded['data']['items'];
        projects.assignAll(items.map((item) => HomeScreenData.fromJson(item)).toList());
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}