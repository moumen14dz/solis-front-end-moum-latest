// class DropdownItem<T> {
//   final String name;
//   final T value;
//
//   DropdownItem(this.name, this.value);
// }
class DropdownItem<T> {
  final String name;
  final T value;

  DropdownItem(this.name, this.value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DropdownItem<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
