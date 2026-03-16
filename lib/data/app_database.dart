import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:ecom_mini/data/tables/products_table.dart';
import 'package:ecom_mini/model/product.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';
part 'dao/product_dao.dart';

@DriftDatabase(tables: [ProductItems], daos: [ProductDao])
class AppDatabase extends _$AppDatabase {
  // Private constructor
  AppDatabase._internal() : super(_openConnection());

  static AppDatabase? _instance;

  /// Provide a single shared instance of [AppDatabase].
  ///
  /// Usage: `final db = AppDatabase.instance;`
  static AppDatabase get instance {
    if (_instance == null) {
      _instance = AppDatabase._internal();
    }
    return _instance!;
  }

  @override
  int get schemaVersion => 2;

  static QueryExecutor _openConnection() {
    return LazyDatabase(() async {
      final dir = await getApplicationDocumentsDirectory();
      final file = File(p.join(dir.path, 'ecom_mini.sqlite'));
      return NativeDatabase.createInBackground(file);
    });
  }
}
