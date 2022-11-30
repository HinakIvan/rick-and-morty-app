import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/exeption.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/feauture/domain/entiities/pereson_entity.dart';
import 'package:rick_and_morty/feauture/domain/repositories/person_repository.dart';

import '../../../core/platform/network_info.dart';
import '../datasourses/person_local_data_source.dart';
import '../datasourses/person_remote_data_source.dart';

class PersonRepositoryImpl implements  PersonRepository{

   final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
   final NetworkInfo networkInfo;

  PersonRepositoryImpl(this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page)async {
    if (await networkInfo.isConnected){
      try{
      final remotePerson = await remoteDataSource.getAllPersons(page);
      localDataSource.personsToCache(remotePerson);
    return Right(remotePerson);}
    on ServerFailure{return Left(ServerFailure());}}else {
      try{
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      }on CachExeption{
        return Left(CachFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async{
    if (await networkInfo.isConnected){
      try{
        final remotePerson = await remoteDataSource.searchAllPerson(query);
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);}
      on ServerFailure{return Left(ServerFailure());}}else {
      try{
        final locationPerson = await localDataSource.getLastPersonsFromCache();
        return Right(locationPerson);
      }on CachExeption{
        return Left(CachFailure());
      }
    }
  }
  
}