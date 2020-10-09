class Category{

  Category({this.id,this.nameEn,this.nameJp});
  final String id;
  final String nameEn;
  final String nameJp;

}

List <Category> categories =[
  Category(id: '0',nameJp: '総合',nameEn: 'general'),
  Category(id: '1',nameJp: 'ビジネス',nameEn: 'business'),
  Category(id: '2',nameJp: 'エンターテインメント',nameEn: 'entertainment'),
  Category(id: '3',nameJp: '健康',nameEn: 'health'),
  Category(id: '4',nameJp: '科学',nameEn: 'science'),
  Category(id: '5',nameJp: 'スポーツ',nameEn: 'sports'),
  Category(id: '6',nameJp: 'テクノロジー',nameEn: 'technology'),
];