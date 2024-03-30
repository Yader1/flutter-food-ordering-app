import '../../data/api/api_client.dart';
import '../../utils/app_constants.dart';

import 'package:get/get.dart';

class DrinksProductRepo extends GetxService {
  final ApiClient apiClient;

  DrinksProductRepo({required this.apiClient});

  Future<Response> getDrinkProductList() async {
    return await apiClient.getData(AppConstants.DRINKS_PRODUCT_URI);
  }
}