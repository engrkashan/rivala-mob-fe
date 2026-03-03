import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:rivala/models/link_model.dart';

class LinktreeService {
  Future<List<LinkModel>> getLinks(String url) async {
    // Normalize URL
    if (!url.startsWith('http')) {
      url = 'https://$url';
    }

    try {
      final response = await http.get(Uri.parse(url));
      print("--------------------------------------------------");
      print("LINKTREE FETCH LOG");
      print("URL: $url");
      print("STATUS CODE: ${response.statusCode}");
      print(
          "BODY (truncated): ${response.body.length > 500 ? response.body.substring(0, 500) + '...' : response.body}");
      print("--------------------------------------------------");

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        Map<String, LinkModel> linksMap = {};
        var elements = document.getElementsByTagName('a');

        for (var element in elements) {
          var href = element.attributes['href'];
          var text = element.text.trim();

          if (href != null && href.startsWith('http') && text.isNotEmpty) {
            // Filter out Linktree's own operational links
            if (!href.contains('linktr.ee') &&
                !href.contains('cookie') &&
                !text.toLowerCase().contains('linktree') &&
                !text.toLowerCase().contains('sign up') &&
                !text.toLowerCase().contains('log in')) {
              // De-duplicate by URL (normalized)
              String normalizedHref =
                  href.toLowerCase().replaceAll(RegExp(r'/$'), '');
              if (!linksMap.containsKey(normalizedHref)) {
                linksMap[normalizedHref] = LinkModel(name: text, url: href);
              }
            }
          }
        }
        return linksMap.values.toList();
      } else {
        throw Exception('Failed to load Linktree profile');
      }
    } catch (e) {
      throw Exception('Error fetching Linktree: $e');
    }
  }
}
