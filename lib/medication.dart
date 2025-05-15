class Medication {
  final String id;
  final String name;
  final int dosage;
  final DateTime time;
  final String userId;
  final List<DateTime> takenHistory; // 👈 nuevo campo

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.userId,
    this.takenHistory = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'time': time.toIso8601String(),
      'userId': userId,
      'takenHistory': takenHistory.map((dt) => dt.toIso8601String()).toList(),
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['\$id'],
      name: json['name'],
      dosage: json['dosage'] is int
          ? json['dosage']
          : int.parse(json['dosage'].toString()),
      time: DateTime.parse(json['time']),
      userId: json['userId'],
      takenHistory: (json['takenHistory'] != null)
          ? List<String>.from(json['takenHistory'])
              .map((e) => DateTime.parse(e))
              .toList()
          : [],
    );
  }

  Medication copyWith({
    String? id,
    String? name,
    int? dosage,
    DateTime? time,
    String? userId,
    List<DateTime>? takenHistory,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      time: time ?? this.time,
      userId: userId ?? this.userId,
      takenHistory: takenHistory ?? this.takenHistory,
    );
  }
}
