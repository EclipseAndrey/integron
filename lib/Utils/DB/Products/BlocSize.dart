abstract class BlocSize {
  int error;
  int blocSize;
  String image;
  String name;
  int route;
  BlocSize(this.name, this.blocSize, this.image, this.route);
  BlocSize.error(this.error);
}