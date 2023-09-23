import 'package:flutter_tienda_comida/data/api/api_client.dart';
import 'package:flutter_tienda_comida/utils/app_constants.dart';
import 'package:get/get.dart';

class DrinksProductRepo extends GetxService {
  final ApiClient apiClient;

  DrinksProductRepo({required this.apiClient});

  Future<Response> getDrinkProductList() async {
    return await apiClient.getData(AppConstants.DRINKS_PRODUCT_URI);
  }
}