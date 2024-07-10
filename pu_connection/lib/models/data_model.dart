class ResponseModel {
  final String? id;
  final String? message;
  final int? pages;
  final bool? success;
  final List<dynamic>? data; // Dữ liệu cụ thể

  ResponseModel({
    this.id,
    this.message,
    this.pages,
    this.success,
    this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      id: json['Id'],
      message: json['Message'],
      pages: json['Pages'],
      success: json['Success'],
      data: json['Data'],
    );
  }
}
