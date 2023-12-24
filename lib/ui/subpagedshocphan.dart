import 'package:connection/providers/mainViewModel.dart';
import 'package:connection/responsitoris/hocphan_reponsitory.dart';
import 'package:flutter/material.dart';

import '../models/hocphan.dart';

class SubPageDshocphan extends StatelessWidget {
  const SubPageDshocphan({super.key});
  static int idpage = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/assets/images/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(

        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Danh Sách Học Phần',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.75,
            child: FutureBuilder<List<HocPhan>>(
              future: HocPhanReponsitory().getDSHocPhan(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<HocPhan> dataList = snapshot.data!;
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: double.infinity,
                    child: GridView.builder(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        
                        crossAxisSpacing: 15, 
                        mainAxisSpacing: 10, 
                      ),
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 600,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      dataList[index].tenhocphan,
                                      style: const TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      textAlign: TextAlign.center,
                                      dataList[index].tengv,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}