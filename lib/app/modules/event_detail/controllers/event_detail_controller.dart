import 'package:gdg_festival/app/core/state/loading_state.dart';
import 'package:gdg_festival/app/data/models/event.dart';
import 'package:gdg_festival/app/services/event_service.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@injectable
class EventDetailController extends GetxController {
  final pageState = Rx<LoadingState>(LoadingState.loading());

  var event = Rx<Event?>(null);

  List<Event> get events => eventService.events;

  var isFavorite = false.obs;

  EventService eventService;

  EventDetailController(this.eventService);

  @override
  void onInit() {
    super.onInit();
    _fetchEvent();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  onFavorite() {
    eventService.favorite(id: event.value!.id, isFav: isFavorite.value);
    isFavorite.toggle();
  }

  void _fetchEvent() async {
    pageState.value = LOADING();
    final _id = Get.parameters['id'];
    if (_id == null) return;
    final failureOrEvent = await eventService.getEvent(id: _id);
    failureOrEvent.fold((l) {}, (_event) {
      event.value = _event;
      isFavorite.value =_event.isFavorite;
      pageState.value = LOADED();
    });
  }
}
