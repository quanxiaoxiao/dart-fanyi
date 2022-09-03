import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

const remoteAddress = '123.123.219.80';
const hostname = 'fanyi.youdao.com';
const pathname = 'openapi.do';

const params = {
  'keyfrom': 'vimvim',
  'key': '816393792',
  'type': 'data',
  'doctype': 'json',
  'version': '1.1',
};

Future<void> main(List<String> arguments) async {
  if (arguments.isNotEmpty) {
    final keywords = arguments[0];
    final url = Uri.http(remoteAddress, pathname, {
      ...params,
      'q': keywords,
    });
    final response = await http.get(
      url,
      headers: {
        'host': hostname,
      },
    );
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      final list = decodedResponse['basic']['explains'] as List;
      final line = '#' * 60;
      if (list.isNotEmpty) {
        stdout.writeln(line);
        for (var item in list) {
          stdout.writeln('# $item');
        }
        stdout.writeln(line);
      }
    }
  }
}
