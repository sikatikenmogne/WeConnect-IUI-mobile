class GenericService<T>{
  Map<String, T> _data;

  GenericService(Map<String, T> data) : _data = data;

  List<T> getAll(){
    return _data.values.toList();
  }

  T? getById(String id){
    return _data[id];
  }

  void add(String id, T item){
    try {
      _data[id] = item;
    } catch (e) {
      throw Exception("Error inserting: ${e.toString()}");
    }
  }

  // Update an existing item
  void update(String id, T item) {
  // Check if the item with the given ID exists in the data
    if (_data.containsKey(id)) {
      // Retrieve the existing item from the data map
      T existingItem = _data[id]!;
      // Create a copy of the existing item as a map to allow modifications
      Map<String, dynamic> updatedItem = Map.from(existingItem as Map<String, dynamic>);

    // Cast the new item to a map so its fields can be accessed
    Map<String, dynamic> newItem = item as Map<String, dynamic>;

      _data[id] = item;
    } else {
      throw Exception("$T with ID $id not found");
    }
  }

  // Delete an item by ID
  void delete(String id) {
    if (_data.containsKey(id)) {
      _data.remove(id);
    } else {
      throw Exception("$T with ID $id not found");
    }
  }

  List<T> search(Map<String, dynamic> searchMap){
    return _data.values.where((item) {
      Map<String, dynamic> itemMap = item as Map<String, dynamic>;
      for(var key in searchMap.keys){
        if(searchMap[key] != null && searchMap != itemMap[key]) {
          return false;
        };
      }
      return true;
    }).toList();
  }
}