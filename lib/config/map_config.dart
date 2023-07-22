class MapData{
  late final String name,address,lat,long,icon,faulty,image;
  MapData ({
    required this.name,
    required this.address,
    required this.lat,
    required this.long,
    required this.icon,
    required this.faulty,
    required this.image
   
  });
}

 List<MapData> mapData = [
  MapData(
    name: "Bukuru", 
    address: "bauchi ring",
    lat: '0.999999',
    long: '0.66666', 
    icon: "assets/icons/icon__facebook.svg",
    faulty: 'true',
    image: "assets/icons/icon__facebook.svg"
  ),
  MapData(
    name: "Bukuru", 
    address: "bauchi ring",
    lat: '0.22222229',
    long: '0.7777666', 
    icon: "assets/icons/icon__facebook.svg",
    faulty: 'no',
    image: "assets/icons/icon__facebook.svg"
  ),
  

];