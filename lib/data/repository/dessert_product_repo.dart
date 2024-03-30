import '../../data/api/api_client.dart';
import '../../utils/app_constants.dart';

import 'package:get/get.dart';
class DessertProductRepo extends GetxService {
  final ApiClient apiClient;

  DessertProductRepo({required this.apiClient});

  Future<Response> getDessertProductList() async {
    return await apiClient.getData(AppConstants.DESSERT_PRODUCT_URI);
  }
}