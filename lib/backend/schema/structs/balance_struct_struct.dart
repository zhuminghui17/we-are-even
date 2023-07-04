// ignore_for_file: unnecessary_getters_setters
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class BalanceStructStruct extends FFFirebaseStruct {
  BalanceStructStruct({
    DocumentReference? userRef,
    double? balance,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _userRef = userRef,
        _balance = balance,
        super(firestoreUtilData);

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  set userRef(DocumentReference? val) => _userRef = val;
  bool hasUserRef() => _userRef != null;

  // "balance" field.
  double? _balance;
  double get balance => _balance ?? 0.0;
  set balance(double? val) => _balance = val;
  void incrementBalance(double amount) => _balance = balance + amount;
  bool hasBalance() => _balance != null;

  static BalanceStructStruct fromMap(Map<String, dynamic> data) =>
      BalanceStructStruct(
        userRef: data['userRef'] as DocumentReference?,
        balance: castToType<double>(data['balance']),
      );

  static BalanceStructStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? BalanceStructStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'userRef': _userRef,
        'balance': _balance,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'userRef': serializeParam(
          _userRef,
          ParamType.DocumentReference,
        ),
        'balance': serializeParam(
          _balance,
          ParamType.double,
        ),
      }.withoutNulls;

  static BalanceStructStruct fromSerializableMap(Map<String, dynamic> data) =>
      BalanceStructStruct(
        userRef: deserializeParam(
          data['userRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        balance: deserializeParam(
          data['balance'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'BalanceStructStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is BalanceStructStruct &&
        userRef == other.userRef &&
        balance == other.balance;
  }

  @override
  int get hashCode => const ListEquality().hash([userRef, balance]);
}

BalanceStructStruct createBalanceStructStruct({
  DocumentReference? userRef,
  double? balance,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    BalanceStructStruct(
      userRef: userRef,
      balance: balance,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

BalanceStructStruct? updateBalanceStructStruct(
  BalanceStructStruct? balanceStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    balanceStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addBalanceStructStructData(
  Map<String, dynamic> firestoreData,
  BalanceStructStruct? balanceStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (balanceStruct == null) {
    return;
  }
  if (balanceStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && balanceStruct.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final balanceStructData =
      getBalanceStructFirestoreData(balanceStruct, forFieldValue);
  final nestedData =
      balanceStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = balanceStruct.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getBalanceStructFirestoreData(
  BalanceStructStruct? balanceStruct, [
  bool forFieldValue = false,
]) {
  if (balanceStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(balanceStruct.toMap());

  // Add any Firestore field values
  balanceStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getBalanceStructListFirestoreData(
  List<BalanceStructStruct>? balanceStructs,
) =>
    balanceStructs
        ?.map((e) => getBalanceStructFirestoreData(e, true))
        .toList() ??
    [];
