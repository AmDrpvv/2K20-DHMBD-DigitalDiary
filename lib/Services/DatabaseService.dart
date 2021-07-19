import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hisabapp/Models/AppEntity.dart';
class DatabaseService 
{

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference dataCollection =Firestore.instance.collection('Data Collection');

  List<String> convertListProductIntoStringProduct(List<Product> products)
  {
    List<String> _newproductList=[];
    if(products!=null)
    {
      for(int i=0;i<products.length;i++)
      {
        _newproductList.add(products[i].toStringList());
      }
    }
    return _newproductList;
  }

  List<Product> convertStringProductIntoListProdcuts(List<dynamic> productlist)
  {
    List<Product> newproductList=[];
    for(int i=0;i<productlist.length;i++)
      {
        Product _product = new Product();
        _product.quantity= productlist[i].substring(0,2);
        _product.price=productlist[i].substring(2,4);
        _product.name=productlist[i].substring(4,productlist[i].length);
        
        newproductList.add(_product);
      }
    return newproductList;
  }

  //get UserData daily products stream
  Stream<Map<dynamic,dynamic>> get userdataDailyProductStream {
    return dataCollection.document(uid).collection('dailyProductsList').snapshots()
        .map(changequerySnapshotIntoDailyProductList);
  }

  Map<dynamic,dynamic> getProductListMap(CollectionReference reference)
  {
    if(reference==null)
      return null;

    Map<dynamic,dynamic> _map=Map();
    reference.getDocuments().then((value) {
      List<DayProducts> list= value.documents.map((doc) {
        return DayProducts(
          date: doc.data['date'] ?? 'undefined',
          notes: doc.data['notes'] ?? 'notes',
          productlist: convertStringProductIntoListProdcuts(doc.data['productList']) ?? [],
        );
    }).toList();

      list.forEach((element) {
        _map[element.date]=element;
      });
      _map.forEach((key, value) {print("monu $key : $value");});
  });
    return _map;
  }
  Map<dynamic,dynamic> changequerySnapshotIntoDailyProductList(QuerySnapshot snapshots)
  {
    List<DayProducts> list= snapshots.documents.map((doc) {
      return DayProducts(
        date: doc.data['date'] ?? 'undefined',
        notes: doc.data['notes'] ?? 'notes',
        productlist: convertStringProductIntoListProdcuts(doc.data['productList']) ?? [],
      );
    }).toList();
    Map<dynamic,dynamic> _map=Map();
    list.forEach((element) {
      _map[element.date]=element;
    });
    _map.forEach((key, value) {print("monu $key : $value");});
    return _map;
  }

  //get UserData Stream
  Stream<UserData> get userdataStream {
    return dataCollection.document(uid).snapshots()
        .map(_changeDocumentsnapshotsintoUserData);
  }


  UserData _changeDocumentsnapshotsintoUserData(DocumentSnapshot snapshots)
  {
    return UserData(
        uid: uid,
        defaultProductList: convertStringProductIntoListProdcuts(
            snapshots['defaultProductList']) ?? [],
        name: snapshots['name']??'new User',
        //dailyProductMap: getProductListMap(snapshots.reference.collection('dailyProductsList'))??{},
    );
  }

  Future updateUserDatabaseProductList(String date,List<Product> _productList,String notes) async{

    return await dataCollection.document(uid).collection('dailyProductsList').document(date).setData(
      {
        'date': date,
        'notes':notes,
        'productList': convertListProductIntoStringProduct(_productList),
      }
    );
  }

  Future updateUserDatabase(String name,List<Product> defaultProductList) async
  {

    return await dataCollection.document(uid).setData({
      'name': name,
      'defaultProductList': convertListProductIntoStringProduct(defaultProductList),
    } );
  }

  Future deleteDailyProductSubCollection() async
  {
    return await dataCollection.document(uid).collection('dailyProductsList').getDocuments().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.documents) {
        doc.reference.delete();
      }
    });
  }
  Future deleteDocumentDayProduct(String date) async{
    return await dataCollection.document(uid).collection('dailyProductsList').document(date).delete();
  }
}

