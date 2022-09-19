// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, avoid_js_rounded_ints, prefer_final_locals

extension GetPurchaseModelCollection on Isar {
  IsarCollection<PurchaseModel> get purchaseModels => this.collection();
}

const PurchaseModelSchema = CollectionSchema(
  name: r'Purchase',
  id: -2376489861051921561,
  properties: {
    r'discount': PropertySchema(
      id: 0,
      name: r'discount',
      type: IsarType.long,
    ),
    r'discountFormula': PropertySchema(
      id: 1,
      name: r'discountFormula',
      type: IsarType.string,
    ),
    r'number': PropertySchema(
      id: 2,
      name: r'number',
      type: IsarType.string,
    ),
    r'paymentPaid': PropertySchema(
      id: 3,
      name: r'paymentPaid',
      type: IsarType.long,
    ),
    r'paymentResidual': PropertySchema(
      id: 4,
      name: r'paymentResidual',
      type: IsarType.long,
    ),
    r'publicId': PropertySchema(
      id: 5,
      name: r'publicId',
      type: IsarType.string,
    ),
    r'status': PropertySchema(
      id: 6,
      name: r'status',
      type: IsarType.string,
    ),
    r'subTotal': PropertySchema(
      id: 7,
      name: r'subTotal',
      type: IsarType.long,
    ),
    r'total': PropertySchema(
      id: 8,
      name: r'total',
      type: IsarType.long,
    ),
    r'type': PropertySchema(
      id: 9,
      name: r'type',
      type: IsarType.string,
    )
  },
  estimateSize: _purchaseModelEstimateSize,
  serializeNative: _purchaseModelSerializeNative,
  deserializeNative: _purchaseModelDeserializeNative,
  deserializePropNative: _purchaseModelDeserializePropNative,
  serializeWeb: _purchaseModelSerializeWeb,
  deserializeWeb: _purchaseModelDeserializeWeb,
  deserializePropWeb: _purchaseModelDeserializePropWeb,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _purchaseModelGetId,
  getLinks: _purchaseModelGetLinks,
  attach: _purchaseModelAttach,
  version: '3.0.0-dev.14',
);

int _purchaseModelEstimateSize(
  PurchaseModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.discountFormula.length * 3;
  bytesCount += 3 + object.number.length * 3;
  bytesCount += 3 + object.publicId.length * 3;
  bytesCount += 3 + object.status.length * 3;
  bytesCount += 3 + object.type.length * 3;
  return bytesCount;
}

int _purchaseModelSerializeNative(
  PurchaseModel object,
  IsarBinaryWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.discount);
  writer.writeString(offsets[1], object.discountFormula);
  writer.writeString(offsets[2], object.number);
  writer.writeLong(offsets[3], object.paymentPaid);
  writer.writeLong(offsets[4], object.paymentResidual);
  writer.writeString(offsets[5], object.publicId);
  writer.writeString(offsets[6], object.status);
  writer.writeLong(offsets[7], object.subTotal);
  writer.writeLong(offsets[8], object.total);
  writer.writeString(offsets[9], object.type);
  return writer.usedBytes;
}

PurchaseModel _purchaseModelDeserializeNative(
  Id id,
  IsarBinaryReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PurchaseModel(
    reader.readString(offsets[5]),
    reader.readString(offsets[2]),
    reader.readString(offsets[9]),
    reader.readString(offsets[6]),
    reader.readLong(offsets[7]),
    reader.readString(offsets[1]),
    reader.readLong(offsets[0]),
    reader.readLong(offsets[3]),
    reader.readLong(offsets[4]),
    reader.readLong(offsets[8]),
  );
  object.id = id;
  return object;
}

P _purchaseModelDeserializePropNative<P>(
  IsarBinaryReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Object _purchaseModelSerializeWeb(
    IsarCollection<PurchaseModel> collection, PurchaseModel object) {
  /*final jsObj = IsarNative.newJsObject();*/ throw UnimplementedError();
}

PurchaseModel _purchaseModelDeserializeWeb(
    IsarCollection<PurchaseModel> collection, Object jsObj) {
  /*final object = PurchaseModel(IsarNative.jsObjectGet(jsObj, r'publicId') ?? '',IsarNative.jsObjectGet(jsObj, r'number') ?? '',IsarNative.jsObjectGet(jsObj, r'type') ?? '',IsarNative.jsObjectGet(jsObj, r'status') ?? '',IsarNative.jsObjectGet(jsObj, r'subTotal') ?? (double.negativeInfinity as int),IsarNative.jsObjectGet(jsObj, r'discountFormula') ?? '',IsarNative.jsObjectGet(jsObj, r'discount') ?? (double.negativeInfinity as int),IsarNative.jsObjectGet(jsObj, r'paymentPaid') ?? (double.negativeInfinity as int),IsarNative.jsObjectGet(jsObj, r'paymentResidual') ?? (double.negativeInfinity as int),IsarNative.jsObjectGet(jsObj, r'total') ?? (double.negativeInfinity as int),);object.id = IsarNative.jsObjectGet(jsObj, r'id') ?? (double.negativeInfinity as int);*/
  //return object;
  throw UnimplementedError();
}

P _purchaseModelDeserializePropWeb<P>(Object jsObj, String propertyName) {
  switch (propertyName) {
    default:
      throw IsarError('Illegal propertyName');
  }
}

Id _purchaseModelGetId(PurchaseModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _purchaseModelGetLinks(PurchaseModel object) {
  return [];
}

void _purchaseModelAttach(
    IsarCollection<dynamic> col, Id id, PurchaseModel object) {
  object.id = id;
}

extension PurchaseModelQueryWhereSort
    on QueryBuilder<PurchaseModel, PurchaseModel, QWhere> {
  QueryBuilder<PurchaseModel, PurchaseModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PurchaseModelQueryWhere
    on QueryBuilder<PurchaseModel, PurchaseModel, QWhereClause> {
  QueryBuilder<PurchaseModel, PurchaseModel, QAfterWhereClause> idEqualTo(
      int id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterWhereClause> idNotEqualTo(
      int id) {
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterWhereClause> idGreaterThan(
      int id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterWhereClause> idLessThan(
      int id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterWhereClause> idBetween(
    int lowerId,
    int upperId, {
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

extension PurchaseModelQueryFilter
    on QueryBuilder<PurchaseModel, PurchaseModel, QFilterCondition> {
  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discount',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'discount',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'discount',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'discount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discountFormula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'discountFormula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'discountFormula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'discountFormula',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'discountFormula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'discountFormula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'discountFormula',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'discountFormula',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'discountFormula',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      discountFormulaIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'discountFormula',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition> idEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      idGreaterThan(
    int value, {
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition> idLessThan(
    int value, {
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition> idBetween(
    int lower,
    int upper, {
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'number',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'number',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'number',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'number',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      numberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'number',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      paymentPaidEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentPaid',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      paymentPaidGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentPaid',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      paymentPaidLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentPaid',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      paymentPaidBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentPaid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      paymentResidualEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'paymentResidual',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      paymentResidualGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'paymentResidual',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      paymentResidualLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'paymentResidual',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      paymentResidualBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'paymentResidual',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publicId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'publicId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'publicId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'publicId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'publicId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'publicId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'publicId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'publicId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'publicId',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      publicIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'publicId',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      subTotalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      subTotalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      subTotalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subTotal',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      subTotalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subTotal',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      totalEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      totalGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      totalLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'total',
        value: value,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      totalBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'total',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition> typeEqualTo(
    String value, {
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      typeGreaterThan(
    String value, {
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      typeLessThan(
    String value, {
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition> typeBetween(
    String lower,
    String upper, {
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      typeStartsWith(
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      typeEndsWith(
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

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      typeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'type',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition> typeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'type',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'type',
        value: '',
      ));
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterFilterCondition>
      typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'type',
        value: '',
      ));
    });
  }
}

extension PurchaseModelQueryObject
    on QueryBuilder<PurchaseModel, PurchaseModel, QFilterCondition> {}

extension PurchaseModelQueryLinks
    on QueryBuilder<PurchaseModel, PurchaseModel, QFilterCondition> {}

extension PurchaseModelQuerySortBy
    on QueryBuilder<PurchaseModel, PurchaseModel, QSortBy> {
  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discount', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      sortByDiscountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discount', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      sortByDiscountFormula() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountFormula', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      sortByDiscountFormulaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountFormula', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByPaymentPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentPaid', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      sortByPaymentPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentPaid', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      sortByPaymentResidual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentResidual', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      sortByPaymentResidualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentResidual', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByPublicId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicId', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      sortByPublicIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicId', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortBySubTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subTotal', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      sortBySubTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subTotal', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension PurchaseModelQuerySortThenBy
    on QueryBuilder<PurchaseModel, PurchaseModel, QSortThenBy> {
  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discount', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      thenByDiscountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discount', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      thenByDiscountFormula() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountFormula', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      thenByDiscountFormulaDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'discountFormula', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'number', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByPaymentPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentPaid', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      thenByPaymentPaidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentPaid', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      thenByPaymentResidual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentResidual', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      thenByPaymentResidualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'paymentResidual', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByPublicId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicId', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      thenByPublicIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'publicId', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenBySubTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subTotal', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy>
      thenBySubTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subTotal', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByTotalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'total', Sort.desc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }
}

extension PurchaseModelQueryWhereDistinct
    on QueryBuilder<PurchaseModel, PurchaseModel, QDistinct> {
  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct> distinctByDiscount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discount');
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct>
      distinctByDiscountFormula({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'discountFormula',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct> distinctByNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'number', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct>
      distinctByPaymentPaid() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentPaid');
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct>
      distinctByPaymentResidual() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'paymentResidual');
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct> distinctByPublicId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'publicId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct> distinctByStatus(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct> distinctBySubTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subTotal');
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct> distinctByTotal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'total');
    });
  }

  QueryBuilder<PurchaseModel, PurchaseModel, QDistinct> distinctByType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }
}

extension PurchaseModelQueryProperty
    on QueryBuilder<PurchaseModel, PurchaseModel, QQueryProperty> {
  QueryBuilder<PurchaseModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PurchaseModel, int, QQueryOperations> discountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discount');
    });
  }

  QueryBuilder<PurchaseModel, String, QQueryOperations>
      discountFormulaProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'discountFormula');
    });
  }

  QueryBuilder<PurchaseModel, String, QQueryOperations> numberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'number');
    });
  }

  QueryBuilder<PurchaseModel, int, QQueryOperations> paymentPaidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentPaid');
    });
  }

  QueryBuilder<PurchaseModel, int, QQueryOperations> paymentResidualProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'paymentResidual');
    });
  }

  QueryBuilder<PurchaseModel, String, QQueryOperations> publicIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'publicId');
    });
  }

  QueryBuilder<PurchaseModel, String, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<PurchaseModel, int, QQueryOperations> subTotalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subTotal');
    });
  }

  QueryBuilder<PurchaseModel, int, QQueryOperations> totalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'total');
    });
  }

  QueryBuilder<PurchaseModel, String, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PurchaseModel _$PurchaseModelFromJson(Map<String, dynamic> json) =>
    PurchaseModel(
      json['public_id'] as String,
      json['number'] as String,
      json['type'] as String,
      json['status'] as String,
      json['subtotal'] as int,
      json['discount_formula'] as String,
      json['discount'] as int,
      json['payment_paid'] as int,
      json['payment_residual'] as int,
      json['total'] as int,
      branch: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
      partner: json['partner'] == null
          ? null
          : PartnerModel.fromJson(json['partner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PurchaseModelToJson(PurchaseModel instance) =>
    <String, dynamic>{
      'public_id': instance.publicId,
      'number': instance.number,
      'type': instance.type,
      'status': instance.status,
      'subtotal': instance.subTotal,
      'discount_formula': instance.discountFormula,
      'discount': instance.discount,
      'payment_paid': instance.paymentPaid,
      'payment_residual': instance.paymentResidual,
      'total': instance.total,
      'branch': instance.branch?.toJson(),
      'partner': instance.partner?.toJson(),
    };

PurchaseInsertModel _$PurchaseInsertModelFromJson(Map<String, dynamic> json) =>
    PurchaseInsertModel(
      json['number'] as String,
      json['type'] as String,
      json['status'] as String,
      json['branch_public_id'] as String,
      json['partner_public_id'] as String,
      json['user_public_id'] as String,
      json['deadline'] == null
          ? null
          : DateTime.parse(json['deadline'] as String),
    );

Map<String, dynamic> _$PurchaseInsertModelToJson(
        PurchaseInsertModel instance) =>
    <String, dynamic>{
      'number': instance.number,
      'type': instance.type,
      'status': instance.status,
      'branch_public_id': instance.branchPublicId,
      'partner_public_id': instance.partnerPublicId,
      'user_public_id': instance.userPublicId,
      'deadline': instance.deadline?.toIso8601String(),
    };
