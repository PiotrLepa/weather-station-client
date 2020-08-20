abstract class RawKeyString {
  String get(Map<String, String> localizedStrings);
}

class RawString extends RawKeyString {
  final String rawString;

  RawString(this.rawString);

  @override
  String get(Map<String, String> localizedStrings) => rawString;
}

class KeyString extends RawKeyString {
  final String keyString;

  KeyString(this.keyString);

  @override
  String get(Map<String, String> localizedStrings) =>
      localizedStrings[keyString];
}
