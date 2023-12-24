import 'package:connection/models/lop.dart';
import 'package:connection/models/profile.dart';
import 'package:flutter/material.dart';

import '../providers/mainViewModel.dart';
import '../responsitoris/lophoc_reponsitory.dart';

class SubPageDslop extends StatelessWidget {
  const SubPageDslop({super.key});
  static int idpage = 4;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Danh sách sinh viên',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height - 200,
          child: FutureBuilder<List<DanhsachSV>>(
            future: LopResponsitory().getDSSinhVien(Profile().student.idlop),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                ); 
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                
                List<DanhsachSV> dataList = snapshot.data!;
                return Column(
                  children: [
                    Text(
                      'Tổng số sinh viên : ${dataList.length}',
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 71, 51, 51),
                          borderRadius: BorderRadius.circular(20)),
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: double.infinity,
                      child: GridView.builder(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 400,
                          childAspectRatio: 6,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 10,
                        ),
                        itemCount: dataList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(6, 15, 6, 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          dataList[index].mssv,
                                          style: const TextStyle(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          dataList[index].first_name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }
}