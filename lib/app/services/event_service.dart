import 'package:dartz/dartz.dart';
import 'package:gdg_festival/app/core/errors/failures.dart';
import 'package:gdg_festival/app/data/models/event.dart';
import 'package:gdg_festival/app/data/repo/event_repo.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class EventService {
  var events = <Event>[].obs;
  EventRepo eventRepo;

  EventService(this.eventRepo);

  Future<Either<Failure, List<Event>>> getEvents() async {
    final failureOrEvents = await eventRepo.getEvents();
    failureOrEvents.fold((failure) {}, (_events) => events.assignAll(_events));
    return failureOrEvents;
  }

  Future<Either<Failure, Event>> getEvent({required String id}) async {
    return eventRepo.getEvent(id: id);
  }

  void favorite({required String id, required bool isFav}) {
    final index = events.indexWhere((e) => e.id == id);
    if (index == -1) return;
    final event = events[index];
    event.isFavorite = !event.isFavorite;
    events[index] = event;
  }
}
