import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gdg_festival/app/core/di/injection.dart';
import 'package:gdg_festival/app/modules/home/views/list_event_view.dart';
import 'package:gdg_festival/app/routes/app_pages.dart';
import 'package:gdg_festival/app/widgets/favorite_card.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  final homeController = Get.put(getIt<HomeController>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Container(
          color: Colors.blue.withOpacity(0.05),
          child: Obx(() {
            final pageState = homeController.pageState.value;
            return pageState.map(
              loading: (value) => Center(
                child: CircularProgressIndicator(),
              ),
              empty: (value) => const SizedBox(),
              error: (value) => value.message != null ? Text(value.message!) : const SizedBox(),
              loaded: (value) {
                final events = homeController.events.toList();
                if (events.isEmpty) return Container();
                return RefreshIndicator(
                  onRefresh: () => homeController.onRefresh(),
                  child: ListEventView(
                    events: events,
                    homeController: homeController,
                  ),
                );
              },
            );
          }),
        ));
  }
}
