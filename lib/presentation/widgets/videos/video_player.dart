import 'package:cineapp/domain/entities/video.dart';
import 'package:cineapp/presentation/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final FutureProviderFamily<List<Video>, int> videosProvider =
    FutureProvider.family((ref, int movieId) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return movieRepository.getYoutubeVideosById(movieId);
});

class VideoPlayer extends ConsumerWidget {
  final int movieId;
  const VideoPlayer({required this.movieId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieFromVideo = ref.watch(videosProvider(movieId));

    return movieFromVideo.when(
        data: (videos) => _VideoList(video: videos),
        error: (_, __) => const Center(
              child: Text('No se pudo cargar películas'),
            ),
        loading: () => const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ));
  }
}

class _VideoList extends StatelessWidget {
  final List<Video> video;

  _VideoList({required this.video});

  @override
  Widget build(BuildContext context) {
    if (video.isEmpty){
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('Videos', style: TextStyle(fontSize: 20),),),


        _YoutubeVideoPlayer(youtubeId: video.first.youtubeKey, name: video.first.name)

      ],

    );
  }
}


class _YoutubeVideoPlayer extends StatefulWidget {

  final String youtubeId;
  final String name;
  const _YoutubeVideoPlayer({super.key, required this.youtubeId, required this.name});

  @override
  State<_YoutubeVideoPlayer> createState() => __YoutubeVideoPlayerState();
}

class __YoutubeVideoPlayerState extends State<_YoutubeVideoPlayer> {


  late YoutubePlayerController _controller;


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false
      )

    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {



    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.name),
          YoutubePlayer(controller: _controller)
        ],

      ),
      );
  }
}
