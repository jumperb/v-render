import 'package:flutter/material.dart';
import 'watcher.dart';
import 'vo.dart';

typedef VRowBlock<T> = Widget Function(int index, dynamic o);

class VRow extends StatefulWidget  {
  final VO<List> list;
  final VRowBlock b;
  VRow(this.list, this.b);

  @override
  State<StatefulWidget> createState() {
    return VRowState(list, b);
  }
}

class VRowState extends State implements Watcher{
  final VO<List> list;
  final VRowBlock _buildBlock;
  VRowState(this.list, this._buildBlock);

  @override
  bool alive() {
    return this.mounted;
  }
  
  @override
  Widget build(BuildContext context) {
    WatcherStack.ins().push(this);
    List innerList = list.v;
    List<Widget> children = List();
    for (int i = 0; i < innerList.length; i ++) {
      dynamic o = innerList[i];
      var view = this._buildBlock(i, o);
      children.add(view);
    }        
    WatcherStack.ins().pop();         
    return Row(children: children);
  }

  @override
  void signal(dynamic v) {
    setState((){});
  }
}


