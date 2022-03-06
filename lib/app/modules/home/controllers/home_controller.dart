
import 'package:gdg_festival/app/core/errors/failures.dart';
import 'package:gdg_festival/app/core/errors/message_type.dart';
import 'package:gdg_festival/app/core/state/loading_state.dart';
import 'package:gdg_festival/app/data/models/event.dart';
import 'package:gdg_festival/app/services/event_service.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeController extends GetxController {
  var pageState = Rx<LoadingState>(LoadingState.loading());

  EventService eventService;

  HomeController(this.eventService);

  List<Event> get events => eventService.events;

  @override
  void onInit() {
    super.onInit();
    _fetchProducts();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void _fetchProducts() async {
    pageState.value = LOADING();
    final failureOrEvents = await eventService.getEvents();
    failureOrEvents.fold((failure) {
      if (failure is CacheFailure) {
        pageState.value = ERROR(message: failure.message, type: MessageType.danger);
      } else if (failure is ServerFailure) {
        pageState.value = ERROR(message: failure.message, type: MessageType.danger);
      } else {
        pageState.value = ERROR();
      }
    }, (_events) {
      pageState.value = LOADED();
    });
  }

  onFavorite({required String id, required bool isFav}) {
    eventService.favorite(id: id, isFav: isFav);
  }

  Future onRefresh() async {
    _fetchProducts();
  }
}
