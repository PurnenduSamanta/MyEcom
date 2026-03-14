// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProductItemsTable extends ProductItems
    with TableInfo<$ProductItemsTable, ProductItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingRateMeta = const VerificationMeta(
    'ratingRate',
  );
  @override
  late final GeneratedColumn<double> ratingRate = GeneratedColumn<double>(
    'rating_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _ratingCountMeta = const VerificationMeta(
    'ratingCount',
  );
  @override
  late final GeneratedColumn<int> ratingCount = GeneratedColumn<int>(
    'rating_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    price,
    description,
    category,
    image,
    ratingRate,
    ratingCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'product_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProductItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('rating_rate')) {
      context.handle(
        _ratingRateMeta,
        ratingRate.isAcceptableOrUnknown(data['rating_rate']!, _ratingRateMeta),
      );
    }
    if (data.containsKey('rating_count')) {
      context.handle(
        _ratingCountMeta,
        ratingCount.isAcceptableOrUnknown(
          data['rating_count']!,
          _ratingCountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProductItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProductItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      ratingRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rating_rate'],
      )!,
      ratingCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating_count'],
      )!,
    );
  }

  @override
  $ProductItemsTable createAlias(String alias) {
    return $ProductItemsTable(attachedDatabase, alias);
  }
}

class ProductItem extends DataClass implements Insertable<ProductItem> {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double ratingRate;
  final int ratingCount;
  const ProductItem({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.ratingRate,
    required this.ratingCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['price'] = Variable<double>(price);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['image'] = Variable<String>(image);
    map['rating_rate'] = Variable<double>(ratingRate);
    map['rating_count'] = Variable<int>(ratingCount);
    return map;
  }

  ProductItemsCompanion toCompanion(bool nullToAbsent) {
    return ProductItemsCompanion(
      id: Value(id),
      title: Value(title),
      price: Value(price),
      description: Value(description),
      category: Value(category),
      image: Value(image),
      ratingRate: Value(ratingRate),
      ratingCount: Value(ratingCount),
    );
  }

  factory ProductItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProductItem(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      price: serializer.fromJson<double>(json['price']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      image: serializer.fromJson<String>(json['image']),
      ratingRate: serializer.fromJson<double>(json['ratingRate']),
      ratingCount: serializer.fromJson<int>(json['ratingCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'price': serializer.toJson<double>(price),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'image': serializer.toJson<String>(image),
      'ratingRate': serializer.toJson<double>(ratingRate),
      'ratingCount': serializer.toJson<int>(ratingCount),
    };
  }

  ProductItem copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    double? ratingRate,
    int? ratingCount,
  }) => ProductItem(
    id: id ?? this.id,
    title: title ?? this.title,
    price: price ?? this.price,
    description: description ?? this.description,
    category: category ?? this.category,
    image: image ?? this.image,
    ratingRate: ratingRate ?? this.ratingRate,
    ratingCount: ratingCount ?? this.ratingCount,
  );
  ProductItem copyWithCompanion(ProductItemsCompanion data) {
    return ProductItem(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      price: data.price.present ? data.price.value : this.price,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      image: data.image.present ? data.image.value : this.image,
      ratingRate: data.ratingRate.present
          ? data.ratingRate.value
          : this.ratingRate,
      ratingCount: data.ratingCount.present
          ? data.ratingCount.value
          : this.ratingCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProductItem(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('ratingRate: $ratingRate, ')
          ..write('ratingCount: $ratingCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    price,
    description,
    category,
    image,
    ratingRate,
    ratingCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProductItem &&
          other.id == this.id &&
          other.title == this.title &&
          other.price == this.price &&
          other.description == this.description &&
          other.category == this.category &&
          other.image == this.image &&
          other.ratingRate == this.ratingRate &&
          other.ratingCount == this.ratingCount);
}

class ProductItemsCompanion extends UpdateCompanion<ProductItem> {
  final Value<int> id;
  final Value<String> title;
  final Value<double> price;
  final Value<String> description;
  final Value<String> category;
  final Value<String> image;
  final Value<double> ratingRate;
  final Value<int> ratingCount;
  const ProductItemsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.price = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.image = const Value.absent(),
    this.ratingRate = const Value.absent(),
    this.ratingCount = const Value.absent(),
  });
  ProductItemsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required double price,
    required String description,
    required String category,
    required String image,
    this.ratingRate = const Value.absent(),
    this.ratingCount = const Value.absent(),
  }) : title = Value(title),
       price = Value(price),
       description = Value(description),
       category = Value(category),
       image = Value(image);
  static Insertable<ProductItem> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<double>? price,
    Expression<String>? description,
    Expression<String>? category,
    Expression<String>? image,
    Expression<double>? ratingRate,
    Expression<int>? ratingCount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (price != null) 'price': price,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (image != null) 'image': image,
      if (ratingRate != null) 'rating_rate': ratingRate,
      if (ratingCount != null) 'rating_count': ratingCount,
    });
  }

  ProductItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<double>? price,
    Value<String>? description,
    Value<String>? category,
    Value<String>? image,
    Value<double>? ratingRate,
    Value<int>? ratingCount,
  }) {
    return ProductItemsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      ratingRate: ratingRate ?? this.ratingRate,
      ratingCount: ratingCount ?? this.ratingCount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (ratingRate.present) {
      map['rating_rate'] = Variable<double>(ratingRate.value);
    }
    if (ratingCount.present) {
      map['rating_count'] = Variable<int>(ratingCount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductItemsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('price: $price, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('image: $image, ')
          ..write('ratingRate: $ratingRate, ')
          ..write('ratingCount: $ratingCount')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProductItemsTable productItems = $ProductItemsTable(this);
  late final ProductDao productDao = ProductDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [productItems];
}

typedef $$ProductItemsTableCreateCompanionBuilder =
    ProductItemsCompanion Function({
      Value<int> id,
      required String title,
      required double price,
      required String description,
      required String category,
      required String image,
      Value<double> ratingRate,
      Value<int> ratingCount,
    });
typedef $$ProductItemsTableUpdateCompanionBuilder =
    ProductItemsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<double> price,
      Value<String> description,
      Value<String> category,
      Value<String> image,
      Value<double> ratingRate,
      Value<int> ratingCount,
    });

class $$ProductItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductItemsTable> {
  $$ProductItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ratingRate => $composableBuilder(
    column: $table.ratingRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ratingCount => $composableBuilder(
    column: $table.ratingCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductItemsTable> {
  $$ProductItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ratingRate => $composableBuilder(
    column: $table.ratingRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ratingCount => $composableBuilder(
    column: $table.ratingCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductItemsTable> {
  $$ProductItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<double> get ratingRate => $composableBuilder(
    column: $table.ratingRate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ratingCount => $composableBuilder(
    column: $table.ratingCount,
    builder: (column) => column,
  );
}

class $$ProductItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductItemsTable,
          ProductItem,
          $$ProductItemsTableFilterComposer,
          $$ProductItemsTableOrderingComposer,
          $$ProductItemsTableAnnotationComposer,
          $$ProductItemsTableCreateCompanionBuilder,
          $$ProductItemsTableUpdateCompanionBuilder,
          (
            ProductItem,
            BaseReferences<_$AppDatabase, $ProductItemsTable, ProductItem>,
          ),
          ProductItem,
          PrefetchHooks Function()
        > {
  $$ProductItemsTableTableManager(_$AppDatabase db, $ProductItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<double> ratingRate = const Value.absent(),
                Value<int> ratingCount = const Value.absent(),
              }) => ProductItemsCompanion(
                id: id,
                title: title,
                price: price,
                description: description,
                category: category,
                image: image,
                ratingRate: ratingRate,
                ratingCount: ratingCount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required double price,
                required String description,
                required String category,
                required String image,
                Value<double> ratingRate = const Value.absent(),
                Value<int> ratingCount = const Value.absent(),
              }) => ProductItemsCompanion.insert(
                id: id,
                title: title,
                price: price,
                description: description,
                category: category,
                image: image,
                ratingRate: ratingRate,
                ratingCount: ratingCount,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductItemsTable,
      ProductItem,
      $$ProductItemsTableFilterComposer,
      $$ProductItemsTableOrderingComposer,
      $$ProductItemsTableAnnotationComposer,
      $$ProductItemsTableCreateCompanionBuilder,
      $$ProductItemsTableUpdateCompanionBuilder,
      (
        ProductItem,
        BaseReferences<_$AppDatabase, $ProductItemsTable, ProductItem>,
      ),
      ProductItem,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProductItemsTableTableManager get productItems =>
      $$ProductItemsTableTableManager(_db, _db.productItems);
}

mixin _$ProductDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProductItemsTable get productItems => attachedDatabase.productItems;
  ProductDaoManager get managers => ProductDaoManager(this);
}

class ProductDaoManager {
  final _$ProductDaoMixin _db;
  ProductDaoManager(this._db);
  $$ProductItemsTableTableManager get productItems =>
      $$ProductItemsTableTableManager(_db.attachedDatabase, _db.productItems);
}
