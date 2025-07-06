String? getValueForKey(int targetKey, List<Map<int, String>> list) {
  for (Map<int, String> map in list) {
    if (map.containsKey(targetKey)) {
      return map[targetKey];
    }
  }
  return null; // Key not found
}
