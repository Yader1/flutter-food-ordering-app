import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/location_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/address_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/big_text.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonNameController =
      TextEditingController();
  final TextEditingController _contactPersonNumberController =
      TextEditingController();
  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);
  late LatLng _initialPosition = const LatLng(45.51563, -122.677433);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userLoggedIn();

    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }

    if (Get.find<LocationController>().addressList.isNotEmpty) {
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress["latitude"]),
              double.parse(
                  Get.find<LocationController>().getAddress["longitude"])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]),
          double.parse(Get.find<LocationController>().getAddress["longitude"]));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("página de dirección"),
          backgroundColor: AppColors.mainColor,
        ),
        body: GetBuilder<UserController>(builder: (userController) {
          if (userController.userModel != null && _contactPersonNameController.text.isEmpty) {
            _contactPersonNameController.text = '${userController.userModel?.name}';
            _contactPersonNumberController.text = '${userController.userModel?.phone}';

            if(Get.find<LocationController>().addressList.isNotEmpty){
              _addressController.text = Get.find<LocationController>().getUserAddress().address;
            }
          }
          return GetBuilder<LocationController>(builder: (locationController) {
            _addressController.text =
                '${locationController.placemark.name ?? ''}'
                '${locationController.placemark.locality ?? ''}'
                '${locationController.placemark.postalCode ?? ''}'
                '${locationController.placemark.country ?? ''}';
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140.0,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                      left: 5,
                      right: 5,
                      top: 5,
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 2, color: AppColors.mainColor)),
                    child: Stack(
                      children: [
                        GoogleMap(
                          initialCameraPosition:
                              CameraPosition(target: _initialPosition, zoom: 17),
                          zoomControlsEnabled: false,
                          compassEnabled: false,
                          indoorViewEnabled: true,
                          mapToolbarEnabled: false,
                          myLocationEnabled: true,
                          onCameraIdle: () {
                            locationController.updatePosition(
                                _cameraPosition, true);
                          },
                          onCameraMove: ((position) =>
                              _cameraPosition = position),
                          onMapCreated: (GoogleMapController controller) {
                            locationController.setMapController(controller);
                          },
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimenciones.width20, top: Dimenciones.height20 ),
                    child: SizedBox(height: 50, child: ListView.builder(shrinkWrap: true, scrollDirection: Axis.horizontal, itemCount: locationController.addressTypeList.length, itemBuilder: (context, index){
                      return InkWell(
                        onTap: (){
                          locationController.setAddressTypeIndex(index);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimenciones.width20, vertical: Dimenciones.height10),
                          margin: EdgeInsets.only(right:Dimenciones.width10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimenciones.radius20/4),
                            color: Theme.of(context).cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[200]!,
                                spreadRadius: 1,
                                blurRadius: 5,
                              )
                            ]
                          ),
                          child: Icon(
                                index == 0?Icons.home_filled:index == 1?Icons.work_outlined:Icons.location_on_outlined,
                                color: locationController.addressTypeIndex == index?AppColors.mainColor:Theme.of(context).disabledColor,
                              )
                        ),
                      );
                    }),),
                  ),
                  SizedBox(
                    height: Dimenciones.height20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: Dimenciones.width20),
                    child: BigText(text: "Dirección de entrega"),
                  ),
                  SizedBox(height: Dimenciones.height10),
                  AppTextField(
                      textEditingController: _addressController,
                      hintText: "Su dirección",
                      icon: Icons.map),
                  SizedBox(height: Dimenciones.height20),
                  Padding(
                    padding: EdgeInsets.only(left: Dimenciones.width20),
                    child: BigText(text: "Nombre de contacto"),
                  ),
                  SizedBox(height: Dimenciones.height10),
                  AppTextField(
                      textEditingController: _contactPersonNameController,
                      hintText: "Tu nombre",
                      icon: Icons.person_pin),
                  SizedBox(height: Dimenciones.height20),
                  Padding(
                    padding: EdgeInsets.only(left: Dimenciones.width20),
                    child: BigText(text: "Tu número"),
                  ),
                  SizedBox(height: Dimenciones.height10),
                  AppTextField(
                      textEditingController: _contactPersonNumberController,
                      hintText: "Tu número",
                      icon: Icons.phone_iphone_rounded),
                ],
              ),
            );
          });
        }),
        bottomNavigationBar:
            GetBuilder<LocationController>(builder: (locationController) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: Dimenciones.height20*8,
              padding: EdgeInsets.only(
                  top: Dimenciones.height30,
                  bottom: Dimenciones.height30,
                  left: Dimenciones.width20,
                  right: Dimenciones.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimenciones.radius20 * 2),
                      topRight: Radius.circular(Dimenciones.radius20 * 2))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AddressModel _addressModel = AddressModel(
                          addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                          contactPersonName: _contactPersonNameController.text,
                          contactPersonNumber: _contactPersonNumberController.text,
                          address: _addressController.text,
                          latitude: locationController.position.latitude.toString(),
                          longitude: locationController.position.longitude.toString(),
                        );
                        locationController.addAddress(_addressModel).then((response){
                          if (response.isSuccess) {
                            Get.toNamed(RouteHelper.getInitial());
                            Get.snackbar("Dirección", "Agregado exitosamente");
                          } else {
                            Get.snackbar("Dirección", "No se pudo guardar la dirección");
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimenciones.height20,
                            bottom: Dimenciones.height20,
                            left: Dimenciones.width20,
                            right: Dimenciones.width20),
                        child: BigText(
                          text: "Guardar dirección",
                          color: Colors.white,
                          size: 26,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimenciones.radius20),
                            color: AppColors.mainColor),
                      ),
                    )
                  ]),
            ),
          ]);
        }));
    }
  }