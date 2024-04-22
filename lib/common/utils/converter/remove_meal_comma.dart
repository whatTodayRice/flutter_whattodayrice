List<String> removeCommaEachMeal({required List<String> meals}) {
  List<String> removedCommaMeal = [];
  for (String menu in meals) {
    if (menu.startsWith(',')) {
      removedCommaMeal.add(menu.substring(1));
    } else {
      removedCommaMeal.add(menu);
    }
  }
  return removedCommaMeal;
}
