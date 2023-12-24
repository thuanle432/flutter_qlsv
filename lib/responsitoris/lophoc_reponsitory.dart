import 'dart:convert';

import 'package:connection/services/api_service.dart';

import '../models/lop.dart';

class LopResponsitory{
  Future<List<Lop>> getDsLop() async{
    List<Lop> list = [];
    list.add(Lop(ten: "--chọn--"));
    final response = await  ApiService().getDSLop();
    if(response != null){
      var data = response.data['data'];
      for(var item in data){
        var lop = Lop.fromJson(item);
        list.add(lop);
      }

    }

    return list;
  }
  Future<List<DanhsachSV>> getDSSinhVien(int id) async{
    List<DanhsachSV> list = [];
    var response = await ApiService().getDSSinhVien(id);
    if(response != null && response.data != null){
      var data = response.data;
      List<dynamic> jsonList = json.decode(data);
      list = jsonList.map((json) => DanhsachSV.fromJson(json)).toList();
      return list;
    }
    return [];
  }


}