interface class Constants {
  static const apiKey = String.fromEnvironment(
    'apiKey',
    defaultValue: 'e619a27c2342c4193d3a7a03c7d7be687565ac6e',
  );
  static const baseUrl = 'https://api.todoist.com';
  static const apiV2Path = '/rest/v2';
  static const apiSyncPath = '/sync/v9';
}
