class Place {
  String? name;
  double? lat;
  double? long;
  String? imagePath;
  String? city;
  int? id;
String? category;
String? description;
bool? isVaild;
String? url;

  Place({required this.name, this.lat, this.long, this.imagePath,  this.city, this.id, this.category,this.description , this.isVaild=false, this.url='No website available'});
}
