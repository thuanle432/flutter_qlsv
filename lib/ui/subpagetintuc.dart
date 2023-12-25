import 'package:flutter/material.dart';

import '../providers/mainviewmodel.dart';

class SubPageTintuc extends StatelessWidget {
  const SubPageTintuc({super.key});

  static int idpage  = 0;
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      home: NewsScreen(),
    );
  }
}

class NewsScreen extends StatelessWidget {
  final List<NewsItem> newsList = [
    NewsItem(
      title: 'Học sinh tiểu học làm thí nghiệm để hiểu vai trò của nước',
      content: 'Gần 600 học sinh tiểu học tại TP.HCM đã tham gia thực hiện các thí nghiệm hóa học đơn giản, vui nhộn để tìm hiểu vai trò của nước và bảo vệ nguồn nước. Đây là hoạt động nằm trong chương trình BASF Kids’ Lab (Bé làm thí nghiệm vui) do Tập đoàn BASF phối hợp với Sở Giáo dục & Đào tạo TP.HCM tổ chức sáng 24.11.2017 tại Nhà Thiếu nhi quận 10.',
    ),
    NewsItem(
      title: 'Nuôi trồng thủy sản gắn với sức tải môi trường',
      content: 'Nghiên cứu, đánh giá nguồn ô nhiễm, lượng chất thải từ hoạt động nuôi trồng thủy sản trên biển ở Nam Trung bộ là nhiệm vụ quan trọng để đề xuất giải pháp quản lý.',
    ),
    NewsItem(
      title: 'Giá cà phê hôm nay 24/12/2023: Tuần này tăng 1.000 đ/kg',
      content: 'Giá cà phê hôm nay 24/12/2023 neo ở ngưỡng 67.200 - 68.000 đ/kg. Tuần này, thị trường trong nước tiếp tục tăng khi tăng thêm 1.000 đ/kg.',
    ),
    // Thêm các tin tức khác vào đây
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách tin tức'),
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Icon(Icons.article),
              title: Text(
                newsList[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Nhấn để xem chi tiết'),
              onTap: () {
                // Chuyển đến màn hình chi tiết tin tức khi người dùng nhấn vào
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetailScreen(newsList[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class NewsItem {
  final String title;
  final String content;

  NewsItem({required this.title, required this.content});
}

class NewsDetailScreen extends StatelessWidget {
  final NewsItem newsItem;

  NewsDetailScreen(this.newsItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsItem.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsItem.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 10.0),
            Text(newsItem.content),
          ],
        ),
      ),
    );
  }
}