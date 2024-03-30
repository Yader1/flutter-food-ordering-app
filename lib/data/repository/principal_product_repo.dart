import '../../data/api/api_client.dart';
import '../../utils/app_constants.dart';

import 'package:get/get.dart';

class PrincipalProductRepo extends GetxService {
  final ApiClient apiClient;

  PrincipalProductRepo({required this.apiClient});

  Future<Response> getPrincipalProductList() async {
    return await apiClient.getData(AppConstants.PRINCIPAL_PRODUCT_URI);
  }
}