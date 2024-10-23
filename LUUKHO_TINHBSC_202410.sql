select * from admin.v_hs_thuebao@dataguard ;
select * from admin.v_file_hs@dataguard ;
select a.ma_tb, a.hdkh_id, b.ma_gd, b.ma_hd
from css.v_hd_thuebao@dataguard a, css.v_hd_khachhang@dataguard b
where a.hdkh_id = b.hdkh_id 
and a.ma_tb = '914428489' ;
-------------- TAO FILE LUU HO SO TRONG BCT ------------------------------------
drop table nt_tam_luuhs_20241013 purge ;
create table nt_tam_luuhs_20241013 as SELECT * FROM ttkd_bsc.nt_tam_luuhs_20241013@dhsxkd ; /* TAO FILE QUA BSC */
CREATE INDEX nt_tam_luuhs_20241013_HDID ON nt_tam_luuhs_20241013 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20241013_matb ON nt_tam_luuhs_20241013 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20241013_magd ON nt_tam_luuhs_20241013 (ma_gd ASC) ;
select ma_tb, ma_gd, hdtb_id, count(*)sl from nt_tam_luuhs_20241013 group by ma_tb, ma_gd, hdtb_id having count(*)>1 ;
select * from nt_tam_luuhs_20241013 ;

-- 400.012
select * FROM ttkdhcm_ktnv.v_bangiao_hoso_new a where MA_TB in('915985698','916446188','945409775') ;
select * FROM ttkdhcm_ktnv.v_bangiao_hoso_new a  
where ma_tb in('84849283390','84849879350','84849566761','84848196202','84845327870','84845327820','84845706891','84847750531')  ;
select * from tam_luuhs a ;

create table tam_luuhs as SELECT * FROM ttkd_bsc.tam_luuhs@dhsxkd ; /* TAO FILE QUA BSC */

drop table tam_luuhs_20241013 purge ;
create table tam_luuhs_20241013 as 
        SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du , ngay_nop, ngay_bg
        from ttkd_bct.bangiao_hoso_tinhbsc
        where MA_TB in('84915985698','84916446188','84945409775') 
        where trunc(ngay_bg) between to_date('01/01/2024','dd/mm/yyyy') and to_date('13/10/2024','dd/mm/yyyy')
        and ma_tb in('hcm_vnpt_his_00000074','hcm_lis_00000046','hcm_hddt_00017419','hcm_cloud_00008713','hcm_ioff_00000128')
--        and ma_tb in('hcm_iot_cbsc_00001047', 'hcm_iot_cbsc_00001033','hcm_iot_cbsc_00001048')
;
commit ;

select * FROM ttkd_bct.tam_luuhs_20241013 a ;
select * FROM ttkd_bct.nt_tam_luuhs_20241013 a ;

--create table ttkd_bct.nt_tam_luuhs_20241013 as 
--drop table nt_tam_luuhs_20241013 purge ;
create table nt_tam_luuhs_20241013 as 
select distinct ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, 
       decode(donvi_id_nhap,283466,'TTVT SG',283452,'TTVT CL',283467,'TTVT GD',283451,'TTVT TB',283453,'TTVT BC',283454,'TTVT CC',
                            283455,'TTVT HM',283468,'TTVT NSG',283469,'TTVT TD') ten_ttvt, nop_du, 
       max(ngay_nop_du)ngay_nop_du, min(ngay_bg)ngay_bg
from 
  ( 
   select ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, ngay_nop_du, ngay_bg, ngay_nop, a.nop_du,
         ( case when (select d.donvi_id from admin_hcm.nhanvien c,admin_hcm.donvi b, admin_hcm.donvi d 
                      where c.nhanvien_id=a.nhanvien_id and c.donvi_id=b.donvi_id 
                        and b.donvi_cha_id=d.donvi_id) in(283466,283452,283467,283451,283453,283454,283455,283468,283469) then 'TTVT' else 'TTKD' end
         ) donvi_nhap, nhanvien_id, 
         ( select d.donvi_id from admin_hcm.nhanvien c,admin_hcm.donvi b, admin_hcm.donvi d 
            where c.nhanvien_id=a.nhanvien_id and c.donvi_id=b.donvi_id and b.donvi_cha_id=d.donvi_id
         ) donvi_id_nhap
    from
      (    
        SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_id, nop_du, max(ngay_nop_du) ngay_nop_du, max(ngay_bg)ngay_bg, max(ngay_nop) ngay_nop
        FROM ttkd_bct.tam_luuhs_20241013 a 
        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_id, nop_du
      ) a 
  ) a 
group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id,donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20241013_HDID ON nt_tam_luuhs_20241013 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20241013_matb ON nt_tam_luuhs_20241013 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20241013_magd ON nt_tam_luuhs_20241013 (ma_gd ASC) ;


select * from ttkd_bct.nt_tam_luuhs_20241013 where to_char(ngay_nop_du,'yyyymm') >= 202406 ;
/* --------------------------------------------- */
select a.thang_ptm, a.ma_tb, a.nop_du, a.dich_vu, nguon, ngay_luuhs_ttvt, ngay_luuhs_ttkd
from ttkd_bsc.ct_bsc_ptm a where thang_ptm >= 202406 
and nop_du=1 and (a.ngay_luuhs_ttkd is not null or a.ngay_luuhs_ttvt is not null) and dichvuvt_id not in(2) ;

rollback ;

select hdtb_id from ttkd_bsc.ct_bsc_ptm a 
;
/* ----------------------- TEST TRUOC KHI UP -------------------- */

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202406
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm order by nguon, thang_luong, thang_ptm ;

/* --------- UPDATE NGAY 19/05/2023 ------------------ */

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241013', b.nop_du, (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end), (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241013 b where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id and b.nop_du=1 and b.ngay_nop_du is not null
        ) 
-- select a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202406 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and nguon is not null
; 
commit ;

rollback ;
select * from ttkd_bsc.ct_bsc_ptm a where nguon='ptm_codinh_202406' ;


select * from ttkd_bct.nt_tam_luuhs_20241013 a 
where nop_du=1 and to_char(ngay_nop_du,'yyyymmdd') >= '20240601' and ma_gd like 'HCM-LD%'
and exists(select 1 from ttkd_bsc.dt_ptm_vnp_202406 where somay=a.ma_tb) ;

select a.ma_tb, a.ma_gd, ngay_luuhs_ttkd, ngay_luuhs_ttvt, nop_du
from ttkd_bsc.ct_bsc_ptm a
where thang_ptm=202406 and (nop_du is null or nop_du=0)
and nguon='dt_ptm_vnp'
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241013 where ma_tb=a.ma_tb and nop_du=1) ;

select a.ma_tb, a.ma_gd, ngay_luuhs_ttkd, ngay_luuhs_ttvt, nop_du
from ttkd_bsc.ct_bsc_ptm a
where thang_ptm=202406 and (nop_du is null or nop_du=0)
and nguon='dt_ptm_vnp'
and not exists(select 1 from ttkd_bct.nt_tam_luuhs_20241013 where ma_tb=a.ma_tb) ;

/* ---------- UP VINA.TS ----------- */
--select a.thang_ptm, TENKIEU_LD, a.nop_du, a.dich_vu, nguon from ttkd_bsc.ct_bsc_ptm a where thang_ptm >= '202304' and (nop_du is null or nop_du=0) and loaitb_id=20 AND DICH_VU='VNPTS' ;

select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202406 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;


update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20240918',b.nop_du, (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end), (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241013 b where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and nop_du=1 and b.ngay_nop_du is not null) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202406 
-- and mien_hsgoc is null  CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241013 b where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and nop_du=1 and b.ngay_nop_du is not null)  ; 
;
COMMIT ;

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20240918',b.nop_du, (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end), (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20240918_bs b where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and nop_du=1 and b.ngay_nop_du is not null) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202406 
-- and mien_hsgoc is null  CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241013 b where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and nop_du=1 and b.ngay_nop_du is not null)  ; 
;
COMMIT ;
drop table nt_tam_luuhs_20240918_bs purge ;
create table nt_tam_luuhs_20240918_bs as 
select distinct ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, 
       decode(donvi_id_nhap,283466,'TTVT SG',283452,'TTVT CL',283467,'TTVT GD',283451,'TTVT TB',283453,'TTVT BC',283454,'TTVT CC',
                            283455,'TTVT HM',283468,'TTVT NSG',283469,'TTVT TD') ten_ttvt, nop_du, 
       max(ngay_nop_du)ngay_nop_du, min(ngay_bg)ngay_bg
from 
  ( 
   select ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, ngay_nop_du, ngay_bg, ngay_nop, a.nop_du,
         ( case when (select d.donvi_id from admin_hcm.nhanvien c,admin_hcm.donvi b, admin_hcm.donvi d 
                      where c.nhanvien_id=a.nhanvien_id and c.donvi_id=b.donvi_id 
                        and b.donvi_cha_id=d.donvi_id) in(283466,283452,283467,283451,283453,283454,283455,283468,283469) then 'TTVT' else 'TTKD' end
         ) donvi_nhap, nhanvien_id, 
         ( select d.donvi_id from admin_hcm.nhanvien c,admin_hcm.donvi b, admin_hcm.donvi d 
            where c.nhanvien_id=a.nhanvien_id and c.donvi_id=b.donvi_id and b.donvi_cha_id=d.donvi_id
         ) donvi_id_nhap
    from
      (    
        SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, max(ngay_nop_du) ngay_nop_du, max(ngay_bg)ngay_bg, max(ngay_nop) ngay_nop
        FROM ttkd_bct.bangiao_hoso_tinhbsc_20240917 a
        where ECONTRACT_CHANNEL is not null 
        and exists(select 1 from ttkd_bsc.ct_bsc_ptm where thang_ptm >= 202406 and nop_du is null and ma_tb = a.ma_tb)
        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg, nop_du
      ) a 
  ) a 
group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id,donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20240918_bs_HDID ON nt_tam_luuhs_20240918_bs (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20240918_bs_matb ON nt_tam_luuhs_20240918_bs (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20240918_bs_magd ON nt_tam_luuhs_20240918_bs (ma_gd ASC) ;

select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202406 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;


update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241013',b.nop_du, (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end), (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241013 b where b.ma_tb=a.ma_tb and nop_du=1 and b.ngay_nop_du is not null) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202406 
-- and mien_hsgoc is null  CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241013 b where b.ma_tb=a.ma_tb and nop_du=1 and b.ngay_nop_du is not null)  ; 
;
COMMIT ;

select * from ttkd_bct.bangiao_hoso_tinhbsc_20240917 a where ECONTRACT_CHANNEL is not null 
and exists(select 1 from ttkd_bsc.ct_bsc_ptm where thang_ptm >= 202406 and nop_du is null and ma_tb = a.ma_tb)

rollback ;