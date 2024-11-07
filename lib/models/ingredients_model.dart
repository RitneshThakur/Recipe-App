class Ingredient {
  final String text;
  final double quantity;
   String? image;
   final String unit;

  Ingredient({required this.text, required this.quantity,this.image,required this.unit});
Map<String,dynamic>toJson(){
  return{
    'text': text,
    'quantity': quantity,
    'unit': unit,
    'image': image,
  };
}
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      text: json['food'] ?? 'Unknown ingredient',
      quantity: json['quantity']?.toDouble() ?? 0.0,
      image: json['image'],
        unit: json['measure'] ?? 'pcs'
    );
  }
}
