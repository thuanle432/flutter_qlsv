import 'package:connection/models/place.dart';
import 'package:connection/responsitoris/place_reponsitory.dart';
import 'package:flutter/foundation.dart';

class DiaChiModel with ChangeNotifier{
  List<City> listCity = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];
  int curCityId = 0;
  int curDistId = 0;
  int curWardId = 0;
  String address = "";
  Future <void> initialize(int Cid, int Did, int Wid) async{
    curCityId = Cid;
    curDistId = Did;
    curWardId = Wid;
    final repo = PlaceReponsitory();
    listCity = await repo.getListCity();
    if(curCityId != 0){
      listDistrict = await repo.getListDistrict(curCityId);
    }
    if(curDistId != 0){
      listWard = await repo.getListWard(curDistId);
    }
  }
  Future<void> setCity(int Cid) async{
    if(Cid != curCityId){
      curCityId = Cid;
      curDistId = 0;
      curWardId = 0;
      final repo = PlaceReponsitory();
      listDistrict = await repo.getListDistrict(curDistId);
      listWard.clear();
    }
    
  }
  Future<void>setDistrict(int Did) async{
    if(Did != curDistId){
      
      curDistId = Did;
      curWardId = 0;
      final repo = PlaceReponsitory();
      listWard = await repo.getListWard(curDistId);
    }
  }
   Future<void>setWard(int Wid) async{
    if(Wid != curWardId){
      curWardId = Wid;
    }
  }
}