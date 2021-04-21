import 'dart:convert';

class TempModel {
  final String id;
  final String idUser;
  final String recDateTime;
  final String recHourTime;
  final String recTemp;
  final String urlTemp;
  TempModel({
    this.id,
    this.idUser,
    this.recDateTime,
    this.recHourTime,
    this.recTemp,
    this.urlTemp,
  });

  TempModel copyWith({
    String id,
    String idUser,
    String recDateTime,
    String recHourTime,
    String recTemp,
    String urlTemp,
  }) {
    return TempModel(
      id: id ?? this.id,
      idUser: idUser ?? this.idUser,
      recDateTime: recDateTime ?? this.recDateTime,
      recHourTime: recHourTime ?? this.recHourTime,
      recTemp: recTemp ?? this.recTemp,
      urlTemp: urlTemp ?? this.urlTemp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idUser': idUser,
      'recDateTime': recDateTime,
      'recHourTime': recHourTime,
      'recTemp': recTemp,
      'urlTemp': urlTemp,
    };
  }

  factory TempModel.fromMap(Map<String, dynamic> map) {
    return TempModel(
      id: map['id'],
      idUser: map['idUser'],
      recDateTime: map['recDateTime'],
      recHourTime: map['recHourTime'],
      recTemp: map['recTemp'],
      urlTemp: map['urlTemp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TempModel.fromJson(String source) =>
      TempModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TempModel(id: $id, idUser: $idUser, recDateTime: $recDateTime, recHourTime: $recHourTime, recTemp: $recTemp, urlTemp: $urlTemp)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TempModel &&
        other.id == id &&
        other.idUser == idUser &&
        other.recDateTime == recDateTime &&
        other.recHourTime == recHourTime &&
        other.recTemp == recTemp &&
        other.urlTemp == urlTemp;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        idUser.hashCode ^
        recDateTime.hashCode ^
        recHourTime.hashCode ^
        recTemp.hashCode ^
        urlTemp.hashCode;
  }
}
