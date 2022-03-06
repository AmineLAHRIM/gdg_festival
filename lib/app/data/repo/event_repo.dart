import 'package:dartz/dartz.dart';
import 'package:gdg_festival/app/core/errors/exceptions.dart';
import 'package:gdg_festival/app/core/errors/failures.dart';
import 'package:gdg_festival/app/core/network/network_info.dart';
import 'package:gdg_festival/app/data/datasources/local/local_event_repo.dart';
import 'package:gdg_festival/app/data/datasources/remote/remote_event_repo.dart';
import 'package:gdg_festival/app/data/models/event.dart';
import 'package:injectable/injectable.dart';

abstract class EventRepo {
  Future<Either<Failure, List<Event>>> getEvents();

  Future<Either<Failure, Event>> getEvent({required String id});
}

@LazySingleton(as: EventRepo)
class EventRepoImpl implements EventRepo {
  NetworkInfo networkInfo;
  RemoteEventRepo remoteEventRepo;
  LocalEventRepo localEventRepo;

  EventRepoImpl(this.remoteEventRepo, this.localEventRepo, this.networkInfo);

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    if (await networkInfo.isConnected()) {
      /// Here we will call the remote layer
      try {
        final events = await remoteEventRepo.getEvents();
        return Right(events);
      } on RemoteException catch (remoteExp) {
        /// Log no fatal Firebase crashlytics
        return Left(ServerFailure(message: remoteExp.message));
      }
    } else {
      /// Here we will call the local layer
      try {
        final events = await localEventRepo.getEvents();
        return Right(events);
      } on CacheException catch (cacheExp) {
        /// Log no fatal Firebase crashlytics
        return Left(CacheFailure(message: cacheExp.message));
      }
    }
  }

  @override
  Future<Either<Failure, Event>> getEvent({required String id}) async {
    if (await networkInfo.isConnected()) {
      /// Here we will call the remote layer
      try {
        final event = await remoteEventRepo.getEvent(id:id);
        return Right(event);
      } on RemoteException catch (remoteExp) {
        /// Log no fatal Firebase crashlytics
        return Left(ServerFailure(message: remoteExp.message));
      }
    } else {
      /// Here we will call the local layer
      try {
        final event = await localEventRepo.getEvent(id:id);
        return Right(event);
      } on CacheException catch (cacheExp) {
        /// Log no fatal Firebase crashlytics
        return Left(CacheFailure(message: cacheExp.message));
      }
    }
  }
}
