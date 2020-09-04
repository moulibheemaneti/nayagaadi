import 'package:naya/models/index.dart';
import 'package:naya/vehicles/vehicles.dart';

class VehiclesInfo{
  List<Map> getAll() => veh;

  List<String> getVehicles() => veh
      .map((map) => Vehicles.fromJson(map))
      .map((e) => e.type)
      .toList();

  getVehicleBrand(String vehicle) => veh
      .map((map) => Vehicles.fromJson(map))
      .where((item) => item.type == vehicle)
      .map((e) => e.brand)
      .toList();

  getVehicleModel(String vehicle, String brand) => veh
      .map((map) => Vehicles.fromJson(map))
      .where((item) => (item.type == vehicle) & (item.brand == brand))
      .map((e) => e.model)
      .toList();

  getVehicleVariant(String vehicle, String brand, String model) => veh
      .map((map) => Vehicles.fromJson(map))
      .where((item) => (item.type == vehicle) & (item.brand == brand) & (item.model==model))
      .map((e) => e.variants)
      .expand((i) => i)
      .toList();

}