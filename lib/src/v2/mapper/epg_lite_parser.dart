import 'package:xml/xml_events.dart';
import 'package:xtream_code_client/src/v2/model/epg_lite.dart';

/// Streaming XMLTV parser that extracts a lightweight EPG representation.
class EpgLiteParser {
  EpgLite parse(String xml) {
    final channels = <EpgLiteChannel>[];
    final programmes = <EpgLiteProgramme>[];

    String? channelId;
    List<String>? displayNames;

    String? programmeChannelId;
    DateTime? programmeStart;
    DateTime? programmeStop;
    String? programmeTitle;
    String? programmeDescription;

    String? activeTextField;
    StringBuffer? textBuffer;

    void beginTextField(String field) {
      activeTextField = field;
      textBuffer = StringBuffer();
    }

    void flushTextField(String field) {
      if (activeTextField != field || textBuffer == null) {
        return;
      }
      final text = textBuffer.toString().trim();
      if (field == 'display-name') {
        final names = displayNames;
        if (text.isNotEmpty && names != null) {
          names.add(text);
        }
      } else if (field == 'title') {
        if (text.isNotEmpty) {
          programmeTitle = text;
        }
      } else if (field == 'desc') {
        if (text.isNotEmpty) {
          programmeDescription = text;
        }
      }
      activeTextField = null;
      textBuffer = null;
    }

    for (final event in parseEvents(xml, withBuffer: false)) {
      if (event is XmlStartElementEvent) {
        final name = event.name;
        if (name == 'channel') {
          channelId = _attribute(event, 'id') ?? '';
          displayNames = <String>[];
          continue;
        }

        if (name == 'programme') {
          programmeChannelId = _attribute(event, 'channel') ?? '';
          programmeStart = _parseXmltvDateTime(_attribute(event, 'start'));
          programmeStop = _parseXmltvDateTime(_attribute(event, 'stop'));
          programmeTitle = null;
          programmeDescription = null;
          continue;
        }

        if (name == 'display-name' && displayNames != null) {
          beginTextField(name);
          continue;
        }

        if (name == 'title' && programmeChannelId != null) {
          beginTextField(name);
          continue;
        }

        if (name == 'desc' && programmeChannelId != null) {
          beginTextField(name);
        }
        continue;
      }

      if (event is XmlTextEvent) {
        if (textBuffer != null) {
          textBuffer!.write(event.value);
        }
        continue;
      }

      if (event is XmlEndElementEvent) {
        final name = event.name;

        if (name == 'display-name') {
          flushTextField('display-name');
          continue;
        }

        if (name == 'title') {
          flushTextField('title');
          continue;
        }

        if (name == 'desc') {
          flushTextField('desc');
          continue;
        }

        if (name == 'channel') {
          channels.add(EpgLiteChannel(
            id: channelId ?? '',
            displayNames: displayNames ?? const <String>[],
          ));
          channelId = null;
          displayNames = null;
          continue;
        }

        if (name == 'programme') {
          programmes.add(EpgLiteProgramme(
            channelId: programmeChannelId ?? '',
            start: programmeStart,
            stop: programmeStop,
            title: programmeTitle,
            description: programmeDescription,
          ));
          programmeChannelId = null;
          programmeStart = null;
          programmeStop = null;
          programmeTitle = null;
          programmeDescription = null;
        }
      }
    }

    return EpgLite(
      channels: channels,
      programmes: programmes,
    );
  }

  static String? _attribute(XmlStartElementEvent event, String name) {
    for (final attribute in event.attributes) {
      if (attribute.name == name) {
        return attribute.value;
      }
    }
    return null;
  }

  static DateTime? _parseXmltvDateTime(String? raw) {
    if (raw == null) {
      return null;
    }
    final value = raw.trim();
    if (value.isEmpty) {
      return null;
    }

    // Common XMLTV format: YYYYMMDDHHMMSS +/-HHMM
    if (value.length >= 14) {
      final compact = value.substring(0, 14);
      if (_isAsciiDigits(compact)) {
        final year = int.tryParse(compact.substring(0, 4));
        final month = int.tryParse(compact.substring(4, 6));
        final day = int.tryParse(compact.substring(6, 8));
        final hour = int.tryParse(compact.substring(8, 10));
        final minute = int.tryParse(compact.substring(10, 12));
        final second = int.tryParse(compact.substring(12, 14));

        if (year != null &&
            month != null &&
            day != null &&
            hour != null &&
            minute != null &&
            second != null) {
          final offsetRaw = value.substring(14).trim();
          final base =
              '$year-${_two(month)}-${_two(day)}T${_two(hour)}:${_two(minute)}:${_two(second)}';

          if (offsetRaw.isEmpty) {
            return DateTime.tryParse('${base}Z')?.toUtc();
          }

          final normalizedOffset = _normalizeOffset(offsetRaw);
          if (normalizedOffset != null) {
            return DateTime.tryParse('$base$normalizedOffset')?.toUtc();
          }
        }
      }
    }

    return DateTime.tryParse(value)?.toUtc();
  }

  static bool _isAsciiDigits(String value) {
    for (var i = 0; i < value.length; i++) {
      final codeUnit = value.codeUnitAt(i);
      if (codeUnit < 48 || codeUnit > 57) {
        return false;
      }
    }
    return true;
  }

  static String _two(int value) => value.toString().padLeft(2, '0');

  static String? _normalizeOffset(String offsetRaw) {
    if (offsetRaw.length == 5 &&
        (offsetRaw.startsWith('+') || offsetRaw.startsWith('-')) &&
        _isAsciiDigits(offsetRaw.substring(1))) {
      return '${offsetRaw.substring(0, 3)}:${offsetRaw.substring(3, 5)}';
    }

    if (offsetRaw.length == 6 &&
        (offsetRaw.startsWith('+') || offsetRaw.startsWith('-')) &&
        offsetRaw[3] == ':' &&
        _isAsciiDigits(offsetRaw.substring(1, 3)) &&
        _isAsciiDigits(offsetRaw.substring(4, 6))) {
      return offsetRaw;
    }

    if (offsetRaw.toUpperCase() == 'Z') {
      return 'Z';
    }

    return null;
  }
}
