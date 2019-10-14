
/*
  This class is a modal for the Categories that we have.
  With title and path of the image and the url to send request
  to identify each category, abd a bool variable isSelected
  to handle the click effect.
*/

class CategoryItem {

  String title;
  String pathImage;
  String url;
  bool isSelected = false;

  CategoryItem({this.title, this.url, this.pathImage, this.isSelected});


}



/*
  List of Categories that we have.
*/

List<CategoryItem> listOfCategories = [
  CategoryItem(
    title: 'Books',
    pathImage: 'assets/images/book.png',
    url: 'https://opentdb.com/api.php?amount=10&category=10&type=multiple',
    isSelected: true,
  ),
  CategoryItem(
    title: 'Films',
    pathImage: 'assets/images/video_camera.png',
    url: 'https://opentdb.com/api.php?amount=10&category=11&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Music',
    pathImage: 'assets/images/music.png',
    url: 'https://opentdb.com/api.php?amount=10&category=12&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Television',
    pathImage: 'assets/images/monitor.png',
    url: 'https://opentdb.com/api.php?amount=10&category=14&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Video games',
    pathImage: 'assets/images/video_game.png',
    url: 'https://opentdb.com/api.php?amount=10&category=15&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Science',
    pathImage: 'assets/images/science.png',
    url: 'https://opentdb.com/api.php?amount=10&category=17&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Computers',
    pathImage: 'assets/images/computer.png',
    url: 'https://opentdb.com/api.php?amount=10&category=18&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Mathematics',
    pathImage: 'assets/images/mathematics.png',
    url: 'https://opentdb.com/api.php?amount=10&category=19&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Sports',
    pathImage: 'assets/images/sports.png',
    url: 'https://opentdb.com/api.php?amount=10&category=21&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'History',
    pathImage: 'assets/images/history.png',
    url: 'https://opentdb.com/api.php?amount=10&category=23&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Art',
    pathImage: 'assets/images/art.png',
    url: 'https://opentdb.com/api.php?amount=10&category=25&type=multiple',
    isSelected: false
  ),
  CategoryItem(
    title: 'Politics',
    pathImage: 'assets/images/politics.png',
    url: 'https://opentdb.com/api.php?amount=10&category=24&type=multiple',
    isSelected: false
  ),
];