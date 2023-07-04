// ignore_for_file: unnecessary_getters_setters
import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FriendStructStruct extends FFFirebaseStruct {
  FriendStructStruct({
    DocumentReference? friendRef,
    double? ownTheFriend,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _friendRef = friendRef,
        _ownTheFriend = ownTheFriend,
        super(firestoreUtilData);

  // "friendRef" field.
  DocumentReference? _friendRef;
  DocumentReference? get friendRef => _friendRef;
  set friendRef(DocumentReference? val) => _friendRef = val;
  bool hasFriendRef() => _friendRef != null;

  // "ownTheFriend" field.
  double? _ownTheFriend;
  double get ownTheFriend => _ownTheFriend ?? 0.0;
  set ownTheFriend(double? val) => _ownTheFriend = val;
  void incrementOwnTheFriend(double amount) =>
      _ownTheFriend = ownTheFriend + amount;
  bool hasOwnTheFriend() => _ownTheFriend != null;

  static FriendStructStruct fromMap(Map<String, dynamic> data) =>
      FriendStructStruct(
        friendRef: data['friendRef'] as DocumentReference?,
        ownTheFriend: castToType<double>(data['ownTheFriend']),
      );

  static FriendStructStruct? maybeFromMap(dynamic data) =>
      data is Map<String, dynamic> ? FriendStructStruct.fromMap(data) : null;

  Map<String, dynamic> toMap() => {
        'friendRef': _friendRef,
        'ownTheFriend': _ownTheFriend,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'friendRef': serializeParam(
          _friendRef,
          ParamType.DocumentReference,
        ),
        'ownTheFriend': serializeParam(
          _ownTheFriend,
          ParamType.double,
        ),
      }.withoutNulls;

  static FriendStructStruct fromSerializableMap(Map<String, dynamic> data) =>
      FriendStructStruct(
        friendRef: deserializeParam(
          data['friendRef'],
          ParamType.DocumentReference,
          false,
          collectionNamePath: ['users'],
        ),
        ownTheFriend: deserializeParam(
          data['ownTheFriend'],
          ParamType.double,
          false,
        ),
      );

  @override
  String toString() => 'FriendStructStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FriendStructStruct &&
        friendRef == other.friendRef &&
        ownTheFriend == other.ownTheFriend;
  }

  @override
  int get hashCode => const ListEquality().hash([friendRef, ownTheFriend]);
}

FriendStructStruct createFriendStructStruct({
  DocumentReference? friendRef,
  double? ownTheFriend,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    FriendStructStruct(
      friendRef: friendRef,
      ownTheFriend: ownTheFriend,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

FriendStructStruct? updateFriendStructStruct(
  FriendStructStruct? friendStruct, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    friendStruct
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addFriendStructStructData(
  Map<String, dynamic> firestoreData,
  FriendStructStruct? friendStruct,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (friendStruct == null) {
    return;
  }
  if (friendStruct.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  if (!forFieldValue && friendStruct.firestoreUtilData.clearUnsetFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final friendStructData =
      getFriendStructFirestoreData(friendStruct, forFieldValue);
  final nestedData =
      friendStructData.map((k, v) => MapEntry('$fieldName.$k', v));

  final create = friendStruct.firestoreUtilData.create;
  firestoreData.addAll(create ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getFriendStructFirestoreData(
  FriendStructStruct? friendStruct, [
  bool forFieldValue = false,
]) {
  if (friendStruct == null) {
    return {};
  }
  final firestoreData = mapToFirestore(friendStruct.toMap());

  // Add any Firestore field values
  friendStruct.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getFriendStructListFirestoreData(
  List<FriendStructStruct>? friendStructs,
) =>
    friendStructs?.map((e) => getFriendStructFirestoreData(e, true)).toList() ??
    [];
