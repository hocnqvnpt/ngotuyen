-- drop table tuyenngo.a_ct_bsc_ptm_temp purge ;
create table a_ct_bsc_ptm_temp as
select NGUON, ma_pb, ten_pb, THANG_LUONG, THANG_PTM, MA_TB, MA_GD, HDTB_ID, DICH_VU, NOP_DU, BS_LUUKHO, NGAY_LUUHS_TTKD, NGAY_LUUHS_TTVT
     , LYDO_KHONGTINH_luong, DOITUONG_KH, LOAITB_ID, DICHVUVT_ID, mien_hsgoc
from ttkd_bsc.ct_bsc_ptm 
where (nop_du is null or nop_du=0) and thang_ptm >= 202411 
 and mien_hsgoc is null 
 --and loaitb_id in(1,58,59,61,171) 
 and nguon = 'ptm_codinh'
-- and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
 
;
update tuyenngo.a_ct_bsc_ptm_temp a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,LYDO_KHONGTINH_DONGIA)
        =( select distinct '20250308', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , 'kq=? Đối tượng khách hàng "Cá Nhân", Thuê bao ĐTCĐ, FIBER, MYTV PTM không ký qua Hđđt , econtract_app = 0' lydo_khongtinh_dongia    
           from ttkd_bct.nt_tam_luuhs_20250303 b 
            where b.loaitb_id in(1,58,59,61,171) 
                and b.econtract_app = 0
                and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
         ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, lydo_khongtinh_dongia from a_ct_bsc_ptm_temp a
where (nop_du is null or nop_du=0) and thang_ptm >= 202412 
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
; 
commit ;
rollback ;
 select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, lydo_khongtinh_dongia from a_ct_bsc_ptm_temp a
where nop_du = 1 and thang_ptm >= 202411
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
 ;