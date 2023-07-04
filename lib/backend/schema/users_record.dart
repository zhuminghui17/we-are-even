import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class UsersRecord extends FirestoreRecord {
  UsersRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "display_name" field.
  String? _displayName;
  String get displayName => _displayName ?? '';
  bool hasDisplayName() => _displayName != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "password" field.
  String? _password;
  String get password => _password ?? '';
  bool hasPassword() => _password != null;

  // "age" field.
  int? _age;
  int get age => _age ?? 0;
  bool hasAge() => _age != null;

  // "location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "phone_number" field.
  String? _phoneNumber;
  String get phoneNumber => _phoneNumber ?? '';
  bool hasPhoneNumber() => _phoneNumber != null;

  // "photo_url" field.
  String? _photoUrl;
  String get photoUrl => _photoUrl ?? '';
  bool hasPhotoUrl() => _photoUrl != null;

  // "created_time" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "userTitle" field.
  String? _userTitle;
  String get userTitle => _userTitle ?? '';
  bool hasUserTitle() => _userTitle != null;

  // "activitiesRef" field.
  List<DocumentReference>? _activitiesRef;
  List<DocumentReference> get activitiesRef => _activitiesRef ?? const [];
  bool hasActivitiesRef() => _activitiesRef != null;

  // "uid" field.
  String? _uid;
  String get uid => _uid ?? '';
  bool hasUid() => _uid != null;

  // "friendsList" field.
  List<FriendStructStruct>? _friendsList;
  List<FriendStructStruct> get friendsList => _friendsList ?? const [];
  bool hasFriendsList() => _friendsList != null;

  // "totalBalance" field.
  double? _totalBalance;
  double get totalBalance => _totalBalance ?? 0.0;
  bool hasTotalBalance() => _totalBalance != null;

  // "groupsList" field.
  List<DocumentReference>? _groupsList;
  List<DocumentReference> get groupsList => _groupsList ?? const [];
  bool hasGroupsList() => _groupsList != null;

  void _initializeFields() {
    _displayName = snapshotData['display_name'] as String?;
    _email = snapshotData['email'] as String?;
    _password = snapshotData['password'] as String?;
    _age = castToType<int>(snapshotData['age']);
    _location = snapshotData['location'] as LatLng?;
    _phoneNumber = snapshotData['phone_number'] as String?;
    _photoUrl = snapshotData['photo_url'] as String?;
    _createdTime = snapshotData['created_time'] as DateTime?;
    _userTitle = snapshotData['userTitle'] as String?;
    _activitiesRef = getDataList(snapshotData['activitiesRef']);
    _uid = snapshotData['uid'] as String?;
    _friendsList = getStructList(
      snapshotData['friendsList'],
      FriendStructStruct.fromMap,
    );
    _totalBalance = castToType<double>(snapshotData['totalBalance']);
    _groupsList = getDataList(snapshotData['groupsList']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => UsersRecord.fromSnapshot(s));

  static Future<UsersRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => UsersRecord.fromSnapshot(s));

  static UsersRecord fromSnapshot(DocumentSnapshot snapshot) => UsersRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static UsersRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      UsersRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'UsersRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is UsersRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createUsersRecordData({
  String? displayName,
  String? email,
  String? password,
  int? age,
  LatLng? location,
  String? phoneNumber,
  String? photoUrl,
  DateTime? createdTime,
  String? userTitle,
  String? uid,
  double? totalBalance,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'display_name': displayName,
      'email': email,
      'password': password,
      'age': age,
      'location': location,
      'phone_number': phoneNumber,
      'photo_url': photoUrl,
      'created_time': createdTime,
      'userTitle': userTitle,
      'uid': uid,
      'totalBalance': totalBalance,
    }.withoutNulls,
  );

  return firestoreData;
}

class UsersRecordDocumentEquality implements Equality<UsersRecord> {
  const UsersRecordDocumentEquality();

  @override
  bool equals(UsersRecord? e1, UsersRecord? e2) {
    const listEquality = ListEquality();
    return e1?.displayName == e2?.displayName &&
        e1?.email == e2?.email &&
        e1?.password == e2?.password &&
        e1?.age == e2?.age &&
        e1?.location == e2?.location &&
        e1?.phoneNumber == e2?.phoneNumber &&
        e1?.photoUrl == e2?.photoUrl &&
        e1?.createdTime == e2?.createdTime &&
        e1?.userTitle == e2?.userTitle &&
        listEquality.equals(e1?.activitiesRef, e2?.activitiesRef) &&
        e1?.uid == e2?.uid &&
        listEquality.equals(e1?.friendsList, e2?.friendsList) &&
        e1?.totalBalance == e2?.totalBalance &&
        listEquality.equals(e1?.groupsList, e2?.groupsList);
  }

  @override
  int hash(UsersRecord? e) => const ListEquality().hash([
        e?.displayName,
        e?.email,
        e?.password,
        e?.age,
        e?.location,
        e?.phoneNumber,
        e?.photoUrl,
        e?.createdTime,
        e?.userTitle,
        e?.activitiesRef,
        e?.uid,
        e?.friendsList,
        e?.totalBalance,
        e?.groupsList
      ]);

  @override
  bool isValidKey(Object? o) => o is UsersRecord;
}
