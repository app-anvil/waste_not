// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetItemIsarModelCollection on Isar {
  IsarCollection<ItemIsarModel> get itemIsarModels => this.collection();
}

const ItemIsarModelSchema = CollectionSchema(
  name: r'ItemIsarModel',
  id: 7840271036790876950,
  properties: {
    r'amount': PropertySchema(
      id: 0,
      name: r'amount',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'initialExpiryDate': PropertySchema(
      id: 2,
      name: r'initialExpiryDate',
      type: IsarType.dateTime,
    ),
    r'openedAt': PropertySchema(
      id: 3,
      name: r'openedAt',
      type: IsarType.dateTime,
    ),
    r'product': PropertySchema(
      id: 4,
      name: r'product',
      type: IsarType.object,
      target: r'ProductIsar',
    ),
    r'shelf': PropertySchema(
      id: 5,
      name: r'shelf',
      type: IsarType.long,
    ),
    r'unsealedLifeTimeInDays': PropertySchema(
      id: 6,
      name: r'unsealedLifeTimeInDays',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 7,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _itemIsarModelEstimateSize,
  serialize: _itemIsarModelSerialize,
  deserialize: _itemIsarModelDeserialize,
  deserializeProp: _itemIsarModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'storage': LinkSchema(
      id: 7651145346914218454,
      name: r'storage',
      target: r'StorageDbModel',
      single: true,
    )
  },
  embeddedSchemas: {r'ProductIsar': ProductIsarSchema},
  getId: _itemIsarModelGetId,
  getLinks: _itemIsarModelGetLinks,
  attach: _itemIsarModelAttach,
  version: '3.1.0+1',
);

int _itemIsarModelEstimateSize(
  ItemIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      ProductIsarSchema.estimateSize(
          object.product, allOffsets[ProductIsar]!, allOffsets);
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _itemIsarModelSerialize(
  ItemIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.amount);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeDateTime(offsets[2], object.initialExpiryDate);
  writer.writeDateTime(offsets[3], object.openedAt);
  writer.writeObject<ProductIsar>(
    offsets[4],
    allOffsets,
    ProductIsarSchema.serialize,
    object.product,
  );
  writer.writeLong(offsets[5], object.shelf);
  writer.writeLong(offsets[6], object.unsealedLifeTimeInDays);
  writer.writeString(offsets[7], object.uuid);
}

ItemIsarModel _itemIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ItemIsarModel();
  object.amount = reader.readLong(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.id = id;
  object.initialExpiryDate = reader.readDateTime(offsets[2]);
  object.openedAt = reader.readDateTimeOrNull(offsets[3]);
  object.product = reader.readObjectOrNull<ProductIsar>(
        offsets[4],
        ProductIsarSchema.deserialize,
        allOffsets,
      ) ??
      ProductIsar();
  object.shelf = reader.readLongOrNull(offsets[5]);
  object.unsealedLifeTimeInDays = reader.readLongOrNull(offsets[6]);
  object.uuid = reader.readString(offsets[7]);
  return object;
}

P _itemIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTime(offset)) as P;
    case 3:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<ProductIsar>(
            offset,
            ProductIsarSchema.deserialize,
            allOffsets,
          ) ??
          ProductIsar()) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readLongOrNull(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _itemIsarModelGetId(ItemIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _itemIsarModelGetLinks(ItemIsarModel object) {
  return [object.storage];
}

void _itemIsarModelAttach(
    IsarCollection<dynamic> col, Id id, ItemIsarModel object) {
  object.id = id;
  object.storage
      .attach(col, col.isar.collection<StorageDbModel>(), r'storage', id);
}

extension ItemIsarModelQueryWhereSort
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QWhere> {
  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ItemIsarModelQueryWhere
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QWhereClause> {
  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ItemIsarModelQueryFilter
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QFilterCondition> {
  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      amountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      amountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      amountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      amountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      initialExpiryDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initialExpiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      initialExpiryDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'initialExpiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      initialExpiryDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'initialExpiryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      initialExpiryDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'initialExpiryDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      openedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'openedAt',
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      openedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'openedAt',
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      openedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'openedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      openedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'openedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      openedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'openedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      openedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'openedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      shelfIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'shelf',
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      shelfIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'shelf',
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      shelfEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'shelf',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      shelfGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'shelf',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      shelfLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'shelf',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      shelfBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'shelf',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      unsealedLifeTimeInDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unsealedLifeTimeInDays',
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      unsealedLifeTimeInDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unsealedLifeTimeInDays',
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      unsealedLifeTimeInDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unsealedLifeTimeInDays',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      unsealedLifeTimeInDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unsealedLifeTimeInDays',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      unsealedLifeTimeInDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unsealedLifeTimeInDays',
        value: value,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      unsealedLifeTimeInDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unsealedLifeTimeInDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension ItemIsarModelQueryObject
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QFilterCondition> {
  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition> product(
      FilterQuery<ProductIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'product');
    });
  }
}

extension ItemIsarModelQueryLinks
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QFilterCondition> {
  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition> storage(
      FilterQuery<StorageDbModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'storage');
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterFilterCondition>
      storageIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'storage', 0, true, 0, true);
    });
  }
}

extension ItemIsarModelQuerySortBy
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QSortBy> {
  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      sortByInitialExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialExpiryDate', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      sortByInitialExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialExpiryDate', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> sortByOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openedAt', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      sortByOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openedAt', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> sortByShelf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelf', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> sortByShelfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelf', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      sortByUnsealedLifeTimeInDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unsealedLifeTimeInDays', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      sortByUnsealedLifeTimeInDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unsealedLifeTimeInDays', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension ItemIsarModelQuerySortThenBy
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QSortThenBy> {
  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      thenByInitialExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialExpiryDate', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      thenByInitialExpiryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initialExpiryDate', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openedAt', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      thenByOpenedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'openedAt', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByShelf() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelf', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByShelfDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'shelf', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      thenByUnsealedLifeTimeInDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unsealedLifeTimeInDays', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy>
      thenByUnsealedLifeTimeInDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unsealedLifeTimeInDays', Sort.desc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension ItemIsarModelQueryWhereDistinct
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QDistinct> {
  QueryBuilder<ItemIsarModel, ItemIsarModel, QDistinct> distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QDistinct>
      distinctByInitialExpiryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'initialExpiryDate');
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QDistinct> distinctByOpenedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'openedAt');
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QDistinct> distinctByShelf() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'shelf');
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QDistinct>
      distinctByUnsealedLifeTimeInDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unsealedLifeTimeInDays');
    });
  }

  QueryBuilder<ItemIsarModel, ItemIsarModel, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension ItemIsarModelQueryProperty
    on QueryBuilder<ItemIsarModel, ItemIsarModel, QQueryProperty> {
  QueryBuilder<ItemIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ItemIsarModel, int, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<ItemIsarModel, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<ItemIsarModel, DateTime, QQueryOperations>
      initialExpiryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'initialExpiryDate');
    });
  }

  QueryBuilder<ItemIsarModel, DateTime?, QQueryOperations> openedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'openedAt');
    });
  }

  QueryBuilder<ItemIsarModel, ProductIsar, QQueryOperations> productProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'product');
    });
  }

  QueryBuilder<ItemIsarModel, int?, QQueryOperations> shelfProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'shelf');
    });
  }

  QueryBuilder<ItemIsarModel, int?, QQueryOperations>
      unsealedLifeTimeInDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unsealedLifeTimeInDays');
    });
  }

  QueryBuilder<ItemIsarModel, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ProductIsarSchema = Schema(
  name: r'ProductIsar',
  id: 4795372949910402302,
  properties: {
    r'barcode': PropertySchema(
      id: 0,
      name: r'barcode',
      type: IsarType.string,
    ),
    r'expectedShelfLife': PropertySchema(
      id: 1,
      name: r'expectedShelfLife',
      type: IsarType.long,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'imageFrontSmallUrl': PropertySchema(
      id: 3,
      name: r'imageFrontSmallUrl',
      type: IsarType.string,
    ),
    r'imageFrontUrl': PropertySchema(
      id: 4,
      name: r'imageFrontUrl',
      type: IsarType.string,
    ),
    r'measure': PropertySchema(
      id: 5,
      name: r'measure',
      type: IsarType.object,
      target: r'MeasureIsar',
    ),
    r'name': PropertySchema(
      id: 6,
      name: r'name',
      type: IsarType.string,
    ),
    r'unsealedLifeTimeInDays': PropertySchema(
      id: 7,
      name: r'unsealedLifeTimeInDays',
      type: IsarType.long,
    )
  },
  estimateSize: _productIsarEstimateSize,
  serialize: _productIsarSerialize,
  deserialize: _productIsarDeserialize,
  deserializeProp: _productIsarDeserializeProp,
);

int _productIsarEstimateSize(
  ProductIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.barcode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  {
    final value = object.imageFrontSmallUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageFrontUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.measure;
    if (value != null) {
      bytesCount += 3 +
          MeasureIsarSchema.estimateSize(
              value, allOffsets[MeasureIsar]!, allOffsets);
    }
  }
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _productIsarSerialize(
  ProductIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.barcode);
  writer.writeLong(offsets[1], object.expectedShelfLife);
  writer.writeString(offsets[2], object.id);
  writer.writeString(offsets[3], object.imageFrontSmallUrl);
  writer.writeString(offsets[4], object.imageFrontUrl);
  writer.writeObject<MeasureIsar>(
    offsets[5],
    allOffsets,
    MeasureIsarSchema.serialize,
    object.measure,
  );
  writer.writeString(offsets[6], object.name);
  writer.writeLong(offsets[7], object.unsealedLifeTimeInDays);
}

ProductIsar _productIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProductIsar();
  object.barcode = reader.readStringOrNull(offsets[0]);
  object.expectedShelfLife = reader.readLongOrNull(offsets[1]);
  object.id = reader.readString(offsets[2]);
  object.imageFrontSmallUrl = reader.readStringOrNull(offsets[3]);
  object.imageFrontUrl = reader.readStringOrNull(offsets[4]);
  object.measure = reader.readObjectOrNull<MeasureIsar>(
    offsets[5],
    MeasureIsarSchema.deserialize,
    allOffsets,
  );
  object.name = reader.readStringOrNull(offsets[6]);
  object.unsealedLifeTimeInDays = reader.readLongOrNull(offsets[7]);
  return object;
}

P _productIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readObjectOrNull<MeasureIsar>(
        offset,
        MeasureIsarSchema.deserialize,
        allOffsets,
      )) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLongOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ProductIsarQueryFilter
    on QueryBuilder<ProductIsar, ProductIsar, QFilterCondition> {
  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      barcodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'barcode',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      barcodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'barcode',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> barcodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      barcodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> barcodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> barcodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'barcode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      barcodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> barcodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> barcodeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'barcode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> barcodeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'barcode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      barcodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'barcode',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      barcodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'barcode',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      expectedShelfLifeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'expectedShelfLife',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      expectedShelfLifeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'expectedShelfLife',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      expectedShelfLifeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedShelfLife',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      expectedShelfLifeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedShelfLife',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      expectedShelfLifeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedShelfLife',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      expectedShelfLifeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedShelfLife',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageFrontSmallUrl',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageFrontSmallUrl',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFrontSmallUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageFrontSmallUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageFrontSmallUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageFrontSmallUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageFrontSmallUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageFrontSmallUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageFrontSmallUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageFrontSmallUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFrontSmallUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontSmallUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageFrontSmallUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'imageFrontUrl',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'imageFrontUrl',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFrontUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imageFrontUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imageFrontUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imageFrontUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imageFrontUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imageFrontUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imageFrontUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imageFrontUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imageFrontUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      imageFrontUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imageFrontUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      measureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'measure',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      measureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'measure',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      unsealedLifeTimeInDaysIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unsealedLifeTimeInDays',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      unsealedLifeTimeInDaysIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unsealedLifeTimeInDays',
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      unsealedLifeTimeInDaysEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unsealedLifeTimeInDays',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      unsealedLifeTimeInDaysGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unsealedLifeTimeInDays',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      unsealedLifeTimeInDaysLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unsealedLifeTimeInDays',
        value: value,
      ));
    });
  }

  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition>
      unsealedLifeTimeInDaysBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unsealedLifeTimeInDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension ProductIsarQueryObject
    on QueryBuilder<ProductIsar, ProductIsar, QFilterCondition> {
  QueryBuilder<ProductIsar, ProductIsar, QAfterFilterCondition> measure(
      FilterQuery<MeasureIsar> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'measure');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MeasureIsarSchema = Schema(
  name: r'MeasureIsar',
  id: -8173726185507382953,
  properties: {
    r'quantity': PropertySchema(
      id: 0,
      name: r'quantity',
      type: IsarType.double,
    ),
    r'unitOfMeasure': PropertySchema(
      id: 1,
      name: r'unitOfMeasure',
      type: IsarType.string,
      enumMap: _MeasureIsarunitOfMeasureEnumValueMap,
    )
  },
  estimateSize: _measureIsarEstimateSize,
  serialize: _measureIsarSerialize,
  deserialize: _measureIsarDeserialize,
  deserializeProp: _measureIsarDeserializeProp,
);

int _measureIsarEstimateSize(
  MeasureIsar object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.unitOfMeasure;
    if (value != null) {
      bytesCount += 3 + value.name.length * 3;
    }
  }
  return bytesCount;
}

void _measureIsarSerialize(
  MeasureIsar object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.quantity);
  writer.writeString(offsets[1], object.unitOfMeasure?.name);
}

MeasureIsar _measureIsarDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MeasureIsar();
  object.quantity = reader.readDoubleOrNull(offsets[0]);
  object.unitOfMeasure = _MeasureIsarunitOfMeasureValueEnumMap[
      reader.readStringOrNull(offsets[1])];
  return object;
}

P _measureIsarDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDoubleOrNull(offset)) as P;
    case 1:
      return (_MeasureIsarunitOfMeasureValueEnumMap[
          reader.readStringOrNull(offset)]) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _MeasureIsarunitOfMeasureEnumValueMap = {
  r'kilogram': r'kilogram',
  r'liter': r'liter',
};
const _MeasureIsarunitOfMeasureValueEnumMap = {
  r'kilogram': UnitOfMeasure.kilogram,
  r'liter': UnitOfMeasure.liter,
};

extension MeasureIsarQueryFilter
    on QueryBuilder<MeasureIsar, MeasureIsar, QFilterCondition> {
  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      quantityIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      quantityIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantity',
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition> quantityEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      quantityGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      quantityLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition> quantityBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'unitOfMeasure',
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'unitOfMeasure',
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureEqualTo(
    UnitOfMeasure? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitOfMeasure',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureGreaterThan(
    UnitOfMeasure? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unitOfMeasure',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureLessThan(
    UnitOfMeasure? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unitOfMeasure',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureBetween(
    UnitOfMeasure? lower,
    UnitOfMeasure? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unitOfMeasure',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unitOfMeasure',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unitOfMeasure',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unitOfMeasure',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unitOfMeasure',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unitOfMeasure',
        value: '',
      ));
    });
  }

  QueryBuilder<MeasureIsar, MeasureIsar, QAfterFilterCondition>
      unitOfMeasureIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unitOfMeasure',
        value: '',
      ));
    });
  }
}

extension MeasureIsarQueryObject
    on QueryBuilder<MeasureIsar, MeasureIsar, QFilterCondition> {}
