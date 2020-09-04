import 'package:json_annotation/json_annotation.dart';

part 'vehicles.g.dart';

@JsonSerializable()
class Vehicles {
    Vehicles();

    String type;
    String brand;
    String model;
    List<String> variants;
    
    factory Vehicles.fromJson(Map<String,dynamic> json) => _$VehiclesFromJson(json);
    Map<String, dynamic> toJson() => _$VehiclesToJson(this);
}
