import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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

  List<dynamic> contactsFromApi = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    try {
      final response = await http.get(
        Uri.parse("https://api-blue-archive.vercel.app/api/characters?page=1"),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          contactsFromApi = data["data"];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load characters');
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredContacts =
        contactsFromApi.where((contact) {
          final name = contact['name'].toString().toLowerCase();
          return name.contains(_searchQuery.toLowerCase());
        }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 171, 188, 1),
        title: Image.asset('images/momotalk.png', height: 30),
      ),
      body: Stack(
        children: [
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: ListView.builder(
                itemCount: filteredContacts.length,
                itemBuilder: (context, index) {
                  final contact = filteredContacts[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(contact['image']),
                      radius: 25,
                    ),
                    title: Text(
                      contact['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      contact['school'] ?? '',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      Chat selectedChat = Chat(
                        name: contact['name'],
                        lastMessage: contact['school'] ?? '',
                        unread: false,
                        avatarPath: contact['image'],
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

          // Search bar
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
