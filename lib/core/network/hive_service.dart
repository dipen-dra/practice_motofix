import 'package:hive_flutter/adapters.dart';
import 'package:motofix_app/app/constant/hive_constant_table.dart';
import 'package:motofix_app/feature/auth/data/model/user_hive_model.dart';
import 'package:path_provider/path_provider.dart';

class HiveService {
  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    Hive.registerAdapter(UserHiveModelAdapter());
  }

  //   ================ user queries =============
  Future<void> addUser(UserHiveModel user) async {
    final box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userId, user);
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    final box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    return box.values.toList()..sort((a, b) => a.fullName.compareTo(b.fullName));
  }

  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  // ===Auth queries ========
  Future<void> register(UserHiveModel auth) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  //Login using username and password
  Future<UserHiveModel?> login(String email, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere(
      (element) => element.email == email && element.password == password,
      orElse: () => throw Exception('Invalid username or password'),
    );
    box.close();
    return user;
  }

  // clear all data and delete database
  Future<void> clearAll() async {
    await Hive.deleteFromDisk();
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }
}
