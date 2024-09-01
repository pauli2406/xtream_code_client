import 'package:xml/xml.dart';
import 'package:xtream_code_client/src/model/epg/epg.dart';

/// Parses EPG (Electronic Program Guide) data from XML format.
class EpgParser {
  /// Parses the given XML string and returns a [EPG] object.
  EPG parse(String xmlString) {
    final document = XmlDocument.parse(xmlString);
    final epgXml = document.rootElement;
    return EPG.fromXmlElement(epgXml);
  }
}
