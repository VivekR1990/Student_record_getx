

import 'package:hive/hive.dart';
part 'db_model.g.dart';



@HiveType(typeId: 1)
class Student {
  
  @HiveField(1)
  String name;
  @HiveField(2)
  String age;
  @HiveField(3)
  String batch;
  @HiveField(4)
  String id;
  @HiveField(5)
  String? imgPath;

  Student({
   
    required this.age,
    required this.batch,
    required this.id,
    required this.name,
    this.imgPath
  });
}