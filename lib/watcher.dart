abstract class Watcher {
  bool alive();
  void signal(dynamic newValue);
}
class WatcherStack {
  List<Watcher> stack = List();
  WatcherStack._();

  static WatcherStack _instance;

  static WatcherStack ins() {
    if (_instance == null) {
      _instance = WatcherStack._();
    }
    return _instance;
  }

  void push(Watcher b) {
    stack.add(b);
  }
  Watcher pop() {
    return stack.removeLast();
  }
  Watcher top() {
    if (stack.isEmpty) return null;
    return stack.last;
  } 
}