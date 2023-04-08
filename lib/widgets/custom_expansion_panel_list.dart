import 'package:flutter/material.dart';
import 'package:hungry_jack/models/expansion_panel_item.dart';

class CustomExpansionPanelList extends StatefulWidget {
  const CustomExpansionPanelList({Key? key, required this.data})
      : super(key: key);
  final List<ExpansionPanelItem> data;

  @override
  State<CustomExpansionPanelList> createState() =>
      _CustomExpansionPanelListState();
}

class _CustomExpansionPanelListState extends State<CustomExpansionPanelList> {
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          widget.data[index].isExpanded = !isExpanded;
        });
      },
      children: widget.data.map<ExpansionPanel>((ExpansionPanelItem item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  item.headerValue,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
          body: ListTile(
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                item.expandedValue,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
