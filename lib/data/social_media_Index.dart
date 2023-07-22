

//AMPS
class SocialMediaIndex {
  final String type,url,icon;
  SocialMediaIndex ({
    required this.type,
    required this.url,
    required this.icon,
   
  });
}

 List<SocialMediaIndex> socialMedia = [
  SocialMediaIndex(
    type: "FACEBOOK", 
    url: "https://www.facebook.com/medexerlimited", 
    icon: "assets/icons/icon__facebook.svg"
  ),
  SocialMediaIndex(
    type: "LINKEDIN", 
    url: "https://www.linkedin.com/company/medexer-limited", 
    icon: "assets/icons/icon__linkedin.svg"
  ),
  SocialMediaIndex(
    type: "TWITTER", 
    url: "https://www.twitter.com/MedexerLTD", 
    icon: "assets/icons/icon__twitter.svg"
  ),

];


