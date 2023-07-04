import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GroupsRecord extends FirestoreRecord {
  GroupsRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "groupName" field.
  String? _groupName;
  String get groupName => _groupName ?? '';
  bool hasGroupName() => _groupName != null;

  // "groupDescription" field.
  String? _groupDescription;
  String get groupDescription => _groupDescription ?? '';
  bool hasGroupDescription() => _groupDescription != null;

  // "groupMembersRef" field.
  List<DocumentReference>? _groupMembersRef;
  List<DocumentReference> get groupMembersRef => _groupMembersRef ?? const [];
  bool hasGroupMembersRef() => _groupMembersRef != null;

  // "activitiesRef" field.
  List<DocumentReference>? _activitiesRef;
  List<DocumentReference> get activitiesRef => _activitiesRef ?? const [];
  bool hasActivitiesRef() => _activitiesRef != null;

  // "balanceList" field.
  List<BalanceStructStruct>? _balanceList;
  List<BalanceStructStruct> get balanceList => _balanceList ?? const [];
  bool hasBalanceList() => _balanceList != null;

  // "groupIdUserCreated" field.
  String? _groupIdUserCreated;
  String get groupIdUserCreated => _groupIdUserCreated ?? '';
  bool hasGroupIdUserCreated() => _groupIdUserCreated != null;

  void _initializeFields() {
    _groupName = snapshotData['groupName'] as String?;
    _groupDescription = snapshotData['groupDescription'] as String?;
    _groupMembersRef = getDataList(snapshotData['groupMembersRef']);
    _activitiesRef = getDataList(snapshotData['activitiesRef']);
    _balanceList = getStructList(
      snapshotData['balanceList'],
      BalanceStructStruct.fromMap,
    );
    _groupIdUserCreated = snapshotData['groupIdUserCreated'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('groups');

  static Stream<GroupsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => GroupsRecord.fromSnapshot(s));

  static Future<GroupsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => GroupsRecord.fromSnapshot(s));

  static GroupsRecord fromSnapshot(DocumentSnapshot snapshot) => GroupsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static GroupsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      GroupsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'GroupsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is GroupsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createGroupsRecordData({
  String? groupName,
  String? groupDescription,
  String? groupIdUserCreated,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'groupName': groupName,
      'groupDescription': groupDescription,
      'groupIdUserCreated': groupIdUserCreated,
    }.withoutNulls,
  );

  return firestoreData;
}

class GroupsRecordDocumentEquality implements Equality<GroupsRecord> {
  const GroupsRecordDocumentEquality();

  @override
  bool equals(GroupsRecord? e1, GroupsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.groupName == e2?.groupName &&
        e1?.groupDescription == e2?.groupDescription &&
        listEquality.equals(e1?.groupMembersRef, e2?.groupMembersRef) &&
        listEquality.equals(e1?.activitiesRef, e2?.activitiesRef) &&
        listEquality.equals(e1?.balanceList, e2?.balanceList) &&
        e1?.groupIdUserCreated == e2?.groupIdUserCreated;
  }

  @override
  int hash(GroupsRecord? e) => const ListEquality().hash([
        e?.groupName,
        e?.groupDescription,
        e?.groupMembersRef,
        e?.activitiesRef,
        e?.balanceList,
        e?.groupIdUserCreated
      ]);

  @override
  bool isValidKey(Object? o) => o is GroupsRecord;
}
