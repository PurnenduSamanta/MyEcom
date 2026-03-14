import 'package:drift/drift.dart';

class ProductItems extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  RealColumn get price => real()();
  TextColumn get description => text()();
  TextColumn get category => text()();
  TextColumn get image => text()();
  RealColumn get ratingRate => real().withDefault(const Constant(0.0))();
  IntColumn get ratingCount => integer().withDefault(const Constant(0))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
