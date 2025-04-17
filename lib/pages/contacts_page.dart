import 'package:flutter/material.dart';
import '../models/chat.dart';
import 'contact_detail_page.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  final List<Map<String, dynamic>> allContacts = [
    {
      'name': 'Ako',
      'status': "Do not disturb unless it's task-related.",
      'avatar': 'images/ako.png',
      'isFavorite': false,
    },
    {
      'name': 'Aris',
      'status': "Aris: Game Dev Dep.",
      'avatar': 'images/aris.png',
      'isFavorite': false,
    },
    {
      'name': 'Arona',
      'status': "I'm always here for you, Sensei!",
      'avatar': 'images/arona.png',
      'isFavorite': true,
    },
    {
      'name': 'Aru',
      'status': "I'll solve any problem!",
      'avatar': 'images/aru.png',
      'isFavorite': false,
    },
    {
      'name': 'Asuna',
      'status': "Only the best service!",
      'avatar': 'images/asuna.png',
      'isFavorite': false,
    },
    {
      'name': 'Chinatsu',
      'status': "Tidak dapat bicara, WhatsApp saja",
      'avatar': 'images/chinatsu.png',
      'isFavorite': false,
    },
    {
      'name': 'Karin',
      'status': "Rapopo ireng, penting sangar",
      'avatar': 'images/karin.png',
      'isFavorite': false,
    },
    {
      'name': 'Mika',
      'status': "XD",
      'avatar': 'images/mika.png',
      'isFavorite': false,
    },
    {
      'name': 'Miku',
      'status': "They Call Me Miku",
      'avatar': 'images/miku.png',
      'isFavorite': false,
    },
    {
      'name': 'Momoi',
      'status': "CERTEFIED GAMER",
      'avatar': 'images/momoi.png',
      'isFavorite': true,
    },
    {
      'name': 'Nonomi',
      'status': "Nonomi IKI MAAAASS",
      'avatar': 'images/nonomi.png',
      'isFavorite': true,
    },
  ];

  void toggleFavorite(int index) {
    setState(() {
      allContacts[index]['isFavorite'] = !allContacts[index]['isFavorite'];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredContacts =
        allContacts
            .where(
              (contact) => contact['name'].toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
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
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(
                      filteredContacts[index]['avatar'],
                    ),
                    radius: 25,
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          filteredContacts[index]['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: IconButton(
                          icon: Icon(
                            filteredContacts[index]['isFavorite']
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                filteredContacts[index]['isFavorite']
                                    ? Colors.red
                                    : Colors.grey,
                          ),
                          onPressed: () => toggleFavorite(index),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    filteredContacts[index]['status'],
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),

                  onTap: () {
                    Chat selectedChat = Chat(
                      name: filteredContacts[index]['name'],
                      lastMessage: filteredContacts[index]['status'],
                      unread: false,
                      avatarPath: filteredContacts[index]['avatar'],
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                ContactDetailPage(contact: selectedChat),
                      ),
                    );
                  },
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
