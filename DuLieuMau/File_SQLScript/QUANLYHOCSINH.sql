USE [master]

GO
CREATE DATABASE [QUANLYHOCSINH]
GO
ALTER DATABASE TEST SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

USE [QUANLYHOCSINH]

GO

/******  Start create all table for work ******/

CREATE TABLE [dbo].[KHOILOP]
(
	[MaKhoiLop] nvarchar(12) primary key not null,
	[TenKhoiLop] nvarchar(40) not null,
)

CREATE TABLE [dbo].[NAMHOC]
(
	[MaNamHoc] nvarchar(12) primary key not null,
	[NamBatDau] int not null,
	[NamKetThuc] int not null,
)

CREATE TABLE [dbo].[HOCKY]
(
	[MaHocKy] nvarchar(12) primary key not null,
	[TenHocKy] nvarchar(40) not null,
)

CREATE TABLE [dbo].[HOCKYNAMHOC]
(
	[MaHocKyNamHoc] nvarchar(12) primary key not null,
	[MaNamHoc] nvarchar(12) foreign key references [dbo].[NAMHOC](MaNamHoc) not null,
	[MaHocKy] nvarchar(12) foreign key references [dbo].[HOCKY](MaHocKy) not null,
)

CREATE TABLE [dbo].[LOP]
(
	[MaLop] nvarchar(12) primary key not null,
	[TenLop] nvarchar(40) not null,
	[MaKhoiLop] nvarchar(12) foreign key references [dbo].[KHOILOP](MaKhoiLop) not null,
)

CREATE TABLE [dbo].[LOAITINHTRANGTHEOHOC]
(
	[MaLoaiTinhTrangTheoHoc] nvarchar(12) primary key,
	[TenLoaiTinhTrangTheoHoc] nvarchar(100) not null,
)

CREATE TABLE [dbo].[HOCSINH]
(
	[MaHocSinh] nvarchar(12) primary key not null,
	[HoTen] nvarchar(80) not null,
	[GioiTinh] int not null,
	[NgaySinh] smalldatetime not null, 
	[DiaChi] nvarchar(100) not null,
	[Email] nvarchar(100) not null,
	[SoDienThoaiPhuHuynh] nvarchar(50) not null,
	[NgayNhapHoc] smalldatetime not null,
	[AnhDaiDien] nvarchar(12) null,
	[GhiChu] nvarchar(100) null,
	[MaLoaiTinhTrangTheoHoc] nvarchar(12) foreign key references [dbo].[LOAITINHTRANGTHEOHOC](MaLoaiTinhTrangTheoHoc) not null,
)

CREATE TABLE [dbo].[MONHOC]
(
	[MaMonHoc] nvarchar(12) primary key not null,
	[TenMonHoc] nvarchar(20) not null,
	[HeSo] float not null, 
)

CREATE TABLE [dbo].[BANGDIEM]
(
	[MaBangDiem] nvarchar(12) primary key not null,
	[MaMonHoc] nvarchar(12) foreign key references [dbo].[MONHOC](MaMonHoc) not null,
	[MaLop] nvarchar(12) foreign key references [dbo].[LOP](MaLop) not null,
	[MaHocKyNamHoc] nvarchar(12) foreign key references [dbo].[HOCKYNAMHOC](MaHocKyNamHoc) not null, 
)

CREATE TABLE [dbo].[CT_BANGDIEM]
(
	[MaCT_BangDiem] nvarchar(12) primary key not null,
	[MaBangDiem] nvarchar(12) foreign key references [dbo].[BANGDIEM](MaBangDiem) not null,
	[MaHocSinh] nvarchar(12) foreign key references [dbo].[HOCSINH](MaHocSinh) not null,
)

CREATE TABLE [dbo].[LOAIDIEM]
(
	[MaLoaiDiem] nvarchar(12) primary key not null,
	[TenLoaiDiem] nvarchar(50) not null,
	[HeSo] float,
)

CREATE TABLE [dbo].[CT_DIEM]
(
	[MaCT_Diem] nvarchar(12) primary key not null,
	[GiaTri] float not null,
	[MaLoaiDiem] nvarchar(12) foreign key references [dbo].[LOAIDIEM](MaLoaiDiem) not null,
	[MaCT_BangDiem] nvarchar(12) foreign key references [dbo].[CT_BANGDIEM](MaCT_BANGDIEM) not null, 
)

CREATE TABLE [dbo].[LOAINGUOIDUNG]
(
	[MaLoaiNguoiDung] nvarchar(12) primary key not null,
	[TenLoaiNguoiDung] nvarchar(50) not null,
)

CREATE TABLE [dbo].[NGUOIDUNG]
(
	[TenDangNhap] nvarchar(50) primary key not null,
	[MaLoaiNguoiDung] nvarchar(12) foreign key references [dbo].[LOAINGUOIDUNG](MaLoaiNguoiDung) not null,
	[MatKhau] nvarchar(50) not null,
)

CREATE TABLE [dbo].[LOAIHANHKIEM]
(
	[MaLoaiHanhKiem] nvarchar(12) primary key,
	[TenLoaiHanhKiem] nvarchar(50) not null,
)

CREATE TABLE [dbo].[XEPLOAIHANHKIEM]
(
	[MaXepLoaiHanhKiem] nvarchar(12) primary key,
	[MaHocSinh] nvarchar(12) foreign key references [dbo].[HOCSINH](MaHocSinh) not null,
	[MaHocKyNamHoc] nvarchar(12) foreign key references [dbo].[HOCKYNAMHOC](MaHocKyNamHoc) not null,
	[MaLoaiHanhKiem] nvarchar(12) foreign key references [dbo].[LOAIHANHKIEM](MaLoaiHanhKiem) not null,
) 

CREATE TABLE [dbo].[TTHOCPHI]
(
	[MaTTHocPhi] nvarchar(12) primary key,
	[MaHocKyNamHoc] nvarchar(12) foreign key references [dbo].[HOCKYNAMHOC](MaHocKyNamHoc) not null,
	[MaHocSinh] nvarchar(12) foreign key references [dbo].[HOCSINH](MaHocSinh) not null,
	[TongHocPhi] money not null,
	[HocPhiDaDong] money not null,
	[HocPhiConLai] money not null,
	[SoDu] money not null,
)

CREATE TABLE [dbo].[CT_DONGHOCPHI]
(
	[MaCT_DongHocPhi] nvarchar(12) primary key,
	[MaTTHocPhi] nvarchar(12) foreign key references [dbo].[TTHOCPHI](MaTTHocPhi) not null,
	[NgayDong] smalldatetime not null,
	[SoTienDong] money not null,
	[NguoiDong] nvarchar(100) not null,
	[NoiDong] nvarchar(100) not null,
)

CREATE TABLE [dbo].[TTBAOHIEMYTE]
(
	[MaTTBaoHiemYTe] nvarchar(12) primary key,
	[MaHocKyNamHoc] nvarchar(12) foreign key references [dbo].[HOCKYNAMHOC](MaHocKyNamHoc) not null,
	[MaHocSinh] nvarchar(12) foreign key references [dbo].[HOCSINH](MaHocSinh) not null,
	[TrangThai] bit not null,
	[PhiBaoHiem] money not null,
	[SoDu] money not null,
)

CREATE TABLE [dbo].[CT_DONGBAOHIEM]
(
	[MaCT_DongBaoHiem] nvarchar(12) primary key,
	[MaTTBaoHiemYTe] nvarchar(12) foreign key references [dbo].[TTBAOHIEMYTE](MaTTBaoHiemYTe) not null,
	[NgayDong] smalldatetime not null,
	[SoTienDong] money not null,
	[NoiDong] nvarchar(100) not null,
	[NguoiDong] nvarchar(100) not null,
)

CREATE TABLE [dbo].[CHUYENMON]
(
	[MaChuyenMon] nvarchar(12) primary key,
	[TenChuyenMon] nvarchar(100) not null,
)

CREATE TABLE [dbo].[LOAITINHTRANGCONGTAC]
(
	[MaLoaiTinhTrangCongTac] nvarchar(12) primary key,
	[TenLoaiTinhTrangCongTac] nvarchar(100) not null, 
)

CREATE TABLE [dbo].[GIAOVIEN]
(
	[MaGiaoVien] nvarchar(12) primary key,
	[MaChuyenMon] nvarchar(12) foreign key references [dbo].[CHUYENMON](MaChuyenMon),
	[HoTen] nvarchar(80) not null,
	[NgaySinh]	smalldatetime not null,
	[GioiTinh] int not null,
	[DiaChi] nvarchar(100) not null,
	[Email] nvarchar(100) not null,
	[SoDienThoai] nvarchar(50) not null,
	[NgayVaoLam] smalldatetime not null,
	[AnhDaiDien] nvarchar(12) null,
	[GhiChu] nvarchar(100) null,
	[MaLoaiTinhTrangCongTac] nvarchar(12) foreign key references [dbo].[LOAITINHTRANGCONGTAC](MaLoaiTinhTrangCongTac)not null,
)

CREATE TABLE [dbo].[DANHSACHGIAOVIEN]
(
	[MaGiaoVien] nvarchar(12) foreign key references [dbo].[GIAOVIEN](MaGiaoVien),
	[MaHocKyNamHoc] nvarchar(12) foreign key references [dbo].[HOCKYNAMHOC](MaHocKyNamHoc),
	[MaMonHoc] nvarchar(12) foreign key references [dbo].[MONHOC](MaMonHoc),

	constraint pk_DanhSachGiaoVien primary key (MaGiaoVien,MaHocKyNamHoc),
)

CREATE TABLE [dbo].[DANHSACHLOP]
(
	[MaGiaoVien] nvarchar(12)not null,
	[MaLop] nvarchar(12) foreign key references [dbo].[LOP](MaLop) not null,
	[MaHocKyNamHoc] nvarchar(12) not null,

	constraint FK_DanhSachLop foreign key(MaGiaoVien,MaHocKyNamHoc) references [dbo].[DANHSACHGIAOVIEN](MaGiaoVien,MaHocKyNamHoc),
	constraint PK_DanhSachLop primary key(MaLop,MaHocKyNamHoc),
)

CREATE TABLE [dbo].[DANHSACHCT_LOP]
(
	[MaLop] nvarchar(12) not null,
	[MaHocKyNamHoc] nvarchar(12) not null,
	[MaHocSinh] nvarchar(12) not null,

	constraint FK_DanhSachCT_Lop_DanhSachLop foreign key (MaLop,MaHocKyNamHoc) references [dbo].[DANHSACHLOP](MaLop,MaHocKyNamHoc),
	constraint FK_DanhSachCT_Lop_HocSinh foreign key (MaHocSinh) references [dbo].[HOCSINH](MaHocSinh),
	constraint PK_DanhSachCT_Lop primary key(MaLop,MaHocKyNamHoc,MaHocSinh),

)

CREATE TABLE [dbo].[THOIKHOABIEULOP]
(
	[MaLop] nvarchar(12) not null,
	[MaHocKyNamHoc] nvarchar(12) not null,
	[NgayHoc] int not null, /* Ngay hoc  trong tuan: 2-7 */
	[TietHoc] int not null, /* Tiet hoc trong ngay: 1-10 */
	[MaMonHoc] nvarchar(12) not null foreign key references [dbo].[MONHOC](MaMonHoc),
	[MaGiaoVien] nvarchar(12) not null,

	constraint FK_ThoiKhoaBieu_Lop foreign key(MaLop,MaHocKyNamHoc) references [dbo].[DANHSACHLOP](MaLop,MaHocKyNamHoc),
	constraint FK_ThoiKhoaBieu_GiaoVien foreign key(MaGiaoVien,MaHocKyNamHoc) references [dbo].[DANHSACHGIAOVIEN](MaGiaoVien,MaHocKyNamHoc),
	constraint PK_ThoiKhoaBieu primary key(MaLop,MaHocKyNamHoc,NgayHoc,TietHoc),
)

CREATE TABLE [dbo].[THAMSO]
(
	[TenThamSo] nvarchar(50) primary key not null,
	[GiaTri] float not null,
)

CREATE TABLE [dbo].[BODEM]
(
	[TenBangDem] nvarchar(50) primary key not null,
	[TongCong] int not null,
)

GO

/******  End create table  ******/
/*******************************/


/******  Start create all StoredProcedure for work  ******/
/******  Create 4 StoredProcedure for 1 table:  ******/
/******		1. Insert.  ******/
/******		2. Update.  ******/
/******		3. Delete.  ******/
/******		4. Select.  ******/


/******  Table [dbo].[KHOILOP]  ******/
/******  StoredProcedure [dbo].[ThemKhoiLop]   ******/
create procedure [dbo].[ThemKhoiLop]
	@MaKhoiLop nvarchar(12) ,
	@TenKhoiLop nvarchar(40) 
	as
		begin
			insert into [dbo].[KHOILOP](MaKhoiLop,TenKhoiLop) values(@MaKhoiLop,@TenKhoiLop)
			exec [dbo].[TangBoDem] 'KHOILOP'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiKhoiLop]   ******/
create procedure [dbo].[ThayDoiKhoiLop]
	@MaKhoiLop nvarchar(12),
	@TenKhoiLop nvarchar(40)
	as
		begin
		update [dbo].[KHOILOP]
		set TenKhoiLop = @TenKhoiLop
		where MaKhoiLop = @MaKhoiLop
		end
GO
/******  StoredProcedure [dbo].[XoaKhoiLop]   ******/
create procedure [dbo].[XoaKhoiLop]
	@MaKhoiLop nvarchar(12) = null
	as
		begin
			if(@MaKhoiLop is not null)
				begin
					delete from [dbo].[KHOILOP]
					where MaKhoiLop = @MaKhoiLop
				end
			else
				begin
					delete from [dbo].[KHOILOP]
				end
		end
GO
/******  StoredProcedure [dbo].[LayKhoiLop]   ******/
create procedure [dbo].[LayKhoiLop]
	@MaKhoiLop nvarchar(12) = null
	as
		begin
			if(@MaKhoiLop is not null)
				begin
					select * from [dbo].[KHOILOP]
					where MaKhoiLop = @MaKhoiLop
				end 
			else
				begin
					select * from [dbo].[KHOILOP] 
				end
		end
GO
/***************************************************/

/******  Table [dbo].[NAMHOC]  ******/
/******  StoredProcedure [dbo].[ThemNamHoc]   ******/
create procedure [dbo].[ThemNamHoc]
	@MaNamHoc nvarchar(12),
	@NamBatDau int,
	@NamKetThuc int
	as
		begin
			insert into [dbo].[NAMHOC](MaNamHoc,NamBatDau,NamKetThuc) values(@MaNamHoc,@NamBatDau,@NamKetThuc)
			exec [dbo].[TangBoDem] 'NAMHOC'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiNamHoc]   ******/
create procedure [dbo].[ThayDoiNamHoc]
	@MaNamHoc nvarchar(12),
	@NamBatDau int,
	@NamKetThuc int
	as
		begin
			update [dbo].[NAMHOC]
			set NamBatDau = @NamBatDau ,
				NamKetThuc = @NamKetThuc
			where MaNamHoc = @MaNamHoc
		end
GO
/******  StoredProcedure [dbo].[XoaNamHoc]   ******/
create procedure [dbo].[XoaNamHoc]
	@MaNamHoc nvarchar(12) = null
	as
		begin
			if(@MaNamHoc is not null)
				begin
					delete from [dbo].[NAMHOC]
					where MaNamHoc = @MaNamHoc
				end
			else
				begin
					delete from [dbo].[NAMHOC]
				end
		end
GO
/******  StoredProcedure [dbo].[LayNamHoc]   ******/
create procedure [dbo].[LayNamHoc]
	@MaNamHoc nvarchar(12) = null
	as
		begin
			if(@MaNamHoc is not null)
				begin
					select * from [dbo].[NamHoc]
					where MaNamHoc = @MaNamHoc 
				end
			else
				begin
					select * from [dbo].[NAMHOC]
				end
		end
GO
/***************************************************/

/******  Table [dbo].[HOCKY]  ******/
/******  StoredProcedure [dbo].[ThemHocKy]   ******/
create procedure [dbo].[ThemHocKy]
	@MaHocky nvarchar(12),
	@TenHocKy nvarchar(40)
	as
		begin
			insert into [dbo].[HOCKY](MaHocKy,TenHocKy) values(@MaHocky,@TenHocKy)
			exec [dbo].[TangBoDem] 'HOCKY'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiHocKy]   ******/
create procedure [dbo].[ThayDoiHocKy]
	@MaHocky nvarchar(12),
	@TenHocKy nvarchar(40)
	as
		begin
			update [dbo].[HOCKY]
			set TenHocKy = @TenHocKy
			where MaHocKy = @MaHocky
		end
GO
/******  StoredProcedure [dbo].[XoaHocKy]   ******/
create procedure [dbo].[XoaHocKy]
	@MaHocKy nvarchar(12) = null
	as
		begin
			if(@MaHocKy is not null)
				begin
					delete from [dbo].[HOCKY]
					where MaHocKy = @MaHocKy
				end 
			else
				begin
					delete from [dbo].[HOCKY]
				end
		end
GO
/******  StoredProcedure [dbo].[LayHocKy]   ******/
create procedure [dbo].[LayHocKy]
	@MaHocKy nvarchar(12) = null
	as
		begin
			if(@MaHocKy is not null)
				begin
					select * from [dbo].[HOCKY]
					where MaHocKy = @MaHocKy
				end
			else
				begin 
					select * from [dbo].[HOCKY]
				end
		end
GO
/***************************************************/

/******  Table [dbo].[HOCKYNAMHOC]  ******/
/******  StoredProcedure [dbo].[ThemHocKyNamHoc]   ******/
create procedure [dbo].[ThemHocKyNamHoc]
	@MaHocKyNamHoc nvarchar(12) ,
	@MaNamHoc nvarchar(12) ,
	@MaHocKy nvarchar(12) 
	as
		begin
			insert into [dbo].[HOCKYNAMHOC](MaHocKyNamHoc,MaNamHoc,MaHocKy) 
			values(@MaHocKyNamHoc,@MaNamHoc,@MaHocKy)
			exec [dbo].[TangBoDem] 'HOCKYNAMHOC'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiHocKyNamHoc]   ******/
create procedure [dbo].[ThayDoiHocKyNamHoc]
	@MaHocKyNamHoc nvarchar(12),
	@MaHocKy nvarchar(12) = null,
	@MaNamHoc nvarchar(12) = null
	as
		begin
			if(@MaHocKy is not null)
				begin
					update [dbo].[HOCKYNAMHOC]
					set MaHocKy = @MaHocKy
					where MaHocKyNamHoc = @MaHocKyNamHoc
				end
			if(@MaNamHoc is not null)
				begin
					update [dbo].[HOCKYNAMHOC]
					set MaNamHoc = @MaNamHoc
					where MaHocKyNamHoc = @MaHocKyNamHoc
				end
		end
GO
/******  StoredProcedure [dbo].[XoaHocKyNamHoc]   ******/
create procedure [dbo].[XoaHocKyNamHoc]
	@MaHocKyNamHoc nvarchar(12) = null
	as
		begin
			if(@MaHocKyNamHoc is not null)
				begin
					delete from [dbo].[HOCKYNAMHOC]
					where MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else
				begin
					delete from [dbo].[HOCKYNAMHOC]
				end
		end
GO
/******  StoredProcedure [dbo].[LayHocKyNamHoc]   ******/
create procedure [dbo].[LayHocKyNamHoc]
	@MaHocKyNamHoc nvarchar(12) = null,
	@MaNamHoc nvarchar(12) = null
	as
		begin
			if(@MaNamHoc is not null and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[HOCKYNAMHOC]
					where MaNamHoc = @MaNamHoc
				end
			else if(@MaHocKyNamHoc is null and @MaNamHoc is null)
				begin
					select * from [dbo].[HOCKYNAMHOC]
				end
			else if(@MaNamHoc is null and @MaHocKyNamHoc is not null)
				begin
					select * from [dbo].[HOCKYNAMHOC]
					where MaHocKyNamHoc = @MaHocKyNamHoc 
				end
		end
GO
/***************************************************/

/******  Table [dbo].[LOP]  ******/
/******  StoredProcedure [dbo].[ThemLop]   ******/
create procedure [dbo].[ThemLop]
	@MaLop nvarchar(12) ,
	@TenLop nvarchar(40) ,
	@MaKhoiLop nvarchar(12)
	as
		begin
			insert into [dbo].[LOP](MaLop,TenLop,MaKhoiLop) 
			values(@MaLop,@TenLop,@MaKhoiLop)
			exec [dbo].[TangBoDem] 'LOP'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiLop]   ******/
create procedure [dbo].[ThayDoiLop]
	@MaLop nvarchar(12) ,
	@TenLop nvarchar(40) = null ,
	@MaKhoiLop nvarchar(12) = null
	as
		begin
			if(@TenLop is not null)
				begin 
					update [dbo].[LOP]
					set TenLop = @TenLop
					where MaLop = @MaLop
				end
			if(@MaKhoiLop is not null)
				begin 
					update [dbo].[LOP]
					set MaKhoiLop = @MaKhoiLop
					where MaLop = @MaLop
				end
		end
GO
/******  StoredProcedure [dbo].[XoaLop]   ******/
create procedure [dbo].[XoaLop]
	@MaLop nvarchar(12) = null
	as
		begin
			if(@MaLop is not null)
				begin 
					delete from [dbo].[LOP]
					where MaLop = @MaLop
				end
			else
				begin
					delete from [dbo].[LOP]
				end
		end
GO
/******  StoredProcedure [dbo].[LayLop]   ******/
create procedure [dbo].[LayLop]
	@MaLop nvarchar(12) = null,
	@MaKhoiLop nvarchar(12) = null
	as
		begin
			if(@MaKhoiLop is null and @MaLop is null)
				begin
					select * from [dbo].[LOP]
				end
			else if( @MaLop is null)
				begin
					select * from [dbo].[LOP]
					where MaKhoiLop = @MaKhoiLop
				end
			else if(@MaKhoiLop is null)
				begin
					select * from [dbo].[LOP]
					where MaLop = @MaLop
				end
		end
GO
/***************************************************/

/******  Table [dbo].[LOAITINHTRANGTHEOHOC]  ******/
/******  StoredProcedure [dbo].[ThemLoaiTinhTrangTheoHoc]   ******/
create procedure [dbo].[ThemLoaiTinhTrangTheoHoc]
	@MaLoaiTinhTrangTheoHoc nvarchar(12) ,
	@TenLoaiTinhTrangTheoHoc nvarchar(40) 
	as
		begin
			insert into [dbo].[LOAITINHTRANGTHEOHOC](MaLoaiTinhTrangTheoHoc,TenLoaiTinhTrangTheoHoc)
			 values(@MaLoaiTinhTrangTheoHoc,@TenLoaiTinhTrangTheoHoc)
			exec [dbo].[TangBoDem] 'LOAITINHTRANGTHEOHOC'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiLoaiTinhTrangTheoHoc]   ******/
create procedure [dbo].[ThayDoiLoaiTinhTrangTheoHoc]
	@MaLoaiTinhTrangTheoHoc nvarchar(12) ,
	@TenLoaiTinhTrangTheoHoc nvarchar(40) 
	as
		begin
		update [dbo].[LOAITINHTRANGTHEOHOC]
		set TenLoaiTinhTrangTheoHoc = @TenLoaiTinhTrangTheoHoc
		where MaLoaiTinhTrangTheoHoc = @MaLoaiTinhTrangTheoHoc
		end
GO
/******  StoredProcedure [dbo].[XoaLoaiTinhTrangTheoHoc]   ******/
create procedure [dbo].[XoaLoaiTinhTrangTheoHoc]
	@MaLoaiTinhTrangTheoHoc nvarchar(12) = null
	as
		begin
			if(@MaLoaiTinhTrangTheoHoc is not null)
				begin
					delete from [dbo].[LOAITINHTRANGTHEOHOC]
					where MaLoaiTinhTrangTheoHoc = @MaLoaiTinhTrangTheoHoc
				end
			else
				begin
					delete from [dbo].[LOAITINHTRANGTHEOHOC]
				end
		end
GO
/******  StoredProcedure [dbo].[LayLoaiTinhTrangTheoHoc]   ******/
create procedure [dbo].[LayLoaiTinhTrangTheoHoc]
	@MaLoaiTinhTrangTheoHoc nvarchar(12) = null
	as
		begin
			if(@MaLoaiTinhTrangTheoHoc is not null)
				begin
					select * from [dbo].[LOAITINHTRANGTHEOHOC]
					where MaLoaiTinhTrangTheoHoc = @MaLoaiTinhTrangTheoHoc
				end 
			else
				begin
					select * from [dbo].[LOAITINHTRANGTHEOHOC] 
				end
		end
GO
/***************************************************/

/******  Table [dbo].[HOCSINH]  ******/
/******  StoredProcedure [dbo].[ThemHocSinh]   ******/
create procedure [dbo].[ThemHocSinh]
	@MaHocSinh nvarchar(12),
	@HoTen nvarchar(80) ,
	@GioiTinh int ,
	@NgaySinh smalldatetime , 
	@DiaChi nvarchar(100) ,
	@Email nvarchar(100) ,
	@SoDienThoaiPhuHuynh nvarchar(50),
	@NgayNhapHoc smalldatetime ,
	@AnhDaiDien nvarchar(12) ,
	@GhiChu nvarchar(100),
	@MaLoaiTinhTrangTheoHoc nvarchar(12)
	as
		begin
			insert into [dbo].[HOCSINH](MaHocSinh, HoTen, GioiTinh, NgaySinh,  DiaChi, Email, SoDienThoaiPhuHuynh, NgayNhapHoc, AnhDaiDien, GhiChu, MaLoaiTinhTrangTheoHoc) 
			values(@MaHocSinh, @HoTen, @GioiTinh, @NgaySinh,  @DiaChi, @Email, @SoDienThoaiPhuHuynh, @NgayNhapHoc, @AnhDaiDien, @GhiChu, @MaLoaiTinhTrangTheoHoc)
			exec [dbo].[TangBoDem] 'HOCSINH'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiHocSinh]   ******/
create procedure [dbo].[ThayDoiHocSinh]
	@MaHocSinh nvarchar(12),
	@HoTen nvarchar(80) = null,
	@GioiTinh int  = null,
	@NgaySinh smalldatetime  = null, 
	@DiaChi nvarchar(100)  = null,
	@Email nvarchar(100)  = null,
	@SoDienThoaiPhuHuynh nvarchar(50) = null,
	@NgayNhapHoc smalldatetime  = null,
	@AnhDaiDien nvarchar(12)  = null,
	@GhiChu nvarchar(100) = null,
	@MaLoaiTinhTrangTheoHoc nvarchar(12) = null
	as
		begin
			if(@HoTen is not null)
				begin
					update [dbo].[HOCSINH]
					set HoTen = @HoTen
					where MaHocSinh = @MaHocSinh
				end
			if(@GioiTinh is not null)
				begin
					update [dbo].[HOCSINH]
					set GioiTinh = @GioiTinh
					where MaHocSinh = @MaHocSinh
				end
			if(@NgaySinh is not null)
				begin
					update [dbo].[HOCSINH]
					set NgaySinh = @NgaySinh
					where MaHocSinh = @MaHocSinh
				end
			if(@DiaChi is not null)
				begin
					update [dbo].[HOCSINH]
					set DiaChi = @DiaChi
					where MaHocSinh = @MaHocSinh
				end
			if(@Email is not null)
				begin
					update [dbo].[HOCSINH]
					set Email = @Email
					where MaHocSinh = @MaHocSinh
				end
			if(@SoDienThoaiPhuHuynh is not null)
				begin
					update [dbo].[HOCSINH]
					set SoDienThoaiPhuHuynh = @SoDienThoaiPhuHuynh
					where MaHocSinh = @MaHocSinh
				end
			if(@AnhDaiDien is not null)
				begin
					update [dbo].[HOCSINH]
					set AnhDaiDien = @AnhDaiDien
					where MaHocSinh = @MaHocSinh
				end
			if(@GhiChu is not null)
				begin
					update [dbo].[HOCSINH]
					set GhiChu = @GhiChu
					where MaHocSinh = @MaHocSinh
				end
			if(@MaLoaiTinhTrangTheoHoc is not null)
				begin
					update [dbo].[HOCSINH]
					set MaLoaiTinhTrangTheoHoc = @MaLoaiTinhTrangTheoHoc
					where MaHocSinh = @MaHocSinh
				end

		end
GO
/******  StoredProcedure [dbo].[XoaHocSinh]   ******/
create procedure [dbo].[XoaHocSinh]
	@MaHocSinh nvarchar(12) = null
	as
		begin
			if(@MaHocSinh is not null)
				begin
					delete from [dbo].[HOCSINH]
					where MaHocSinh = @MaHocSinh
				end
			else
				begin
					delete from [dbo].[HOCSINH]
				end
		end
GO
/******  StoredProcedure [dbo].[LayHocSinh]   ******/
create procedure [dbo].[LayHocSinh]
	@NgayNhapHoc smalldatetime = null,
	@MaHocSinh nvarchar(12) = null,
	@MaLoaiTinhTrangTheoHoc nvarchar(12) = null
	as
		begin
			if(@NgayNhapHoc is not null and @MaHocSinh is null and @MaLoaiTinhTrangTheoHoc is null)
				begin
					select * from [dbo].[HOCSINH]
					where NgayNhapHoc = @NgayNhapHoc
				end
			else if(@NgayNhapHoc is null and @MaHocSinh is null and @MaLoaiTinhTrangTheoHoc is null)
				begin 
					select * from [dbo].[HOCSINH]
				end
			else if(@MaHocSinh is not null and @NgayNhapHoc is null and @MaLoaiTinhTrangTheoHoc is null)
				begin 
					select * from [dbo].[HOCSINH]
					where MaHocSinh = @MaHocSinh
				end
			else if(@MaHocSinh is null and @NgayNhapHoc is null and @MaLoaiTinhTrangTheoHoc is not null)
				begin 
					select * from [dbo].[HOCSINH]
					where MaLoaiTinhTrangTheoHoc = @MaLoaiTinhTrangTheoHoc
				end
		end
GO
/***************************************************/

/******  Table [dbo].[DANHSACHLOP]  ******/
/******  StoredProcedure [dbo].[ThemDanhSachLop]   ******/
create procedure [dbo].[ThemDanhSachLop]
	@MaLop nvarchar(12) ,
	@MaGiaoVien nvarchar(12) ,
	@MaHocKyNamHoc nvarchar(12)

	as
		begin
			insert into [dbo].[DANHSACHLOP] (MaGiaoVien,MaLop,MaHocKyNamHoc) 
			values(@MaGiaoVien,@MaLop,@MaHocKyNamHoc)
		end
GO
/******  StoredProcedure [dbo].[ThayDoiDanhSachLop]   ******/
create procedure [dbo].[ThayDoiDanhSachLop]
	@MaLop nvarchar(12) ,
	@MaGiaoVien nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12)
	as
		begin
			if(@MaGiaoVien is not null)
				begin
					update [dbo].[DANHSACHLOP]
					set MaGiaoVien = @MaGiaoVien
					where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc
				end
		end
GO
/******  StoredProcedure [dbo].[XoaDanhSachLop]   ******/
create procedure [dbo].[XoaDanhSachLop]
	@MaLop nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null
	as
		begin
			if(@MaLop is not null and @MaHocKyNamHoc is not null)
				begin
					delete from [dbo].[DANHSACHLOP]
					where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else
				begin
					delete from [dbo].[DANHSACHLOP]
				end
		end
GO
/******  StoredProcedure [dbo].[LayDanhSachLop]   ******/
create procedure [dbo].[LayDanhSachLop]
	@MaLop nvarchar(12) = null,
	@MaGiaoVien nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null
	as
		begin
			if(@MaLop is null and @MaGiaoVien is null and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[DANHSACHLOP]
				end
			else if(@MaLop is not null and @MaGiaoVien is null and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[DANHSACHLOP]
					where MaLop = @MaLop
				end
			else if(@MaLop is null and @MaGiaoVien is not null and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[DANHSACHLOP]
					where MaGiaoVien = @MaGiaoVien
				end
			else if(@MaLop is null and @MaGiaoVien is null and  @MaHocKyNamHoc is not null)
				begin
					select * from [dbo].[DANHSACHLOP]
					where MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else if( @MaLop is not null and @MaGiaoVien is null and  @MaHocKyNamHoc is not null)
				begin
					select * from [dbo].[DANHSACHLOP]
					where MaHocKyNamHoc = @MaHocKyNamHoc and MaLop = @MaLop
				end
			else if(@MaLop is  null and @MaGiaoVien is not null and  @MaHocKyNamHoc is not null)
				begin
					select * from [dbo].[DANHSACHLOP]
					where MaGiaoVien = @MaGiaoVien and MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else if(@MaLop is not null and @MaGiaoVien is not null  and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[DANHSACHLOP]
					where MaGiaoVien = @MaGiaoVien and MaLop = @MaLop
				end
		end
GO
/***************************************************/

/******  Table [dbo].[MONHOC]  ******/
/******  StoredProcedure [dbo].[ThemMonHoc]   ******/
create procedure [dbo].[ThemMonHoc]
	@MaMonHoc nvarchar(12) ,
	@TenMonHoc nvarchar(20),
	@HeSo float
	as
		begin
			insert into [dbo].[MONHOC] (MaMonHoc,TenMonHoc,HeSo) 
			values(@MaMonHoc, @TenMonHoc,@HeSo)
			exec [dbo].[TangBoDem] 'MONHOC'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiMonHoc]   ******/
create procedure [dbo].[ThayDoiMonHoc]
	@MaMonHoc nvarchar(12) ,
	@TenMonHoc nvarchar(20) = null,
	@HeSo float = null
	as
		begin
			if(@TenMonHoc is not null)
				begin
					update [dbo].[MONHOC]
					set TenMonHoc = @TenMonHoc
					where MaMonHoc = @MaMonHoc
				end
			if(@HeSo is not null)
				begin
					update [dbo].[MONHOC]
					set HeSo = @HeSo
					where MaMonHoc = @MaMonHoc
				end
		end
GO
/******  StoredProcedure [dbo].[XoaMonHoc]   ******/
create procedure [dbo].[XoaMonHoc]
	@MaMonHoc nvarchar(12) = null
	as
		begin
			if(@MaMonHoc is not null)
				begin 
					delete from [dbo].[MONHOC]
					where MaMonHoc = @MaMonHoc
				end
			else
				begin
					delete from [dbo].[MONHOC]
				end
		end
GO
/******  StoredProcedure [dbo].[LayMonHoc]   ******/
create procedure [dbo].[LayMonHoc]
	@MaMonHoc nvarchar(12) = null
	as
		begin
			if(@MaMonHoc is not null)
				begin
					select * from [dbo].[MONHOC]
					where MaMonHoc = @MaMonHoc
				end
			else
				begin 
					select * from [dbo].[MONHOC]
				end
		end
GO
/***************************************************/

/******  Table [dbo].[BANGDIEM]  ******/
/******  StoredProcedure [dbo].[ThemBangDiem]   ******/
create procedure [dbo].[ThemBangDiem]
	@MaBangDiem nvarchar(12) ,
	@MaMonHoc nvarchar(12) ,
	@MaLop nvarchar(12) ,
	@MaHocKyNamHoc nvarchar(12) 
	as
		begin
			insert into [dbo].[BANGDIEM](MaBangDiem,MaMonHoc,MaLop,MaHocKyNamHoc)
			 values(@MaBangDiem,@MaMonHoc,@MaLop,@MaHocKyNamHoc)
			exec [dbo].[TangBoDem] 'BANGDIEM'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiBangDiem]   ******/
create procedure [dbo].[ThayDoiBangDiem]
	@MaBangDiem nvarchar(12) ,
	@MaMonHoc nvarchar(12)  = null,
	@MaLop nvarchar(12)  = null,
	@MaHocKyNamHoc nvarchar(12) = null
	as
		begin
			if(@MaMonHoc is not null)
				begin 
					update [dbo].[BANGDIEM]
					set MaMonHoc = @MaMonHoc
					where MaBangDiem = @MaBangDiem
				end
			if(@MaLop is not null)
				begin 
					update [dbo].[BANGDIEM]
					set MaLop = @MaLop
					where MaBangDiem = @MaBangDiem
				end
			if(@MaHocKyNamHoc is not null)
				begin 
					update [dbo].[BANGDIEM]
					set MaHocKyNamHoc = @MaHocKyNamHoc
					where MaBangDiem = @MaBangDiem
				end
		end
GO
/******  StoredProcedure [dbo].[XoaBangDiem]   ******/
create procedure [dbo].[XoaBangDiem]
	@MaBangDiem nvarchar(12) = null
	as
		begin
			if(@MaBangDiem is not null)
				begin
					delete from [dbo].[BANGDIEM]
					where MaBangDiem = @MaBangDiem
				end
			else
				begin
					delete from [dbo].[BANGDIEM]
				end
		end
GO
/******  StoredProcedure [dbo].[LayBangDiem]   ******/
create procedure [dbo].[LayBangDiem]
	@MaBangDiem nvarchar(12) = null,
	@MaMonHoc nvarchar(12)  = null,
	@MaLop nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null 
	as
		begin
			if(@MaMonHoc is null and @MaLop is null and @MaHocKyNamHoc is null and @MaBangDiem is null)
				begin
					select * from [dbo].[BANGDIEM]
				end
			else if(@MaMonHoc is not null and @MaLop is not null and @MaHocKyNamHoc is not null and @MaBangDiem is null)
				begin
					select * from [dbo].[BANGDIEM]
					where MaLop = @MaLop and MaMonHoc = @MaMonHoc and MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else if(@MaLop is not null and @MaMonHoc is not null and @MaHocKyNamHoc is null and @MaBangDiem is null)
				begin
					select * from [dbo].[BANGDIEM]
					where MaLop = @MaLop and MaMonHoc = @MaMonHoc
				end
			else if(@MaLop is not null and @MaMonHoc is null and @MaHocKyNamHoc is not null and @MaBangDiem is null)
				begin
					select * from [dbo].[BANGDIEM]
					where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else if(@MaLop is null and @MaHocKyNamHoc is not null and @MaMonHoc is not null and @MaBangDiem is null)
				begin
					select * from [dbo].[BANGDIEM]
					where MaMonHoc = @MaMonHoc and MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else if(@MaLop is null and @MaHocKyNamHoc is null and @MaMonHoc is not null and @MaBangDiem is null)
				begin
					select * from [dbo].[BANGDIEM]
					where MaMonHoc = @MaMonHoc
				end
			else if(@MaLop is not null and @MaHocKyNamHoc is null and @MaMonHoc is null and @MaBangDiem is null)
				begin
					select * from [dbo].[BANGDIEM]
					where MaLop = @MaLop
				end
			else if(@MaLop is null and @MaMonHoc is null and @MaHocKyNamHoc is not null and @MaBangDiem is null)
				begin
					select * from [dbo].[BANGDIEM]
					where MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else if(@MaBangDiem is not null and @MaHocKyNamHoc is null and @MaLop is null and @MaMonHoc is null)
				begin
					select * from [dbo].[BANGDIEM]
					where MaBangDiem = @MaBangDiem
				end
		end
GO
/***************************************************/

/******  Table [dbo].[CT_BANGDIEM]  ******/
/******  StoredProcedure [dbo].[ThemCT_BangDiem]   ******/
create procedure [dbo].[ThemCT_BangDiem]
	@MaCT_BangDiem nvarchar(12) ,
	@MaBangDiem nvarchar(12) ,
	@MaHocSinh nvarchar(12) 
	as
		begin
			insert into [dbo].[CT_BANGDIEM] (MaCT_BangDiem,MaBangDiem,MaHocSinh) 
			values(@MaCT_BangDiem,@MaBangDiem,@MaHocSinh)
			exec [dbo].[TangBoDem] 'CT_BANGDIEM'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiCT_BangDiem]   ******/
create procedure [dbo].[ThayDoiCT_BangDiem]
	@MaCT_BangDiem nvarchar(12) ,
	@MaBangDiem nvarchar(12)  = null,
	@MaHocSinh nvarchar(12) = null
	as
		begin
			if(@MaBangDiem is not null)
				begin
					update [dbo].[CT_BANGDIEM]
					set MaBangDiem = @MaBangDiem
					where MaCT_BangDiem = @MaCT_BangDiem
				end
			if(@MaHocSinh is not null)
				begin
					update [dbo].[CT_BANGDIEM]
					set MaHocSinh = @MaHocSinh
					where MaCT_BangDiem = @MaCT_BangDiem
				end
		end
GO
/******  StoredProcedure [dbo].[XoaCT_BangDiem]   ******/
create procedure [dbo].[XoaCT_BangDiem]
	@MaCT_BangDiem nvarchar(12) = null
	as
		begin
			if(@MaCT_BangDiem is not null)
				begin
					delete from [dbo].[CT_BANGDIEM]
					where MaCT_BangDiem = @MaCT_BangDiem
				end
			else
				begin
					delete from [dbo].[CT_BANGDIEM]
				end
		end
GO
/******  StoredProcedure [dbo].[LayCT_BangDiem]   ******/
create procedure [dbo].[LayCT_BangDiem]
	@MaCT_BangDiem nvarchar(12) = null,
	@MaBangDiem nvarchar(12) = null ,
	@MaHocSinh nvarchar(12)  = null
	as
		begin
			if(@MaBangDiem is null and @MaHocSinh is null and @MaCT_BangDiem is null)
				begin
					select * from [dbo].[CT_BANGDIEM]
				end
			else if(@MaBangDiem is not null and @MaHocSinh is not null and @MaCT_BangDiem is null)
				begin
					select * from [dbo].[CT_BANGDIEM]
					where MaBangDiem = @MaBangDiem and MaHocSinh = @MaHocSinh
				end
			else if(@MaBangDiem is not null and @MaCT_BangDiem is null)
				begin
					select * from [dbo].[CT_BANGDIEM]
					where MaBangDiem = @MaBangDiem
				end
			else if(@MaHocSinh is not null and @MaCT_BangDiem is null)
				begin
					select * from [dbo].[CT_BANGDIEM]
					where MaHocSinh = @MaHocSinh
				end
			else if(@MaCT_BangDiem is not null and @MaBangDiem is null and @MaHocSinh is null)
				begin
					select * from [CT_BANGDIEM]
					where MaCT_BangDiem =@MaCT_BangDiem
				end

		end
GO
/***************************************************/

/******  Table [dbo].[LOAIDIEM]  ******/
/******  StoredProcedure [dbo].[ThemLoaiDiem]   ******/
create procedure [dbo].[ThemLoaiDiem]
	@MaLoaiDiem nvarchar(12) ,
	@TenLoaiDiem nvarchar(50) ,
	@HeSo float
	as
		begin
			insert into [dbo].[LOAIDIEM](MaLoaiDiem,TenLoaiDiem,HeSo)
			 values(@MaLoaiDiem,@TenLoaiDiem,@HeSo)
			exec [dbo].[TangBoDem] 'LOAIDIEM'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiLoaiDiem]   ******/
create procedure [dbo].[ThayDoiLoaiDiem]
	@MaLoaiDiem nvarchar(12) ,
	@TenLoaiDiem nvarchar(50) = null,
	@HeSo float = null
	as
		begin
			if(@TenLoaiDiem is not null)
				begin
					update [dbo].[LOAIDIEM]
					set TenLoaiDiem = @TenLoaiDiem
					where MaLoaiDiem = @MaLoaiDiem
				end
			if(@HeSo is not null)
				begin
					update [dbo].[LOAIDIEM]
					set HeSo = @HeSo
					where MaLoaiDiem = @MaLoaiDiem
				end
		end
GO
/******  StoredProcedure [dbo].[XoaLoaiDiem]   ******/
create procedure [dbo].[XoaLoaiDiem]
	@MaLoaiDiem nvarchar(12) = null
	as
		begin
			if(@MaLoaiDiem is not null)
				begin
					delete from [dbo].[LOAIDIEM]
					where MaLoaiDiem = @MaLoaiDiem
				end
			else
				begin
					delete from [dbo].[LOAIDIEM]
				end
		end
GO
/******  StoredProcedure [dbo].[LayLoaiDiem]   ******/
create procedure [dbo].[LayLoaiDiem]
	@MaLoaiDiem nvarchar(12) = null
	as
		begin
			if(@MaLoaiDiem is not null)
				begin
					select * from [dbo].[LOAIDIEM]
					where MaLoaiDiem = @MaLoaiDiem
				end
			else 
				begin 
					select * from [dbo].[LOAIDIEM]
				end
		end
GO
/***************************************************/

/******  Table [dbo].[CT_DIEM]  ******/
/******  StoredProcedure [dbo].[ThemCT_Diem]   ******/
create procedure [dbo].[ThemCT_Diem]
	@MaCT_Diem nvarchar(12) ,
	@GiaTri float ,
	@MaLoaiDiem nvarchar(12),
	@MaCT_BangDiem nvarchar(12) 
	as
		begin
			insert into [dbo].[CT_DIEM](MaCT_Diem,GiaTri,MaLoaiDiem,MaCT_BangDiem)
			values(@MaCT_Diem,@GiaTri,@MaLoaiDiem,@MaCT_BangDiem)
			exec [dbo].[TangBoDem] 'CT_DIEM'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiCT_Diem]   ******/
create procedure [dbo].[ThayDoiCT_Diem]
	@MaCT_Diem nvarchar(12) ,
	@GiaTri float = null ,
	@MaLoaiDiem nvarchar(12) = null,
	@MaCT_BangDiem nvarchar(12)  = null
	as
		begin
			if(@GiaTri is not null)
				begin
					update [dbo].[CT_DIEM]
					set GiaTri = @GiaTri
					where MaCT_Diem = @MaCT_Diem
				end
			if(@MaLoaiDiem is not null)
				begin
					update [dbo].[CT_DIEM]
					set MaLoaiDiem = @MaLoaiDiem
					where MaCT_Diem = @MaCT_Diem
				end
			if(@MaCT_BangDiem is not null)
				begin
					update [dbo].[CT_DIEM]
					set MaCT_BangDiem = @MaCT_BangDiem
					where MaCT_Diem = @MaCT_Diem
				end
		end
GO
/******  StoredProcedure [dbo].[XoaCT_Diem]   ******/
create procedure [dbo].[XoaCT_Diem]
	@MaCT_Diem nvarchar(12) = null
	as
		begin
			if(@MaCT_Diem is not null)
				begin
					delete from  [dbo].[CT_DIEM]
					where MaCT_Diem = @MaCT_Diem
				end
			else
				begin
					delete from  [dbo].[CT_DIEM]
				end
		end
GO
/******  StoredProcedure [dbo].[LayCT_Diem]   ******/
create procedure [dbo].[LayCT_Diem]
	@MaCT_Diem nvarchar(12) = null,
	@MaCT_BangDiem nvarchar(12) = null
	as
		begin
			if(@MaCT_BangDiem is not null and @MaCT_Diem is null)
				begin 
					select * from [dbo].[CT_DIEM]
					where MaCT_BangDiem = @MaCT_BangDiem
				end
			else if(@MaCT_BangDiem is null and @MaCT_Diem is null)
				begin 
					select * from [dbo].[CT_DIEM]
				end
			else if(@MaCT_BangDiem is null and @MaCT_Diem is not null)
				begin
					select * from [dbo].[CT_DIEM]
					where MaCT_Diem = @MaCT_Diem
				end
		end
GO
/***************************************************/

/******  Table [dbo].[LOAINGUOIDUNG]  ******/
/******  StoredProcedure [dbo].[ThemLoaiNguoiDung]   ******/
create procedure [dbo].[ThemLoaiNguoiDung]
	@MaLoaiNguoiDung nvarchar(12) ,
	@TenLoaiNguoiDung nvarchar(50) 
	as
		begin
			insert into [dbo].[LOAINGUOIDUNG](MaLoaiNguoiDung,TenLoaiNguoiDung)
			 values(@MaLoaiNguoiDung,@TenLoaiNGuoiDung)
			exec [dbo].[TangBoDem] 'LOAINGUOIDUNG'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiLoaiNguoiDung]   ******/
create procedure [dbo].[ThayDoiLoaiNguoiDung]
	@MaLoaiNguoiDung nvarchar(12) ,
	@TenLoaiNguoiDung nvarchar(50) 
	as
		begin
			update [dbo].[LOAINGUOIDUNG]
		set TenLoaiNguoiDung = @TenLoaiNguoiDung
		where MaLoaiNguoiDung = @MaLoaiNguoiDung
		end
GO
/******  StoredProcedure [dbo].[XoaLoaiNguoiDung]   ******/
create procedure [dbo].[XoaLoaiNguoiDung]
	@MaLoaiNguoiDung nvarchar(12) = null
	as
		begin
			if(@MaLoaiNguoiDung is not null)
				begin
					delete from [dbo].[LOAINGUOIDUNG]
					where MaLoaiNguoiDung = @MaLoaiNguoiDung
				end
			else
				begin
					delete from [dbo].[LOAINGUOIDUNG]
				end
		end
GO
/******  StoredProcedure [dbo].[LayLoaiNguoiDung]   ******/
create procedure [dbo].[LayLoaiNguoiDung]
	@MaLoaiNguoiDung nvarchar(12) = null
	as
		begin
			if(@MaLoaiNguoiDung is not null)
				begin
					select * from [dbo].[LOAINGUOIDUNG]
					where MaLoaiNguoiDung = @MaLoaiNguoiDung
				end
			else 
				begin
					select * from [dbo].[LOAINGUOIDUNG]
				end
		end
GO
/***************************************************/

/******  Table [dbo].[NGUOIDUNG]  ******/
/******  StoredProcedure [dbo].[ThemNguoiDung]   ******/
create procedure [dbo].[ThemNguoiDung]
	@TenDangNhap nvarchar(50),
	@MaLoaiNguoiDung nvarchar(12) ,
	@MatKhau nvarchar(50) 
	as
		begin
			insert into [dbo].[NGUOIDUNG](TenDangNhap,MaLoaiNguoiDung,MatKhau)
			 values(@TenDangNhap,@MaLoaiNguoiDung,@MatKhau)
		end
GO
/******  StoredProcedure [dbo].[ThayDoiNguoiDung]   ******/
create procedure [dbo].[ThayDoiNguoiDung]
	@TenDangNhap nvarchar(50),
	@MaLoaiNguoiDung nvarchar(12) = null ,
	@MatKhau nvarchar(50) = null 
	as
		begin
			if(@MaLoaiNguoiDung is not null)
				begin
					update [dbo].[NGUOIDUNG]
					set MaLoaiNguoiDung = @MaLoaiNguoiDung
					where TenDangNhap = @TenDangNhap
				end	
			if(@MatKhau is not null)
				begin
					update [dbo].[NGUOIDUNG]
					set MatKhau = @MatKhau
					where TenDangNhap = @TenDangNhap
				end	
		end
GO
/******  StoredProcedure [dbo].[XoaNguoiDung]   ******/
create procedure [dbo].[XoaNguoiDung]
	@TenDangNhap nvarchar(12) = null
	as
		begin
			if(@TenDangNhap is not null)
				begin
					delete from [dbo].[NGUOIDUNG]
					where TenDangNhap = @TenDangNhap and TenDangNhap <> 'admin'
				end
			else
				begin
					delete from [dbo].[NGUOIDUNG]
					where TenDangNhap <> 'admin'
				end
		end
GO
/******  StoredProcedure [dbo].[LayNguoiDung]   ******/
create procedure [dbo].[LayNguoiDung]
	@TenDangNhap nvarchar(12) = null,
	@MaLoaiNguoiDung nvarchar(12) = null
	as
		begin
			if(@MaLoaiNguoiDung is not null and @TenDangNhap is null)
				begin
					select * from [dbo].[NGUOIDUNG]
					where MaLoaiNguoiDung = @MaLoaiNguoiDung
				end
			else if(@TenDangNhap is null)
				begin
					select * from [dbo].[NGUOIDUNG]
				end
			else if(@TenDangNhap is not null)
				begin
					select * from [dbo].[NGUOIDUNG]
					where TenDangNhap = @TenDangNhap
				end
				
		end
GO
/***************************************************/

/******  Table [dbo].[THAMSO]  ******/
/******  StoredProcedure [dbo].[ThemThamSo]   ******/
create procedure [dbo].[ThemThamSo]
	@TenThamSo nvarchar(50) ,
	@GiaTri float 
	as
		begin
			insert into [dbo].[THAMSO](TenThamSo,GiaTri)
			 values(@TenThamSo,@GiaTri)
		end
GO
/******  StoredProcedure [dbo].[ThayDoiThamSo]   ******/
create procedure [dbo].[ThayDoiThamSo]
	@TenThamSo nvarchar(50),
	@GiaTri float = null
	as
		begin
			if(@GiaTri is not null)
				begin
					update [dbo].[THAMSO]
					set GiaTri = @GiaTri
					where TenThamSo = @TenThamSo
				end
		end
GO
/******  StoredProcedure [dbo].[XoaThamSo]   ******/
create procedure [dbo].[XoaThamSo]
	@TenThamSo nvarchar(50) = null
	as
		begin
			if(@TenThamSo is not null)
				begin
					delete from [dbo].[THAMSO]
					where TenThamSo = @TenThamSo
				end
			else
				begin
					delete from [dbo].[THAMSO]
				end
		end
GO
/******  StoredProcedure [dbo].[LayThamSo]   ******/
create procedure [dbo].[LayThamSo]
	@TenThamSo nvarchar(50) = null
	as
		begin
			if(@TenThamSo is not null)
				begin
					select * from [dbo].[THAMSO]
					where TenThamSo = @TenThamSo
				end	
			else
				begin
					select * from [dbo].[THAMSO]
				end
		end
GO
/***************************************************/

/******  Table [dbo].[BODEM]  ******/
/******  StoredProcedure [dbo].[ThemBoDem]   ******/
create procedure [dbo].[ThemBoDem]
	@TenBangDem nvarchar(50) ,
	@TongCong int 
	as
		begin
			insert into [dbo].[BODEM](TenBangDem,TongCong)
			 values(@TenBangDem,@TongCong)
		end
GO
/******  StoredProcedure [dbo].[ThayDoiBoDem]   ******/
create procedure [dbo].[ThayDoiBoDem]
	@TenBangDem nvarchar(50),
	@TongCong int = null
	as
		begin
			if(@TongCong is not null)
				begin
					update [dbo].[BODEM]
					set TongCong = @TongCong
					where TenBangDem = @TenBangDem
				end
		end
GO
/******  StoredProcedure [dbo].[TangBoDem]   ******/
create procedure [dbo].[TangBoDem]
	@TenBangDem nvarchar(50) 
	as
		begin
			declare @TongSoHienTai int
			set @TongSoHienTai = (select MAX(TongCong) from [dbo].[BoDem] where TenBangDem = @TenBangDem)
			update [dbo].[BODEM]
			set TongCong = (@TongSoHienTai+1)
			where TenBangDem = @TenBangDem
		end
GO
/******  StoredProcedure [dbo].[XoaBoDem]   ******/
create procedure [dbo].[XoaBoDem]
	@TenBangDem nvarchar(50) = null
	as
		begin
			if(@TenBangDem is not null)
				begin
					delete from [dbo].[BODEM]
					where TenBangDem = @TenBangDem
				end
			else
				begin
					delete from [dbo].[BODEM]
				end
		end
GO
/******  StoredProcedure [dbo].[LayBoDem]   ******/
create procedure [dbo].[LayBoDem]
	@TenBangDem nvarchar(50) = null
	as
	begin
		if(@TenBangDem is not null)
			begin
				select * from [dbo].[BODEM]
				where TenBangDem = @TenBangDem
			end
		else
			begin
				select * from [dbo].[BODEM]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[LOAIHANHKIEM]  ******/
/******  StoredProcedure [dbo].[ThemLoaiHanhKiem]   ******/
create procedure [dbo].[ThemLoaiHanhKiem]
	@MaLoaiHanhKiem nvarchar(12),
	@TenLoaiHanhKiem nvarchar(50)
	as
		begin
			insert into [dbo].[LOAIHANHKIEM](MaLoaiHanhKiem,TenLoaiHanhKiem)
			 values(@MaLoaiHanhKiem,@TenLoaiHanhKiem)
			 exec [dbo].[TangBoDem] 'LOAIHANHKIEM'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiLoaiHanhKiem]   ******/
create procedure [dbo].[ThayDoiLoaiHanhKiem]
	@MaLoaiHanhKiem nvarchar(12),
	@TenLoaiHanhKiem nvarchar(50) = null
	as
		begin
			if(@TenLoaiHanhKiem is not null)
				begin
					update [dbo].[LOAIHANHKIEM]
					set TenLoaiHanhKiem = @TenLoaiHanhKiem
					where MaLoaiHanhKiem = @MaLoaiHanhKiem
				end
		end
GO
/******  StoredProcedure [dbo].[XoaLoaiHanhKiem]   ******/
create procedure [dbo].[XoaLoaiHanhKiem]
	@MaLoaiHanhKiem nvarchar(12) = null
	as
		begin
			if(@MaLoaiHanhKiem is not null)
				begin
					delete from [dbo].[LOAIHANHKIEM]
					where MaLoaiHanhKiem = @MaLoaiHanhKiem
				end
			else
				begin
					delete from [dbo].[LOAIHANHKIEM]
				end
		end
GO
/******  StoredProcedure [dbo].[LayLoaiHanhKiem]   ******/
create procedure [dbo].[LayLoaiHanhKiem]
	@MaLoaiHanhKiem nvarchar(12) = null
	as
	begin
		if(@MaLoaiHanhKiem is not null)
			begin
				select * from [dbo].[LOAIHANHKIEM]
				where MaLoaiHanhKiem = @MaLoaiHanhKiem
			end
		else
			begin
				select * from [dbo].[LOAIHANHKIEM]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[XEPLOAIHANHKIEM]  ******/
/******  StoredProcedure [dbo].[ThemXepLoaiHanhKiem]   ******/
create procedure [dbo].[ThemXepLoaiHanhKiem]
	@MaXepLoaiHanhKiem nvarchar(12),
	@MaHocSinh nvarchar(12) ,
	@MaHocKyNamHoc nvarchar(12) ,
	@MaLoaiHanhKiem nvarchar(12) 
	as
		begin
			insert into [dbo].[XEPLOAIHANHKIEM](MaXepLoaiHanhKiem,MaHocSinh,MaHocKyNamHoc,MaLoaiHanhKiem)
			 values(@MaXepLoaiHanhKiem,@MaHocSinh,@MaHocKyNamHoc,@MaLoaiHanhKiem)
			 exec [dbo].[TangBoDem] 'XEPLOAIHANHKIEM'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiXepLoaiHanhKiem]   ******/
create procedure [dbo].[ThayDoiXepLoaiHanhKiem]
	@MaXepLoaiHanhKiem nvarchar(12),
	@MaHocSinh nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null,
	@MaLoaiHanhKiem nvarchar(12) = null
	as
		begin
			if(@MaHocSinh is not null)
				begin
					update [dbo].[XEPLOAIHANHKIEM]
					set MaHocSinh = @MaHocSinh
					where MaXepLoaiHanhKiem = @MaXepLoaiHanhKiem
				end
			if(@MaHocKyNamHoc is not null)
				begin
					update [dbo].[XEPLOAIHANHKIEM]
					set MaHocKyNamHoc = @MaHocKyNamHoc
					where MaXepLoaiHanhKiem = @MaXepLoaiHanhKiem
				end
			if(@MaLoaiHanhKiem is not null)
				begin
					update [dbo].[XEPLOAIHANHKIEM]
					set MaLoaiHanhKiem = @MaLoaiHanhKiem
					where MaXepLoaiHanhKiem = @MaXepLoaiHanhKiem
				end
		end
GO
/******  StoredProcedure [dbo].[XoaXepLoaiHanhKiem]   ******/
create procedure [dbo].[XoaXepLoaiHanhKiem]
	@MaXepLoaiHanhKiem nvarchar(12) = null
	as
		begin
			if(@MaXepLoaiHanhKiem is not null)
				begin
					delete from [dbo].[XEPLOAIHANHKIEM]
					where MaXepLoaiHanhKiem = @MaXepLoaiHanhKiem
				end
			else
				begin
					delete from [dbo].[XEPLOAIHANHKIEM]
				end
		end
GO
/******  StoredProcedure [dbo].[LayXepLoaiHanhKiem]   ******/
create procedure [dbo].[LayXepLoaiHanhKiem]
	@MaXepLoaiHanhKiem nvarchar(12) = null,
	@MaHocSinh nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null
	as
	begin
		if(@MaXepLoaiHanhKiem is not null and @MaHocSinh is null and @MaHocKyNamHoc is null)
			begin
				select * from [dbo].[XEPLOAIHANHKIEM]
				where MaXepLoaiHanhKiem = @MaXepLoaiHanhKiem
			end
		else if(@MaXepLoaiHanhKiem is null and @MaHocSinh is not null and @MaHocKyNamHoc is not null)
			begin 
				select * from [dbo].[XEPLOAIHANHKIEM]
				where MaHocSinh = @MaHocSinh and MaHocKyNamHoc = @MaHocKyNamHoc
			end
		else if(@MaXepLoaiHanhKiem is null and @MaHocSinh is not null and @MaHocKyNamHoc is null)
			begin 
				select * from [dbo].[XEPLOAIHANHKIEM]
				where MaHocSinh = @MaHocSinh
			end
		else if(@MaXepLoaiHanhKiem is null and @MaHocSinh is null and @MaHocKyNamHoc is not null)
			begin
				select * from [dbo].[XEPLOAIHANHKIEM]
				where MaHocKyNamHoc = @MaHocKyNamHoc
				end
		else if(@MaXepLoaiHanhKiem is null and @MaHocSinh is null and @MaHocKyNamHoc is null)
			begin
				select * from [dbo].[XEPLOAIHANHKIEM]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[TTHOCPHI]  ******/
/******  StoredProcedure [dbo].[ThemTTHocPhi]   ******/
create procedure [dbo].[ThemTTHocPhi]
	@MaTTHocPhi nvarchar(12),
	@MaHocKyNamHoc nvarchar(12),
	@MaHocSinh nvarchar(12),
	@TongHocPhi money ,
	@HocPhiDaDong money ,
	@HocPhiConLai money ,
	@SoDu money
	as
		begin
			insert into [dbo].[TTHOCPHI](MaTTHocPhi,MaHocKyNamHoc,MaHocSinh,TongHocPhi,HocPhiDaDong,HocPhiConLai,SoDu)
			 values(@MaTTHocPhi,@MaHocKyNamHoc,@MaHocSinh,@TongHocPhi,@HocPhiDaDong,@HocPhiConLai,@SoDu)
			 exec [dbo].[TangBoDem] 'TTHOCPHI'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiTTHocPhi]   ******/
create procedure [dbo].[ThayDoiTTHocPhi]
	@MaTTHocPhi nvarchar(12),
	@MaHocKyNamHoc nvarchar(12) = null,
	@MaHocSinh nvarchar(12) = null,
	@TongHocPhi money = null,
	@HocPhiDaDong money = null,
	@HocPhiConLai money = null,
	@SoDu money = null
	as
		begin
			if(@MaHocKyNamHoc is not null)
				begin
					update [dbo].[TTHOCPHI]
					set MaHocKyNamHoc = @MaHocKyNamHoc
					where MaTTHocPhi = @MaTTHocPhi
				end
			if(@HocPhiConLai is not null)
				begin
					update [dbo].[TTHOCPHI]
					set HocPhiConLai = @HocPhiConLai
					where MaTTHocPhi = @MaTTHocPhi
				end
			if(@MaHocSinh is not null)
				begin
					update [dbo].[TTHOCPHI]
					set MaHocSinh = @MaHocSinh
					where MaTTHocPhi = @MaTTHocPhi
				end
			if(@TongHocPhi is not null)
				begin
					update [dbo].[TTHOCPHI]
					set TongHocPhi = @TongHocPhi
					where MaTTHocPhi = @MaTTHocPhi
				end
			if(@HocPhiDaDong is not null)
				begin
					update [dbo].[TTHOCPHI]
					set HocPhiDaDong = @HocPhiDaDong
					where MaTTHocPhi = @MaTTHocPhi
				end
			if(@SoDu is not null)
				begin
					update [dbo].[TTHOCPHI]
					set SoDu = @SoDu
					where MaTTHocPhi = @MaTTHocPhi
				end
		end
GO
/******  StoredProcedure [dbo].[XoaTTHocPhi]   ******/
create procedure [dbo].[XoaTTHocPhi]
	@MaTTHocPhi nvarchar(12) = null
	as
		begin
			if(@MaTTHocPhi is not null)
				begin
					delete from [dbo].[TTHOCPHI]
					where MaTTHocPhi = @MaTTHocPhi
				end
			else
				begin
					delete from [dbo].[TTHOCPHI]
				end
		end
GO
/******  StoredProcedure [dbo].[LayTTHocPhi]   ******/
create procedure [dbo].[LayTTHocPhi]
	@MaTTHocPhi nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null,
	@MaHocSinh nvarchar(12) = null
	as
	begin
		if(@MaTTHocPhi is not null and @MaHocKyNamHoc is null and @MaHocSinh is null)
			begin
				select * from [dbo].[TTHOCPHI]
				where MaTTHocPhi = @MaTTHocPhi
			end
		else if(@MaTTHocPhi is null and @MaHocKyNamHoc is not null and @MaHocSinh is null)
			begin
				select * from [dbo].[TTHOCPHI]
				where MaHocKyNamHoc = @MaHocKyNamHoc
			end
		else if(@MaTTHocPhi is null and @MaHocKyNamHoc is null and @MaHocSinh is not null)
			begin
				select * from [dbo].[TTHOCPHI]
				where MaHocSinh = @MaHocSinh
			end
		else if(@MaTTHocPhi is null and @MaHocKyNamHoc is not null and @MaHocSinh is not null)
			begin
				select * from [dbo].[TTHOCPHI]
				where MaHocSinh = @MaHocSinh and MaHocKyNamHoc = @MaHocKyNamHoc
			end
		else if(@MaTTHocPhi is null and @MaHocKyNamHoc is null and @MaHocSinh is null)
			begin
				select * from [dbo].[TTHOCPHI]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[TC_DONGHOCPHI]  ******/
/******  StoredProcedure [dbo].[ThemCT_DongHocPhi]   ******/
create procedure [dbo].[ThemCT_DongHocPhi]
	@MaCT_DongHocPhi nvarchar(12),
	@MaTTHocPhi nvarchar(12) ,
	@NgayDong smalldatetime ,
	@SoTienDong money,
	@NoiDong nvarchar(100) ,
	@NguoiDong nvarchar(100)
	as
		begin
			insert into [dbo].[CT_DONGHOCPHI](MaCT_DongHocPhi,MaTTHocPhi,NgayDong,SoTienDong,NoiDong,NguoiDong)
			 values(@MaCT_DongHocPhi,@MaTTHocPhi,@NgayDong,@SoTienDong,@NoiDong,@NguoiDong)
			 exec [dbo].[TangBoDem] 'CT_DONGHOCPHI'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiCT_DongHocPhi]   ******/
create procedure [dbo].[ThayDoiCT_DongHocPhi]
	@MaCT_DongHocPhi nvarchar(12),
	@MaTTHocPhi nvarchar(12) = null,
	@NgayDong smalldatetime = null,
	@SoTienDong money = null,
	@NoiDong nvarchar(100) = null
	as
		begin
			if(@MaTTHocPhi is not null)
				begin
					update [dbo].[CT_DONGHOCPHI]
					set MaTTHocPhi = @MaTTHocPhi
					where MaCT_DongHocPhi = @MaCT_DongHocPhi
				end
			if(@NoiDong is not null)
				begin
					update [dbo].[CT_DONGHOCPHI]
					set NoiDong = @NoiDong
					where MaCT_DongHocPhi = @MaCT_DongHocPhi
				end
			if(@NgayDong is not null)
				begin
					update [dbo].[CT_DONGHOCPHI]
					set NgayDong = @NgayDong
					where MaCT_DongHocPhi = @MaCT_DongHocPhi
				end
			if(@SoTienDong is not null)
				begin
					update [dbo].[CT_DONGHOCPHI]
					set SoTienDong = @SoTienDong
					where MaCT_DongHocPhi = @MaCT_DongHocPhi
				end
		end
GO
/******  StoredProcedure [dbo].[XoaCT_DongHocPhi]   ******/
create procedure [dbo].[XoaCT_DongHocPhi]
	@MaCT_DongHocPhi nvarchar(12) = null
	as
		begin
			if(@MaCT_DongHocPhi is not null)
				begin
					delete from [dbo].[CT_DONGHOCPHI]
					where MaCT_DongHocPhi = @MaCT_DongHocPhi
				end
			else
				begin
					delete from [dbo].[CT_DONGHOCPHI]
				end
		end
GO
/******  StoredProcedure [dbo].[LayCT_DongHocPhi]   ******/
create procedure [dbo].[LayCT_DongHocPhi]
	@MaCT_DongHocPhi nvarchar(12) = null,
	@MaTTHocPhi nvarchar(12) = null 
	as
	begin
		if(@MaCT_DongHocPhi is not null and @MaTTHocPhi is null)
			begin
				select * from [dbo].[CT_DONGHOCPHI]
				where MaCT_DongHocPhi = @MaCT_DongHocPhi
			end
		else if(@MaCT_DongHocPhi is null and @MaTTHocPhi is not null)
			begin
				select * from [dbo].[CT_DONGHOCPHI]
				where MaTTHocPhi = @MaTTHocPhi
			end
		else if(@MaCT_DongHocPhi is null and @MaTTHocPhi is null)
			begin
				select * from [dbo].[CT_DONGHOCPHI]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[TTBAOHIEMYTE]  ******/
/******  StoredProcedure [dbo].[ThemTTBaoHiemYTe]   ******/
create procedure [dbo].[ThemTTBaoHiemYTe]
	@MaTTBaoHiemYTe nvarchar(12) ,
	@MaHocKyNamHoc nvarchar(12) ,
	@MaHocSinh nvarchar(12) ,
	@TrangThai bit ,
	@PhiBaoHiem money,
	@SoDu money
	as
		begin
			insert into [dbo].[TTBAOHIEMYTE](MaTTBaoHiemYTe,MaHocKyNamHoc,MaHocSinh,TrangThai,PhiBaoHiem,SoDu)
			 values(@MaTTBaoHiemYTe,@MaHocKyNamHoc,@MaHocSinh,@TrangThai,@PhiBaoHiem,@SoDu)
			 exec [dbo].[TangBoDem] 'TTBAOHIEMYTE'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiTTBaoHiemYTe]   ******/
create procedure [dbo].[ThayDoiTTBaoHiemYTe]
	@MaTTBaoHiemYTe nvarchar(12) ,
	@MaHocKyNamHoc nvarchar(12) = null,
	@MaHocSinh nvarchar(12) = null,
	@TrangThai bit = null,
	@PhiBaoHiem money = null,
	@SoDu money = null
	as
		begin
			if(@MaHocKyNamHoc is not null)
				begin
					update [dbo].[TTBAOHIEMYTE]
					set MaHocKyNamHoc = @MaHocKyNamHoc
					where MaTTBaoHiemYTe = @MaTTBaoHiemYTe
				end
			if(@MaHocSinh is not null)
				begin
					update [dbo].[TTBAOHIEMYTE]
					set MaHocSinh = @MaHocSinh
					where MaTTBaoHiemYTe = @MaTTBaoHiemYTe
				end
			if(@TrangThai is not null)
				begin
					update [dbo].[TTBAOHIEMYTE]
					set TrangThai = @TrangThai
					where MaTTBaoHiemYTe = @MaTTBaoHiemYTe
				end
			if(@PhiBaoHiem is not null)
				begin
					update [dbo].[TTBAOHIEMYTE]
					set PhiBaoHiem = @PhiBaoHiem
					where MaTTBaoHiemYTe = @MaTTBaoHiemYTe
				end
			if(@SoDu is not null)
				begin
					update [dbo].[TTBAOHIEMYTE]
					set SoDu = @SoDu
					where MaTTBaoHiemYTe = @MaTTBaoHiemYTe
				end
		end
GO
/******  StoredProcedure [dbo].[XoaTTBaoHiemYTe]   ******/
create procedure [dbo].[XoaTTBaoHiemYTe]
	@MaTTBaoHiemYTe nvarchar(12) = null
	as
		begin
			if(@MaTTBaoHiemYTe is not null)
				begin
					delete from [dbo].[TTBAOHIEMYTE]
					where MaTTBaoHiemYTe = @MaTTBaoHiemYTe
				end
			else
				begin
					delete from [dbo].[TTBAOHIEMYTE]
				end
		end
GO
/******  StoredProcedure [dbo].[LayTTBaoHiemYTe]   ******/
create procedure [dbo].[LayTTBaoHiemYTe]
	@MaTTBaoHiemYTe nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null,
	@MaHocSinh nvarchar(12) = null
	as
	begin
		if(@MaTTBaoHiemYTe is not null and @MaHocKyNamHoc is null and @MaHocSinh is null)
			begin
				select * from [dbo].[TTBAOHIEMYTE]
				where MaTTBaoHiemYTe = @MaTTBaoHiemYTe
			end
		else if(@MaTTBaoHiemYTe is null and @MaHocKyNamHoc is not null and @MaHocSinh is null)
			begin
				select * from [dbo].[TTBAOHIEMYTE]
				where MaHocKyNamHoc = @MaHocKyNamHoc
			end
		else if(@MaTTBaoHiemYTe is null and @MaHocKyNamHoc is null and @MaHocSinh is not null)
			begin
				select * from [dbo].[TTBAOHIEMYTE]
				where MaHocSinh = @MaHocSinh
			end
		else if(@MaTTBaoHiemYTe is null and @MaHocKyNamHoc is not null and @MaHocSinh is not null)
			begin
				select * from [dbo].[TTBAOHIEMYTE]
				where MaHocKyNamHoc = @MaHocKyNamHoc and MaHocSinh = @MaHocSinh
			end
		else if(@MaTTBaoHiemYTe is null and @MaHocKyNamHoc is null and @MaHocSinh is null)
			begin
				select * from [dbo].[TTBAOHIEMYTE]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[CT_DONGBAOHIEM]  ******/
/******  StoredProcedure [dbo].[ThemCT_DongBaoHiem]   ******/
create procedure [dbo].[ThemCT_DongBaoHiem]
	@MaCT_DongBaoHiem nvarchar(12),
	@MaTTBaoHiemYTe nvarchar(12) ,
	@NgayDong smalldatetime ,
	@SoTienDong money ,
	@NoiDong nvarchar(100) ,
	@NguoiDong nvarchar(100)
	as
		begin
			insert into [dbo].[CT_DONGBAOHIEM](MaCT_DongBaoHiem,MaTTBaoHiemYTe,NgayDong,SoTienDong,NoiDong,NguoiDong)
			 values(@MaCT_DongBaoHiem,@MaTTBaoHiemYTe,@NgayDong,@SoTienDong,@NoiDong,@NguoiDong)
			 exec [dbo].[TangBoDem] 'CT_DONGBAOHIEM'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiCT_DongBaoHiem]   ******/
create procedure [dbo].[ThayDoiCT_DongBaoHiem]
	@MaCT_DongBaoHiem nvarchar(12),
	@MaTTBaoHiemYTe nvarchar(12) = null ,
	@NgayDong smalldatetime = null,
	@SoTienDong money = null,
	@NoiDong nvarchar(100) = null,
	@NguoiDong nvarchar(100) = null
	as
		begin
			if(@MaTTBaoHiemYTe is not null)
				begin
					update [dbo].[CT_DONGBAOHIEM]
					set MaTTBaoHiemYTe = @MaTTBaoHiemYTe
					where MaCT_DongBaoHiem = @MaCT_DongBaoHiem
				end
			if(@NgayDong is not null)
				begin
					update [dbo].[CT_DONGBAOHIEM]
					set NgayDong = @NgayDong
					where MaCT_DongBaoHiem = @MaCT_DongBaoHiem
				end
			if(@SoTienDong is not null)
				begin
					update [dbo].[CT_DONGBAOHIEM]
					set SoTienDong = @SoTienDong
					where MaCT_DongBaoHiem = @MaCT_DongBaoHiem
				end
			if(@NoiDong is not null)
				begin
					update [dbo].[CT_DONGBAOHIEM]
					set NoiDong = @NoiDong
					where MaCT_DongBaoHiem = @MaCT_DongBaoHiem
				end
			if(@NguoiDong is not null)
				begin
					update [dbo].[CT_DONGBAOHIEM]
					set NguoiDong = @NguoiDong
					where MaCT_DongBaoHiem = @MaCT_DongBaoHiem
				end
		end
GO
/******  StoredProcedure [dbo].[XoaCT_DongBaoHiem]   ******/
create procedure [dbo].[XoaCT_DongBaoHiem]
	@MaCT_DongBaoHiem nvarchar(12) = null
	as
		begin
			if(@MaCT_DongBaoHiem is not null)
				begin
					delete from [dbo].[CT_DONGBAOHIEM]
					where MaCT_DongBaoHiem = @MaCT_DongBaoHiem
				end
			else
				begin
					delete from [dbo].[CT_DONGBAOHIEM]
				end
		end
GO
/******  StoredProcedure [dbo].[LayCT_DongBaoHiem]   ******/
create procedure [dbo].[LayCT_DongBaoHiem]
	@MaCT_DongBaoHiem nvarchar(12) = null,
	@MaTTBaoHiemYTe nvarchar(12) = null 
	as
	begin
		if(@MaCT_DongBaoHiem is not null and @MaTTBaoHiemYTe is null)
			begin
				select * from [dbo].[CT_DONGBAOHIEM]
				where MaCT_DongBaoHiem = @MaCT_DongBaoHiem
			end
		else if(@MaCT_DongBaoHiem is null and @MaTTBaoHiemYTe is not null)
			begin
				select * from [dbo].[CT_DONGBAOHIEM]
				where MaTTBaoHiemYTe = @MaTTBaoHiemYTe
			end
		else if(@MaCT_DongBaoHiem is null and @MaTTBaoHiemYTe is null)
			begin
				select * from [dbo].[CT_DONGBAOHIEM]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[CHUYENMON]  ******/
/******  StoredProcedure [dbo].[ThemChuyenMon]   ******/
create procedure [dbo].[ThemChuyenMon]
	@MaChuyenMon nvarchar(12),
	@TenChuyenMon nvarchar(100)
	as
		begin
			insert into [dbo].[CHUYENMON](MaChuyenMon,TenChuyenMon)
			 values(@MaChuyenMon,@TenChuyenMon)
			 exec [dbo].[TangBoDem] 'CHUYENMON'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiChuyenMon]   ******/
create procedure [dbo].[ThayDoiChuyenMon]
	@MaChuyenMon nvarchar(12),
	@TenChuyenMon nvarchar(100) = null
	as
		begin
			if(@TenChuyenMon is not null)
				begin
					update [dbo].[CHUYENMON]
					set TenChuyenMon = @TenChuyenMon
					where MaChuyenMon = @MaChuyenMon
				end
		end
GO
/******  StoredProcedure [dbo].[XoaChuyenMon]   ******/
create procedure [dbo].[XoaChuyenMon]
	@MaChuyenMon nvarchar(12) = null
	as
		begin
			if(@MaChuyenMon  is not null)
				begin
					delete from [dbo].[CHUYENMON]
					where MaChuyenMon = @MaChuyenMon
				end
			else
				begin
					delete from [dbo].[CHUYENMON]
				end
		end
GO
/******  StoredProcedure [dbo].[LayChuyenMon]   ******/
create procedure [dbo].[LayChuyenMon]
	@MaChuyenMon nvarchar(12) = null
	as
	begin
		if(@MaChuyenMon is not null)
			begin
				select * from [dbo].[CHUYENMON]
				where MaChuyenMon = @MaChuyenMon
			end
		else
			begin
				select * from [dbo].[CHUYENMON]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[LOAITINHTRANGCONGTAC]  ******/
/******  StoredProcedure [dbo].[ThemLoaiTinhTrangCongTac]   ******/
create procedure [dbo].[ThemLoaiTinhTrangCongTac]
	@MaLoaiTinhTrangCongTac nvarchar(12),
	@TenLoaiTinhTrangCongTac nvarchar(100)
	as
		begin
			insert into [dbo].[LOAITINHTRANGCONGTAC](MaLoaiTinhTrangCongTac,TenLoaiTinhTrangCongTac)
			 values(@MaLoaiTinhTrangCongTac,@TenLoaiTinhTrangCongTac)
			 exec [dbo].[TangBoDem] 'LOAITINHTRANGCONGTAC'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiLoaiTinhTrangCongTac]   ******/
create procedure [dbo].[ThayDoiLoaiTinhTrangCongTac]
	@MaLoaiTinhTrangCongTac nvarchar(12),
	@TenLoaiTinhTrangCongTac nvarchar(100) = null
	as
		begin
			if(@TenLoaiTinhTrangCongTac is not null)
				begin
					update [dbo].[LOAITINHTRANGCONGTAC]
					set TenLoaiTinhTrangCongTac = @TenLoaiTinhTrangCongTac
					where MaLoaiTinhTrangCongTac = @MaLoaiTinhTrangCongTac
				end
		end
GO
/******  StoredProcedure [dbo].[XoaLoaiTinhTrangCongTac]   ******/
create procedure [dbo].[XoaLoaiTinhTrangCongTac]
	@MaLoaiTinhTrangCongTac nvarchar(12) = null
	as
		begin
			if(@MaLoaiTinhTrangCongTac is not null)
				begin
					delete from [dbo].[LOAITINHTRANGCONGTAC]
					where MaLoaiTinhTrangCongTac = @MaLoaiTinhTrangCongTac
				end
			else
				begin
					delete from [dbo].[LOAITINHTRANGCONGTAC]
				end
		end
GO
/******  StoredProcedure [dbo].[LayLoaiTinhTrangCongTac]   ******/
create procedure [dbo].[LayLoaiTinhTrangCongTac]
	@MaLoaiTinhTrangCongTac nvarchar(12) = null
	as
	begin
		if(@MaLoaiTinhTrangCongTac is not null)
			begin
				select * from [dbo].[LOAITINHTRANGCONGTAC]
				where MaLoaiTinhTrangCongTac = @MaLoaiTinhTrangCongTac
			end
		else
			begin
				select * from [dbo].[LOAITINHTRANGCONGTAC]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[GIAOVIEN]  ******/
/******  StoredProcedure [dbo].[ThemGiaoVien]   ******/
create procedure [dbo].[ThemGiaoVien]
	@MaGiaoVien nvarchar(12) ,
	@MaChuyenMon nvarchar(12) ,
	@HoTen nvarchar(80) ,
	@NgaySinh	smalldatetime,
	@GioiTinh int ,
	@DiaChi nvarchar(100) ,
	@Email nvarchar(100) ,
	@SoDienThoai nvarchar(50) ,
	@NgayVaoLam smalldatetime ,
	@AnhDaiDien nvarchar(12) ,
	@GhiChu nvarchar(100) ,
	@MaLoaiTinhTrangCongTac nvarchar(12) 
	as
		begin
			insert into [dbo].[GIAOVIEN](MaGiaoVien,MaChuyenMon,HoTen,NgaySinh,GioiTinh,DiaChi,Email,SoDienThoai,NgayVaoLam,AnhDaiDien,GhiChu,MaLoaiTinhTrangCongTac)
			 values(@MaGiaoVien,@MaChuyenMon,@HoTen,@NgaySinh,@GioiTinh,@DiaChi,@Email,@SoDienThoai,@NgayVaoLam,@AnhDaiDien,@GhiChu,@MaLoaiTinhTrangCongTac)
			exec [dbo].[TangBoDem] 'GIAOVIEN'
		end
GO
/******  StoredProcedure [dbo].[ThayDoiGiaoVien]   ******/
create procedure [dbo].[ThayDoiGiaoVien]
	@MaGiaoVien nvarchar(12) ,
	@MaChuyenMon nvarchar(12) = null,
	@HoTen nvarchar(80) = null,
	@NgaySinh	smalldatetime = null,
	@GioiTinh int = null,
	@DiaChi nvarchar(100) = null,
	@Email nvarchar(100) = null,
	@SoDienThoai nvarchar(50) = null,
	@NgayVaoLam smalldatetime  = null,
	@AnhDaiDien nvarchar(12) = null,
	@GhiChu nvarchar(100) = null,
	@MaLoaiTinhTrangCongTac nvarchar(12) = null 
	as
		begin
			if(@MaChuyenMon is not null)
				begin
					update [dbo].[GIAOVIEN]
					set MaChuyenMon = @MaChuyenMon
					where MaGiaoVien = @MaGiaoVien
				end
			if(@HoTen is not null)
				begin
					update [dbo].[GIAOVIEN]
					set HoTen = @HoTen
					where MaGiaoVien = @MaGiaoVien
				end
			if(@NgaySinh is not null)
				begin
					update [dbo].[GIAOVIEN]
					set NgaySinh = @NgaySinh
					where MaGiaoVien = @MaGiaoVien
				end
			if(@GioiTinh is not null)
				begin
					update [dbo].[GIAOVIEN]
					set GioiTinh = @GioiTinh
					where MaGiaoVien = @MaGiaoVien
				end
			if(@DiaChi is not null)
				begin
					update [dbo].[GIAOVIEN]
					set DiaChi = @DiaChi
					where MaGiaoVien = @MaGiaoVien
				end
			if(@Email is not null)
				begin
					update [dbo].[GIAOVIEN]
					set Email = @Email
					where MaGiaoVien = @MaGiaoVien
				end
			if(@SoDienThoai is not null)
				begin
					update [dbo].[GIAOVIEN]
					set SoDienThoai = @SoDienThoai
					where MaGiaoVien = @MaGiaoVien
				end
			if(@NgayVaoLam is not null)
				begin
					update [dbo].[GIAOVIEN]
					set NgayVaoLam = @NgayVaoLam
					where MaGiaoVien = @MaGiaoVien
				end
			if(@AnhDaiDien is not null)
				begin
					update [dbo].[GIAOVIEN]
					set AnhDaiDien = @AnhDaiDien
					where MaGiaoVien = @MaGiaoVien
				end
			if(@GhiChu is not null)
				begin
					update [dbo].[GIAOVIEN]
					set GhiChu = @GhiChu
					where MaGiaoVien = @MaGiaoVien
				end
			if(@MaLoaiTinhTrangCongTac is not null)
				begin
					update [dbo].[GIAOVIEN]
					set MaLoaiTinhTrangCongTac = @MaLoaiTinhTrangCongTac
					where MaGiaoVien = @MaGiaoVien
				end
		end
GO
/******  StoredProcedure [dbo].[XoaGiaoVien]   ******/
create procedure [dbo].[XoaGiaoVien]
	@MaGiaoVien nvarchar(12) = null
	as
		begin
			if(@MaGiaoVien is not null)
				begin
					delete from [dbo].[GIAOVIEN]
					where MaGiaoVien = @MaGiaoVien
				end
			else
				begin
					delete from [dbo].[GIAOVIEN]
				end
		end
GO
/******  StoredProcedure [dbo].[LayGiaoVien]   ******/
create procedure [dbo].[LayGiaoVien]
	@MaGiaoVien nvarchar(12) = null,
	@MaChuyenMon nvarchar(12) = null,
	@MaLoaiTinhTrangCongTac nvarchar(12) = null 
	as
	begin
		if(@MaGiaoVien is not null and @MaChuyenMon is null and @MaLoaiTinhTrangCongTac is null )
			begin
				select * from [dbo].[GIAOVIEN]
				where MaGiaoVien = @MaGiaoVien
			end
		else if(@MaGiaoVien is null and @MaChuyenMon is not null and @MaLoaiTinhTrangCongTac is null )
			begin
				select * from [dbo].[GIAOVIEN]
				where MaChuyenMon = @MaChuyenMon
			end
		else if(@MaGiaoVien is null and @MaChuyenMon is null and @MaLoaiTinhTrangCongTac is not null)
			begin
				select * from [dbo].[GIAOVIEN]
				where MaLoaiTinhTrangCongTac = @MaLoaiTinhTrangCongTac
			end
		else if(@MaGiaoVien is null and @MaChuyenMon is not null and @MaLoaiTinhTrangCongTac is not null)
			begin
				select * from [dbo].[GIAOVIEN]
				where MaLoaiTinhTrangCongTac = @MaLoaiTinhTrangCongTac and MaChuyenMon = @MaChuyenMon
			end
		else if(@MaGiaoVien is null and @MaChuyenMon is null and @MaLoaiTinhTrangCongTac is null)
			begin
				select * from [dbo].[GIAOVIEN]
			end
	end
GO
/***************************************************/

/******  Table [dbo].[DANHSACHGIAOVIEN]  ******/
/******  StoredProcedure [dbo].[ThemDanhSachGiaoVien]   ******/
create procedure [dbo].[ThemDanhSachGiaoVien]
	@MaGiaoVien nvarchar(12) ,
	@MaHocKyNamHoc nvarchar(12) ,
	@MaMonHoc nvarchar(12) 
	as
		begin
			insert into [dbo].[DANHSACHGIAOVIEN](MaGiaoVien,MaHocKyNamHoc,MaMonHoc)
			 values(@MaGiaoVien,@MaHocKyNamHoc,@MaMonHoc)
		end
GO
/******  StoredProcedure [dbo].[ThayDoiDanhSachGiaoVien]   ******/
create procedure [dbo].[ThayDoiDanhSachGiaoVien]
	@MaGiaoVien nvarchar(12) ,
	@MaHocKyNamHoc nvarchar(12) ,
	@MaMonHoc nvarchar(12)  = null 
	as
		begin
			if(@MaMonHoc is not null)
				begin
					update [dbo].[DANHSACHGIAOVIEN]
					set MaMonHoc = @MaMonHoc
					where MaGiaoVien = @MaGiaoVien and MaHocKyNamHoc = @MaHocKyNamHoc
				end
		end
GO
/******  StoredProcedure [dbo].[XoaDanhSachGiaoVien]   ******/
create procedure [dbo].[XoaDanhSachGiaoVien]
	@MaGiaoVien nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null
	as
		begin
			if(@MaGiaoVien is not null and @MaHocKyNamHoc is not null)
				begin
					delete from [dbo].[DANHSACHGIAOVIEN]
					where MaGiaoVien = @MaGiaoVien and MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else
				begin
					delete from [dbo].[DANHSACHGIAOVIEN]
				end
		end
GO
/******  StoredProcedure [dbo].[LayDanhSachGiaoVien]   ******/
create procedure [dbo].[LayDanhSachGiaoVien]
	@MaGiaoVien nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null
	as
	begin
		if(@MaHocKyNamHoc is not null and @MaGiaoVien is null)
			begin
				select * from [dbo].[DANHSACHGIAOVIEN]
				where MaHocKyNamHoc = @MaHocKyNamHoc
			end
		else if(@MaHocKyNamHoc is null and @MaGiaoVien is not null)
			begin
				select * from [dbo].[DANHSACHGIAOVIEN]
				where MaGiaoVien = @MaGiaoVien
			end
		else if(@MaHocKyNamHoc is not null and @MaGiaoVien is not null)
			begin
				select * from [dbo].[DANHSACHGIAOVIEN]
				where MaHocKyNamHoc = @MaHocKyNamHoc and MaGiaoVien = @MaGiaoVien
			end
		else if(@MaHocKyNamHoc is null and @MaGiaoVien is null)
			begin
				select * from [dbo].[DANHSACHGIAOVIEN]
			end
	end
GO

/******  Table [dbo].[DANHSACHCT_LOP]  ******/
/******  StoredProcedure [dbo].[ThemDanhSachCT_Lop]   ******/
create procedure [dbo].[ThemDanhSachCT_Lop]
	@MaLop nvarchar(12) ,
	@MaHocSinh nvarchar(12) ,
	@MaHocKyNamHoc nvarchar(12)

	as
		begin
			insert into [dbo].[DANHSACHCT_LOP] (MaHocSinh,MaLop,MaHocKyNamHoc) 
			values(@MaHocSinh,@MaLop,@MaHocKyNamHoc)
		end
GO

/******  Dont have update method   ******/

/******  StoredProcedure [dbo].[XoaDanhSachCT_Lop]   ******/
create procedure [dbo].[XoaDanhSachCT_Lop]
	@MaLop nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null,
	@MaHocSinh nvarchar(12) = null
	as
		begin
			if(@MaLop is not null and @MaHocKyNamHoc is not null and @MaHocSinh is not null)
				begin
					delete from [dbo].[DANHSACHCT_LOP]
					where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc and MaHocSinh = @MaHocSinh
				end
			else
				begin
					delete from [dbo].[DANHSACHCT_LOP]
				end
		end
GO
/******  StoredProcedure [dbo].[LayDanhSachCT_Lop]   ******/
create procedure [dbo].[LayDanhSachCT_Lop]
	@MaLop nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null,
	@MaHocSinh nvarchar(12) = null
	as
		begin
			if(@MaLop is null and @MaHocSinh is null and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[DANHSACHCT_LOP]
				end
			else if(@MaLop is not null and @MaHocSinh is null and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[DANHSACHCT_LOP]
					where MaLop = @MaLop
				end
			else if(@MaLop is null and @MaHocSinh is not null and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[DANHSACHCT_LOP]
					where MaHocSinh = @MaHocSinh
				end
			else if(@MaLop is null and @MaHocSinh is null and  @MaHocKyNamHoc is not null)
				begin
					select * from [dbo].[DANHSACHCT_LOP]
					where MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else if( @MaLop is not null and @MaHocSinh is null and  @MaHocKyNamHoc is not null)
				begin
					select * from [dbo].[DANHSACHCT_LOP]
					where MaHocKyNamHoc = @MaHocKyNamHoc and MaLop = @MaLop
				end
			else if(@MaLop is  null and @MaHocSinh is not null and  @MaHocKyNamHoc is not null)
				begin
					select * from [dbo].[DANHSACHCT_LOP]
					where MaHocSinh = @MaHocSinh and MaHocKyNamHoc = @MaHocKyNamHoc
				end
			else if(@MaLop is not null and @MaHocSinh is not null  and @MaHocKyNamHoc is null)
				begin
					select * from [dbo].[DANHSACHCT_LOP]
					where MaHocSinh = @MaHocSinh and MaLop = @MaLop
				end
			else if(@MaLop is not null and @MaHocSinh is not null  and @MaHocKyNamHoc is not null)
				begin
					select * from [dbo].[DANHSACHCT_LOP]
					where MaHocSinh = @MaHocSinh and MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc
				end
		end
GO

/******  Table [dbo].[THOIKHOABIEULOP]  ******/
/******  StoredProcedure [dbo].[ThemThoiKhoaBieuLop]   ******/
create procedure [dbo].[ThemThoiKhoaBieuLop]
	@MaLop nvarchar(12),
	@MaHocKyNamHoc nvarchar(12),
	@NgayHoc int,
	@TietHoc int, 
	@MaMonHoc nvarchar(12),
	@MaGiaoVien nvarchar(12)
	as
		begin
			insert into [dbo].[THOIKHOABIEULOP](MaLop,MaHocKyNamHoc,NgayHoc,TietHoc,MaMonHoc,MaGiaoVien)
			 values(@MaLop,@MaHocKyNamHoc,@NgayHoc,@TietHoc,@MaMonHoc,@MaGiaoVien)
		end
GO
/******  StoredProcedure [dbo].[ThayDoiThoiKhoaBieuLop]   ******/
create procedure [dbo].[ThayDoiThoiKhoaBieuLop]
	@MaLop nvarchar(12),
	@MaHocKyNamHoc nvarchar(12),
	@NgayHoc int,
	@TietHoc int, 
	@MaMonHoc nvarchar(12) = null,
	@MaGiaoVien nvarchar(12) = null
	as
		begin
			if(@MaMonHoc is not null)
				begin
					update [dbo].[THOIKHOABIEULOP]
					set MaMonHoc = @MaMonHoc
					where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc and NgayHoc = @NgayHoc and TietHoc = @TietHoc
				end
			if(@MaGiaoVien is not null)
				begin
					update [dbo].[THOIKHOABIEULOP]
					set MaGiaoVien = @MaGiaoVien
					where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc and NgayHoc = @NgayHoc and TietHoc = @TietHoc
				end
		end
GO
/******  StoredProcedure [dbo].[XoaThoiKhoaBieuLop]   ******/
create procedure [dbo].[XoaThoiKhoaBieuLop]
	@MaLop nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null,
	@NgayHoc int = null,
	@TietHoc int = null 
	as
		begin
			if(@MaLop is not null and @MaHocKyNamHoc is not null and @NgayHoc is not null and @TietHoc is not null)
				begin
					delete from [dbo].[THOIKHOABIEULOP]
					where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc and NgayHoc = @NgayHoc and TietHoc = @TietHoc
				end
			else
				begin
					delete from [dbo].[THOIKHOABIEULOP]
				end
		end
GO
/******  StoredProcedure [dbo].[LayThoiKhoaBieuLop]   ******/
create procedure [dbo].[LayThoiKhoaBieuLop]
	@MaLop nvarchar(12) = null,
	@MaHocKyNamHoc nvarchar(12) = null,
	@NgayHoc int = null,
	@TietHoc int = null,
	@MaGiaoVien nvarchar(12) = null 
	as
	begin
		if(@MaLop is not null and @MaHocKyNamHoc is null and @NgayHoc is null and @TietHoc is null and @MaGiaoVien is null)
			begin
				select * from [dbo].[THOIKHOABIEULOP]
				where MaLop = @MaLop
			end
		else if(@MaLop is null and @MaHocKyNamHoc is not null and @NgayHoc is null and @TietHoc is null and @MaGiaoVien is null)
			begin
				select * from [dbo].[THOIKHOABIEULOP]
				where MaHocKyNamHoc = @MaHocKyNamHoc
			end
		else if(@MaLop is not null and @MaHocKyNamHoc is not null and @NgayHoc is not null and @TietHoc is null and @MaGiaoVien is null)
			begin
				select * from [dbo].[THOIKHOABIEULOP]
				where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc and NgayHoc = @NgayHoc
			end
		else if(@MaLop is not null and @MaHocKyNamHoc is not null and @NgayHoc is not null and @TietHoc is not null and @MaGiaoVien is null)
			begin
				select * from [dbo].[THOIKHOABIEULOP]
				where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc and NgayHoc = @NgayHoc and TietHoc = @TietHoc
			end
		else if(@MaLop is not null and @MaHocKyNamHoc is not null and @NgayHoc is null and @TietHoc is null and @MaGiaoVien is null)
			begin
				select * from [dbo].[THOIKHOABIEULOP]
				where MaLop = @MaLop and MaHocKyNamHoc = @MaHocKyNamHoc
			end
		else if(@MaLop is null and @MaHocKyNamHoc is null and @NgayHoc is null and @TietHoc is null and @MaGiaoVien is null)
			begin
				select * from [dbo].[THOIKHOABIEULOP]
			end
		else if(@MaLop is null and @MaHocKyNamHoc is null and @NgayHoc is null and @TietHoc is null and @MaGiaoVien is not null)
			begin
				select * from [dbo].[THOIKHOABIEULOP]
				where MaGiaoVien = @MaGiaoVien
			end
	end
GO

/******  End create all StoredProcedure******/
/********************************************/
 
/******  Start create all Trigger for work  ******/
/************************************************/


 /******  Trigger [dbo].[TriggerHocSinh]   ******/
create trigger [dbo].[TriggerHocSinh] on [dbo].[HOCSINH] 
for insert, update
as
begin
	declare @NgaySinh smalldatetime;
	declare @NgayNhapHoc smalldatetime;
	declare @NgayHienTai smalldatetime;

	select @NgaySinh = i.NgaySinh from inserted i;	
	select @NgayNhapHoc=i.NgayNhapHoc from inserted i;	
	select @NgayHienTai = GETDATE();	
	if (@NgayHienTai <= @NgaySinh)
		rollback tran
	if (@NgayHienTai <= @NgayNhapHoc)
		rollback tran
	if (@NgayNhapHoc <= @NgaySinh)
		rollback tran
end
GO
/******  Trigger [dbo].[TriggerCanBoNhanVien]   ******/
create trigger [dbo].[TriggerCanBoNhanVien] on [dbo].[GIAOVIEN] 
for insert, update
as
begin
	declare @NgaySinh smalldatetime;
	declare @NgayVaoLam smalldatetime;
	declare @NgayHienTai smalldatetime;

	select @NgaySinh = i.NgaySinh from inserted i;	
	select @NgayVaoLam=i.NgayVaoLam from inserted i;	
	select @NgayHienTai = GETDATE();	
	if (@NgayHienTai <= @NgaySinh)
		rollback tran
	if (@NgayHienTai <= @NgayVaoLam)
		rollback tran
	if (@NgayVaoLam <= @NgaySinh)
		rollback tran
end
GO
/******  Trigger [dbo].[TriggerCTDiem]   ******/
create trigger [dbo].[TriggerCTDiem] on [dbo].[CT_Diem] 
for insert, update
as
begin
	declare  @GiaTri float;
	select @GiaTri= i.GiaTri from inserted i;	
	if (@GiaTri < 0)
		rollback tran
end

GO
/******  Trigger [dbo].[TriggerNamHoc]  ******/
create trigger [dbo].[TriggerNamHoc] on [dbo].[NAMHOC] 
for insert, update
as
begin
	declare @NamBatDau int;
	declare @NamKetThuc int;
	declare @NamHienTai int;

	select @NamBatDau = i.NamBatDau from inserted i;	
	select @NamKetThuc = i.NamKetThuc from inserted i;	
	select @NamHienTai = YEAR(GETDATE())	
	
	if (@NamBatDau > @NamKetThuc)
		rollback tran
	if (@NamHienTai < @NamBatDau)
		rollback tran
end

GO
/******  Trigger [dbo].[TriggerMonHoc]  ******/
create trigger [dbo].[TriggerMonHoc] on [dbo].[MONHOC] 
for insert,update
as
begin
	declare @HeSo float;
	
	select @HeSo = i.HeSo from inserted i;	
	if (@HeSo <= 0)
		rollback tran
end

GO
/******  Trigger [dbo].[TriggerLoaiDiem]  ******/
create trigger [dbo].[TriggerLoaiDiem] on [dbo].[LOAIDIEM] 
for insert,update
as
begin
	declare @HeSo float;
	
	select @HeSo = i.HeSo from inserted i;	
	if (@HeSo <= 0)
		rollback tran
end

GO
/******  Trigger [dbo].[TriggerThoiKhoaBieuLop]  ******/
create trigger [dbo].[TriggerThoiKhoaBieuLop] on [dbo].[THOIKHOABIEULOP] 
for insert,update
as
begin
	declare @NgayHoc int;
	
	select @NgayHoc = i.NgayHoc from inserted i;	
	if (@NgayHoc < 2 or @NgayHoc > 7)
		rollback tran
end

GO

/******  End create all Trigger******/
/********************************************/


/******  Insert Standard query******/



exec [dbo].[ThemThamSo] N'Tuổi Học Sinh Tối Thiểu',15
GO		
exec [dbo].[ThemThamSo] N'Tuổi Học Sinh Tối Đa',20
GO		
exec [dbo].[ThemThamSo] N'Sĩ Số Tối Đa',40
GO		
exec [dbo].[ThemThamSo] N'Điểm Tối Thiểu',0
GO		
exec [dbo].[ThemThamSo] N'Điểm Tối Đa',10
GO		
exec [dbo].[ThemThamSo] N'Điểm Đạt',5
GO		
exec [dbo].[ThemThamSo] N'Tuổi Giáo Viên Tối Thiểu',25
GO
exec [dbo].[ThemThamSo] N'Tuổi Giáo Viên Tối Đa',60
GO
exec [dbo].[ThemThamSo] N'Số Tiết Học Trong Ngày',5
GO


exec [dbo].[ThemBoDem] N'KHOILOP',0
GO		
exec [dbo].[ThemBoDem] N'NAMHOC',0
GO		
exec [dbo].[ThemBoDem] N'HOCKY',0
GO		
exec [dbo].[ThemBoDem] N'HOCKYNAMHOC',0
GO		
exec [dbo].[ThemBoDem] N'LOP',0
GO		
exec [dbo].[ThemBoDem] N'LOAITINHTRANGTHEOHOC',0
GO		
exec [dbo].[ThemBoDem] N'HOCSINH',0
GO		
exec [dbo].[ThemBoDem] N'MONHOC',0
GO		
exec [dbo].[ThemBoDem] N'BANGDIEM',0
GO		
exec [dbo].[ThemBoDem] N'CT_BANGDIEM',0
GO	
exec [dbo].[ThemBoDem] N'CT_DIEM',0
GO	
exec [dbo].[ThemBoDem] N'LOAINGUOIDUNG',0
GO	
exec [dbo].[ThemBoDem] N'LOAIHANHKIEM',0
GO	
exec [dbo].[ThemBoDem] N'TTHOCPHI',0
GO	
exec [dbo].[ThemBoDem] N'CT_DONGHOCPHI',0
GO	
exec [dbo].[ThemBoDem] N'TTBAOHIEMYTE',0
GO	
exec [dbo].[ThemBoDem] N'CT_DONGBAOHIEM',0
GO		
exec [dbo].[ThemBoDem] N'CHUYENMON',0
GO			
exec [dbo].[ThemBoDem] N'LOAITINHTRANGCONGTAC',0
GO			
exec [dbo].[ThemBoDem] N'GIAOVIEN',0
GO		
exec [dbo].[ThemBoDem] N'XEPLOAIHANHKIEM',0
GO				


exec [dbo].[ThemLoaiNguoiDung] 'LND000000000',N'Quản Trị Hệ Thống'
GO
exec [dbo].[ThemLoaiNguoiDung] 'LND000000001',N'Phòng Giáo Vụ'
GO
exec [dbo].[ThemLoaiNguoiDung] 'LND000000002',N'Phòng Tài Vụ'
GO
exec [dbo].[ThemNguoiDung] 'admin','LND000000000','8f184094c279e20908fecfeca75dd76c' -- quantrihethong
GO
exec [dbo].[ThemNguoiDung] 'taivu','LND000000002','fc4a76a2d06e3743b94ad08de9deaca8' -- taivu
GO
exec [dbo].[ThemNguoiDung] 'giaovu','LND000000001','9c5e8ed003d1ccebd3674e7040f844d6' -- giaovu
GO		


GO	
exec [dbo].[ThemLoaiTinhTrangTheoHoc] N'LTTTH0000000',"Đang Học"
GO	
exec [dbo].[ThemLoaiTinhTrangTheoHoc] N'LTTTH0000001',"Đình Chỉ"
GO	
exec [dbo].[ThemLoaiTinhTrangTheoHoc] N'LTTTH0000002',"Nghỉ Học"
GO	
exec [dbo].[ThemLoaiTinhTrangTheoHoc] N'LTTTH0000003',"Hoàn Thành"
GO	

GO
exec [dbo].[ThemLoaiHanhKiem] 'LH0000000000', N'Tốt'
GO
exec [dbo].[ThemLoaiHanhKiem] 'LH0000000001', N'Khá'
GO
exec [dbo].[ThemLoaiHanhKiem] 'LH0000000002', N'Trung Bình'
GO
exec [dbo].[ThemLoaiHanhKiem] 'LH0000000003', N'Yếu'
GO
 
exec [dbo].[ThemLoaiTinhTrangCongTac] 'LTTCT0000000',N'Đang Công Tác'
GO
exec [dbo].[ThemLoaiTinhTrangCongTac] 'LTTCT0000001',N'Đã Nghỉ Hưu'
GO
exec [dbo].[ThemLoaiTinhTrangCongTac] 'LTTCT0000002',N'Đình Chỉ Công Tác'
GO
exec [dbo].[ThemLoaiTinhTrangCongTac] 'LTTCT0000003',N'Đã Chuyển Công Tác'
GO

exec [dbo].[ThemLoaiDiem] 'LD0000000000',N'Điểm Miệng',1
GO
exec [dbo].[ThemLoaiDiem] 'LD0000000001',N'Điểm 15 Phút',1
GO
exec [dbo].[ThemLoaiDiem] 'LD0000000002',N'Điểm 45 Phút',2
GO
exec [dbo].[ThemLoaiDiem] 'LD0000000003',N'Điểm Thi Học Kỳ',3
GO
exec [dbo].[ThemLoaiDiem] 'LD0000000004',N'Điểm Trung Bình',1
GO

exec [dbo].[ThemKhoiLop] 'KL0000000000',N'Khối 10'
GO
exec [dbo].[ThemKhoiLop] 'KL0000000001',N'Khối 11'
GO
exec [dbo].[ThemKhoiLop] 'KL0000000002',N'Khối 12'
GO

exec [dbo].[ThemMonHoc] 'MH0000000000',N'Toán',2
GO
exec [dbo].[ThemMonHoc] 'MH0000000001',N'Vật Lý',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000002',N'Hóa Học',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000003',N'Sinh Học',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000004',N'Ngữ Văn',2
GO
exec [dbo].[ThemMonHoc] 'MH0000000005',N'Lịch Sử',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000006',N'Địa Lý',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000007',N'Ngoại Ngữ',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000008',N'Thể Dục',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000009',N'Công Nghệ',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000010',N'Giáo Dục Công Dân',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000011',N'Giáo Dục Quốc Phòng',1
GO
exec [dbo].[ThemMonHoc] 'MH0000000012',N'Tin Học',1
GO

exec [dbo].[ThemChuyenMon] 'CM0000000000', N'Toán Học'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000001', N'Văn Học'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000002', N'Vật Lý Học'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000003', N'Hóa Học'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000004', N'Sinh Học'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000005', N'Sử Học'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000006', N'Ngoại Ngữ'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000007', N'Địa Lý Học'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000008', N'Công Nghệ'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000009', N'Thể Dục'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000010', N'Giáo Dục Quốc Phòng'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000011', N'Giáo Dục Công Dân'
GO
exec [dbo].[ThemChuyenMon] 'CM0000000012', N'Tin Học'
GO


/********************************************/