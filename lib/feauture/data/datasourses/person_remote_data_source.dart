import 'package:rick_and_morty/core/error/exeption.dart';

import '../models/person_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class PersonRemoteDataSource {
  Future<List<PersonModel>>getAllPersons(int page);
  Future<List<PersonModel>>searchAllPerson(String querry);
}

class PersonRemoteDataSoureImpl implements PersonRemoteDataSource{
  @override
  Future<List<PersonModel>> getAllPersons(int page) async{
    var url = Uri.https('https://rickandmortyapi.com/api/character/?page=$page','/appllication/json' );
    final response = await http.get(url);

    if(response.statusCode==200){
      final persons= json.decode(response.body) ;
      return (persons['results']as List).map((person) => PersonModel.fromJson(person)).toList();
    }else {
      throw ServerExeption();
    }
  }

  @override
  Future<List<PersonModel>> searchAllPerson(String querry)async {
    var url = Uri.https('https://rickandmortyapi.com/api/character/?name=$querry','/appllication/json' );
    final response = await http.get(url);

    if(response.statusCode==200){
      final persons= json.decode(response.body) ;
      return (persons['results']as List).map((person) => PersonModel.fromJson(person)).toList();
    }else {
      throw ServerExeption();
    }
  }

  // _getPersonFromUrl(String url)async{
  //   print(url);
  //   var url = Uri.https(url,'/appllication/json' );
  //   final response = await http.get(url);
  //
  //   if(response.statusCode==200){
  //     final persons= json.decode(response.body) ;
  //     return (persons['results']as List).map((person) => PersonModel.fromJson(person)).toList();
  //   }else {
  //     throw ServerExeption();
  //   }
  // }
}