import 'package:flutter/material.dart';
import 'package:haajar_final/models/announcement.dart';

class PlacementListTile extends StatefulWidget {
  const PlacementListTile({super.key, required this.announcement});

  final Announcement announcement;

  @override
  State<PlacementListTile> createState() => _PlacementListTileState();
}

class _PlacementListTileState extends State<PlacementListTile> {
  late String timestamp;

  @override
  Widget build(BuildContext context) {
    if (widget.announcement.timestamp.day == DateTime.now().day) {
      timestamp = "Today";
    } else if (widget.announcement.timestamp.day == DateTime.now().day - 1) {
      timestamp = "Yesterday";
    } else {
      timestamp =
          "${widget.announcement.timestamp.day}/${widget.announcement.timestamp.month}/${widget.announcement.timestamp.year}";
    }
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          borderOnForeground: true,
          color: Colors.orange[50],
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 30,
              backgroundImage: const AssetImage(
                "assets/images/announcement_asset.png",
              ),
              onBackgroundImageError: (exception, stackTrace) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Error loading image"),
                  ),
                );
              },
            ),
            title: Text(
              widget.announcement.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
            ),
            subtitle: Text(
              widget.announcement.timestamp.toIso8601String().toString(),
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
              ),
            ),
            onTap: () {},
            //show timestamp
            trailing: Text(
              timestamp,
              style: const TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
