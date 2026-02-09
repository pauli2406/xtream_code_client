import 'package:xtream_code_client/src/model/category.dart' as legacy;
import 'package:xtream_code_client/src/model/channel_epg.dart' as legacy;
import 'package:xtream_code_client/src/model/channel_epg_table.dart' as legacy;
import 'package:xtream_code_client/src/model/general_information.dart'
    as legacy;
import 'package:xtream_code_client/src/model/live_stream_items.dart' as legacy;
import 'package:xtream_code_client/src/model/series_info.dart' as legacy;
import 'package:xtream_code_client/src/model/series_items.dart' as legacy;
import 'package:xtream_code_client/src/model/server_info.dart' as legacy;
import 'package:xtream_code_client/src/model/user_info.dart' as legacy;
import 'package:xtream_code_client/src/model/vod_info.dart' as legacy;
import 'package:xtream_code_client/src/model/vod_items.dart' as legacy;
import 'package:xtream_code_client/src/v2/model/models.dart' as v2;

class LegacyModelMapper {
  static v2.Category toCanonicalCategory(legacy.XTremeCodeCategory category) {
    return v2.Category(
      categoryId: category.categoryId,
      categoryName: category.categoryName,
      parentId: category.parentId,
    );
  }

  static v2.LiveStreamItem toCanonicalLiveStreamItem(
    legacy.XTremeCodeLiveStreamItem item,
  ) {
    return v2.LiveStreamItem(
      num: item.num,
      name: item.name,
      streamType: item.streamType,
      streamId: item.streamId,
      streamIcon: item.streamIcon,
      epgChannelId: item.epgChannelId,
      added: item.added,
      customSid: item.customSid,
      tvArchive: item.tvArchive,
      directSource: item.directSource,
      tvArchiveDuration: item.tvArchiveDuration,
      categoryId: item.categoryId,
      categoryIds: item.categoryIds,
      thumbnail: item.thumbnail,
    );
  }

  static v2.SeriesItem toCanonicalSeriesItem(legacy.XTremeCodeSeriesItem item) {
    return v2.SeriesItem(
      num: item.num,
      name: item.name,
      title: item.title,
      year: item.year,
      streamType: item.streamType,
      seriesId: item.seriesId,
      cover: item.cover,
      plot: item.plot,
      cast: item.cast,
      director: item.director,
      genre: item.genre,
      releaseDate: item.releaseDate == null
          ? null
          : DateTime.tryParse(item.releaseDate!),
      lastModified: item.lastModified,
      rating: item.rating,
      rating5based: item.rating5based,
      backdropPath: item.backdropPath,
      youtubeTrailer: item.youtubeTrailer,
      episodeRunTime: item.episodeRunTime,
      categoryId: item.categoryId,
      categoryIds: item.categoryIds,
    );
  }

  static v2.VodItem toCanonicalVodItem(legacy.XTremeCodeVodItem item) {
    return v2.VodItem(
      streamId: item.streamId,
      num: item.num,
      name: item.name,
      title: item.title,
      year: item.year,
      streamType: item.streamType,
      streamIcon: item.streamIcon,
      rating: item.rating,
      rating5based: item.rating5based,
      added: item.added,
      categoryId: item.categoryId,
      categoryIds: item.categoryIds,
      containerExtension: item.containerExtension,
      customSid: item.customSid,
      directSource: item.directSource,
    );
  }

  static legacy.XTremeCodeCategory toLegacyCategory(v2.Category category) {
    return legacy.XTremeCodeCategory(
      categoryId: category.categoryId,
      categoryName: category.categoryName,
      parentId: category.parentId,
    );
  }

  static List<legacy.XTremeCodeCategory> toLegacyCategoryList(
    List<v2.Category> categories,
  ) {
    final result = <legacy.XTremeCodeCategory>[];
    for (var index = 0; index < categories.length; index++) {
      result.add(toLegacyCategory(categories[index]));
    }
    return result;
  }

  static legacy.XTremeCodeLiveStreamItem toLegacyLiveStreamItem(
      v2.LiveStreamItem item) {
    return legacy.XTremeCodeLiveStreamItem(
      num: item.num,
      name: item.name,
      streamType: item.streamType,
      streamId: item.streamId,
      streamIcon: item.streamIcon,
      epgChannelId: item.epgChannelId,
      added: item.added,
      customSid: item.customSid,
      tvArchive: item.tvArchive,
      directSource: item.directSource,
      tvArchiveDuration: item.tvArchiveDuration,
      categoryId: item.categoryId,
      categoryIds: item.categoryIds,
      thumbnail: item.thumbnail,
    );
  }

  static List<legacy.XTremeCodeLiveStreamItem> toLegacyLiveStreamItemList(
    List<v2.LiveStreamItem> items,
  ) {
    final result = <legacy.XTremeCodeLiveStreamItem>[];
    for (var index = 0; index < items.length; index++) {
      result.add(toLegacyLiveStreamItem(items[index]));
    }
    return result;
  }

  static legacy.XTremeCodeVodItem toLegacyVodItem(v2.VodItem item) {
    return legacy.XTremeCodeVodItem(
      streamId: item.streamId,
      num: item.num,
      name: item.name,
      title: item.title,
      year: item.year,
      streamType: item.streamType,
      streamIcon: item.streamIcon,
      rating: item.rating,
      rating5based: item.rating5based,
      added: item.added,
      categoryId: item.categoryId,
      categoryIds: item.categoryIds,
      containerExtension: item.containerExtension,
      customSid: item.customSid,
      directSource: item.directSource,
    );
  }

  static List<legacy.XTremeCodeVodItem> toLegacyVodItemList(
      List<v2.VodItem> items) {
    final result = <legacy.XTremeCodeVodItem>[];
    for (var index = 0; index < items.length; index++) {
      result.add(toLegacyVodItem(items[index]));
    }
    return result;
  }

  static legacy.XTremeCodeSeriesItem toLegacySeriesItem(v2.SeriesItem item) {
    return legacy.XTremeCodeSeriesItem(
      num: item.num,
      name: item.name,
      title: item.title,
      year: item.year,
      streamType: item.streamType,
      seriesId: item.seriesId,
      cover: item.cover,
      plot: item.plot,
      cast: item.cast,
      director: item.director,
      genre: item.genre,
      releaseDate: _legacyDateString(item.releaseDate),
      lastModified: item.lastModified,
      rating: item.rating,
      rating5based: item.rating5based,
      backdropPath: item.backdropPath,
      youtubeTrailer: item.youtubeTrailer,
      episodeRunTime: item.episodeRunTime,
      categoryId: item.categoryId,
      categoryIds: item.categoryIds,
    );
  }

  static List<legacy.XTremeCodeSeriesItem> toLegacySeriesItemList(
    List<v2.SeriesItem> items,
  ) {
    final result = <legacy.XTremeCodeSeriesItem>[];
    for (var index = 0; index < items.length; index++) {
      result.add(toLegacySeriesItem(items[index]));
    }
    return result;
  }

  static legacy.XTremeCodeGeneralInformation toLegacyGeneralInformation(
    v2.GeneralInformation info,
  ) {
    return legacy.XTremeCodeGeneralInformation(
      userInfo: toLegacyUserInfo(info.userInfo),
      serverInfo: toLegacyServerInfo(info.serverInfo),
    );
  }

  static legacy.XTremeCodeUserInfo toLegacyUserInfo(v2.UserInfo info) {
    return legacy.XTremeCodeUserInfo(
      username: info.username,
      password: info.password,
      message: info.message,
      auth: info.auth,
      status: info.status,
      expDate: info.expDate,
      isTrial: info.isTrial,
      activeCons: info.activeCons,
      createdAt: info.createdAt,
      maxConnections: info.maxConnections,
      allowedOutputFormats: info.allowedOutputFormats,
    );
  }

  static legacy.XTremeCodeServerInfo toLegacyServerInfo(v2.ServerInfo info) {
    return legacy.XTremeCodeServerInfo(
      xui: info.xui,
      version: info.version,
      revision: info.revision,
      url: info.url,
      port: info.port,
      httpsPort: info.httpsPort,
      serverProtocol: info.serverProtocol,
      rtmpPort: info.rtmpPort,
      timestampNow: info.timestampNow,
      timeNow: info.timeNow,
      timezone: info.timezone,
    );
  }

  static legacy.XTremeCodeVodInfo toLegacyVodInfo(v2.VodInfo info) {
    return legacy.XTremeCodeVodInfo(
      info: toLegacyVodDetails(info.info),
      movieData: toLegacyMovieData(info.movieData),
    );
  }

  static legacy.XTremeCodeInfoVod toLegacyVodDetails(v2.VodDetails details) {
    return legacy.XTremeCodeInfoVod(
      kinopoiskUrl: details.kinopoiskUrl,
      tmdbId: details.tmdbId,
      name: details.name,
      oName: details.oName,
      coverBig: details.coverBig,
      movieImage: details.movieImage,
      releaseDate: details.releaseDate,
      episodeRunTime: details.episodeRunTime,
      youtubeTrailer: details.youtubeTrailer,
      director: details.director,
      actors: details.actors,
      cast: details.cast,
      description: details.description,
      plot: details.plot,
      age: details.age,
      mpaaRating: details.mpaaRating,
      ratingCountKinopoisk: details.ratingCountKinopoisk,
      country: details.country,
      genre: details.genre,
      backdropPath: details.backdropPath,
      durationSecs: details.durationSecs,
      duration: details.duration,
      bitrate: details.bitrate,
      rating: details.rating,
      releasedate: details.releaseDate,
      subtitles: details.subtitles,
    );
  }

  static legacy.XTremeCodeMovieData toLegacyMovieData(v2.MovieData data) {
    return legacy.XTremeCodeMovieData(
      streamId: data.streamId,
      name: data.name,
      title: data.title,
      year: data.year,
      added: data.added,
      categoryId: data.categoryId,
      categoryIds: data.categoryIds,
      containerExtension: data.containerExtension ?? '',
      customSid: data.customSid,
      directSource: data.directSource,
    );
  }

  static legacy.XTremeCodeSeriesInfo toLegacySeriesInfo(v2.SeriesInfo info) {
    return legacy.XTremeCodeSeriesInfo(
      seasons: info.seasons?.map(toLegacySeason).toList(),
      info: toLegacySeriesDetails(info.info),
      episodes: info.episodes?.map(
        (key, value) => MapEntry(
          key,
          value.map(toLegacyEpisode).toList(),
        ),
      ),
    );
  }

  static legacy.XTremeCodeSeason toLegacySeason(v2.Season season) {
    return legacy.XTremeCodeSeason(
      id: season.id,
      airDate: season.airDate,
      episodeCount: season.episodeCount,
      name: season.name,
      overview: season.overview,
      seasonNumber: season.seasonNumber,
      voteAverage: season.voteAverage,
      cover: season.cover,
      coverBig: season.coverBig,
    );
  }

  static legacy.XTremeCodeInfo toLegacySeriesDetails(v2.SeriesDetails info) {
    return legacy.XTremeCodeInfo(
      name: info.name,
      title: info.title,
      year: info.year,
      cover: info.cover,
      plot: info.plot,
      cast: info.cast,
      director: info.director,
      genre: info.genre,
      releaseDate: info.releaseDate,
      lastModified: info.lastModified,
      rating: info.rating,
      rating5based: info.rating5based,
      backdropPath: info.backdropPath,
      youtubeTrailer: info.youtubeTrailer,
      episodeRunTime: info.episodeRunTime,
      categoryId: info.categoryId,
      categoryIds: info.categoryIds,
    );
  }

  static legacy.XTremeCodeEpisode toLegacyEpisode(v2.Episode episode) {
    return legacy.XTremeCodeEpisode(
      id: episode.id,
      episodeNum: episode.episodeNum,
      title: episode.title,
      containerExtension: episode.containerExtension,
      info: toLegacyEpisodeInfo(episode.info),
      subtitles: episode.subtitles,
      customSid: episode.customSid,
      added: episode.added,
      season: episode.season,
      directSource: episode.directSource,
    );
  }

  static legacy.XTremeCodeEpisodeInfo toLegacyEpisodeInfo(v2.EpisodeInfo info) {
    return legacy.XTremeCodeEpisodeInfo(
      tmdbId: info.tmdbId,
      releaseDate: info.releaseDate,
      plot: info.plot,
      durationSecs: info.durationSecs,
      duration: info.duration,
      movieImage: info.movieImage,
      bitrate: info.bitrate,
      rating: info.rating,
      season: info.season,
      coverBig: info.coverBig,
    );
  }

  static legacy.XTremeCodeChannelEpg toLegacyChannelEpg(v2.ChannelEpg epg) {
    return legacy.XTremeCodeChannelEpg(
      epgListings: epg.epgListings?.map(toLegacyEpgListing).toList(),
    );
  }

  static legacy.XTremeCodeEpgListing toLegacyEpgListing(v2.EpgListing listing) {
    return legacy.XTremeCodeEpgListing(
      id: listing.id,
      epgId: listing.epgId,
      title: listing.title,
      lang: listing.lang,
      start: listing.start,
      end: listing.end,
      description: listing.description,
      channelId: listing.channelId,
      startTimestamp: listing.startTimestamp,
      stopTimestamp: listing.stopTimestamp,
      stop: listing.stop,
    );
  }

  static legacy.XTremeCodeChannelEpgTable toLegacyChannelEpgTable(
    v2.ChannelEpgTable table,
  ) {
    return legacy.XTremeCodeChannelEpgTable(
      epgListings: table.epgListings?.map(toLegacyEpgTableListing).toList(),
    );
  }

  static legacy.XTremeCodeEpgListingTable toLegacyEpgTableListing(
    v2.EpgTableListing listing,
  ) {
    return legacy.XTremeCodeEpgListingTable(
      id: listing.id,
      epgId: listing.epgId,
      title: listing.title,
      lang: listing.lang,
      start: listing.start,
      end: listing.end,
      description: listing.description,
      channelId: listing.channelId ?? '',
      startTimestamp: listing.startTimestamp,
      stopTimestamp: listing.stopTimestamp,
      nowPlaying: listing.nowPlaying ?? false,
      hasArchive: listing.hasArchive ?? false,
    );
  }

  static String? _legacyDateString(DateTime? date) {
    if (date == null) {
      return null;
    }

    final utc = date.toUtc();
    if (utc.hour == 0 &&
        utc.minute == 0 &&
        utc.second == 0 &&
        utc.millisecond == 0 &&
        utc.microsecond == 0) {
      final year = utc.year.toString().padLeft(4, '0');
      final month = utc.month.toString().padLeft(2, '0');
      final day = utc.day.toString().padLeft(2, '0');
      return '$year-$month-$day';
    }

    return utc.toIso8601String();
  }
}
