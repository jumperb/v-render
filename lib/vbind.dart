import 'package:flutter/material.dart';
import 'watcher.dart';

typedef VBindBlock<T> = Widget Function();

class VBind extends StatefulWidget {
  final VBindBlock b;
  VBind(this.b);
  @override
  State<StatefulWidget> createState() {
    return VBindState(b);
  }
}

class VBindState extends State implements Watcher {
  final VBindBlock _buildBlock;
  VBindState(this._buildBlock) {
    // print(this);
  }
  @override
  bool alive() {
    return this.mounted;
  }
  @override
  void signal(dynamic v) {
    setState((){});
  }
  @override
  Widget build(BuildContext context) {
    WatcherStack.ins().push(this);
    var view = this._buildBlock();    
    WatcherStack.ins().pop();         
    return view;
  }
}


