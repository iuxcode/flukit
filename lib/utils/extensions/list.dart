extension ListUtils<T> on List<T> {
  void addIf(bool condition, T item) {
    if (condition) add(item);
  }
}
