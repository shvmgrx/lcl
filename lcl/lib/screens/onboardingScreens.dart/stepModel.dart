class StepModel {
  final String id;
  final String text;
  final String texDes;

  StepModel({this.id, this.text,this.texDes});

  static List<StepModel> list = [
    StepModel(
      id: "ageGroup",
      text: "Get to know people from all over the world",
      texDes:"It’s easy to hit on foodies — weather you’re a vegan, have a sweet tooth or are figure conscious. People from around the corner or from faraway continents? A little flirty or just looking for a chat buddy? We have something for every ones taste on our menu!"
    ),
    StepModel(
      id: "eatTogether",
      text:"Let’s eat together",
      texDes:"You don’t have to live in the same city to have lunch with someone else. With our app you can meet online in the video chat and can check out what the other person has on it’s plate. The best: You don’t have to share your dessert"
    ),
    StepModel(
      id: "shareRecipe",
      text: "Share your tastiest recipes",
      texDes:"Jamie Oliver and Gordon Ramsay can still learn some professional tricks from you?  Then there is no more false modesty: Swing the cooking spoon and show us how you cook your favorite dish à la #foodporn!"
    ),
    StepModel(
      id: "donate",
      text: "Sharing is caring",
      texDes:"You’re tired of people in the world starving? We don’t like it either! That’s why we want to work with you and the Welthungerhilfe (link) to ensure that people in poor parts of the world get something to eat. Eyerybody is allowed to help – can, but don’t have to."
    ),
  ];
}