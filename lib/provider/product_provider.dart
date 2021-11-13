import 'package:flutter/material.dart';
import 'package:flutter_woocomerce/api_service.dart';
import 'package:flutter_woocomerce/model/product.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

enum LoadMoreStatus { INITIAL, STABLE, LOADING }

class ProductProvider with ChangeNotifier {
  APIServices _apiServices;
  List<Product> _productList;
  SortBy _sortBy;
  int pageSize = 10;

  List<Product> get allProducts => _productList;

  double get totalRecords => _productList.length.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;

  getLoadMoreStatus() => _loadMoreStatus;

  ProductProvider() {
    _sortBy = SortBy("modified", "Latest", "asc");
  }
  void resetStreams(){
    _apiServices=APIServices();
    _productList=List<Product>();
  }
  setLoadingState(LoadMoreStatus loadMoreStatus){
    _loadMoreStatus =loadMoreStatus;
    notifyListeners();
  }
  setSortOrder(SortBy sortBy){
    _sortBy=sortBy;
    notifyListeners();
  }
  fetchProducts(pageNumber,{
    String strSearch,
    String tagName,
    String categoryId,
    String sortBy,
    String sortOrder="asc",
  })async{
    List<Product> itemModel= await _apiServices.getProducts(
      strSearch: strSearch,
      tagName: tagName,
      pageNumber: pageNumber,
      pageSize: this.pageSize,
      categoryId: categoryId,
      sortBy: this._sortBy.value,
      sortOrder: this._sortBy.sortOrder,
    );
    if(itemModel.length>0){
      _productList.addAll(itemModel);
    }
    setLoadingState(LoadMoreStatus.STABLE);
    notifyListeners();
  }
}
