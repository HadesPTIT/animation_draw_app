// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:animation_draw_app/gen/assets.gen.dart';
import 'package:flutter/widgets.dart';

class StickerListWidget extends StatefulWidget {
  final Function(Widget) onSelectSticker;
  const StickerListWidget({
    super.key,
    required this.onSelectSticker,
  });

  @override
  State<StickerListWidget> createState() => _StickerListWidgetState();
}

class _StickerListWidgetState extends State<StickerListWidget> {
  late List<String> mStickers;

  @override
  void initState() {
    super.initState();
    mStickers = [
      Assets.images.sticker1.path,
      Assets.images.sticker2.path,
      Assets.images.sticker3.path,
      Assets.images.sticker4.path,
      Assets.images.sticker5.path,
      Assets.images.sticker6.path,
      Assets.images.sticker6.path,
      Assets.images.sticker7.path,
      Assets.images.sticker8.path,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mStickers.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            widget.onSelectSticker.call(_item(index));
          },
          child: _item(index),
        );
      },
    );
  }

  Widget _item(int index) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Image.asset(
        mStickers[index],
        fit: BoxFit.contain,
      ),
    );
  }
}
