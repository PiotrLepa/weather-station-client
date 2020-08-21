abstract class RKString {
  String get(Map<String, String> localizedStrings);
}

class RawString extends RKString {
  final String rawString;

  RawString(this.rawString);

  @override
  String get(Map<String, String> localizedStrings) => rawString;
}

class KeyString extends RKString {
  final String keyString;

  KeyString(this.keyString);

  @override
  String get(Map<String, String> localizedStrings) =>
      localizedStrings[keyString];
}

extension RKStringExtensions on String {
  RawString toRawString() => RawString(this);

  KeyString toKeyString() => KeyString(this);
}
