enum FilterEnum {
  newestFirst,
  oldestFirst,
  expensive,
  cheapest,
  letterDescending,
  letterAscending,
  ratingHightToLow,
  ratingLowToHight,
}

class Filter {
  final String name;
  final FilterEnum fEnum;
  Filter({required this.name, required this.fEnum});
}

final List<Filter> filter = [
  Filter(
    name: "Release date newest first",
    fEnum: FilterEnum.newestFirst,
  ),
  Filter(
    name: "Release date oldest first",
    fEnum: FilterEnum.oldestFirst,
  ),
  Filter(
    name: "expensive",
    fEnum: FilterEnum.expensive,
  ),
  Filter(
    name: "price cheap",
    fEnum: FilterEnum.cheapest,
  ),
  Filter(
    name: "Product Name Ascending",
    fEnum: FilterEnum.letterAscending,
  ),
  Filter(
    name: "Product Name Descending",
    fEnum: FilterEnum.letterDescending,
  ),
  Filter(
    name: "Review rating high order",
    fEnum: FilterEnum.ratingHightToLow,
  ),
  Filter(
    name: "Review rating low to high",
    fEnum: FilterEnum.ratingLowToHight,
  ),
];
