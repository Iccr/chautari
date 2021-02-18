class MenuItem {
  int index;
  final String title;
  final String subtitle;
  final String extra;
  final String toId;
  final String fromId;

  bool selected;
  MenuItem(
      {this.index,
      this.title,
      this.subtitle,
      this.selected,
      this.extra,
      this.toId,
      this.fromId});
}
