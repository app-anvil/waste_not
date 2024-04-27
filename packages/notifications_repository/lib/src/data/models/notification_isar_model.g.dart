// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_isar_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetNotificationIsarModelCollection on Isar {
  IsarCollection<NotificationIsarModel> get notificationIsarModels =>
      this.collection();
}

const NotificationIsarModelSchema = CollectionSchema(
  name: r'NotificationIsarModel',
  id: 4722066407008489912,
  properties: {
    r'boolVal': PropertySchema(
      id: 0,
      name: r'boolVal',
      type: IsarType.bool,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'dateTimeVal': PropertySchema(
      id: 2,
      name: r'dateTimeVal',
      type: IsarType.dateTime,
    ),
    r'intVal': PropertySchema(
      id: 3,
      name: r'intVal',
      type: IsarType.long,
    ),
    r'location': PropertySchema(
      id: 4,
      name: r'location',
      type: IsarType.string,
    ),
    r'readAt': PropertySchema(
      id: 5,
      name: r'readAt',
      type: IsarType.dateTime,
    ),
    r'scheduledAt': PropertySchema(
      id: 6,
      name: r'scheduledAt',
      type: IsarType.dateTime,
    ),
    r'stringVal': PropertySchema(
      id: 7,
      name: r'stringVal',
      type: IsarType.string,
    ),
    r'type': PropertySchema(
      id: 8,
      name: r'type',
      type: IsarType.string,
      enumMap: _NotificationIsarModeltypeEnumValueMap,
    ),
    r'uuid': PropertySchema(
      id: 9,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _notificationIsarModelEstimateSize,
  serialize: _notificationIsarModelSerialize,
  deserialize: _notificationIsarModelDeserialize,
  deserializeProp: _notificationIsarModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _notificationIsarModelGetId,
  getLinks: _notificationIsarModelGetLinks,
  attach: _notificationIsarModelAttach,
  version: '3.1.0+1',
);

int _notificationIsarModelEstimateSize(
  NotificationIsarModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.location.length * 3;
  {
    final value = object.stringVal;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.type.name.length * 3;
  {
    final value = object.uuid;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _notificationIsarModelSerialize(
  NotificationIsarModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.boolVal);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeDateTime(offsets[2], object.dateTimeVal);
  writer.writeLong(offsets[3], object.intVal);
  writer.writeString(offsets[4], object.location);
  writer.writeDateTime(offsets[5], object.readAt);
  writer.writeDateTime(offsets[6], object.scheduledAt);
  writer.writeString(offsets[7], object.stringVal);
  writer.writeString(offsets[8], object.type.name);
  writer.writeString(offsets[9], object.uuid);
}

NotificationIsarModel _notificationIsarModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = NotificationIsarModel();
  object.boolVal = reader.readBoolOrNull(offsets[0]);
  object.createdAt = reader.readDateTime(offsets[1]);
  object.dateTimeVal = reader.readDateTimeOrNull(offsets[2]);
  object.id = id;
  object.intVal = reader.readLongOrNull(offsets[3]);
  object.location = reader.readString(offsets[4]);
  object.readAt = reader.readDateTimeOrNull(offsets[5]);
  object.scheduledAt = reader.readDateTime(offsets[6]);
  object.stringVal = reader.readStringOrNull(offsets[7]);
  object.type = _NotificationIsarModeltypeValueEnumMap[
          reader.readStringOrNull(offsets[8])] ??
      NotificationType.expiringItem;
  object.uuid = reader.readStringOrNull(offsets[9]);
  return object;
}

P _notificationIsarModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readStringOrNull(offset)) as P;
    case 8:
      return (_NotificationIsarModeltypeValueEnumMap[
              reader.readStringOrNull(offset)] ??
          NotificationType.expiringItem) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _NotificationIsarModeltypeEnumValueMap = {
  r'expiringItem': r'expiringItem',
  r'expiredItem': r'expiredItem',
  r'openedItem': r'openedItem',
};
const _NotificationIsarModeltypeValueEnumMap = {
  r'expiringItem': NotificationType.expiringItem,
  r'expiredItem': NotificationType.expiredItem,
  r'openedItem': NotificationType.openedItem,
};

Id _notificationIsarModelGetId(NotificationIsarModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _notificationIsarModelGetLinks(
    NotificationIsarModel object) {
  return [];
}

void _notificationIsarModelAttach(
    IsarCollection<dynamic> col, Id id, NotificationIsarModel object) {
  object.id = id;
}

extension NotificationIsarModelQueryWhereSort
    on QueryBuilder<NotificationIsarModel, NotificationIsarModel, QWhere> {
  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension NotificationIsarModelQueryWhere on QueryBuilder<NotificationIsarModel,
    NotificationIsarModel, QWhereClause> {
  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterWhereClause>
      idBetween(
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
}

extension NotificationIsarModelQueryFilter on QueryBuilder<
    NotificationIsarModel, NotificationIsarModel, QFilterCondition> {
  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> boolValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'boolVal',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> boolValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'boolVal',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> boolValEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'boolVal',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> createdAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> createdAtGreaterThan(
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> dateTimeValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dateTimeVal',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> dateTimeValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dateTimeVal',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> dateTimeValEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dateTimeVal',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> dateTimeValGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dateTimeVal',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> dateTimeValLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dateTimeVal',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> dateTimeValBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dateTimeVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> intValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'intVal',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> intValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'intVal',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> intValEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'intVal',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> intValGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'intVal',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> intValLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'intVal',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> intValBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'intVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> locationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> locationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> locationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> locationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'location',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> locationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> locationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
          QAfterFilterCondition>
      locationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'location',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
          QAfterFilterCondition>
      locationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'location',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> locationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> locationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'location',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> readAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'readAt',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> readAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'readAt',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> readAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'readAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> readAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'readAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> readAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'readAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> readAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'readAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> scheduledAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> scheduledAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> scheduledAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scheduledAt',
        value: value,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> scheduledAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scheduledAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'stringVal',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'stringVal',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stringVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stringVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stringVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stringVal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'stringVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'stringVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
          QAfterFilterCondition>
      stringValContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'stringVal',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
          QAfterFilterCondition>
      stringValMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'stringVal',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stringVal',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> stringValIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'stringVal',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> typeEqualTo(
    NotificationType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> typeGreaterThan(
    NotificationType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> typeLessThan(
    NotificationType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> typeBetween(
    NotificationType lower,
    NotificationType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'type',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
          QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
          QAfterFilterCondition>
      typeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uuid',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidEqualTo(
    String? value, {
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidGreaterThan(
    String? value, {
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidLessThan(
    String? value, {
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidBetween(
    String? lower,
    String? upper, {
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
          QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
          QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension NotificationIsarModelQueryObject on QueryBuilder<
    NotificationIsarModel, NotificationIsarModel, QFilterCondition> {}

extension NotificationIsarModelQueryLinks on QueryBuilder<NotificationIsarModel,
    NotificationIsarModel, QFilterCondition> {}

extension NotificationIsarModelQuerySortBy
    on QueryBuilder<NotificationIsarModel, NotificationIsarModel, QSortBy> {
  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByBoolVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boolVal', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByBoolValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boolVal', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByDateTimeVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeVal', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByDateTimeValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeVal', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByIntVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intVal', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByIntValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intVal', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByReadAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByStringVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stringVal', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByStringValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stringVal', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension NotificationIsarModelQuerySortThenBy
    on QueryBuilder<NotificationIsarModel, NotificationIsarModel, QSortThenBy> {
  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByBoolVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boolVal', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByBoolValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'boolVal', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByDateTimeVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeVal', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByDateTimeValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dateTimeVal', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByIntVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intVal', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByIntValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'intVal', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByLocation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByLocationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'location', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByReadAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'readAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByScheduledAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scheduledAt', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByStringVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stringVal', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByStringValDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stringVal', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension NotificationIsarModelQueryWhereDistinct
    on QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct> {
  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByBoolVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'boolVal');
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByDateTimeVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dateTimeVal');
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByIntVal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'intVal');
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByLocation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'location', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByReadAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'readAt');
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByScheduledAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scheduledAt');
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByStringVal({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stringVal', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByType({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationIsarModel, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension NotificationIsarModelQueryProperty on QueryBuilder<
    NotificationIsarModel, NotificationIsarModel, QQueryProperty> {
  QueryBuilder<NotificationIsarModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<NotificationIsarModel, bool?, QQueryOperations>
      boolValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'boolVal');
    });
  }

  QueryBuilder<NotificationIsarModel, DateTime, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<NotificationIsarModel, DateTime?, QQueryOperations>
      dateTimeValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dateTimeVal');
    });
  }

  QueryBuilder<NotificationIsarModel, int?, QQueryOperations> intValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'intVal');
    });
  }

  QueryBuilder<NotificationIsarModel, String, QQueryOperations>
      locationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'location');
    });
  }

  QueryBuilder<NotificationIsarModel, DateTime?, QQueryOperations>
      readAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'readAt');
    });
  }

  QueryBuilder<NotificationIsarModel, DateTime, QQueryOperations>
      scheduledAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scheduledAt');
    });
  }

  QueryBuilder<NotificationIsarModel, String?, QQueryOperations>
      stringValProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stringVal');
    });
  }

  QueryBuilder<NotificationIsarModel, NotificationType, QQueryOperations>
      typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<NotificationIsarModel, String?, QQueryOperations>
      uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
