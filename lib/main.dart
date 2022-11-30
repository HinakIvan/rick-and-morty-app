import 'package:flutter/material.dart';
import 'package:rick_and_morty/feauture/presentation/bloc/search_bloc/search_block.dart';
import 'feauture/presentation/bloc/person_list_cubit/person_list_cubit.dart';
import 'feauture/presentation/pages/person_screen.dart';
import 'locator_service.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'locator_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubit>(
            create: (context) =>
            sl<PersonListCubit>()
              ..loadPerson()),
        BlocProvider<PersonSeachBlock>(
            create: (context) => sl<PersonSeachBlock>()),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: Colors.black54,
          scaffoldBackgroundColor: Colors.grey,
        ),
        home: HomePage(),
      ),
    );
  }}