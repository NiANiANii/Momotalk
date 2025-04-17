import 'package:flutter/material.dart';
import '../widgets/chat_list_item.dart';
import '../models/chat.dart';
import 'chat_page.dart';
import 'contacts_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [ChatListPage(), ContactsPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 76, 91, 114),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('images/message.png'), size: 25),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('images/contact.png'), size: 25),
            label: 'Contact',
          ),
        ],
      ),
    );
  }
}

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Chat> allChats = [
    Chat(
      name: 'Suzumi',
      lastMessage: 'Just let me know.',
      unread: true,
      avatarPath: 'images/suzumi.png',
    ),
    Chat(
      name: 'Chinatsu',
      lastMessage: '- Chinatsu',
      unread: true,
      avatarPath: 'images/chinatsu.png',
    ),
    Chat(
      name: 'Nonomi',
      lastMessage: '♡♡',
      unread: true,
      avatarPath: 'images/nonomi.png',
    ),
    Chat(
      name: 'Momoi',
      lastMessage: 'NIGG-',
      unread: false,
      avatarPath: 'images/momoi.png',
    ),
    Chat(
      name: 'Karin',
      lastMessage: 'Hati - hati sensei, Momoi sudekat',
      unread: false,
      avatarPath: 'images/karin.png',
    ),
    Chat(
      name: 'Miku',
      lastMessage: 'MIIIGUUUUUU~~',
      unread: false,
      avatarPath: 'images/miku.png',
    ),
    Chat(
      name: 'Mutsuki',
      lastMessage: 'Tikus dilarang masuk',
      unread: false,
      avatarPath: 'images/mutsuki.png',
    ),
    Chat(
      name: 'Mika',
      lastMessage: 'XD',
      unread: false,
      avatarPath: 'images/mika.png',
    ),
    Chat(
      name: 'Aru',
      lastMessage: '44 + 66 = 100',
      unread: false,
      avatarPath: 'images/aru.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<Chat> filteredChats =
        allChats
            .where(
              (chat) =>
                  chat.name.toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 171, 188, 1),
        title: Image.asset('images/momotalk.png', height: 30),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: ListView.builder(
              itemCount: filteredChats.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ChatPage(chat: filteredChats[index]),
                      ),
                    );
                  },
                  child: ChatListItem(chat: filteredChats[index]),
                );
              },
            ),
          ),

          Positioned(
            top: 8,
            left: 16,
            right: 16,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
