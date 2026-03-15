part of 'package:ecom_mini/data/app_database.dart';

@DriftAccessor(tables: [ProductItems])
class ProductDao extends DatabaseAccessor<AppDatabase> with _$ProductDaoMixin {
  ProductDao(super.db);

  // Helper function to convert database rows to Product objects
  List<Product> _rowsToProducts(List<dynamic> rows) {
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
    final rows = await (select(
      productItems,
    )..orderBy([(table) => OrderingTerm.asc(table.id)])).get();

    return _rowsToProducts(rows);
  }

  Stream<List<Product>> watchProducts() {
    // Create the select query
    final query = select(productItems);
    query.orderBy([(table) => OrderingTerm.asc(table.id)]);

    // Get the stream of rows and map to Products
    return query.watch().map(_rowsToProducts);
  }
}
