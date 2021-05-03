import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';

class SharesBloc {
  final _sharesController = BehaviorSubject<List<ItemModel>>();
  final _topGainersController = BehaviorSubject<List<ItemModel>>();
  final _topLosersController = BehaviorSubject<List<ItemModel>>();
  final _repository = Repository();
  List<ItemModel> allItemsForTop = new List<ItemModel>();
  List<ItemModel> allItemsForBottom = new List<ItemModel>();

  Observable<List<ItemModel>> get shares => _sharesController.stream;
  Observable<List<ItemModel>> get topGainers => _topGainersController.stream;
  Observable<List<ItemModel>> get topLosers => _topLosersController.stream;

  fetchShare() async {
    final items = await _repository.fetchShare();
    allItemsForTop.addAll(items);
    allItemsForBottom.addAll(items);
    _sharesController.sink.add(items);
    print('fetched');
    fetchTopLosers();
    fetchTopGainers();
  }

  fetchShareDb() async {
    final items = await _repository.fetchShareDb();
    _sharesController.sink.add(items);
  }

  fetchTopGainers() {
    allItemsForTop.sort((a, b) => b.difference.compareTo(a.difference));
    _topGainersController.sink.add(allItemsForTop);
  }

  fetchTopLosers() {
    allItemsForBottom.sort((a, b) => a.difference.compareTo(b.difference));
    _topLosersController.sink.add(allItemsForBottom);
  }

  void dispose() {
    _sharesController.close();
    _topGainersController.close();
    _topLosersController.close();
  }
}
