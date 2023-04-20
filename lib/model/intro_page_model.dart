class HomePageDataModel {
    String? id;
    String? title;
    String? subtitle;
    String? text;
    String? img;

    HomePageDataModel({this.id, this.title, this.subtitle, this.text, this.img}); 

    HomePageDataModel.fromJson(dynamic json) {
        id = json['id'];
        title = json['title'];
        subtitle = json['sub_title'];
        text = json['text'];
        img = json['img'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = Map<String, dynamic>();
        data['id'] = id;
        data['title'] = title;
        data['sub_title'] = subtitle;
        data['text'] = text;
        data['img'] = img;
        return data;
    }
}
