import 'watcher.dart';

class VO<T> implements Watcher {
  T _v;
  Set<Watcher> watchers;
  VO(this._v);

  T get v {    
    final top = WatcherStack.ins().top();
    if (top != null) {
      _addWatcher(top);
    }
    return _v;
  }
  void set(T newValue) {
    signal(newValue);
  }

  void _dispatch() {    
    var needDelete = Set();
    if (watchers == null) return;
    watchers.forEach((w){
      if (w.alive()) {
        _dispatchOne(w, _v);
      }
      else {
        needDelete.add(w);
      }      
    });
    needDelete.forEach((w){
      watchers.remove(w);
    });
  }
  void _dispatchOne(Watcher w, T v) {
    w.signal(v);
  }
  void _addWatcher(Watcher ob) {
    if (watchers == null) {
      watchers = Set();
    }
    if (!watchers.contains(ob)) {
      watchers.add(ob);
    }    
  }
  
  @override
  bool alive() {
    return true;
  }

  @override
  void signal(newValue) {
    if (newValue == _v) return;
    _v = newValue;
    _dispatch();
  }

  

  VO next(VO sig) {
    _addWatcher(sig);
    _dispatchOne(sig, _v);
    return sig;
  }

  void then(void callback(T v)) {
    next(VOThen(callback));
  }

  VO map<TIn, TOut>(TOut callback(TIn v)) {
    final sig = VOMap<TIn,TOut>(callback);
    next(sig);
    return sig;
  }

  VO<String> toStr() {
    return map<T, String>((T v) {
      return v.toString();
    });
  }

  VO<int> toInt() {
    return map((T v) {
      if (v is num) {
        return v.toInt();
      }
      return int.parse(v.toString());
    });
  }

  VO<double> toDouble() {
    return map((T v) {
      if (v is num) {
        return v.toDouble();
      }
      return double.parse(v.toString());
    });
  }
  VO<T> filter(bool callback(T v)) {
    final vo = VOFilter(callback);
    next(vo);
    return vo;
  }
  VO<T> notNull() {
    final vo = VOFilter((T v){
      return (v != null);
    });
    next(vo);
    return vo;
  }

  void change(void callback(T o)) {
    callback(_v);
    _dispatch();
  }

  static VO compute(dynamic callback()) {
    return VOCompute(callback);
  }
}

class VOThen<T> extends VO<T> {
  void Function(T v) _callback;
  VOThen(this._callback) : super(null);
  @override
  void signal(dynamic newValue) {
    _callback(newValue);
  }
}

class VOMap<TIn, TOut> extends VO<TOut> {
  TOut Function(TIn v) _callback;
  VOMap(this._callback) : super(null);
  @override
  void signal(dynamic newValue) {
    this._v = _callback(newValue);
    _dispatch();
  }
}

class VOFilter<T> extends VO<T> {
  bool Function(T v) _callback;
  VOFilter(this._callback) : super(null);
  @override
  void _dispatchOne(Watcher w, T v) {
    if (_callback(v)) {
      super._dispatchOne(w, v);
    }
  }
}

class VOCompute extends VO {
  dynamic Function() _callback;
  VOCompute(this._callback): super(null) {
    _doCompute();
  }

  void _doCompute() {
    WatcherStack.ins().push(this);
    _v = _callback();
    WatcherStack.ins().pop();
  }

  @override
  void signal(dynamic newValue) {
    _doCompute();
    _dispatch();
  }
  
}