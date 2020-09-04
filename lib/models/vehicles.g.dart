// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicles _$VehiclesFromJson(Map<String, dynamic> json) {
  return Vehicles()
    ..type = json['type'] as String
    ..brand = json['brand'] as String
    ..model = json['model'] as String
    ..variants = json['variants'] as List<String>;
}

Map<String, dynamic> _$VehiclesToJson(Vehicles instance) => <String, dynamic>{
      'type': instance.type,
      'brand': instance.brand,
      'model': instance.model,
      'variants': instance.variants
    };
