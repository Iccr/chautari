class MenuItem {
  int index;
  final String title;
  final String subtitle;
  final String extra;
  final String toId;
  final String fromId;
  final String fromName;
  final String toName;
  final String image1;
  final String image2;

  bool selected;
  MenuItem(
      {this.index,
      this.title,
      this.subtitle,
      this.selected,
      this.extra,
      this.toId,
      this.fromId,
      this.fromName,
      this.toName,
      this.image1,
      this.image2});
}
