// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars, deprecated_member_use

import 'package:xml/xml.dart';

/// Represents the root element of an EPG (Electronic Program Guide) file.
///
/// This class is an implementation in Dart to parse XMLTV format, which is
/// a standard for representing TV listings. It's based on the XMLTV DTD
/// (Document Type Definition) available at:
/// [XMLTV DTD](https://github.com/XMLTV/xmltv/blob/master/xmltv.dtd)
///
/// The EPG contains all the information parsed from an XMLTV file,
/// including channels, programmes, and various metadata. It closely follows
/// the structure defined in the XMLTV DTD, allowing for comprehensive
/// representation of TV guide data.
class EPG {
  EPG({
    required this.channels,
    required this.programmes,

    /// The date of the EPG.
    this.date,
    this.sourceInfoUrl,
    this.sourceInfoName,
    this.sourceDataUrl,
    this.generatorInfoName,
    this.generatorInfoUrl,
  });

  /// Creates an [EPG] instance from an XML element.
  ///
  /// This factory constructor parses the given [XmlElement] and extracts
  /// all relevant information to create an [EPG] object. It follows the
  /// structure defined in the XMLTV DTD, parsing attributes such as 'date',
  /// 'source-info-url', 'source-info-name', etc., and creates lists of
  /// [Channel] and [Programme] objects from the corresponding XML elements.
  factory EPG.fromXmlElement(XmlElement element) {
    DateTime? parseDateTime(String? value) {
      return value != null && value.isNotEmpty
          ? DateTime.tryParse(value)
          : null;
    }

    return EPG(
      date: parseDateTime(element.getAttribute('date')),
      sourceInfoUrl: element.getAttribute('source-info-url'),
      sourceInfoName: element.getAttribute('source-info-name'),
      sourceDataUrl: element.getAttribute('source-data-url'),
      generatorInfoName: element.getAttribute('generator-info-name'),
      generatorInfoUrl: element.getAttribute('generator-info-url'),
      channels: element.findElements('channel').map((channelElement) {
        // Check if channelElement is not null before parsing
        return Channel.fromXmlElement(channelElement);
      }).toList(),
      programmes: element.findElements('programme').map((programmeElement) {
        // Check if programmeElement is not null before parsing
        return Programme.fromXmlElement(programmeElement);
      }).toList(),
    );
  }
  final DateTime? date;
  final String? sourceInfoUrl;
  final String? sourceInfoName;
  final String? sourceDataUrl;
  final String? generatorInfoName;
  final String? generatorInfoUrl;
  final List<Channel> channels;
  final List<Programme> programmes;
}

/// Represents a TV channel in the XMLTV format.
///
/// This class corresponds to the 'channel' element in the XMLTV DTD.
/// It contains information about a specific TV channel, including its
/// unique identifier, display names, icons, and URLs.
class Channel {
  Channel({
    required this.id,
    required this.displayNames,
    required this.icons,
    required this.urls,
  });

  /// Creates a [Channel] instance from an XML element.
  factory Channel.fromXmlElement(XmlElement element) {
    return Channel(
      id: element.getAttribute('id') ?? '',
      displayNames: element
          .findElements('display-name')
          .map(DisplayName.fromXmlElement)
          .toList(),
      icons: element.findElements('icon').map(Icon.fromXmlElement).toList(),
      urls: element.findElements('url').map(Url.fromXmlElement).toList(),
    );
  }
  final String id;
  final List<DisplayName> displayNames;
  final List<Icon> icons;
  final List<Url> urls;
}

/// Represents a display name for a channel or programme.
///
/// This class corresponds to the 'display-name' element in the XMLTV DTD.
/// It can include a language attribute to specify the name in different languages.
class DisplayName {
  DisplayName({required this.value, this.lang});

  factory DisplayName.fromXmlElement(XmlElement element) {
    return DisplayName(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents an icon (typically an image) associated with a channel or programme.
///
/// This class corresponds to the 'icon' element in the XMLTV DTD.
/// It includes the source URL of the icon and optional width and height attributes.
class Icon {
  Icon({required this.src, this.width, this.height});

  factory Icon.fromXmlElement(XmlElement element) {
    return Icon(
      src: element.getAttribute('src') ?? '',
      width: int.tryParse(element.getAttribute('width') ?? ''),
      height: int.tryParse(element.getAttribute('height') ?? ''),
    );
  }
  final String src;
  final int? width;
  final int? height;
}

/// Represents a URL associated with a channel or programme.
///
/// This class corresponds to the 'url' element in the XMLTV DTD.
/// It can include a system attribute to specify the type or purpose of the URL.
class Url {
  Url({required this.value, this.system});

  factory Url.fromXmlElement(XmlElement element) {
    return Url(
      value: element.text,
      system: element.getAttribute('system'),
    );
  }
  final String value;
  final String? system;
}

/// Represents a TV programme in the XMLTV format.
///
/// This class corresponds to the 'programme' element in the XMLTV DTD.
/// It contains comprehensive information about a specific TV show or event,
/// including timing, titles, descriptions, categories, and various metadata.
class Programme {
  Programme({
    required this.start,
    required this.channel,
    required this.clumpidx,
    required this.titles,
    required this.subTitles,
    required this.descs,
    required this.categories,
    required this.keywords,
    required this.icons,
    required this.urls,
    required this.countries,
    required this.episodeNums,
    required this.isNew,
    required this.subtitles,
    required this.ratings,
    required this.starRatings,
    required this.reviews,
    required this.images,
    this.stop,
    this.pdcStart,
    this.vpsStart,
    this.showview,
    this.videoplus,
    this.credits,
    this.date,
    this.language,
    this.origLanguage,
    this.length,
    this.video,
    this.audio,
    this.previouslyShown,
    this.premiere,
    this.lastChance,
  });

  /// Creates a [Programme] instance from an XML element.
  ///
  /// This factory method parses all the child elements and attributes
  /// defined in the XMLTV DTD for a programme.
  factory Programme.fromXmlElement(XmlElement element) {
    DateTime? parseDateTime(String? value) {
      return value != null && value.isNotEmpty ? DateTime.parse(value) : null;
    }

    DateTime? parseDateTimeWithOffset(String? value) {
      if (value == null || value.isEmpty) return null;
      try {
        // Parse YYYYMMDDHHMMSS +HHMM format
        final date = value.substring(0, 14);
        final offset = value.substring(15);
        return DateTime.parse(
            '${date.substring(0, 8)}T${date.substring(8)}$offset');
      } catch (e) {
        // ignore invalid programme date values from malformed XMLTV sources.
        return null;
      }
    }

    return Programme(
      start: parseDateTimeWithOffset(element.getAttribute('start')) ??
          DateTime.now(),
      stop: parseDateTimeWithOffset(element.getAttribute('stop')),
      pdcStart: parseDateTime(element.getAttribute('pdc-start')),
      vpsStart: parseDateTime(element.getAttribute('vps-start')),
      showview: element.getAttribute('showview'),
      videoplus: element.getAttribute('videoplus'),
      channel: element.getAttribute('channel') ?? '',
      clumpidx: element.getAttribute('clumpidx') ?? '0/1',
      titles: element.findElements('title').map(Title.fromXmlElement).toList(),
      subTitles: element
          .findElements('sub-title')
          .map(SubTitle.fromXmlElement)
          .toList(),
      descs: element.findElements('desc').map(Desc.fromXmlElement).toList(),
      credits: element.getElement('credits') != null
          ? Credits.fromXmlElement(element.getElement('credits')!)
          : null,
      date: element.getElement('date')?.text,
      categories: element
          .findElements('category')
          .map(Category.fromXmlElement)
          .toList(),
      keywords:
          element.findElements('keyword').map(Keyword.fromXmlElement).toList(),
      language: element.getElement('language') != null
          ? Language.fromXmlElement(element.getElement('language')!)
          : null,
      origLanguage: element.getElement('orig-language') != null
          ? OrigLanguage.fromXmlElement(element.getElement('orig-language')!)
          : null,
      length: element.getElement('length') != null
          ? Length.fromXmlElement(element.getElement('length')!)
          : null,
      icons: element.findElements('icon').map(Icon.fromXmlElement).toList(),
      urls: element.findElements('url').map(Url.fromXmlElement).toList(),
      countries:
          element.findElements('country').map(Country.fromXmlElement).toList(),
      episodeNums: element
          .findElements('episode-num')
          .map(EpisodeNum.fromXmlElement)
          .toList(),
      video: element.getElement('video') != null
          ? Video.fromXmlElement(element.getElement('video')!)
          : null,
      audio: element.getElement('audio') != null
          ? Audio.fromXmlElement(element.getElement('audio')!)
          : null,
      previouslyShown: element.getElement('previously-shown') != null
          ? PreviouslyShown.fromXmlElement(
              element.getElement('previously-shown')!)
          : null,
      premiere: element.getElement('premiere') != null
          ? Premiere.fromXmlElement(element.getElement('premiere')!)
          : null,
      lastChance: element.getElement('last-chance') != null
          ? LastChance.fromXmlElement(element.getElement('last-chance')!)
          : null,
      isNew: element.getElement('new') != null,
      subtitles: element
          .findElements('subtitles')
          .map(Subtitles.fromXmlElement)
          .toList(),
      ratings:
          element.findElements('rating').map(Rating.fromXmlElement).toList(),
      starRatings: element
          .findElements('star-rating')
          .map(StarRating.fromXmlElement)
          .toList(),
      reviews:
          element.findElements('review').map(Review.fromXmlElement).toList(),
      images: element.findElements('image').map(Image.fromXmlElement).toList(),
    );
  }
  final DateTime start;
  final DateTime? stop;
  final DateTime? pdcStart;
  final DateTime? vpsStart;
  final String? showview;
  final String? videoplus;
  final String channel;
  final String clumpidx;
  final List<Title> titles;
  final List<SubTitle> subTitles;
  final List<Desc> descs;
  final Credits? credits;
  final String? date;
  final List<Category> categories;
  final List<Keyword> keywords;
  final Language? language;
  final OrigLanguage? origLanguage;
  final Length? length;
  final List<Icon> icons;
  final List<Url> urls;
  final List<Country> countries;
  final List<EpisodeNum> episodeNums;
  final Video? video;
  final Audio? audio;
  final PreviouslyShown? previouslyShown;
  final Premiere? premiere;
  final LastChance? lastChance;
  final bool isNew;
  final List<Subtitles> subtitles;
  final List<Rating> ratings;
  final List<StarRating> starRatings;
  final List<Review> reviews;
  final List<Image> images;
}

/// Represents a title of a programme.
///
/// This class corresponds to the 'title' element in the XMLTV DTD.
/// It can include a language attribute to specify the title in different languages.
class Title {
  Title({required this.value, this.lang});

  factory Title.fromXmlElement(XmlElement element) {
    return Title(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents a subtitle of a programme.
///
/// This class corresponds to the 'sub-title' element in the XMLTV DTD.
/// It can include a language attribute to specify the subtitle in different languages.
class SubTitle {
  SubTitle({required this.value, this.lang});

  factory SubTitle.fromXmlElement(XmlElement element) {
    return SubTitle(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents a description of a programme.
///
/// This class corresponds to the 'desc' element in the XMLTV DTD.
/// It can include a language attribute to specify the description in different languages.
class Desc {
  Desc({required this.value, this.lang});

  factory Desc.fromXmlElement(XmlElement element) {
    return Desc(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents the credits for a programme.
///
/// This class corresponds to the 'credits' element in the XMLTV DTD.
/// It includes various credit roles such as directors, actors, writers, producers, etc.
class Credits {
  Credits({
    required this.directors,
    required this.actors,
    required this.writers,
    required this.adapters,
    required this.producers,
    required this.composers,
    required this.editors,
    required this.presenters,
    required this.commentators,
    required this.guests,
  });

  factory Credits.fromXmlElement(XmlElement element) {
    return Credits(
      directors: element.findElements('director').map((e) => e.text).toList(),
      actors: element.findElements('actor').map(Actor.fromXmlElement).toList(),
      writers: element.findElements('writer').map((e) => e.text).toList(),
      adapters: element.findElements('adapter').map((e) => e.text).toList(),
      producers: element.findElements('producer').map((e) => e.text).toList(),
      composers: element.findElements('composer').map((e) => e.text).toList(),
      editors: element.findElements('editor').map((e) => e.text).toList(),
      presenters: element.findElements('presenter').map((e) => e.text).toList(),
      commentators:
          element.findElements('commentator').map((e) => e.text).toList(),
      guests: element.findElements('guest').map((e) => e.text).toList(),
    );
  }
  final List<String> directors;
  final List<Actor> actors;
  final List<String> writers;
  final List<String> adapters;
  final List<String> producers;
  final List<String> composers;
  final List<String> editors;
  final List<String> presenters;
  final List<String> commentators;
  final List<String> guests;
}

/// Represents an actor in the credits of a programme.
///
/// This class corresponds to the 'actor' element in the XMLTV DTD.
/// It includes the actor's name, role, guest status, and associated images and URLs.
class Actor {
  Actor({
    required this.name,
    required this.guest,
    required this.images,
    required this.urls,
    this.role,
  });

  factory Actor.fromXmlElement(XmlElement element) {
    return Actor(
      name: element.text,
      role: element.getAttribute('role'),
      guest: element.getAttribute('guest') == 'yes',
      images: element.findElements('image').map(Image.fromXmlElement).toList(),
      urls: element.findElements('url').map(Url.fromXmlElement).toList(),
    );
  }
  final String name;
  final String? role;
  final bool guest;
  final List<Image> images;
  final List<Url> urls;
}

/// Represents a category of a programme.
///
/// This class corresponds to the 'category' element in the XMLTV DTD.
/// It can include a language attribute to specify the category in different languages.
class Category {
  Category({required this.value, this.lang});

  factory Category.fromXmlElement(XmlElement element) {
    return Category(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents a keyword associated with a programme.
///
/// This class corresponds to the 'keyword' element in the XMLTV DTD.
/// It can include a language attribute to specify the keyword in different languages.
class Keyword {
  Keyword({required this.value, this.lang});

  factory Keyword.fromXmlElement(XmlElement element) {
    return Keyword(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents the language of a programme.
///
/// This class corresponds to the 'language' element in the XMLTV DTD.
/// It can include a language attribute to specify the language in different languages.
class Language {
  Language({required this.value, this.lang});

  factory Language.fromXmlElement(XmlElement element) {
    return Language(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents the original language of a programme.
///
/// This class corresponds to the 'orig-language' element in the XMLTV DTD.
/// It can include a language attribute to specify the original language in different languages.
class OrigLanguage {
  OrigLanguage({required this.value, this.lang});

  factory OrigLanguage.fromXmlElement(XmlElement element) {
    return OrigLanguage(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents the length of a programme.
///
/// This class corresponds to the 'length' element in the XMLTV DTD.
/// It includes the length value and the units of measurement.
class Length {
  Length({required this.value, required this.units});

  factory Length.fromXmlElement(XmlElement element) {
    return Length(
      value: int.parse(element.text),
      units: element.getAttribute('units') ?? '',
    );
  }
  final int value;
  final String units;
}

/// Represents a country associated with a programme.
///
/// This class corresponds to the 'country' element in the XMLTV DTD.
/// It can include a language attribute to specify the country in different languages.
class Country {
  Country({required this.value, this.lang});

  factory Country.fromXmlElement(XmlElement element) {
    return Country(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String value;
  final String? lang;
}

/// Represents the episode number of a programme.
///
/// This class corresponds to the 'episode-num' element in the XMLTV DTD.
/// It includes the episode number value and the system used for numbering.
class EpisodeNum {
  EpisodeNum({required this.value, required this.system});

  factory EpisodeNum.fromXmlElement(XmlElement element) {
    return EpisodeNum(
      value: element.text,
      system: element.getAttribute('system') ?? 'onscreen',
    );
  }
  final String value;
  final String system;
}

/// Represents the video information of a programme.
///
/// This class corresponds to the 'video' element in the XMLTV DTD.
/// It includes details such as presence, color, aspect ratio, and quality.
class Video {
  Video({this.present, this.colour, this.aspect, this.quality});

  factory Video.fromXmlElement(XmlElement element) {
    return Video(
      present: element.getElement('present')?.text,
      colour: element.getElement('colour')?.text,
      aspect: element.getElement('aspect')?.text,
      quality: element.getElement('quality')?.text,
    );
  }
  final String? present;
  final String? colour;
  final String? aspect;
  final String? quality;
}

/// Represents the audio information of a programme.
///
/// This class corresponds to the 'audio' element in the XMLTV DTD.
/// It includes details such as presence and stereo information.
class Audio {
  Audio({this.present, this.stereo});

  factory Audio.fromXmlElement(XmlElement element) {
    return Audio(
      present: element.getElement('present')?.text,
      stereo: element.getElement('stereo')?.text,
    );
  }
  final String? present;
  final String? stereo;
}

/// Represents information about a previously shown programme.
///
/// This class corresponds to the 'previously-shown' element in the XMLTV DTD.
/// It includes the start time and the channel where the programme was previously shown.
class PreviouslyShown {
  PreviouslyShown({this.start, this.channel});

  factory PreviouslyShown.fromXmlElement(XmlElement element) {
    DateTime? parseDateTime(String? value) {
      return value != null && value.isNotEmpty ? DateTime.parse(value) : null;
    }

    return PreviouslyShown(
      start: parseDateTime(element.getAttribute('start')),
      channel: element.getAttribute('channel'),
    );
  }
  final DateTime? start;
  final String? channel;
}

/// Represents information about a premiere of a programme.
///
/// This class corresponds to the 'premiere' element in the XMLTV DTD.
/// It can include a language attribute to specify the premiere information in different languages.
class Premiere {
  Premiere({this.value, this.lang});

  factory Premiere.fromXmlElement(XmlElement element) {
    return Premiere(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String? value;
  final String? lang;
}

/// Represents information about the last chance to watch a programme.
///
/// This class corresponds to the 'last-chance' element in the XMLTV DTD.
/// It can include a language attribute to specify the last chance information in different languages.
class LastChance {
  LastChance({this.value, this.lang});

  factory LastChance.fromXmlElement(XmlElement element) {
    return LastChance(
      value: element.text,
      lang: element.getAttribute('lang'),
    );
  }
  final String? value;
  final String? lang;
}

/// Represents subtitle information for a programme.
///
/// This class corresponds to the 'subtitles' element in the XMLTV DTD.
/// It includes the type of subtitles and the language they are in.
class Subtitles {
  Subtitles({this.type, this.language});

  factory Subtitles.fromXmlElement(XmlElement element) {
    return Subtitles(
      type: element.getAttribute('type'),
      language: element.getElement('language') != null
          ? Language.fromXmlElement(element.getElement('language')!)
          : null,
    );
  }
  final String? type;
  final Language? language;
}

/// Represents a rating for a programme.
///
/// This class corresponds to the 'rating' element in the XMLTV DTD.
/// It includes the rating system, value, and associated icons.
class Rating {
  Rating({required this.value, required this.icons, this.system});

  factory Rating.fromXmlElement(XmlElement element) {
    return Rating(
      system: element.getAttribute('system'),
      value: element.getElement('value')?.text ?? '',
      icons: element.findElements('icon').map(Icon.fromXmlElement).toList(),
    );
  }
  final String? system;
  final String value;
  final List<Icon> icons;
}

/// Represents a star rating for a programme.
///
/// This class corresponds to the 'star-rating' element in the XMLTV DTD.
/// It includes the rating system, value, and associated icons.
class StarRating {
  StarRating({required this.value, required this.icons, this.system});

  factory StarRating.fromXmlElement(XmlElement element) {
    return StarRating(
      system: element.getAttribute('system'),
      value: element.getElement('value')?.text ?? '',
      icons: element.findElements('icon').map(Icon.fromXmlElement).toList(),
    );
  }
  final String? system;
  final String value;
  final List<Icon> icons;
}

/// Represents a review for a programme.
///
/// This class corresponds to the 'review' element in the XMLTV DTD.
/// It includes the type of review, source, reviewer, language, and the review text.
class Review {
  Review(
      {required this.type,
      required this.value,
      this.source,
      this.reviewer,
      this.lang});

  factory Review.fromXmlElement(XmlElement element) {
    return Review(
      type: element.getAttribute('type') ?? '',
      source: element.getAttribute('source'),
      reviewer: element.getAttribute('reviewer'),
      lang: element.getAttribute('lang'),
      value: element.text,
    );
  }
  final String type;
  final String? source;
  final String? reviewer;
  final String? lang;
  final String value;
}

/// Represents an image associated with a programme.
///
/// This class corresponds to the 'image' element in the XMLTV DTD.
/// It includes the type of image, size, orientation, system, and the image URL.
class Image {
  Image(
      {required this.type,
      required this.value,
      this.size,
      this.orient,
      this.system});

  factory Image.fromXmlElement(XmlElement element) {
    return Image(
      type: element.getAttribute('type') ?? '',
      size: element.getAttribute('size'),
      orient: element.getAttribute('orient'),
      system: element.getAttribute('system'),
      value: element.text,
    );
  }
  final String type;
  final String? size;
  final String? orient;
  final String? system;
  final String value;
}
