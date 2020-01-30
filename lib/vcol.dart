import 'package:flutter/material.dart';
import 'watcher.dart';
import 'vo.dart';

typedef VColBlock<T> = Widget Function(int index, dynamic o);

class VCol extends StatefulWidget  {
  final VO<List> list;
  final VColBlock b;
  VCol(this.list, this.b);

  @override
  State<StatefulWidget> createState() {
    return VColState(list, b);
  }
}

class VColState extends State implements Watcher{
  final VO<List> list;
  final VColBlock _buildBlock;
  VColState(this.list, this._buildBlock);

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
    return Column(children: children);
  }

  @override
  void signal(dynamic v) {
    setState((){});
  }
}


