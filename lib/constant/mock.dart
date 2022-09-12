import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:outlet/model/brand.dart';
import 'package:uuid/uuid.dart';

import '../model/advertisement.dart';
import '../model/drawer_item.dart';
import '../model/main_category.dart';
import '../model/product.dart';

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
  ["Aeon's new value creation brand", ""],
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

final List<Brand> mockBrands = List.generate(
  brandImages.length,
  (index) => Brand(
    id: Uuid().v1(),
    image: brandImages[index],
    name: "TOPVALU",
    subName: brandSubNamesAndStatus[index][0],
    status: brandSubNamesAndStatus[index][1],
  ),
);

List<Advertisement> advertisements = adImages
    .map((e) => Advertisement(
          id: e,
          image: e,
          dateTime: DateTime.now(),
        ))
    .toList();

List<MainCategory> mainCategories = List.generate(
    mainNames.length,
    (index) => MainCategory(
          id: Uuid().v1(),
          name: mainNames[index],
          image: mainImages[index],
          dateTime: DateTime.now(),
        ));

final hotTopics = [
  Advertisement(
    id: "1",
    image:
        "https://storage.topvalu.net/assets/page/img/arekorenavi/20220810_img_dl-cp.jpg",
    name: "Useful for everyday life! Top value app!",
    isHot: true,
    dateTime: DateTime.now(),
  ),
  Advertisement(
    id: "2",
    image:
        "https://storage.topvalu.net/assets/page/img/review_cp/20210930_img_main-visual.png",
    name: "TOPVALU Product Review Campaign",
    isHot: true,
    dateTime: DateTime.now(),
  ),
  Advertisement(
    id: "3",
    image:
        "https://storage.topvalu.net/assets/contents/images/recipe_theme/71/banner_1661322366_159425.jpg",
    name: "TOPVALU recipe",
    isHot: true,
    dateTime: DateTime.now(),
  ),
];

/**New Products */
const newProductNI = [
  [
    "Melting gouda mixed cheese",
    "https://storage.topvalu.net/assets/contents/images/product/226387/4549414283327_PC_L.jpg",
  ],
  [
    "PEACE FIT skin side cotton quilted shirt pajamas dot pattern",
    "https://storage.topvalu.net/assets/contents/images/product/226174/2315717976011_PC_L.jpg",
  ],
  [
    "PEACE FIT skin side cotton quilted shirt pajamas dot pattern",
    "https://storage.topvalu.net/assets/contents/images/product/226179/2315717976066_PC_L.jpg",
  ],
  [
    "PEACE FIT skin side cotton quilted shirt pajamas dot pattern",
    "https://storage.topvalu.net/assets/contents/images/product/226184/2315717976110_PC_L.jpg",
  ],
  [
    "PEACE FIT skin side cotton quilted shirt pajamas striped pattern",
    "https://storage.topvalu.net/assets/contents/images/product/226189/2315717977018_PC_L.jpg",
  ],
  [
    "PEACE FIT skin side cotton quilted shirt pajamas striped pattern",
    "https://storage.topvalu.net/assets/contents/images/product/226192/2315717977049_PC_L.jpg",
  ],
  [
    "PEACE FIT skin side cotton quilted shirt pajamas striped pattern",
    "https://storage.topvalu.net/assets/contents/images/product/226195/2315717977070_PC_L.jpg",
  ],
  [
    "PEACE FIT skin side cotton quilted shirt pajamas sheep pattern",
    "https://storage.topvalu.net/assets/contents/images/product/226198/2315717978015_PC_L.jpg",
  ]
];

const foodRecommand = [
  [
    "Broccoli instead of rice",
    "300g",
    "https://storage.topvalu.net/assets/contents/images/product/189141/4549741652490_PC_L.jpg",
  ],
  [
    "Roasted currey with aroma and taste,sweet",
    "150g",
    "https://storage.topvalu.net/assets/contents/images/product/221584/4549741805520_PC_L.jpg",
  ],
  [
    "Side dish set demi-glace sauce hamburg steak",
    "264g",
    "https://storage.topvalu.net/assets/contents/images/product/188041/4549741719575_PC_L.jpg",
  ],
  [
    "Rice set Chicken rice and demi-glace sauce",
    "300g",
    "https://storage.topvalu.net/assets/contents/images/product/190746/4549741719544_PC_L.jpg"
  ],

  ///To Delete
  [
    "Broccoli instead of rice",
    "300g",
    "https://storage.topvalu.net/assets/contents/images/product/189141/4549741652490_PC_L.jpg",
  ],
  [
    "Roasted currey with aroma and taste,sweet",
    "150g",
    "https://storage.topvalu.net/assets/contents/images/product/221584/4549741805520_PC_L.jpg",
  ],
  [
    "Side dish set demi-glace sauce hamburg steak",
    "264g",
    "https://storage.topvalu.net/assets/contents/images/product/188041/4549741719575_PC_L.jpg",
  ],
  [
    "Rice set Chicken rice and demi-glace sauce",
    "300g",
    "https://storage.topvalu.net/assets/contents/images/product/190746/4549741719544_PC_L.jpg"
  ],

  ///To Delete
  [
    "Broccoli instead of rice",
    "300g",
    "https://storage.topvalu.net/assets/contents/images/product/189141/4549741652490_PC_L.jpg",
  ],
  [
    "Roasted currey with aroma and taste,sweet",
    "150g",
    "https://storage.topvalu.net/assets/contents/images/product/221584/4549741805520_PC_L.jpg",
  ],
  [
    "Side dish set demi-glace sauce hamburg steak",
    "264g",
    "https://storage.topvalu.net/assets/contents/images/product/188041/4549741719575_PC_L.jpg",
  ],
  [
    "Rice set Chicken rice and demi-glace sauce",
    "300g",
    "https://storage.topvalu.net/assets/contents/images/product/190746/4549741719544_PC_L.jpg"
  ]
];

const dailyGoodsRecommand = [
  [
    "kitchen towel thick type",
    "Size: 228mm × 220mm",
    "https://storage.topvalu.net/assets/contents/images/product/221873/4549741044059_PC_L.jpg",
  ],
  [
    "compact tissue paper",
    "300 sheets (150 pairs) × 4 packs",
    "https://storage.topvalu.net/assets/contents/images/product/127629/4549741681773_PC_L.jpg",
  ],
  [
    "Oxygen-Based Bleach for Clothing,Non-Concentrat",
    "720mL",
    "https://storage.topvalu.net/assets/contents/images/product/198797/4549741336710_PC_L.jpg",
  ],
  [
    "Soft toilet paper Faint flow",
    "107mm × 60m",
    "https://storage.topvalu.net/assets/contents/images/product/146854/4549741875530_PC_L.jpg",
  ],
];
const homeCoordyRecommand = [
  [
    "Home Coordy Microwave Storage Container Square",
    "180ml 5 pieces",
    "https://storage.topvalu.net/assets/contents/images/product/73526/4549741264822_PC_L.jpg",
  ],
  [
    "One push container 1.1L HOME CORRDY",
    "1.1L",
    "https://storage.topvalu.net/assets/contents/images/product/70851/4549741324618_PC_L.jpg",
  ],
  [
    "Pot type water purifier water injection flap type 1.1L HOME CORRDY",
    "1.1L",
    "https://storage.topvalu.net/assets/contents/images/product/139022/4549741267137_PC_L.jpg",
  ],
  [
    "HOME CORRDY As-is mic rowave storage container square",
    "90ml 5 pieces",
    "https://storage.topvalu.net/assets/contents/images/product/91659/4549741509480_PC_L.jpg"
  ]
];
const fashionRecommand = [
  [
    "BODY SWITCH cami type half top",
    "black",
    "https://storage.topvalu.net/assets/contents/images/product/162405/4549741914529_PC_L.jpg",
  ],
  [
    "kids formal shoes",
    "black",
    "https://storage.topvalu.net/assets/contents/images/product/105910/4549326303984_PC_L.jpg",
  ],
  [
    "Neatly deep rubber pants bellw the knee",
    "Black",
    "https://storage.topvalu.net/assets/contents/images/product/71992/2311071533013_PC_L.jpg",
  ],
  [
    "camisole with cup",
    "black",
    "https://storage.topvalu.net/assets/contents/images/product/141224/2312194765039_PC_L.jpg"
  ]
];
const mockProfile =
    "https://png.pngtree.com/png-vector/20191103/ourmid/pngtree-handsome-young-guy-avatar-cartoon-style-png-image_1947775.jpg";
final List<Product> newProducts = List.generate(
  newProductNI.length,
  (index) => Product(
    id: newProductNI[index][1],
    name: newProductNI[index][0],
    image: [newProductNI[index][1]],
    description: "",
    price: 25000,
    parentId: "fashion",
    status: "NEW",
    dateTime: DateTime.now(),
  ),
);

final foodItems = List.generate(
    foodRecommand.length,
    (index) => Product(
        brandId: "",
        rating: 2.2,
        features: "",
        id: "$index",
        name: foodRecommand[index][0],
        image: [foodRecommand[index][2]],
        description: foodRecommand[index][1],
        price: index + 100,
        parentId: "food",
        dateTime: DateTime.now()));

final fashionItems = List.generate(
    fashionRecommand.length,
    (index) => Product(
        id: "$index",
        brandId: "",
        rating: 2.2,
        features: "",
        name: fashionRecommand[index][0],
        image: [fashionRecommand[index][2]],
        description: fashionRecommand[index][1],
        price: index + 100,
        parentId: "food",
        dateTime: DateTime.now()));

final dailyGoodsItems = List.generate(
    dailyGoodsRecommand.length,
    (index) => Product(
        brandId: "",
        rating: 2.2,
        features: "",
        id: "$index",
        name: dailyGoodsRecommand[index][0],
        image: [dailyGoodsRecommand[index][2]],
        description: dailyGoodsRecommand[index][1],
        price: index + 100,
        parentId: "daily goods",
        dateTime: DateTime.now()));

final homeCorrdyItems = List.generate(
    homeCoordyRecommand.length,
    (index) => Product(
        brandId: "",
        rating: 2.2,
        features: "",
        id: "$index",
        name: homeCoordyRecommand[index][0],
        image: [homeCoordyRecommand[index][2]],
        description: homeCoordyRecommand[index][1],
        price: index + 100,
        parentId: "HOME COORDY",
        dateTime: DateTime.now()));

final featureListItems = List.generate(
    featureListProducts.length,
    (index) => Product(
        brandId: "",
        rating: 2.2,
        features: "",
        id: "$index",
        name: featureListProducts[index][0],
        image: [featureListProducts[index][1]],
        description: "",
        price: index + 100,
        parentId: "HOME COORDY",
        dateTime: DateTime.now()));

const featureListProducts = [
  [
    "rolling stock",
    "https://storage.topvalu.net/assets/contents/images/special_page/3636/banner_20210820161850.jpg",
  ],
  [
    "Bringing the bounty of the sea to the future of our children. Proof of sustainable fisheries – MSC, A",
    "https://storage.topvalu.net/assets/contents/images/special_page/2461/banner_20200721163358.jpg",
  ],
  [
    "TOPVALU Sustainable Shift",
    "https://storage.topvalu.net/assets/contents/images/special_page/4322/banner_20220517105943.jpg",
  ],
  [
    "Home appliances that accompany everyday life",
    "https://storage.topvalu.net/assets/contents/images/special_page/4450/banner_20220805102403.jpg",
  ],
  [
    "Bell mark campaign for TOPVALU stationery TOPVALU Topvalu is a customer",
    "https://storage.topvalu.net/assets/contents/images/special_page/4502/banner_20220818114603.jpg",
  ],
  [
    "TOPVALU Gurinai Organic Processed Food",
    "https://storage.topvalu.net/assets/contents/images/special_page/4472/banner_20220805142956.jpg"
  ]
];

final List<DrawerItem> drawerItems = [
  DrawerItem(name: "top page", status: "TOP"),
  DrawerItem(name: "Feature List/Product Information", status: "PRODUCT"),
  DrawerItem(name: "brand", status: "BRAND"),
  DrawerItem(
      name: "view favourites", icon: FontAwesomeIcons.solidHeart, isRow: true),
];
