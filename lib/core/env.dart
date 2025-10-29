// /// Central place for your API base.
// class Env {
//   /// e.g. flutter run --dart-define=API_BASE=https://pmgt.commedialabs.com
//   static const apiBase =
//       String.fromEnvironment('API_BASE', defaultValue: '');
// }


/// Central place for environment constants.
/// If you want to override at build time:
/// flutter run --dart-define=API_BASE=https://your-api
class Env {
  static const String apiBase = String.fromEnvironment(
    'API_BASE',
    defaultValue: 'https://pmgt.commedialabs.com',
  );
}
