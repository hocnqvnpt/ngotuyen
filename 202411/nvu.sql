create table nv_temp as ;
select * from nv_temp ;

truncate table nv_temp ;

insert into nv_temp(THANG, HDTB_ID, HDKH_ID, MA_GD, MA_HD, MA_KH, MA_TB, NGAY_YC, CTV_ID, NHANVIEN_ID, NGUOI_CN, NGAYLAP_HD, TTHD_ID, TRANGTHAI_HD, KIEULD_ID, TEN_KIEULD
, KHACHHANG_ID, THUEBAO_ID, DONVI_ID, LOAITB_ID, DICHVUVT_ID, MA_TIEPTHI, TEN_TIEPTHI, PHIEU_ID, THANHTOAN_ID, NGAY_TT, MA_TT, HTTT_ID, MA_KN, MANV_RA_PCT, TENNV_RA_PCT
, MA_VTCV, TEN_VTCV, MATO_RA_PCT, TENTO_RA_PCT, MAPB_RA_PCT, TENPB_RA_PCT, LOAIHD_ID, TEN_LOAIHD, LOAI)
/* -------------- SBH -------------- */
select THANG, HDTB_ID, HDKH_ID, MA_GD, MA_HD, MA_KH, MA_TB, NGAY_YC, CTV_ID, NHANVIEN_ID, NGUOI_CN, NGAYLAP_HD
, TTHD_ID, TRANGTHAI_HD, KIEULD_ID, TEN_KIEULD, KHACHHANG_ID, THUEBAO_ID, DONVI_ID, LOAITB_ID, DICHVUVT_ID, MA_TIEPTHI, TEN_TIEPTHI
, CAST(NULL as number)phieu_id, CAST(NULL as number)THANHTOAN_ID, CAST(NULL as date)NGAY_TT, CAST(NULL as varchar(30))MA_TT, CAST(NULL as number)HTTT_ID
, CAST(NULL as varchar2(100))MA_KN, MANV_RA_PCT, TENNV_RA_PCT, MA_VTCV, TEN_VTCV, MATO_RA_PCT, TENTO_RA_PCT, MAPB_RA_PCT, TENPB_RA_PCT, LOAIHD_ID, TEN_LOAIHD, LOAI
from 
(
    with v_nv as 
        (select ma_nv, ten_nv , ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, nhanvien_id
            from ttkd_bsc.nhanvien nv where thang = 202410)
    
     select a.*, ma_nv manv_ra_pct, ten_nv tennv_ra_pct, ma_vtcv, ten_vtcv, ma_to mato_ra_pct, ten_to tento_ra_pct, ma_pb mapb_ra_pct, ten_pb tenpb_ra_pct,'SKM' loai,
            (case when ma_vtcv not in('VNP-HNHCM_BHKV_22','VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_27') then 1
                  when (( a.ma_tiepthi is null and nv.ma_nv is not null) or a.ma_tiepthi = nv.ma_nv) 
                        and (ma_vtcv in('VNP-HNHCM_BHKV_22','VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_27')) then 1 else 0
             end ) dung_ma_tiepthi
     from 
        (
            select to_char(trunc(hdkh.ngay_yc),'yyyymm') thang, hdtb.hdtb_id, hdkh.hdkh_id, hdkh.ma_gd, hdkh.ma_hd, hdkh.ma_kh, hdtb.ma_tb, hdkh.ngay_yc, hdkh.ctv_id, hdkh.nhanvien_id, 
                         hdkh.nguoi_cn, hdkh.loaihd_id, (SELECT lhd.ten_loaihd FROM css.loai_hd@dataguard lhd WHERE hdkh.loaihd_id=lhd.loaihd_id) TEN_LOAIHD, 
                         hdkh.ngaylap_hd, hdtb.tthd_id, (SELECT tthd.trangthai_hd FROM css.trangthai_hd@dataguard tthd WHERE hdtb.tthd_id=tthd.tthd_id) TRANGTHAI_HD,
                         hdtb.KIEULD_ID, (select ten_kieuld from css.kieu_ld@dataguard where kieuld_id = hdtb.kieuld_id)ten_kieuld,
                         hdkh.khachhang_id, hdtb.thuebao_id, hdkh.donvi_id, hdtb.loaitb_id, hdtb.dichvuvt_id,  
                        (case when hdkh.ctv_id > 0 then (select ma_nv  from admin.nhanvien@dataguard where nhanvien_id = hdkh.ctv_id and rownum=1) else null end) ma_tiepthi,
                        (case when hdkh.ctv_id > 0 then (select ten_nv from admin.nhanvien@dataguard where nhanvien_id = hdkh.ctv_id and rownum=1) else null end) ten_tiepthi            
            from css.v_hd_khachhang@dataguard hdkh, css.v_hd_thuebao@dataguard hdtb
            Where hdkh.hdkh_id=hdtb.hdkh_id 
              and trunc(hdkh.ngay_yc) between to_date('01/10/2024','dd/mm/yyyy') and to_date('01/10/2024','dd/mm/yyyy')
              and hdtb.dichvuvt_id <> 2
              and LOAIHD_ID in(1,2,3,4,5,7,8,10,14,15,16,17,21,27,28,30,31,32,41)
        ) a, v_nv nv
        where a.nhanvien_id = nv.nhanvien_id(+)
) a
;
commit ;
--union all
/* --------- KHIEU NAI - TIEPNHAN ------------ */
insert into nv_temp(THANG, MA_TB, NGAY_YC, NHANVIEN_ID, NGUOI_CN, KHACHHANG_ID, THUEBAO_ID, DONVI_ID, LOAITB_ID, DICHVUVT_ID
, MA_KN, MANV_RA_PCT, TENNV_RA_PCT, MA_VTCV, TEN_VTCV, MATO_RA_PCT, TENTO_RA_PCT, MAPB_RA_PCT, TENPB_RA_PCT, TEN_LOAIHD, LOAI)

select THANG, MA_TB, NGAY_TN, NHANVIEN_ID, NGUOI_CN, KHACHHANG_ID, THUEBAO_ID, DONVI_ID, LOAITB_ID, DICHVUVT_ID
, MA_KN, MANV_RA_PCT, TENNV_RA_PCT, MA_VTCV, TEN_VTCV_RA_PCT, MATO_RA_PCT, TENTO_RA_PCT, MAPB_RA_PCT, TENPB_RA_PCT, TEN_LOAIHD, LOAI
from
(
    with v_nv as 
        (select ma_nv, ten_nv , ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, nhanvien_id from ttkd_bsc.nhanvien nv where thang = 202410)
    select a.*
        , nv.ma_nv manv_ra_pct, nv.ten_nv tennv_ra_pct, nv.ma_vtcv, nv.ten_vtcv ten_vtcv_ra_pct, nv.ma_to mato_ra_pct
        , nv.ten_to tento_ra_pct, nv.ma_pb mapb_ra_pct, nv.ten_pb tenpb_ra_pct, 'KHN' loai
    from 
    (
       select to_char(trunc(a.ngay_tn),'yyyymm') thang, a.donvi_id, a.thuebao_id
                   , (select khachhang_id from css.v_db_thuebao@dataguard db where a.thuebao_id = db.thuebao_id) khachhang_id
                   , a.ma_tb, a.loaitb_id, a.dichvuvt_id, a.ngay_tn, a.nguoi_cn, a.nhanvien_id
                   , 'KHIEU NAI - TIEPNHAN'TEN_LOAIHD, MA_KN
        from qltn.v_khieunai@dataguard a 
        where phanvung_id=28 and a.dichvuvt_id <> 2 
          and trunc(a.ngay_tn) between to_date('01/10/2024','dd/mm/yyyy') and to_date('01/10/2024','dd/mm/yyyy')
    ) a, v_nv nv
    where a.nhanvien_id = nv.nhanvien_id(+)
) b
;
commit ;
-- union all
/* --------- KHIEU NAI - HOAN THANH ------------ */
insert into nv_temp(THANG, MA_TB, NGAY_YC, NHANVIEN_ID, NGUOI_CN, KHACHHANG_ID, THUEBAO_ID, DONVI_ID, LOAITB_ID, DICHVUVT_ID
, MA_KN, MANV_RA_PCT, TENNV_RA_PCT, MA_VTCV, TEN_VTCV, MATO_RA_PCT, TENTO_RA_PCT, MAPB_RA_PCT, TENPB_RA_PCT, TEN_LOAIHD, LOAI)

select THANG, MA_TB, NGAY_GQ, NHANVIEN_ID, NGUOI_CN, KHACHHANG_ID, THUEBAO_ID, DONVI_ID, LOAITB_ID, DICHVUVT_ID
, MA_KN, MA_NV, TEN_NV, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, TEN_LOAIHD, LOAI

from
(
    with v_nv as 
        (select ma_nv, ten_nv , ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, nhanvien_id
            from ttkd_bsc.nhanvien nv where thang = 202410)
    select a.*
          , nv.ma_nv, nv.ten_nv, nv.ma_vtcv, nv.ten_vtcv, nv.ma_to, nv.ten_to, nv.ma_pb, nv.ten_pb, 'KHN' loai
    from 
    (
      select to_char(trunc(a.ngay_tn),'yyyymm') thang, a.donvi_id, a.thuebao_id
                  , (select khachhang_id from css.v_db_thuebao@dataguard db where a.thuebao_id = db.thuebao_id) khachhang_id            
                  , a.ma_tb,a.loaitb_id,a.dichvuvt_id, a.ngay_gq, a.nguoi_cn, a.nhanvien_gq_id nhanvien_id
                  , 'KHIEU NAI - HOAN THANH' TEN_LOAIHD, MA_KN
      from qltn.v_khieunai@dataguard a 
      where phanvung_id=28 and a.dichvuvt_id <> 2 
        and trunc(a.ngay_gq) between to_date('01/10/2024','dd/mm/yyyy') and to_date('01/10/2024','dd/mm/yyyy')
    ) a, v_nv nv
    where a.nhanvien_id = nv.nhanvien_id(+)
) 
;
commit ;
-- union all

/* ------------ THU CUOC ------------- */
insert into nv_temp(THANG, MA_KH, MA_TB, NGAY_YC, NHANVIEN_ID, NGUOI_CN, KHACHHANG_ID, DICHVUVT_ID, PHIEU_ID
, THANHTOAN_ID, NGAY_TT, MA_TT, HTTT_ID, MANV_RA_PCT, TENNV_RA_PCT, MA_VTCV, TEN_VTCV, MATO_RA_PCT, TENTO_RA_PCT, MAPB_RA_PCT, TENPB_RA_PCT, TEN_LOAIHD, LOAI)

select THANG, MA_KH, MA_TB, NGAY_CN, NHANVIEN_ID, MA_TN, KHACHHANG_ID, DICHVUVT_ID, PHIEU_ID
, THANHTOAN_ID, NGAY_TT, MA_TT, HTTT_ID, MANV_RA_PCT, TENNV_RA_PCT, MA_VTCV, TEN_VTCV, MATO_RA_PCT, TENTO_RA_PCT, MAPB_RA_PCT, TENPB_RA_PCT, TEN_LOAIHD, LOAI
from 
(
    with v_db as ( select tt.thanhtoan_id, tt.khachhang_id, kh.ma_kh
                    from tinhcuoc.v_dbtt@dataguard tt, tinhcuoc.v_dbkh@dataguard kh
                        where tt.phanvung_id = 28 and tt.phanvung_id = 28 
                        and tt.ky_cuoc = '20241001' and kh.ky_cuoc = '20241001'
                        and tt.khachhang_id = kh.khachhang_id
                 )
       , v_nv as 
        (select ma_nv, ten_nv , ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, nhanvien_id
            from ttkd_bsc.nhanvien nv where thang = 202410)
    
    select distinct a.thang, a.phieu_id, a.thanhtoan_id, a.ngay_tt, a.ma_tb, a.ma_tt, a.dichvuvt_id, a.ma_tn, a.ngay_cn, a.nguoi_cn, a.httt_id
                    , a.nhanvien_id, db.khachhang_id, db.ma_kh, a.loaihd_id, a.ten_loaihd,'PTH' loai
                    , ma_nv manv_ra_pct, ten_nv tennv_ra_pct, ma_vtcv, ten_vtcv, ma_to mato_ra_pct, ten_to tento_ra_pct, ma_pb mapb_ra_pct, ten_pb tenpb_ra_pct
    from 
         ( 
           Select distinct to_char(trunc(a.ngay_cn),'yyyymm') thang, a.phieu_id, a.thanhtoan_id, a.ngay_tt, a.ma_tt, a.ma_tn, b.nguoi_cn, a.ngay_cn
                        , a.nhanvien_id, a.httt_id, b.ma_tb, b.dichvuvt_id, 99 loaihd_id, 'THU CUOC' ten_loaihd
           From qltn.v_Bangphieutra@dataguard a, qltn.v_ct_tra@dataguard b
           Where a.phieu_id=b.phieu_id and b.dichvuvt_Id <> 2 
             and a.ky_cuoc='20240901' and b.ky_cuoc='20240901'
             and a.ngay_cn between to_date('01/10/2024 00:00:01','dd/mm/yyyy hh24:mi:ss') and to_date('01/10/2024 23:59:59','dd/mm/yyyy  hh24:mi:ss')
         ) a, v_db db, v_nv nv
    where a.thanhtoan_id = db.thanhtoan_id(+)
      and a.MA_TN = NV.MA_NV(+)
) 
;
commit ;