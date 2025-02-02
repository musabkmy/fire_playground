// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'api_state.freezed.dart';

// @freezed
// class ApiState<T> with _$ApiState<T> {
//   const factory ApiState.initial() = _Initial;
//   const factory ApiState.loading() = _Loading;
//   const factory ApiState.success(T data) = _Success<T>;
//   const factory ApiState.error(String message) = _Error;
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class City {
  final String? name;
  final String? state;
  final String? country;
  final bool? capital;
  final int? population;
  final List<String>? regions;

  City({
    this.name,
    this.state,
    this.country,
    this.capital,
    this.population,
    this.regions,
  });

  factory City.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return City(
      name: data?['name'],
      state: data?['state'],
      country: data?['country'],
      capital: data?['capital'],
      population: data?['population'],
      regions:
          data?['regions'] is Iterable ? List.from(data?['regions']) : null,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (state != null) "state": state,
      if (country != null) "country": country,
      if (capital != null) "capital": capital,
      if (population != null) "population": population,
      if (regions != null) "regions": regions,
    };
  }
}

void frr() {
  final db = FirebaseFirestore.instance;
  final docRef = db.collection("cities").doc("SF");
  docRef.snapshots().listen(
        (event) => print("current data: ${event.data()}"),
        onError: (error) => print("Listen failed: $error"),
      );

  final docRef2 = db.collection("cities").doc("SF");
  docRef.snapshots(includeMetadataChanges: true).listen((event) {
    // ...
  });
}

Stream<List<QueryDocumentSnapshot<City>>> getCaliforniaCities() {
  final db = FirebaseFirestore.instance;

  return db
      .collection("cities")
      .where("state", isEqualTo: "CA")
      .withConverter(
        fromFirestore: City.fromFirestore,
        toFirestore: (value, _) => value.toFirestore(),
      )
      .snapshots()
      .map((querySnapshot) {
    // ← Implicit yield via transformation
    return querySnapshot.docs.map((doc) => doc).toList();
  });
}
