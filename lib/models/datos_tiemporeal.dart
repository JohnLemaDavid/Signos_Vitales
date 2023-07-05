class DatosRealTime {
  final String bpm;
  final String posicion;
  final String oxigenacion;
  final String bateria;
  final String timestamp;

  DatosRealTime({
    required this.bpm,
    required this.posicion,
    required this.oxigenacion,
    required this.bateria,
    required this.timestamp,
  });

  factory DatosRealTime.fromRTDB(Map<dynamic, dynamic> data) {
    DateTime now = DateTime.now();
    return DatosRealTime(
      bpm: data['bpm'] ?? '0',
      posicion: data['posicion'] ?? '0',
      bateria: data['bateria'] ?? '0',
      oxigenacion: data['oxigenacion'] ?? '0',
      timestamp: data['timestamp'] ?? now.millisecondsSinceEpoch.toString(),
    );
  }
}
