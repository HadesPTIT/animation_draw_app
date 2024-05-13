// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:developer';

import 'package:animation_draw_app/components/signature.dart';
import 'package:animation_draw_app/components/sticker_list_widget.dart';
import 'package:bottom_bar_with_sheet/bottom_bar_with_sheet.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lindi_sticker_widget/lindi_controller.dart';
import 'package:lindi_sticker_widget/lindi_sticker_widget.dart';
import 'package:screenshot/screenshot.dart';

class AppDraw extends StatefulWidget {
  const AppDraw({super.key});

  @override
  State<AppDraw> createState() => _AppDrawState();
}

class _AppDrawState extends State<AppDraw> {
  late LindiController _stickerController;

  late SignatureController _drawController;

  // Default pen color
  Color _penColor = Colors.black;

  // Bottom action controller
  late BottomBarWithSheetController _bottomBarController;

  // Initial tab index
  var _tab = BottomTab.PICK_COLOR;

  late ScreenshotController _screenshotController;

  @override
  void initState() {
    super.initState();
    _screenshotController = ScreenshotController();
    _bottomBarController = BottomBarWithSheetController(initialIndex: 0);
    _drawController = SignatureController(
      penColor: _penColor,
      exportBackgroundColor: Colors.transparent,
      onDrawStart: () {
        if (_bottomBarController.isOpened) {
          _bottomBarController.closeSheet();
        }
        log('onDrawStart called!');
      },
      onDrawEnd: () => log('onDrawEnd called!'),
    );
    _stickerController = LindiController(
      borderColor: Colors.white,
      iconColor: Colors.black,
      minScale: 0.3,
    );

    _drawController.addListener(
      () => log('Value changed'),
    );
  }

  @override
  void dispose() {
    _bottomBarController.close();
    _stickerController.dispose();
    _drawController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DRAW'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Screenshot(
              controller: _screenshotController,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: _buildDrawContainer(),
                  ),
                  Positioned.fill(
                    child: _buildStickerContainer(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomActionContainer(),
          ),
        ],
      ),
    );
  }

  ///
  /// Draw region
  ///
  Widget _buildDrawContainer() {
    return Column(
      children: [
        const Expanded(
          child: SizedBox(),
        ),
        Expanded(
          flex: 8,
          child: Signature(
            key: const Key('signature'),
            controller: _drawController,
            height: MediaQuery.of(context).size.height * 0.7,
            backgroundColor: Colors.grey[300]!,
          ),
        ),
        const Expanded(
          flex: 2,
          child: SizedBox(),
        ),
      ],
    );
  }

  ///
  /// Sticker region
  ///
  Widget _buildStickerContainer() {
    return LindiStickerWidget(
      controller: _stickerController,
      child: const SizedBox.expand(),
    );
  }

  ///
  /// Bottom action region
  ///
  Widget _buildBottomActionContainer() {
    return BottomBarWithSheet(
      controller: _bottomBarController,
      duration: const Duration(milliseconds: 200),
      mainActionButtonBuilder: (context) {
        return Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.purple,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              exportImage(context);
            },
          ),
        );
      },
      bottomBarTheme: const BottomBarTheme(
        mainButtonPosition: MainButtonPosition.right,
        heightOpened: 270,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        itemIconColor: Colors.grey,
        itemTextStyle: TextStyle(
          color: Colors.grey,
          fontSize: 10.0,
        ),
        selectedItemTextStyle: TextStyle(
          color: Colors.blue,
          fontSize: 10.0,
        ),
      ),
      onSelectItem: (index) {
        debugPrint('$index');
        handleSelectTab(index);
      },
      sheetChild: _buildSheetChild(),
      items: [
        const BottomBarWithSheetItem(icon: Icons.color_lens),
        const BottomBarWithSheetItem(icon: Icons.wallpaper_rounded),
        const BottomBarWithSheetItem(icon: Icons.undo),
        const BottomBarWithSheetItem(icon: Icons.redo),
        const BottomBarWithSheetItem(icon: Icons.clear),
        BottomBarWithSheetItem(
          icon: _drawController.disabled
              ? Icons.lock_open_rounded
              : Icons.lock_outline,
        ),
      ],
    );
  }

  Future<void> exportImage(BuildContext context) async {
    if (!mounted) {
      return;
    }

    if (_drawController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No content to save! Try again'),
        ),
      );
      return;
    }

    final fileName = 'ice_${DateTime.now().microsecondsSinceEpoch}.png';

    unawaited(
      _screenshotController.capture(pixelRatio: 4).then((value) async {
        final result = await ImageGallerySaver.saveImage(
          value!,
          quality: 60,
          name: fileName,
        );
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.toString()),
          ),
        );
      }),
    );
  }

  void closeBottomBar() {
    if (_bottomBarController.isOpened) {
      _bottomBarController.closeSheet();
    }
  }

  void handleSelectTab(int index) {
    _tab = BottomTab.values.firstWhere((element) => element.index == index);

    switch (_tab) {
      case BottomTab.PICK_COLOR:
      case BottomTab.INSERT_STICKER:
        setState(() {
          _bottomBarController.openSheet();
        });
        break;
      case BottomTab.UNDO:
        closeBottomBar();
        _drawController.undo();
        break;
      case BottomTab.REDO:
        closeBottomBar();
        _drawController.redo();
        break;
      case BottomTab.CLEAR:
        closeBottomBar();
        _drawController.clear();
        break;
      case BottomTab.LOCK:
        closeBottomBar();
        setState(() {
          _drawController.disabled = !_drawController.disabled;
        });
        break;
    }
  }

  Widget _buildSheetChild() {
    switch (_tab) {
      case BottomTab.PICK_COLOR:
        return SingleChildScrollView(
          child: ColorPicker(
            color: _penColor,
            onColorChanged: (Color color) => setState(() {
              _penColor = color;
              _drawController.penColor = _penColor;
              _bottomBarController.closeSheet();
            }),
            borderRadius: 4,
            spacing: 5,
            runSpacing: 5,
            wheelDiameter: 155,
            enableShadesSelection: false,
            heading: const SizedBox(),
            subheading: const SizedBox(),
            wheelSubheading: const SizedBox(),
            materialNameTextStyle: Theme.of(context).textTheme.bodySmall,
            colorNameTextStyle: Theme.of(context).textTheme.bodySmall,
            colorCodeTextStyle: Theme.of(context).textTheme.bodyMedium,
            colorCodePrefixStyle: Theme.of(context).textTheme.bodySmall,
            selectedPickerTypeColor: Theme.of(context).colorScheme.primary,
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.primary: true,
              ColorPickerType.accent: false,
            },
          ),
        );
      case BottomTab.INSERT_STICKER:
        return StickerListWidget(
          onSelectSticker: (item) {
            _stickerController.addWidget(item);
            _bottomBarController.closeSheet();
            setState(() {
              _drawController.disabled = true;
            });
          },
        );
      default:
        return const SizedBox();
    }
  }
}

enum BottomTab {
  PICK_COLOR,
  INSERT_STICKER,
  UNDO,
  REDO,
  CLEAR,
  LOCK,
}
