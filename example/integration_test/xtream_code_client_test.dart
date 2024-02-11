import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:xtream_code_client/src/xtream_code_client.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  test('XTream Code Client should be instantiated', () {
    const url = 'https://some-xtream-code-server.com';
    const port = '8080';
    const username = 'TestUser1';
    const password = 'TestPassword2';

    XtreamCode.initialize(
      url: url,
      port: port,
      username: username,
      password: password,
    );

    final xTreamCodeClient = XtreamCode.instance.client;

    expect(xTreamCodeClient, isNotNull);
    expect(
      xTreamCodeClient.baseUrl,
      '$url:$port/player_api.php?username=$username&password=$password',
    );
  });
}
