import 'package:flutter/material.dart';
import 'package:newspaper_calculator_app/database/app_database.dart';
import 'package:newspaper_calculator_app/widgets/publication_card.dart';
import 'package:newspaper_calculator_app/widgets/publication_sheet.dart';

class PaperScreen extends StatefulWidget {
  const PaperScreen({required this.database, super.key});

  final AppDatabase database;

  @override
  State<PaperScreen> createState() => _PaperScreenState();
}

class _PaperScreenState extends State<PaperScreen> {
  Future<void> _showAddPublicationSheet() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddPublicationSheet(database: widget.database),
    );
  }

  Future<void> _showEditPublicationSheet(Newspaper newspaper) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          AddPublicationSheet(database: widget.database, newspaper: newspaper),
    );
  }

  Future<void> _deleteNewspaper(Newspaper paper) async {
    await widget.database.removeNewspaper(paper.id);
    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${paper.name} deleted.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFE9DDFF),
        title: const Text(
          'Manage Papers',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight(600),
            color: Color(0xFF6750A4),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'update the catalog and pricing of your managed publications',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: StreamBuilder<List<Newspaper>>(
                  stream: widget.database.watchNewspapers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final newspapersList = snapshot.data ?? const <Newspaper>[];

                    if (newspapersList.isEmpty) {
                      return const Center(
                        child: Text('No publications added yet.'),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      itemCount: newspapersList.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final newspaper = newspapersList[index];

                        return PublicationCard(
                          newspaper: newspaper,
                          onEdit: () => _showEditPublicationSheet(newspaper),
                          onDelete: () => _deleteNewspaper(newspaper),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddPublicationSheet,
        backgroundColor: const Color(0xFF6750A4),
        foregroundColor: Colors.white,
        elevation: 5,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
