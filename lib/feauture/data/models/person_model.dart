import 'package:rick_and_morty/feauture/domain/entiities/pereson_entity.dart';
import 'package:flutter/material.dart';

class PersonModel extends PersonEntity {
   int id;
   String name;
  String status;
   String species;
   String type;
   String gender;
   LocationEntity origin;
   LocationEntity location;
   String image;
   List<String> episode;
   DateTime created;

  PersonModel(this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.origin,
      this.location,
      this.image,
      this.episode,
      this.created) : super(
      id,
      name,
      status,
      species,
      type,
      gender,
      origin,
      location,
      image,
      episode,
      created);


  factory PersonModel.fromJson(Map<String, dynamic> json) {
    final id=json['id'];
       final  name = json['name'];
        final status = json['status'];
        final species = json['species'];
       final  type=json['type'];
        final gender=json['gender'];
        final origin=json['origin']['name'];
        final location=json['loacation']['name'];
        final image=json['image'];
        final episode=(json['episode']as List<dynamic>).map((e) => e as String).toList();
        final created=DateTime.parse(json['created']as String);
        return PersonModel(id, name, status, species, type, gender, origin, location, image, episode, created);

  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'episode': episode,
      'created': created.toIso8601String(),
    };
  }
}