class Medication {
  final String id;      // Este campo solo se asigna desde Appwrite (no se envía en JSON)
  final String name;
  final String dosage;
  final DateTime time;
  final String userId;

  Medication({
    required this.id,
    required this.name,
    required this.dosage,
    required this.time,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dosage': dosage,
      'time': time.toIso8601String(),
      'userId': userId,
    };
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['\$id'],              // El ID lo toma del sistema Appwrite
      name: json['name'],
      dosage: json['dosage'],
      time: DateTime.parse(json['time']),
      userId: json['userId'],
    );
  }
}
