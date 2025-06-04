// ignore_for_file: avoid_print

import 'package:xtream_code_client/xtream_code_client.dart';

Future<void> demo() async {
  print('=== XtreamCode Client Demo ===\n');

  try {
    // =================================================================
    // 1. INITIALIZATION
    // =================================================================
    print('1. Initializing XtreamCode client...');
    await XtreamCode.initialize(
      url: 'https://your-server-url',
      port: '8080',
      username: 'your-username',
      password: 'your-password',
      debug: true, // Enable debug logging
    );

    final client = XtreamCode.instance.client;
    print('✓ Client initialized successfully\n');

    // =================================================================
    // 2. SERVER INFORMATION
    // =================================================================
    print('2. Getting server information...');
    final info = await client.serverInformation();
    print('Server info:');
    print('  - Username: ${info.userInfo.username}');
    print('  - Status: ${info.userInfo.status}');
    print('  - Auth: ${info.userInfo.auth}');
    print('  - Active connections: ${info.userInfo.activeCons}');
    print('  - Max connections: ${info.userInfo.maxConnections}');
    print('  - Expiry date: ${info.userInfo.expDate}');
    print('  - Server URL: ${info.serverInfo.url}');
    print('  - Server port: ${info.serverInfo.port}');
    print('  - Server timezone: ${info.serverInfo.timezone}');
    print('  - Base URL: ${client.baseUrl}\n');

    // =================================================================
    // 3. CATEGORIES
    // =================================================================
    print('3. Loading categories...');

    // Live stream categories
    final liveCategories = await client.liveStreamCategories();
    print('Live stream categories: ${liveCategories.length}');
    if (liveCategories.isNotEmpty) {
      print('  Examples:');
      for (var i = 0;
          i < (liveCategories.length > 3 ? 3 : liveCategories.length);
          i++) {
        final cat = liveCategories[i];
        print('    - ${cat.categoryName} (ID: ${cat.categoryId})');
      }
    }

    // VOD categories
    final vodCategories = await client.vodCategories();
    print('VOD categories: ${vodCategories.length}');
    if (vodCategories.isNotEmpty) {
      print('  Examples:');
      for (var i = 0;
          i < (vodCategories.length > 3 ? 3 : vodCategories.length);
          i++) {
        final cat = vodCategories[i];
        print('    - ${cat.categoryName} (ID: ${cat.categoryId})');
      }
    }

    // Series categories
    final seriesCategories = await client.seriesCategories();
    print('Series categories: ${seriesCategories.length}');
    if (seriesCategories.isNotEmpty) {
      print('  Examples:');
      for (var i = 0;
          i < (seriesCategories.length > 3 ? 3 : seriesCategories.length);
          i++) {
        final cat = seriesCategories[i];
        print('    - ${cat.categoryName} (ID: ${cat.categoryId})');
      }
    }
    print('');

    // =================================================================
    // 4. ITEMS (All and by Category)
    // =================================================================
    print('4. Loading items...');

    // All live streams
    final allStreams = await client.livestreamItems();
    print('Total live streams: ${allStreams.length}');

    // Live streams by category
    if (liveCategories.isNotEmpty) {
      final categoryStreams =
          await client.livestreamItems(category: liveCategories.first);
      print(
        'Live streams in "${liveCategories.first.categoryName}": ${categoryStreams.length}',
      );
    }

    // All VOD items
    final allVods = await client.vodItems();
    print('Total VOD items: ${allVods.length}');

    // VOD items by category
    if (vodCategories.isNotEmpty) {
      final categoryVods = await client.vodItems(category: vodCategories.first);
      print(
          'VOD items in "${vodCategories.first.categoryName}": ${categoryVods.length}');
    }

    // All series items
    final allSeries = await client.seriesItems();
    print('Total series: ${allSeries.length}');

    // Series items by category
    if (seriesCategories.isNotEmpty) {
      final categorySeries =
          await client.seriesItems(category: seriesCategories.first);
      print(
          'Series in "${seriesCategories.first.categoryName}": ${categorySeries.length}');
    }
    print('');

    // =================================================================
    // 5. DETAILED INFORMATION
    // =================================================================
    print('5. Getting detailed information...');

    // VOD detailed information
    if (allVods.isNotEmpty) {
      final vodDetails = await client.vodInfo(allVods.first);
      print('VOD details for "${vodDetails.info.name}":');
      print('  - Plot: ${vodDetails.info.plot}');
      print('  - Genre: ${vodDetails.info.genre}');
      print('  - Director: ${vodDetails.info.director}');
      print('  - Cast: ${vodDetails.info.cast}');
      print('  - Rating: ${vodDetails.info.rating}');
      print('  - Duration: ${vodDetails.info.duration}');
      print('  - Release date: ${vodDetails.info.releaseDate}');
    }

    // Series detailed information
    if (allSeries.isNotEmpty) {
      final seriesDetails = await client.seriesInfo(allSeries.first);
      print('Series details for "${seriesDetails.info.name}":');
      print('  - Plot: ${seriesDetails.info.plot}');
      print('  - Genre: ${seriesDetails.info.genre}');
      print('  - Director: ${seriesDetails.info.director}');
      print('  - Cast: ${seriesDetails.info.cast}');
      print('  - Rating: ${seriesDetails.info.rating}');
      print('  - Release date: ${seriesDetails.info.releaseDate}');
      if (seriesDetails.episodes != null &&
          seriesDetails.episodes!.isNotEmpty) {
        final seasonKey = seriesDetails.episodes!.keys.first;
        final episodes = seriesDetails.episodes![seasonKey]!;
        print('  - Season $seasonKey has ${episodes.length} episodes');
        if (episodes.isNotEmpty) {
          print('    - First episode: ${episodes.first.title}');
        }
      }
    }
    print('');

    // =================================================================
    // 6. EPG (Electronic Program Guide) FUNCTIONALITY
    // =================================================================
    print('6. Getting EPG information...');

    // Channel EPG (method 1 - using live stream item)
    if (allStreams.isNotEmpty) {
      final channelEpg = await client.channelEpg(allStreams.first, 5);
      print('Channel EPG for "${allStreams.first.name}":');
      print('  - EPG listings: ${channelEpg.epgListings?.length ?? 0}');
      if (channelEpg.epgListings != null &&
          channelEpg.epgListings!.isNotEmpty) {
        final listing = channelEpg.epgListings!.first;
        print(
            '  - First program: ${listing.title} (${listing.start} - ${listing.stop})');
      }

      // Channel EPG (method 2 - using stream ID directly)
      final channelEpgById =
          await client.channelEpgViaStreamId(allStreams.first.streamId!, 3);
      print('Channel EPG via stream ID (${allStreams.first.streamId}):');
      print('  - EPG listings: ${channelEpgById.epgListings?.length ?? 0}');

      // Channel EPG table
      final epgTable = await client.channelEpgTable(allStreams.first);
      print('Channel EPG table:');
      print(
          '  - Table data available: ${epgTable.epgListings?.isNotEmpty ?? false}');
    }

    // Full EPG in XMLTV format
    print('Loading full EPG (XMLTV format)...');
    final fullEpg = await client.epg();
    print('Full EPG loaded:');
    print('  - Channels: ${fullEpg.channels.length}');
    print('  - Programs: ${fullEpg.programmes.length}');
    if (fullEpg.channels.isNotEmpty) {
      final channel = fullEpg.channels.first;
      final displayName = channel.displayNames.isNotEmpty
          ? channel.displayNames.first.value
          : 'Unknown';
      print('  - First channel: $displayName (ID: ${channel.id})');
    }
    print('');

    // =================================================================
    // 7. URL GENERATION METHODS
    // =================================================================
    print('7. Generating streaming URLs...');

    // Stream URL for live TV
    if (allStreams.isNotEmpty) {
      final stream = allStreams.first;
      final allowedFormats = ['ts', 'm3u8', 'mp4']; // Common formats
      final streamUrl = client.streamUrl(stream.streamId!, allowedFormats);
      print('Live stream URL for "${stream.name}":');
      print('  - URL: $streamUrl');
    }

    // Movie URL for VOD
    if (allVods.isNotEmpty) {
      final vod = allVods.first;
      final containerExtension = vod.containerExtension ?? 'mp4';
      final movieUrl = client.movieUrl(vod.streamId!, containerExtension);
      print('Movie URL for "${vod.name}":');
      print('  - URL: $movieUrl');
      print('  - Container: $containerExtension');
    }

    // Series URL for episodes
    if (allSeries.isNotEmpty) {
      final series = allSeries.first;
      final seriesDetails = await client.seriesInfo(series);
      if (seriesDetails.episodes != null &&
          seriesDetails.episodes!.isNotEmpty) {
        final seasonKey = seriesDetails.episodes!.keys.first;
        final episodes = seriesDetails.episodes![seasonKey]!;
        if (episodes.isNotEmpty) {
          final episode = episodes.first;
          final containerExtension = episode.containerExtension ?? 'ts';
          final seriesUrl = client.seriesUrl(episode.id!, containerExtension);
          print('Series episode URL for "${episode.title}":');
          print('  - URL: $seriesUrl');
          print('  - Container: $containerExtension');
        }
      }
    }
    print('');

    print('=== Demo completed successfully! ===');
  } catch (e, stackTrace) {
    print('Error occurred: $e');
    print('Stack trace: $stackTrace');
  } finally {
    // =================================================================
    // 8. CLEANUP
    // =================================================================
    print('\n8. Cleaning up resources...');
    await XtreamCode.instance.dispose();
    print('✓ Resources disposed');
  }
}
