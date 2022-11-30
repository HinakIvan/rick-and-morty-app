import 'package:equatable/equatable.dart';

import '../../../domain/entiities/pereson_entity.dart';

abstract class PersonSearchState extends Equatable{
  PersonSearchState();

  @override
  List<Object> get props =>[];
}

class PersonEmpty extends PersonSearchState{}

class PersonSearchLoading extends PersonSearchState{}

 class PersonSearchLoaded extends PersonSearchState{
  final List<PersonEntity> persons;

  PersonSearchLoaded(this.persons);

  @override
   List<Object> get props =>[persons];
 }

 class PersonSearchError extends PersonSearchState{
  final String message;

  PersonSearchError(this.message);

  @override
  List<Object> get props =>[message];

 }
