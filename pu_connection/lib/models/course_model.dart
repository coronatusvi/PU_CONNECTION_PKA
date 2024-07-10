class CourseModel {
  final String id;
  final String lichHocId;
  final String ngayTao;
  final String nguoiTaoId;
  final String ngayCapNhatCuoi;
  final String nguoiCapNhatCuoiId;
  final String nguoiHocId;
  final String lopHocPhanId;
  final String tenHocPhan;
  final String lopHocPhanIdLop;
  final String dangKyLopHocPhanTen;
  final String tenLopHocPhan;
  final String baiHoc;
  final String giangVienId;
  final String ngayBatDau;
  final String ngayKetThuc;
  final String thu;
  final String thuHoc;
  final double soTiet;
  final double tietBatDau;
  final double tietKetThuc;
  final String phongHocId;
  final String phongHocTen;
  final String tenPhongHoc;
  final String phongHocMa;
  final String thuocTinhLopId;
  final String thuocTinhTen;
  final String giangVien;
  final String buoiHoc;
  final String ngayHoc;
  final double gioBatDau;
  final double phutBatDau;
  final double gioKetThuc;
  final double phutKetThuc;
  final String phanLoai;
  final String caThi;
  final String thongTinChuyenCan;

  CourseModel({
    required this.id,
    required this.lichHocId,
    required this.ngayTao,
    required this.nguoiTaoId,
    required this.ngayCapNhatCuoi,
    required this.nguoiCapNhatCuoiId,
    required this.nguoiHocId,
    required this.lopHocPhanId,
    required this.tenHocPhan,
    required this.lopHocPhanIdLop,
    required this.dangKyLopHocPhanTen,
    required this.tenLopHocPhan,
    required this.baiHoc,
    required this.giangVienId,
    required this.ngayBatDau,
    required this.ngayKetThuc,
    required this.thu,
    required this.thuHoc,
    required this.soTiet,
    required this.tietBatDau,
    required this.tietKetThuc,
    required this.phongHocId,
    required this.phongHocTen,
    required this.tenPhongHoc,
    required this.phongHocMa,
    required this.thuocTinhLopId,
    required this.thuocTinhTen,
    required this.giangVien,
    required this.buoiHoc,
    required this.ngayHoc,
    required this.gioBatDau,
    required this.phutBatDau,
    required this.gioKetThuc,
    required this.phutKetThuc,
    required this.phanLoai,
    required this.caThi,
    required this.thongTinChuyenCan,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['ID'] ?? '',
      lichHocId: json['IDLICHHOC'] ?? '',
      ngayTao: json['NGAYTAO'] ?? '',
      nguoiTaoId: json['NGUOITAO_ID'] ?? '',
      ngayCapNhatCuoi: json['NGAYCAPNHATCUOI'] ?? '',
      nguoiCapNhatCuoiId: json['NGUOICAPNHATCUOI_ID'] ?? '',
      nguoiHocId: json['QLSV_NGUOIHOC_ID'] ?? '',
      lopHocPhanId: json['DANGKY_LOPHOCPHAN_ID'] ?? '',
      tenHocPhan: json['TENHOCPHAN'] ?? '',
      lopHocPhanIdLop: json['IDLOPHOCPHAN'] ?? '',
      dangKyLopHocPhanTen: json['DANGKY_LOPHOCPHAN_TEN'] ?? '',
      tenLopHocPhan: json['TENLOPHOCPHAN'] ?? '',
      baiHoc: json['BAIHOC'] ?? '',
      giangVienId: json['GIANGVIEN_ID'] ?? '',
      ngayBatDau: json['NGAYBATDAU'] ?? '',
      ngayKetThuc: json['NGAYKETTHUC'] ?? '',
      thu: json['THU'] ?? '',
      thuHoc: json['THUHOC'] ?? '',
      soTiet: json['SOTIET'] ?? 0.0,
      tietBatDau: json['TIETBATDAU'] ?? 0.0,
      tietKetThuc: json['TIETKETTHUC'] ?? 0.0,
      phongHocId: json['PHONGHOC_ID'] ?? '',
      phongHocTen: json['PHONGHOC_TEN'] ?? '',
      tenPhongHoc: json['TENPHONGHOC'] ?? '',
      phongHocMa: json['PHONGHOC_MA'] ?? '',
      thuocTinhLopId: json['THUOCTINHLOP_ID'] ?? '',
      thuocTinhTen: json['THUOCTINH_TEN'] ?? '',
      giangVien: json['GIANGVIEN'] ?? '',
      buoiHoc: json['BUOIHOC'] ?? '',
      ngayHoc: json['NGAYHOC'] ?? '',
      gioBatDau: json['GIOBATDAU'] ?? 0.0,
      phutBatDau: json['PHUTBATDAU'] ?? 0.0,
      gioKetThuc: json['GIOKETTHUC'] ?? 0.0,
      phutKetThuc: json['PHUTKETTHUC'] ?? 0.0,
      phanLoai: json['PHANLOAI'] ?? '',
      caThi: json['CATHI'] ?? '',
      thongTinChuyenCan: json['THONGTINCHUYENCAN'] ?? '',
    );
  }
}
