import 'package:flutter/material.dart';

import '../../../controllers/location_controller.dart';
import '../../../utils/dimensiones.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
//import 'package:google_maps_webservice/src/places.dart';

class LocationDialogue extends StatelessWidget {
  final GoogleMapController mapController;
  const LocationDialogue({Key? key, required this.mapController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimenciones.width10),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimenciones.radius20/2),
        ),
        child: SizedBox(
          width: Dimenciones.screenWidth,
          child: SingleChildScrollView(
            child: SizedBox()
            /*TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                textInputAction: TextInputAction.search,
                autofocus: true,
                textCapitalization: TextCapitalization.words,
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(
                  hintText: "ubicacion de busqueda",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      style: BorderStyle.none,
                      width: 0.0
                    )
                  ),
                  hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Dimenciones.font16
                  )
                )
              ),
              onSuggestionSelected: (Prediction suggestion) {
                Get.find<LocationController>().setLocation(suggestion.placeId!, suggestion.description!, mapController);
                Get.back();
              },
              // As we type, it gives us suggestion
              suggestionsCallback: (pattern) async {
                return await Get.find<LocationController>().searchLocation(context, pattern);
              },
              itemBuilder: (BuildContext context, Prediction suggestion) {
                return Padding(
                  padding: EdgeInsets.all(Dimenciones.width10),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.redAccent),
                      Expanded(
                          child: Text(
                            suggestion.description!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline2?.copyWith(
                              color: Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: Dimenciones.font16
                            ),
                          )
                      ),
                    ],
                  ),
                );
              },
            ),*/
          ),
        ),
      ),
    );
  }
}
