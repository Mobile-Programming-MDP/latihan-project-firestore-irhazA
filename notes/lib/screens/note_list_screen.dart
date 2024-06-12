// import 'package:flutter/material.dart';
// import 'package:notes/models/note.dart';
// import 'package:notes/provider/theme.dart';
// import 'package:notes/screens/google_maps_screen.dart';
// import 'package:notes/screens/map_screen.dart';
// import 'package:notes/services/note_services.dart';
// import 'package:notes/widget/note_dialog.dart';
// import 'package:provider/provider.dart';
// import 'package:url_launcher/url_launcher.dart';

// class NoteListScreen extends StatefulWidget {
//   const NoteListScreen({super.key});

//   @override
//   State<NoteListScreen> createState() => _NoteListScreenState();
// }

// class _NoteListScreenState extends State<NoteListScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Expanded(
//             child: Consumer<ThemeNotifier>(
//               builder: (context, notifier, child) => SwitchListTile.adaptive(
//                 title: const Text('Notes'),
//                 onChanged: (val) {
//                   notifier.toggleChangeTheme(val);
//                 },
//                 value: notifier.darkMode!,
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: const NoteList(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return NoteDialog();
//             },
//           );
//         },
//         tooltip: 'Add Note',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

// class NoteList extends StatelessWidget {
//   const NoteList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: NoteService.getNoteList(),
//       builder: (context, snapshot) {
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         switch (snapshot.connectionState) {
//           case ConnectionState.waiting:
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           default:
//             return ListView(
//               padding: const EdgeInsets.only(bottom: 80),
//               children: snapshot.data!.map((document) {
//                 return Card(
//                   child: Column(
//                     children: [
//                       document.imageUrl != null &&
//                               Uri.parse(document.imageUrl!).isAbsolute
//                           ? ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                 topLeft: Radius.circular(16),
//                                 topRight: Radius.circular(16),
//                               ),
//                               child: Image.network(
//                                 document.imageUrl!,
//                                 width: double.infinity,
//                                 height: 150,
//                                 fit: BoxFit.cover,
//                                 alignment: Alignment.center,
//                               ),
//                             )
//                           : Container(),
//                       ListTile(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (context) {
//                               return NoteDialog(note: document);
//                             },
//                           );
//                         },
//                         title: Text(document.title),
//                         subtitle: Text(document.description),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             document.lat != null && document.lng != null
//                                 ? InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                           builder: (context) => GoogleMapsScreen(
//                                             document.lat,
//                                             document.lng,
//                                           ),
//                                         ),
//                                       );
//                                       //openMap(document.lat, document.lng);
//                                     },
//                                     child: const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(vertical: 10),
//                                       child: Icon(Icons.map),
//                                     ),
//                                   )
//                                 : const Padding(
//                                     padding: EdgeInsets.symmetric(vertical: 10),
//                                     child: Icon(
//                                       Icons.map,
//                                       color: Colors.grey,
//                                     ),
//                                   ),
//                             InkWell(
//                               onTap: () {
//                                 showAlertDialog(context, document);
//                               },
//                               child: const Padding(
//                                 padding: EdgeInsets.symmetric(vertical: 10),
//                                 child: Icon(Icons.delete),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               }).toList(),
//             );
//         }
//       },
//     );
//   }

//   Future<void> openMap(String? lat, String? lng) async {
//     Uri uri =
//         Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat, $lng");
//     if (!await launchUrl(uri)) {
//       throw Exception('Could not launch $uri');
//     }
//   }

//   showAlertDialog(BuildContext context, Note document) {
//     // set up the buttons
//     Widget cancelButton = ElevatedButton(
//       child: const Text("No"),
//       onPressed: () {
//         Navigator.of(context).pop();
//       },
//     );
//     Widget continueButton = ElevatedButton(
//       child: const Text("Yes"),
//       onPressed: () {
//         NoteService.deleteNote(document).whenComplete(() {
//           Navigator.of(context).pop();
//         });
//       },
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: const Text("Delete Note"),
//       content: const Text("Are you sure to delete Note?"),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/provider/theme.dart';
import 'package:notes/screens/google_maps_screen.dart';
import 'package:notes/services/note_services.dart';
import 'package:notes/widget/note_dialog.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: Consumer<ThemeNotifier>(
              builder: (context, notifier, child) => SwitchListTile.adaptive(
                title: const Text('Notes'),
                onChanged: (val) {
                  notifier.toggleChangeTheme(val);
                },
                value: notifier.darkMode!,
              ),
            ),
          ),
        ],
      ),
      body: const NoteList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return NoteDialog();
            },
          );
        },
        tooltip: 'Add Note',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class NoteList extends StatelessWidget {
  const NoteList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: NoteService.getNoteList(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          default:
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No notes available'));
            }
            return ListView(
              padding: const EdgeInsets.only(bottom: 80),
              children: snapshot.data!.map<Widget>((document) {
                return Card(
                  child: Column(
                    children: [
                      document.imageUrl != null &&
                              Uri.parse(document.imageUrl!).isAbsolute
                          ? ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Image.network(
                                document.imageUrl!,
                                width: double.infinity,
                                height: 150,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                              ),
                            )
                          : Container(),
                      ListTile(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return NoteDialog(note: document);
                            },
                          );
                        },
                        title: Text(document.title),
                        subtitle: Text(document.description),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            document.lat != null && document.lng != null
                                ? InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GoogleMapsScreen(
                                            document.lat,
                                            document.lng,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Icon(Icons.map),
                                    ),
                                  )
                                : const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(
                                      Icons.map,
                                      color: Colors.grey,
                                    ),
                                  ),
                            InkWell(
                              onTap: () {
                                showAlertDialog(context, document);
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(Icons.delete),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Share.share(
                                  'Title: \n ${document.title}\n\n Description: \n${document.description}',
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Icon(Icons.share),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
        }
      },
    );
  }

  Future<void> openMap(String? lat, String? lng) async {
    Uri uri = Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$lng");
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  showAlertDialog(BuildContext context, Note document) {
    Widget cancelButton = ElevatedButton(
      child: const Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: const Text("Yes"),
      onPressed: () {
        NoteService.deleteNote(document).whenComplete(() {
          Navigator.of(context).pop();
        });
      },
    );

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Note"),
      content: const Text("Are you sure to delete Note?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
