update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)
        =( select distinct '20250316', b.nop_du
						  , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
						  , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
						  , 'kq=? Đối tượng khách hàng Cá Nhân, Thuê bao ĐTCĐ, FIBER, MYTV PTM không ký qua Hđđt - econtract_app = 0' lydo_khongtinh_luong
           from ttkd_bct.nt_tam_luuhs_20250316 b 
            where b.loaitb_id in(1,58,59,61,171) 
                and b.econtract_app = 0
                and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
         ) 	
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, lydo_khongtinh_dongia from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202412 
				 and mien_hsgoc is null 
				 and loaitb_id in(1,58,59,61,171) 
				 and nguon is not null
				 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
				 and doituong_kh = 'KHCN'
; 
commit ;

--- chay code này HỌC
MERGE INTO tuyenngo.a_ct_bsc_ptm_temp a
USING ( select distinct '20250316', ma_tb, ma_gd, hdtb_id, b.nop_du
						  , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end) ngay_luuhs_ttkd
						  , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end) ngay_luuhs_ttvt
						  , 'KHCN, Thuê bao ĐTCĐ, FIBER, MYTV PTM không ký qua Hđđt' lydo_khongtinh_luong
			 from ttkd_bct.nt_tam_luuhs_20250316 b 
			  where b.loaitb_id in(1,58,59,61,171) 
				 and b.econtract_app = 0
				 and b.nop_du=1 and b.ngay_nop_du is not null 
--				 and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
		) b
ON (b.ma_tb = a.ma_tb and b.ma_gd = a.ma_gd and b.hdtb_id = a.hdtb_id)
WHEN MATCHED THEN
	UPDATE SET 
						a.bs_luukho = '20250316'
						, a.nop_du = b.nop_du
						, a.ngay_luuhs_ttkd = b.ngay_luuhs_ttkd
						, a.ngay_luuhs_ttvt = b.ngay_luuhs_ttvt
						, a.lydo_khongtinh_luong = lydo_khongtinh_luong || b.lydo_khongtinh_luong
	WHERE (nop_du is null or nop_du=0) and thang_ptm >= 202412 
				 and mien_hsgoc is null 
				 and loaitb_id in(1,58,59,61,171) 
				 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
				 and doituong_kh = 'KHCN'
;

select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, lydo_khongtinh_luong
from a_ct_bsc_ptm_temp a
where (nop_du is null or nop_du=0) and thang_ptm >= 202412 
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
;
rollback ;

update ttkd_bsc.ct_bsc_ptm a set nop_du = ''
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, lydo_khongtinh_luong from ttkd_bsc.ct_bsc_ptm a 
where lydo_khongtinh_luong like '%KHCN, Thuê bao ĐTCĐ, FIBER, MYTV PTM không ký qua Hđđt%' 
    and thang_ptm >= 202412 
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600'
             ,'VNP0703000','VNP0702300','VNP0702400','VNP0702500','VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
;
commit ;