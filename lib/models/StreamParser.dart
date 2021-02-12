class DHT {
  final double temp;
  final double humidity;
  final double solidTEmp;
  final double smoistNow;
  final double fan;
  final double pump;
  final double light;
  // final double light;

  DHT(
      {this.temp,
      this.humidity,
      this.solidTEmp,
      this.smoistNow,
      this.fan,
      this.pump,
      this.light});

  factory DHT.fromJson(Map<dynamic, dynamic> json) {
    double parser(dynamic source) {
      try {
        return double.parse(source.toString());
      } on FormatException {
        return -1;
      }
    }

    return DHT(
        temp: parser(json['AtempNow']),
        humidity: parser(json['AhumidNow']),
        solidTEmp: parser(json['StempNow']),
        smoistNow: parser(json['smoistNow']),
        pump: parser(json['irrigation']),
        light: parser(json['LightNow']),
        fan: parser(json['Fan']));
  }
}
