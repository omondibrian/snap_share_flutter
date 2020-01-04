import 'package:sembast/sembast.dart';
import 'package:test_flutter/core/data/app_store.dart';
import 'package:test_flutter/features/Chats/Data/models/chats_model.dart';
abstract class ChatsLocalDataSource{

     
   ///@description fetch all user chats  from the cache memory throws a [CacheException]
   ///@returns Either<Failure,List<Chats>> i.e a list of charts if sucessfull or a failure type
   
  Future<List<ChatsModel>> getAllCachedChats();
    
  ///caches all the incoming chats while the user has an active internet connection
 Future<void> cacheCharts(List<ChatsModel> chatsToCache);

    ///@description fetch's conversation between the user and the specified contact
    ///@params [String id]this is the specified contact chat that is used to fetch
    ///the chats
    ///@returns [List<ChatsModel>] i.e a list of charts if sucessfull or a failure type
  
  Future<List<ChatsModel>>getSpecificChatsFromCache(String id);
  ///fetches all chats read while the device is offline from the cache
  Future<List<ChatsModel>>getReadChatsWhileOfflineFromCache();
  Future<bool>clearSpecificConversation(String id);
}








///chats local datasource implementation
class ChatsLocalDataSourceImpl implements ChatsLocalDataSource{

  static const String Chat_STORE_NAME = 'chats';
  // A Store with int keys and Map<String, dynamic> values.
  // This Store acts like a persistent map, values of which are objects converted to Map
  final _chatStore = intMapStoreFactory.store(Chat_STORE_NAME);

  // Private getter to shorten the amount of code needed to get the
  // singleton instance of an opened database.
  Future<Database> get _db async => await AppDatabase.instance.database;


  @override
  Future<void> cacheCharts(List<ChatsModel> chatsToCache) async{
    chatsToCache.map((chat)async{
         await _chatStore.add(await _db,chat.toJson() );
    });
     
    
  }

  @override
  Future<bool> clearSpecificConversation(String id) async{
    try {
      final finder = Finder(filter: Filter.byKey(id));
      await _chatStore.delete(
      await _db,
      finder: finder,
      );
      return true;
    }catch(e){
      return false;
    }
  }

  @override
  Future<List<ChatsModel>> getAllCachedChats() async{
 // Finder object can also sort data.
    final finder = Finder(sortOrders: [
      SortOrder('time'),
    ]);

    final recordSnapshots = await _chatStore.find(
      await _db,
      finder: finder,
    );
    // Making a List<ChatsModel> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final chat = ChatsModel.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      // chat.localId = snapshot.key;
      return chat;
    }).toList();
  }

  @override
  Future<List<ChatsModel>> getReadChatsWhileOfflineFromCache() async {
 // Finder object can also sort data.
    final finder = Finder(filter: Filter.equals("unread", false),sortOrders: [
      SortOrder('time'),
    ]);

    final recordSnapshots = await _chatStore.find(
      await _db,
      finder: finder,
    );
    // Making a List<ChatsModel> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final chat = ChatsModel.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      // chat.localId = snapshot.key;
      return chat;
    }).toList();
  }

  @override
  Future<List<ChatsModel>> getSpecificChatsFromCache(String id)async {
 // Finder object can also sort data.
    final finder = Finder(filter:Filter.byKey(id),sortOrders: [
      SortOrder('time'),
    ]);

    final recordSnapshots = await _chatStore.find(
      await _db,
      finder: finder,
    );
    // Making a List<ChatsModel> out of List<RecordSnapshot>
    return recordSnapshots.map((snapshot) {
      final chat = ChatsModel.fromJson(snapshot.value);
      // An ID is a key of a record from the database.
      // chat.localId = snapshot.key;
      return chat;
    }).toList();
  }
  
}

