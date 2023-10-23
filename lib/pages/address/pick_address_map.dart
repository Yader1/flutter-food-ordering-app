import 'package:flutter/material.dart';

import '../../base/custom_button.dart';
import '../../controllers/location_controller.dart';
import '../../pages/address/widgets/search_location_dialogue_page.dart';
import '../../routes/route_helper.dart';
import '../../utils/colors.dart';
import '../../utils/dimensiones.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;

  const PickAddressMap({super.key, required this.fromSignup, required this.fromAddress, this.googleMapController});

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initialPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition = LatLng(14.028501, -83.382876);
      _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
    }else{
      if(Get.find<LocationController>().addressList.isNotEmpty){
        _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress["latitude"]), 
          double.parse(Get.find<LocationController>().getAddress["longitude"])
        );
        _cameraPosition = CameraPosition(target: _initialPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController){
      return Scaffold(
        body: SafeArea(child: Center(
          child: SizedBox(
            width: double.maxFinite,
            child: Stack(
              children: [
                GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition,zoom: 17),
                  zoomControlsEnabled: false,
                  onCameraMove: (CameraPosition cameraPosition){
                    _cameraPosition = cameraPosition;
                  },
                  onCameraIdle:() {Get.find<LocationController>().updatePosition(_cameraPosition, false);},
                  onMapCreated: (GoogleMapController mapController){
                    _mapController = mapController;
                    //TODO: PEDIENTE A REVISAR
                    if(!widget.fromAddress){}
                  },
                ),
                Center(
                  child: !locationController.loading?Image.asset("assets/image/pick_marker.png",
                    height: 50.0,
                    width: 50.0,
                  ):const CircularProgressIndicator(),
                ),
                /*
                  Showing and selecting address
                 */
                Positioned(
                  top: Dimenciones.height45,
                  left: Dimenciones.width20,
                  right: Dimenciones.width20,
                  child: InkWell(
                    onTap: ()=> Get.dialog(LocationDialogue(mapController: _mapController)),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: Dimenciones.width10),
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimenciones.radius20/2),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on, size: 25, color: AppColors.yellowColor),
                          Expanded(child: Text(
                            "${locationController.pickPlacemark.name??''}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimenciones.font16
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                          SizedBox(width: Dimenciones.width10),
                          Icon(Icons.search, size: 25.0, color: AppColors.yellowColor)
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  left: Dimenciones.width20,
                  right: Dimenciones.width20,
                  child: locationController.isLoading ? Center( 
                      child: CircularProgressIndicator(),
                    ): CustomButton(
                    buttonText: locationController.inZone ? widget.fromAddress ? "Elegir dirección" : "Elegir ubicación":"El servicio no está disponible en su área",
                    onPressed: (locationController.buttonDisabled || locationController.loading)?null:() {
                      if(locationController.pickPosition.latitude != 0 && locationController.pickPlacemark.name != null){
                        if (widget.fromAddress) {
                          if(widget.googleMapController != null){
                            widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(
                              locationController.pickPosition.latitude,
                              locationController.pickPosition.longitude
                            ))));
                            locationController.setAddAddressData();
                          }
                          //Get.back();
                          Get.toNamed(RouteHelper.getAddressPage());
                        }
                      }
                    },
                  )
                )
              ],
            ),
          ),
        )),
      );
    });
  }
}