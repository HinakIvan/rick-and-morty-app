import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feauture/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty/feauture/presentation/bloc/search_bloc/search_state.dart';

import '../../../domain/usecases/search_person.dart';

const SERVER_FAILURE_MESSAGE = 'Server Failure';
const CACHED_FAILURE_MESSAGE = 'Cache Failure';

class PersonSeachBlock extends Bloc<PersonSearchEvent,PersonSearchState>{
  final SearchPerson searchPerson;
  PersonSeachBlock(this.searchPerson) : super(PersonEmpty());


  @override
  Stream<PersonSearchState> mapEventToState (PersonSearchEvent event)async* {
    if (event is SearchPersons) {
      yield* _mapFetchPersonsToState(event.personQuerry);
    }
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
    await searchPerson (SearchPersonParams(query: personQuery)) ;

    yield failureOrPerson.fold((failure) => PersonSearchError(_mapFailureToMessage(failure)), (person) => PersonSearchLoaded(person));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CachFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
  }

