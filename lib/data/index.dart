import 'package:geo_tek/models/borehole_model.dart';

List<Map<String, dynamic>> boreholes = [
  {
    "name": "1",
    "borehole-ID": "BOREHOLE TI-14",
    "latitude": 9.916587499999999,
    "longitude": 8.8547031,
    "image": "assets/images/borehole__1.jpg",
    "address":
        " No. 20 Tina junction, Millionaires Quarters, Jos Plateau State",
  },
  {
    "name": "2",
    "borehole-ID": "BOREHOLE TI-16",
    "latitude": 9.956587499999999,
    "longitude": 8.9247031,
    "image": "assets/images/borehole__1.jpg",
    "address":
        " No. 20 Tina junction, Millionaires Quarters, Jos Plateau State",
  },
  {
    "name": "3",
    "borehole-ID": "BOREHOLE TI-18",
    "longitude": 8.9647031,
    "latitude": 9.906487499999999,
    "image": "assets/images/borehole__1.jpg",
    "address":
        " No. 20 Tina junction, Millionaires Quarters, Jos Plateau State",
  },
  {
    "name": "4",
    "borehole-ID": "BOREHOLE TI-20",
    "longitude": 8.913382,
    "latitude": 9.913696,
    "image": "assets/images/borehole__1.jpg",
    "address":
        " No. 20 Tina junction, Millionaires Quarters, Jos Plateau State",
  },
  {
    "name": "5",
    "borehole-ID": "BOREHOLE TI-21",
    "longitude": 8.9147031,
    "latitude": 9.886587499999999,
    "image": "assets/images/borehole__1.jpg",
    "address":
        " No. 20 Tina junction, Millionaires Quarters, Jos Plateau State",
  },
];

List<BoreHoleModel> appBoreholes =
    boreholes.map((map) => BoreHoleModel.fromJson(map)).toList();

List<Map> appNotifications = [
  {
    "title": "Borehole TI-14 has entered two weeks of inactivity."
  },
  {
    "title": "Borehole TI-19 has entered two weeks of inactivity."
  },
  {
    "title": "Borehole TI-13 has entered two weeks of inactivity."
  },
];

List<Map> appSocials = [
  {
    "type": "FACEBOOK",
    "url": "fb://page/medexerlimited",
    "weburl": "https://www.facebook.com/medexerlimited",
    "icon": "assets/icons/icon__facebook.svg"
  },
  {
    "type": "LINKEDIN",
    "url": "linkedin://company/medexer-limited",
    "weburl": "https://www.linkedin.com/company/medexer-limited",
    "icon": "assets/icons/icon__linkedin.svg"
  },
  {
    "type": "TWITTER",
    "url": "twitter://user?screen_name=MedexerLTD",
    "weburl": "https://twitter.com/MedexerLTD",
    "icon": "assets/icons/icon__twitter.svg"
  },
];

List<Map> appBloodGroups = [
  {
    'name': 'O+',
  },
  {
    'name': 'O-',
  },
  {
    'name': 'A+',
  },
  {
    'name': 'A-',
  },
  {
    'name': 'B+',
  },
  {
    'name': 'B-',
  },
  {
    'name': 'AB+',
  },
  {
    'name': 'AB-',
  },
];

List<Map> appGenotypes = [
  {'name': 'AA', 'title': 'Normal'},
  {'name': 'AS', 'title': 'Carrier'},
  {'name': 'SS', 'title': 'Sickler'},
];

List<Map> appAfirmations = [
  {
    'name': 'YES',
  },
  {
    'name': 'NO',
  },
];

List<Map> appBloodDonationTimeline = [
  {
    'name': 'Within the past 3 months',
  },
  {
    'name': 'Within the past 4 months',
  },
  {
    'name': 'Within the past 6 months',
  },
];

List<Map> appReligions = [
  {
    'name': 'Christianity',
  },
  {
    'name': 'Islam',
  },
  {
    'name': 'Other',
  },
];

List<Map> appGenders = [
  {
    'name': 'Male',
  },
  {
    'name': 'Female',
  },
  {
    'name': 'Other',
  },
];

List appStates = [
  {"name": "Abia"},
  {"name": "Adamawa"},
  {"name": "Akwa Ibom"},
  {"name": "Anambra"},
  {"name": "Bauchi"},
  {"name": "Bayelsa"},
  {"name": "Benue"},
  {"name": "Borno"},
  {"name": "Cross River"},
  {"name": "Delta"},
  {"name": "Ebonyi"},
  {"name": "Edo"},
  {"name": "Ekiti"},
  {"name": "Enugu"},
  {"name": "Gombe"},
  {"name": "Imo"},
  {"name": "Jigawa"},
  {"name": "Kaduna"},
  {"name": "Kano"},
  {"name": "Katsina"},
  {"name": "Kebbi"},
  {"name": "Kogi"},
  {"name": "Kwara"},
  {"name": "Lagos"},
  {"name": "Nasarawa"},
  {"name": "Niger"},
  {"name": "Ogun"},
  {"name": "Ondo"},
  {"name": "Osun"},
  {"name": "Oyo"},
  {"name": "Plateau"},
  {"name": "Rivers"},
  {"name": "Sokoto"},
  {"name": "Taraba"},
  {"name": "Yobe"},
  {"name": "Zamfara"},
  {"name": "Federal Capital Territory"},
];

List appCountries = [
  {"name": "Nigeria"},
];
