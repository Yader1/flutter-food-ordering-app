import '../../data/api/api_client.dart';
import '../../utils/app_constants.dart';

import 'package:get/get.dart';

class SpecialtyProductRepo extends GetxService {
  final ApiClient apiClient;

  SpecialtyProductRepo({required this.apiClient});

  Future<Response> getSpecialtyProductList() async {
    return await apiClient.getData(AppConstants.SPECIALTY_PRODUCT_URI);
  }
}