import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tienda_comida/base/custom_app_bar.dart';
import 'package:flutter_tienda_comida/controllers/auth_controller.dart';
import 'package:flutter_tienda_comida/pages/order/view_order.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';
import '../../controllers/order_controller.dart';
import '../../utils/dimensiones.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin{
  TabController? _tabController;
  late bool _isLoggedIn;

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userLoggedIn();

    if(_isLoggedIn){
      log("SALIDA"+_isLoggedIn.toString());
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    } else {
      log("SALIDA"+_isLoggedIn.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn ? Scaffold(
      appBar: const CustomAppBar(title: "My orders"),
      body: Column(
        children: [
          SizedBox(
            width: Dimenciones.screenWidth,
            child: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              indicatorWeight: 3.0,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Theme.of(context).disabledColor,
              controller: _tabController,
              tabs: const [
                Tab(text: "Current"),
                Tab(text: "History")
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  ViewOrder(isCurrent: true),
                  ViewOrder(isCurrent: false)
                ]
            ),
          )
        ],
      ),
    ) : const Scaffold(
      appBar: CustomAppBar(title: "Orders"),
      body: Center(
        child: NoDataPage(text: "Inicie sesion", imgPath: "assets/image/undraw_unlock.svg"),
      ),
    );
  }
}