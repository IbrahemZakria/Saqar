import 'package:flutter/material.dart';
import 'package:saqar/core/helper/thems/app_colors.dart';
import 'package:saqar/core/utils/assets.dart';

class SoundItem extends StatelessWidget {
  const SoundItem({
    super.key,
    required this.isPlaying,
    required this.name,
    this.onpresed,
    this.onForward,
    this.onRewind,
    this.onSeek,
    this.duration = Duration.zero,
    this.position = Duration.zero,
    this.showControls = false,
  });

  final bool isPlaying;
  final String name;
  final void Function()? onpresed;
  final void Function()? onForward;
  final void Function()? onRewind;
  final void Function(Duration)? onSeek;
  final Duration duration;
  final Duration position;
  final bool showControls;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Container(
      height: height * .2,
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.kprimarycolor,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Image.asset(
                isPlaying
                    ? Assets.resourceImagesSoundRun
                    : Assets.resourceImagesMosque02,
                key: ValueKey(isPlaying),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),

          // النص + الأزرار
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // 🔊 أزرار التحكم فقط لو showControls = true
                if (showControls) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.replay_5),
                        iconSize: 28,
                        color: Colors.black,
                        onPressed: onRewind,
                      ),
                      IconButton(
                        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                        iconSize: 36,
                        color: Colors.black,
                        onPressed: onpresed,
                      ),
                      IconButton(
                        icon: const Icon(Icons.forward_5),
                        iconSize: 28,
                        color: Colors.black,
                        onPressed: onForward,
                      ),
                    ],
                  ),
                  Flexible(
                    child: Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds
                          .clamp(0, duration.inSeconds)
                          .toDouble(),
                      onChanged: (value) {
                        if (onSeek != null) {
                          onSeek!(Duration(seconds: value.toInt()));
                        }
                      },
                      activeColor: Colors.black,
                      inactiveColor: Colors.white54,
                    ),
                  ),
                  Text(
                    "${_formatDuration(position)} / ${_formatDuration(duration)}",
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ] else
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    iconSize: 36,
                    color: Colors.black,
                    onPressed: onpresed,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
