import 'package:connection/models/hocphan.dart';
import 'package:connection/services/api_service.dart';

class HocPhanReponsitory{
  final ApiService api = ApiService();
  Future<List<HocPhan>> getDSHocPhan() async{
    List<HocPhan> list = [];
    var response = await api.getDSHocPhan();
    if(response != null && response.statusCode == 200){
      var data = response.data['data'];
      for(var item in data){
        var hocphan = HocPhan.fromJson(item);
        list.add(hocphan);
      }
    }
    return list;
  }
}