
/* NV */
--select * from SBH_202409_CT ;
--drop table SBH_202409_CT ;
drop table a_sbh_temp purge ;
create table a_sbh_temp as
      select to_char(trunc(hdkh.ngay_yc),'yyyymm') thang, hdtb.hdtb_id, hdkh.hdkh_id, hdkh.ma_gd, hdkh.ma_hd, hdkh.ma_kh, hdtb.ma_tb, hdkh.ngay_yc, hdkh.ctv_id, hdkh.nhanvien_id, 
             hdkh.nguoi_cn, hdkh.loaihd_id, (SELECT lhd.ten_loaihd FROM css.loai_hd@dataguard lhd WHERE hdkh.loaihd_id=lhd.loaihd_id) TEN_LOAIHD, 
             hdkh.ngaylap_hd, hdtb.tthd_id, (SELECT tthd.trangthai_hd FROM css.trangthai_hd@dataguard tthd WHERE hdtb.tthd_id=tthd.tthd_id) TRANGTHAI_HD,
             hdtb.KIEULD_ID, (select ten_kieuld from css.kieu_ld@dataguard where kieuld_id = hdtb.kieuld_id)ten_kieuld,
             hdkh.khachhang_id, hdtb.thuebao_id, hdkh.donvi_id, hdtb.loaitb_id, hdtb.dichvuvt_id,  
            (case when hdkh.ctv_id > 0 then (select ma_nv  from admin.nhanvien@dataguard where nhanvien_id = hdkh.ctv_id and rownum=1) else null end) ma_tiepthi,
            (case when hdkh.ctv_id > 0 then (select ten_nv from admin.nhanvien@dataguard where nhanvien_id = hdkh.ctv_id and rownum=1) else null end) ten_tiepthi            
      from css.v_hd_khachhang@dataguard hdkh, css.v_hd_thuebao@dataguard hdtb
      where hdkh.hdkh_id=hdtb.hdkh_id 
      and trunc(hdkh.ngay_yc) between to_date('01/09/2024','dd/mm/yyyy') and to_date('30/09/2024','dd/mm/yyyy')
      and hdtb.dichvuvt_id <> 2 
;
drop table SBH_202409_CT purge ;
CREATE TABLE SBH_202409_CT AS 
with v_nv as 
    (select ma_nv, ten_nv , ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, nhanvien_id
        from ttkd_bsc.nhanvien nv where thang = 202409)

 select a.*, ma_nv manv_ra_pct, ten_nv tennv_ra_pct, ma_vtcv, ten_vtcv, ma_to mato_ra_pct, ten_to tento_ra_pct, ma_pb mapb_ra_pct, ten_pb tenpb_ra_pct,'SKM' loai,
        (case when ma_vtcv not in('VNP-HNHCM_BHKV_22','VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_27') then 1
              when (( a.ma_tiepthi is null and nv.ma_nv is not null) or a.ma_tiepthi = nv.ma_nv) 
                    and (ma_vtcv in('VNP-HNHCM_BHKV_22','VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_27')) then 1 else 0
         end ) dung_ma_tiepthi
 from a_sbh_temp a, v_nv nv
    where a.nhanvien_id = nv.nhanvien_id(+)
;
/* ----------- KHIEU NAI ------------- */
drop table a_sbh_temp purge ;
create table a_sbh_temp as
select a.*, db.khachhang_id
      , (select ma_kh from css.v_hd_khachhang@dataguard where khachhang_id=db.khachhang_id and rownum=1)ma_kh
      , (select ma_gd from css.v_hd_khachhang@dataguard where khachhang_id=db.khachhang_id and rownum=1)ma_gd
from 
(
    select to_char(trunc(a.ngay_tn),'yyyymm') thang, a.donvi_id, a.thuebao_id,            
              a.ma_tb,a.loaitb_id,a.dichvuvt_id, a.ngay_tn, a.nguoi_cn, a.nhanvien_id, a.nhanvien_gq_id, 
              'KHIEU NAI - TIEPNHAN'TEN_LOAIHD, MA_KN, ngay_GQ
      from qltn.v_khieunai@dataguard a where phanvung_id=28 and a.dichvuvt_id <> 2 
      and trunc(a.ngay_tn) between to_date('01/09/2024','dd/mm/yyyy') and to_date('30/09/2024','dd/mm/yyyy')
      union all
      select to_char(trunc(a.ngay_gq),'yyyymm') thang, a.donvi_id, a.thuebao_id,            
              a.ma_tb,a.loaitb_id,a.dichvuvt_id, a.ngay_tn, a.nguoi_cn, a.nhanvien_id, a.nhanvien_gq_id, 
              'KHIEU NAI - HOAN THANH' TEN_LOAIHD, MA_KN, NGAY_GQ
      from qltn.v_khieunai@dataguard a where phanvung_id=28 and a.dichvuvt_id <> 2 
      and trunc(a.ngay_gq) between to_date('01/09/2024','dd/mm/yyyy') and to_date('30/09/2024','dd/mm/yyyy')     
) a
left join (select db.khachhang_id, db.thuebao_id from css.v_db_thuebao@dataguard db) db on a.thuebao_id = db.thuebao_id
;

create table SBH_KHIEUNAI_202409_CT_TN AS
with v_nv as 
    (select ma_nv, ten_nv , ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, nhanvien_id
        from ttkd_bsc.nhanvien nv where thang = 202409)
select a.*,
    nv.ma_nv manv_ra_pct, nv.ten_nv tennv_ra_pct, nv.ma_vtcv, nv.ten_vtcv ten_vtcv_ra_pct, nv.ma_to mato_ra_pct, nv.ten_to tento_ra_pct, nv.ma_pb mapb_ra_pct
  , nv.ten_pb tenpb_ra_pct, 'KHN' loai
from a_sbh_temp a, v_nv nv
where a.nhanvien_id = nv.nhanvien_id(+)
and ten_loaihd = 'KHIEU NAI - TIEPNHAN'
;

create table SBH_KHIEUNAI_202409_CT_GQ AS
with v_nv as 
    (select ma_nv, ten_nv , ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, nhanvien_id
        from ttkd_bsc.nhanvien nv where thang = 202409)
select a.*,
    nv.ma_nv manv_gq, nv.ten_nv tennv_gq, nv.ma_vtcv ma_vtcv_gq, nv.ten_vtcv ten_vtcv_gq, nv.ma_to mato_gq, nv.ten_to tento_gq, nv.ma_pb mapb_gq, nv.ten_pb tenpb_gq,
    (Case when ( nv.ma_vtcv in('VNP-HNHCM_BHKV_22','VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_27'))then 'X' else '' end)SBH_GQ, 'KHN' loai
from a_sbh_temp a, v_nv nv
where a.nhanvien_gq_id = nv.nhanvien_id(+)
and ten_loaihd = 'KHIEU NAI - HOAN THANH'

;
/* ------------ THU CUOC ------------- */
drop table a_sbh_temp purge ;
create table a_sbh_temp as 
with v_db as ( select tt.thanhtoan_id, tt.khachhang_id, kh.ma_kh
                from tinhcuoc.v_dbtt@dataguard tt, tinhcuoc.v_dbkh@dataguard kh
                    where tt.phanvung_id = 28 and tt.phanvung_id = 28 
                    and tt.ky_cuoc = '20240901' and kh.ky_cuoc = '20240901'
                    and tt.khachhang_id = kh.khachhang_id
             )

select distinct a.thang, a.phieu_id, a.thanhtoan_id, a.ngay_tt, a.ma_tb,a.ma_tt, a.dichvuvt_id, a.ma_tn, a.ngay_cn, a.nguoi_cn, a.httt_id,
                a.nhanvien_id, db.khachhang_id, db.ma_kh, a.loaihd_id, a.ten_loaihd,'PTH' loai
from 
     ( 
       Select distinct to_char(trunc(a.ngay_cn),'yyyymm') thang, a.phieu_id, a.thanhtoan_id, a.ngay_tt, a.ma_tt, a.ma_tn, b.nguoi_cn, a.ngay_cn
                    , a.nhanvien_id, a.httt_id, b.ma_tb, b.dichvuvt_id, 99 loaihd_id, 'THU CUOC' ten_loaihd
       From qltn.v_Bangphieutra@dataguard a, qltn.v_ct_tra@dataguard b
       Where a.phieu_id=b.phieu_id and b.dichvuvt_Id <> 2 and a.ky_cuoc='20240801' and b.ky_cuoc='20240801'
         and trunc(a.ngay_cn) between to_date('01/09/2024','dd/mm/yyyy') and to_date('30/09/2024','dd/mm/yyyy')
     ) a, v_db db
where  a.thanhtoan_id = db.thanhtoan_id(+)
--and a.dichvuvt_id = db.dichvuvt_id(+)
;

drop table SBH_CT_THU_202409_CT purge ;
create table SBH_CT_THU_202409_CT as 
with v_nv as 
    (select ma_nv, ten_nv , ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, nhanvien_id
        from ttkd_bsc.nhanvien nv where thang = 202409)

select distinct a.*, ma_nv manv_ra_pct, ten_nv tennv_ra_pct, ma_vtcv, ten_vtcv, ma_to mato_ra_pct, ten_to tento_ra_pct, ma_pb mapb_ra_pct, ten_pb tenpb_ra_pct
from a_sbh_temp a, v_nv nv
    where a.MA_TN = NV.MA_NV(+)
;
create index SBH_CT_THU_202409_CT_matb on SBH_CT_THU_202409_CT(ma_tb) ;

