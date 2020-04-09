import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CTCommonRadioGroup extends StatefulWidget {
  final List<String> list;
  final Function(int selected) selectedCallback;

  CTCommonRadioGroup(this.list, this.selectedCallback);

  @override
  State<StatefulWidget> createState() {
    return CTCommonRadioGroupState();
  }
}

class CTCommonRadioGroupState extends State<CTCommonRadioGroup> {
  String _selectedItem;

  @override
  void initState() {
    assert(widget.list != null && widget.list.isNotEmpty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.list.map((e) => getRadioListTileContainer(e)).toList(),
    );
  }

  Widget getRadioListTileContainer(String item) {
    return Container(
      height: 80,
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Color(0xffF3F4FC),
          border: Border.all(
              color: _selectedItem != null && _selectedItem == item
                  ? Color(0xff475DF3)
                  : Colors.white,
              width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: RadioListTile(
          activeColor: Color(0xff475DF3),
          controlAffinity: ListTileControlAffinity.trailing,
          title: Text(
            item,
            style: TextStyle(fontSize: 17, color: Color(0xff1A1D4A)),
          ),
          value: item,
          groupValue: _selectedItem,
          onChanged: (newValue) {
            setState(() {
              _selectedItem = newValue;
              widget.selectedCallback.call(widget.list.indexOf(_selectedItem));
            });
          }),
    );
  }
}
