import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' as foundation;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  TextEditingController textEditingController = TextEditingController();
  String? _emoji;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void setEmoji(emoji) {
    setState(() {
      _emoji = emoji;
    });
  }

  void saveEmoji() async {
    
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.69),
        title: const Text(
          'emoji mood tracker.',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: EmojiPicker(
                onEmojiSelected: (Category? category, Emoji? emoji) {
                  // save emoji and timestamp in sqlite db
                  setEmoji(emoji?.emoji);
                },
                textEditingController: textEditingController,
                config: Config(
                  height: 256,
                  checkPlatformCompatibility: true,
                  emojiViewConfig: EmojiViewConfig(
                    emojiSizeMax: 28 *
                        (foundation.defaultTargetPlatform == TargetPlatform.iOS
                            ? 1.20
                            : 1.0),
                  ),
                  swapCategoryAndBottomBar: false,
                  skinToneConfig: const SkinToneConfig(),
                  categoryViewConfig:
                      const CategoryViewConfig(backgroundColor: Colors.white),
                  bottomActionBarConfig: const BottomActionBarConfig(
                      backgroundColor: Colors.white,
                      buttonIconColor: Colors.grey,
                      buttonColor: Colors.black),
                  searchViewConfig: const SearchViewConfig(
                    backgroundColor: Colors.white,
                  ),
                ),
              )),
          
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: Text(
              _emoji ?? "",
              style: const TextStyle(fontSize: 100),
            )),
          ),
          _emoji != null ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
                child: IconButton(
              icon: const Icon(Icons.check, size: 100,),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("mood saved as $_emoji")));
              },
            )),
          ) : Container()
        ],
      ),
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
          elevation: 0, // to get rid of the shadow
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          backgroundColor: Colors.white.withOpacity(0.69),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black45,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}
