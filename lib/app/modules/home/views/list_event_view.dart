import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gdg_festival/app/data/models/event.dart';
import 'package:gdg_festival/app/modules/home/controllers/home_controller.dart';
import 'package:gdg_festival/app/routes/app_pages.dart';
import 'package:gdg_festival/app/widgets/favorite_card.dart';
import 'package:get/get.dart';

class ListEventView extends StatelessWidget {
  ListEventView({
    Key? key,
    required this.events,
    required this.homeController,
  }) : super(key: key);

  final List<Event> events;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: EdgeInsets.all(16.0),
          child: SizedBox(
            width: double.infinity,
            height: 200.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 70,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      InkWell(
                        onTap: () => Get.toNamed(Routes.EVENT_DETAIL, parameters: {"id": event.id}),
                        child: CachedNetworkImage(
                          imageUrl: event.imageUrl,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => const SizedBox(),
                        ),
                      ),
                      FavoriteCard(
                        onPressed: () => homeController.onFavorite(id: event.id, isFav: event.isFavorite),
                        isFavorite: event.isFavorite,
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 30,
                  child: Center(
                    child: Text(
                      event.name,
                      style: Get.textTheme.headline4,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
