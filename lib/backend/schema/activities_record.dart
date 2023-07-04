import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ActivitiesRecord extends FirestoreRecord {
  ActivitiesRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "userCreatedRef" field.
  DocumentReference? _userCreatedRef;
  DocumentReference? get userCreatedRef => _userCreatedRef;
  bool hasUserCreatedRef() => _userCreatedRef != null;

  // "createTime" field.
  DateTime? _createTime;
  DateTime? get createTime => _createTime;
  bool hasCreateTime() => _createTime != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "totalExpense" field.
  double? _totalExpense;
  double get totalExpense => _totalExpense ?? 0.0;
  bool hasTotalExpense() => _totalExpense != null;

  // "userPaidRef" field.
  DocumentReference? _userPaidRef;
  DocumentReference? get userPaidRef => _userPaidRef;
  bool hasUserPaidRef() => _userPaidRef != null;

  // "activity" field.
  DateTime? _activity;
  DateTime? get activity => _activity;
  bool hasActivity() => _activity != null;

  // "usersAllRef" field.
  List<DocumentReference>? _usersAllRef;
  List<DocumentReference> get usersAllRef => _usersAllRef ?? const [];
  bool hasUsersAllRef() => _usersAllRef != null;

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  bool hasPhoto() => _photo != null;

  // "groupRef" field.
  DocumentReference? _groupRef;
  DocumentReference? get groupRef => _groupRef;
  bool hasGroupRef() => _groupRef != null;

  void _initializeFields() {
    _userCreatedRef = snapshotData['userCreatedRef'] as DocumentReference?;
    _createTime = snapshotData['createTime'] as DateTime?;
    _description = snapshotData['description'] as String?;
    _totalExpense = castToType<double>(snapshotData['totalExpense']);
    _userPaidRef = snapshotData['userPaidRef'] as DocumentReference?;
    _activity = snapshotData['activity'] as DateTime?;
    _usersAllRef = getDataList(snapshotData['usersAllRef']);
    _photo = snapshotData['photo'] as String?;
    _groupRef = snapshotData['groupRef'] as DocumentReference?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Activities');

  static Stream<ActivitiesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => ActivitiesRecord.fromSnapshot(s));

  static Future<ActivitiesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => ActivitiesRecord.fromSnapshot(s));

  static ActivitiesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      ActivitiesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static ActivitiesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      ActivitiesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'ActivitiesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is ActivitiesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createActivitiesRecordData({
  DocumentReference? userCreatedRef,
  DateTime? createTime,
  String? description,
  double? totalExpense,
  DocumentReference? userPaidRef,
  DateTime? activity,
  String? photo,
  DocumentReference? groupRef,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'userCreatedRef': userCreatedRef,
      'createTime': createTime,
      'description': description,
      'totalExpense': totalExpense,
      'userPaidRef': userPaidRef,
      'activity': activity,
      'photo': photo,
      'groupRef': groupRef,
    }.withoutNulls,
  );

  return firestoreData;
}

class ActivitiesRecordDocumentEquality implements Equality<ActivitiesRecord> {
  const ActivitiesRecordDocumentEquality();

  @override
  bool equals(ActivitiesRecord? e1, ActivitiesRecord? e2) {
    const listEquality = ListEquality();
    return e1?.userCreatedRef == e2?.userCreatedRef &&
        e1?.createTime == e2?.createTime &&
        e1?.description == e2?.description &&
        e1?.totalExpense == e2?.totalExpense &&
        e1?.userPaidRef == e2?.userPaidRef &&
        e1?.activity == e2?.activity &&
        listEquality.equals(e1?.usersAllRef, e2?.usersAllRef) &&
        e1?.photo == e2?.photo &&
        e1?.groupRef == e2?.groupRef;
  }

  @override
  int hash(ActivitiesRecord? e) => const ListEquality().hash([
        e?.userCreatedRef,
        e?.createTime,
        e?.description,
        e?.totalExpense,
        e?.userPaidRef,
        e?.activity,
        e?.usersAllRef,
        e?.photo,
        e?.groupRef
      ]);

  @override
  bool isValidKey(Object? o) => o is ActivitiesRecord;
}
