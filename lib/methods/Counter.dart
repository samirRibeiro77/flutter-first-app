class Counter {
  int _count;

  Counter(this._count);

  Counter.start() {
    _count = 0;
  }

  int get count => _count;

  void addOne() {
    _count++;
    print("Count: $_count");
  }

  void removeOne() {
    _count--;
    print("Count: $_count");
  }

  void addTen() {
    _count += 10;
    print("Count: $_count");
  }
}