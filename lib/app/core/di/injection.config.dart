// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:connectivity/connectivity.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../data/datasources/local/local_event_repo.dart' as _i4;
import '../../data/datasources/remote/remote_event_repo.dart' as _i6;
import '../../data/repo/event_repo.dart' as _i7;
import '../../modules/event_detail/controllers/event_detail_controller.dart'
    as _i10;
import '../../modules/home/controllers/home_controller.dart' as _i9;
import '../../services/event_service.dart' as _i8;
import '../network/network_info.dart' as _i5;
import 'register_module.dart' as _i11; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.Connectivity>(registerModule.connectivity);
  gh.lazySingleton<_i4.LocalEventRepo>(() => _i4.LocalEventRepoImpl());
  gh.lazySingleton<_i5.NetworkInfo>(
      () => _i5.NetworkInfoImpl(get<_i3.Connectivity>()));
  gh.lazySingleton<_i6.RemoteEventRepo>(() => _i6.RemoteEventRepoImpl());
  gh.lazySingleton<_i7.EventRepo>(() => _i7.EventRepoImpl(
      get<_i6.RemoteEventRepo>(),
      get<_i4.LocalEventRepo>(),
      get<_i5.NetworkInfo>()));
  gh.lazySingleton<_i8.EventService>(
      () => _i8.EventService(get<_i7.EventRepo>()));
  gh.factory<_i9.HomeController>(
      () => _i9.HomeController(get<_i8.EventService>()));
  gh.factory<_i10.EventDetailController>(
      () => _i10.EventDetailController(get<_i8.EventService>()));
  return get;
}

class _$RegisterModule extends _i11.RegisterModule {
  @override
  _i3.Connectivity get connectivity => _i3.Connectivity();
}
