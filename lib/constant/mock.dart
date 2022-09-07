import 'package:outlet/model/brand.dart';

import '../model/advertisement.dart';
import '../model/main_category.dart';

List<String> adImages = [
  "https://storage.topvalu.net/assets/contents/images/special_page/4493/top_banner_20220826154723.jpg",
  "https://storage.topvalu.net/assets/page/img/arekorenavi/20220810_img_dl-cp.jpg",
  "https://storage.topvalu.net/assets/contents/images/special_page/4539/top_banner_20220829091323.jpg",
  "https://storage.topvalu.net/assets/contents/images/special_page/4527/top_banner_20220826144429.jpg",
  "https://storage.topvalu.net/assets/contents/images/special_page/4493/top_banner_20220826154723.jpg",
  "https://storage.topvalu.net/assets/page/img/arekorenavi/20220810_img_dl-cp.jpg",
  "https://storage.topvalu.net/assets/contents/images/special_page/4539/top_banner_20220829091323.jpg",
  "https://storage.topvalu.net/assets/contents/images/special_page/4527/top_banner_20220826144429.jpg",
];

const List<String> mainImages = [
  "https://www.topvalu.net/img/product-category/icon_new-item.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_100.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_200.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_300.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_400.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_500.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_600.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_750.gif",
  "https://www.topvalu.net/img/product-category/icon_promotion.gif",
  "https://www.topvalu.net/img/product-category/icon_recipe.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_900.gif",
  "https://www.topvalu.net/img/product-category/icon_product-category_950.gif"
];

const mainNames = [
  "New product information",
  "food",
  "fashion",
  "daily goods",
  "interior·kitchen supplies",
  "consumer electronics",
  "Health, beauty, child care,child rearing",
  "sportsoutdoors",
  "campaign",
  "recipe",
  "fashionSpecial Feature Summary",
  "HOME COORDY",
];

const brandSubNamesAndStatus = [
  [
    "Aeon's new value creation brand",
    ""
  ],
  [
    "ion organic& Natural Brand",
    "green eye",
  ],
  [
    "Aeon Satisfaction Quality Brand",
    "best price",
  ],
  [
    "Aeon's commitmenttop quality brand",
    "Select",
  ]
];
const brandImages = [
  "https://www.topvalu.net/img/common/brand/logo_topvalu.png",
  "https://www.topvalu.net/img/common/brand/logo_topvalu-gurinai.png",
  "https://www.topvalu.net/img/common/brand/logo_topvalu-bestprice.png",
  "https://www.topvalu.net/img/common/brand/logo_topvalu-select.png",
];

final List<Brand> brands = List.generate(brandImages.length, 
(index) => Brand(
  id: brandSubNamesAndStatus[index][0], 
  image: brandImages[index], 
  name: "TOPVALU", 
  subName: brandSubNamesAndStatus[index][0], 
  status: brandSubNamesAndStatus[index][1],
),
);

List<Advertisement> advertisements = adImages.map((e) => Advertisement(
  id: e, 
  image: e, 
  dateTime: DateTime.now(),
  )).toList();

List<MainCategory> mainCategories = List.generate(mainNames.length, 
(index) => MainCategory(
    id: mainNames[index], 
    name: mainNames[index], 
    image: mainImages[index],
    dateTime: DateTime.now(),
  ));

final hotTopics = [
  Advertisement(
    id: "1", 
    image: "https://storage.topvalu.net/assets/page/img/arekorenavi/20220810_img_dl-cp.jpg",
    name: "Useful for everyday life! Top value app!", 
    isHot: true,
    dateTime: DateTime.now(),
  ),
  Advertisement(
    id: "2", 
    image: "https://storage.topvalu.net/assets/page/img/review_cp/20210930_img_main-visual.png",
    name: "TOPVALU Product Review Campaign", 
    isHot: true,
    dateTime: DateTime.now(),
  ),
  Advertisement(
    id: "3", 
    image: "https://storage.topvalu.net/assets/contents/images/recipe_theme/71/banner_1661322366_159425.jpg",
    name: "TOPVALU recipe", 
    isHot: true,
    dateTime: DateTime.now(),
  ),
];