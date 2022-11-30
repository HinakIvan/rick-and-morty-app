import 'package:rick_and_morty/core/error/exeption.dart';

import '../models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
abstract class PersonLocalDataSource{
  Future<List<PersonModel>> getLastPersonsFromCache();
  Future<void> personsToCache(List<PersonModel> persons);
}

class PersonLocalDataSourceImpl implements PersonLocalDataSource {
   late final  SharedPreferences sharedPreferences;

   PersonLocalDataSourceImpl(this.sharedPreferences);


  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList = sharedPreferences.getStringList('cashed_persons_list');
    if (jsonPersonsList!.isNotEmpty ){
return Future.value(jsonPersonsList.map((person) => PersonModel.fromJson(json.decode(person))).toList());
    }else {
      throw CachExeption();
    }
  }

  @override
  Future<void> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonList = persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList('cashed_persons_list', jsonPersonList);
    return Future.value(jsonPersonList);
  }
}