import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:http/http.dart' as http;
import 'package:rick_and_morty/feauture/presentation/bloc/search_bloc/search_block.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'feauture/data/datasourses/person_local_data_source.dart';
import 'feauture/data/datasourses/person_remote_data_source.dart';
import 'feauture/data/repositories/person_repository_impl.dart';
import 'feauture/domain/repositories/person_repository.dart';
import 'feauture/domain/usecases/get_all_persons.dart';
import 'feauture/domain/usecases/search_person.dart';
import 'feauture/presentation/bloc/person_list_cubit/person_list_cubit.dart';

final sl = GetIt.instance;

  Future<void> init()async {
    sl.registerFactory(
          () => PersonListCubit( sl()),
    );
    sl.registerFactory(
          () => PersonSeachBlock(sl()),
    );

    // UseCases
    sl.registerLazySingleton(() => GetAllPersons(sl()));
    sl.registerLazySingleton(() => SearchPerson(sl()));

    // Repository
    sl.registerLazySingleton<PersonRepository>(
          () => PersonRepositoryImpl(
        sl(),
        sl(),
        sl(),
      ),
    );

    sl.registerLazySingleton<PersonRemoteDataSource>(
          () => PersonRemoteDataSoureImpl(

      ),
    );

    sl.registerLazySingleton<PersonLocalDataSource>(
          () => PersonLocalDataSourceImpl( sl()),
    );

    // Core
    sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(sl()),
    );

    // External
    final  sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }

