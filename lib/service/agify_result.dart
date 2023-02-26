class AgifyResult {
  final int age;

  const AgifyResult(this.age);

  factory AgifyResult.fromJSON(Map<String, dynamic> jsonObject) {
    return AgifyResult(jsonObject['age']);
  }
}
