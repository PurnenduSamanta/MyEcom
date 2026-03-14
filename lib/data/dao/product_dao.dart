part of 'package:ecom_mini/data/app_database.dart';

@DriftAccessor(tables: [ProductItems])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  Future<void> saveProducts(List<Product> items) async {
    await transaction(() async {
      await delete(productItems).go();
      await batch((batch) {
        batch.insertAll(
          productItems,
          items
              .map(
                (item) => ProductItemsCompanion(
                  id: Value(item.id),
                  title: Value(item.title),
                  price: Value(item.price),
                  description: Value(item.description),
                  category: Value(item.category),
                  image: Value(item.image),
                  ratingRate: Value(item.ratingRate),
                  ratingCount: Value(item.ratingCount),
                ),
              )
              .toList(),
        );
      });
    });
  }

  Future<List<Product>> getProducts() async {
    final rows = await (select(productItems)
          ..orderBy([(table) => OrderingTerm.asc(table.id)]))
        .get();

    return rows
        .map(
          (row) => Product(
            id: row.id,
            title: row.title,
            price: row.price,
            description: row.description,
            category: row.category,
            image: row.image,
            ratingRate: row.ratingRate,
            ratingCount: row.ratingCount,
          ),
        )
        .toList();
  }

  Stream<List<Product>> watchProducts() {
    return (select(productItems)
          ..orderBy([(table) => OrderingTerm.asc(table.id)]))
        .watch()
        .map(
          (rows) => rows
              .map(
                (row) => Product(
                  id: row.id,
                  title: row.title,
                  price: row.price,
                  description: row.description,
                  category: row.category,
                  image: row.image,
                  ratingRate: row.ratingRate,
                  ratingCount: row.ratingCount,
                ),
              )
              .toList(),
        );
  }
}
