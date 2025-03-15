// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:mrt_reader/app/cubit/navigation_cubit.dart' as _i57;
import 'package:mrt_reader/core/database/app_database.dart' as _i1006;
import 'package:mrt_reader/features/card_history/cubit/card_history_cubit.dart'
    as _i322;
import 'package:mrt_reader/features/card_scan/cubit/card_scan_cubit.dart'
    as _i393;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i57.NavigationCubit>(() => _i57.NavigationCubit());
    gh.singleton<_i1006.DatabaseService>(() => _i1006.DatabaseService());
    gh.factory<_i393.CardScanCubit>(
        () => _i393.CardScanCubit(gh<_i1006.DatabaseService>()));
    gh.factory<_i322.CardHistoryCubit>(
        () => _i322.CardHistoryCubit(gh<_i1006.DatabaseService>()));
    return this;
  }
}
