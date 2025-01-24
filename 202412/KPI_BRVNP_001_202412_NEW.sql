-- drop table TUYENNGO.KPI_BRVNP_001_202412 purge ;
  CREATE TABLE "TUYENNGO"."KPI_BRVNP_001_202412" 
   (	"THANG" NUMBER, 
	"MA_KPI" VARCHAR2(30 BYTE), 
	"MA_VTCV" VARCHAR2(20 BYTE), 
	"TEN_VTCV" VARCHAR2(200 BYTE), 
	"MA_TO" VARCHAR2(20 BYTE), 
	"TEN_TO" VARCHAR2(200 BYTE), 
	"MA_PB" VARCHAR2(20 BYTE), 
	"TEN_PB" VARCHAR2(200 BYTE), 
	"MA_NV" VARCHAR2(20 BYTE), 
	"TEN_NV" VARCHAR2(200 BYTE), 
	"LOAI_KPI" VARCHAR2(10 BYTE), 
	"TT_MANV" VARCHAR2(20 BYTE), 
    "PGD_MANV" VARCHAR2(20 BYTE), 
	"SL_FIBER" NUMBER, 
	"SL_MYTV" NUMBER, 
	"SL_WFM" NUMBER, 
	"SL_VNPTS" NUMBER, 
    "SL_VNPTT" NUMBER, 
	"TONG_PTM" NUMBER,
    "DINHMUC_GIAO" NUMBER,
    "TY_TRONG" NUMBER,
    "TINH_BSC" NUMBER,
    "THAYDOI_VTCV" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
;

--create table TUYENNGO.KPI_BRVNP_001_202412 as select * from TUYENNGO.KPI_BRVNP_001_202407 ;
-- truncate table TUYENNGO.KPI_BRVNP_001_202412 ;
commit ;
select * from TUYENNGO.KPI_BRVNP_001_202412 ;
TRUNCATE TABLE  TUYENNGO.KPI_BRVNP_001_202412 ;
insert into TUYENNGO.KPI_BRVNP_001_202412 (thang, ma_kpi,ma_vtcv,ten_vtcv,ma_to,ten_to,ma_pb,ten_pb, ma_nv,ten_nv,tinh_bsc,THAYDOI_VTCV)
select distinct a.thang, a.ma_kpi, b.ma_vtcv, b.ten_vtcv, c.ma_to, c.ten_to, c.ma_pb, c.ten_pb, c.ma_nv, 
                c.ten_nv, C.TINH_BSC, c.thaydoi_vtcv
from ttkd_bsc.blkpi_danhmuc_kpi a, ttkd_bsc.blkpi_danhmuc_kpi_vtcv b, ttkd_bsc.nhanvien c  
where a.ma_kpi=b.ma_kpi and b.ma_vtcv=c.ma_vtcv       
  and a.thang_kt is null and b.thang_kt is null 
  and a.ma_kpi='HCM_SL_BRVNP_001'
  and a.thang = 202412 and b.thang = 202412 and c.thang = 202412 
--  and c.ma_nv != 'VNP017740'
--  and c.tinh_bsc = 1 and c.thaydoi_vtcv  = 0 
;
commit ;
select * from ttkd_bsc.blkpi_danhmuc_kpi where ma_kpi='HCM_SL_BRVNP_001' and thang = 202412 ;
select * from ttkd_bsc.blkpi_danhmuc_kpi_vtcv where ma_kpi='HCM_SL_BRVNP_001' and thang = 202412 ;

select THANG, MA_KPI, TEN_KPI, MA_NV, TEN_NV, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, NGAYCONG, TYTRONG, DONVI_TINH, GIAO
from ttkd_bsc.bangluong_kpi a 
where ma_pb = 'VNP0703000' and ma_kpi='HCM_SL_BRVNP_001' and thang = 202412 
and not exists(select 1 from TUYENNGO.KPI_BRVNP_001_202412 WHERE THANG = 202412 and ma_nv = a.ma_nv) 
;
/*-------- UP TYTRONG, DINHMUC_GIAO TU BANGLUONG_KPI --------------- */
update TUYENNGO.KPI_BRVNP_001_202412 a set (ty_trong, dinhmuc_giao) = (select tytrong, giao from ttkd_bsc.bangluong_kpi
                                                                        where ma_pb = 'VNP0703000' and ma_kpi='HCM_SL_BRVNP_001' 
                                                                            and thang = 202412 and ma_nv = a.ma_nv)
WHERE THANG = 202412
;
commit ;

/* ------------------ XOA NHAN VIEN KO GIAO ---------------------- */
delete from TUYENNGO.KPI_BRVNP_001_202412 a
-- select a.* from TUYENNGO.KPI_BRVNP_001_202412 a
WHERE THANG = 202412
and not exists(select 1 from ttkd_bsc.bangluong_kpi 
                WHERE THANG = 202412 and ma_pb = 'VNP0703000' and ma_kpi='HCM_SL_BRVNP_001' and ma_nv = a.ma_nv) 
;
commit ;

select * --THANG, MA_KPI, TEN_KPI, MA_NV, TEN_NV, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, NGAYCONG, TYTRONG, DONVI_TINH, GIAO
from TUYENNGO.KPI_BRVNP_001_202412 a 
where ma_pb = 'VNP0703000' and thang = 202412 
and not exists(select 1 from ttkd_bsc.bangluong_kpi WHERE THANG = 202412 and ma_kpi='HCM_SL_BRVNP_001' and ma_nv = a.ma_nv) 
;

/* ------------------ UP KPI TT, TCA, PGD_PT --------------- */

update KPI_BRVNP_001_202412 a set loai_kpi = ( case when a.ma_vtcv in('VNP-HNHCM_KDOL_18','VNP-HNHCM_KDOL_23') then 'KPI_TT' 
                                                    when ma_vtcv = 'VNP-HNHCM_KDOL_24.1' then 'KPI_TCA'
                                                    when a.ma_vtcv = 'VNP-HNHCM_KDOL_2' then 'KPI_PGD' 
                                              else 'KPI_NV' end ) ;
commit ;

update tuyenngo.KPI_BRVNP_001_202412 a set tt_manv=(select ma_nv from
                                                        ( select distinct ma_nv, ma_to
                                                            from tuyenngo.KPI_BRVNP_001_202412 b
                                                            where b.loai_kpi in('KPI_TT')                                                        
                                                        )
                                                       where ma_to=a.ma_to
                                                   ) 
where loai_kpi='KPI_NV' 
;
commit ;

select a.* from ttkd_bsc.blkpi_dm_to_pgd a where thang = 202412 and ma_pb = 'VNP0703000' ;
select ma_nv, count(*)sl from TUYENNGO.KPI_BRVNP_001_202412 group by ma_nv ;


rollback ;
select * from tuyenngo.KPI_BRVNP_001_202412 where thang = 202412 ;
select * from nhanvien where thang = 202412 and donvi = 'TTKD' and ma_pb = 'VNP0703000' ;
/*
select MA_TB, 'VNPTT' dich_vu, LOAI_TB, 21 loaitb_id, MA_TIEPTHI, THANG_KH
    ,  MANV_PTM, TENNV_PTM, MA_TO_PTM, TEN_TO_PTM, MAPB_PTM, TENPB_PTM, MA_VTCV_PTM, TEN_VTCV_PTM
from manpn.manpn_goi_tonghop_202412@ttkddb a where MAPB_PTM = 'VNP0703000'
    and loai_tb = 'ptm'
;

select ma_tb, dich_vu, manv_ptm, tennv_ptm, ma_pb, ten_pb, ma_to, ten_to, ma_vtcv, ten_vtcv
from ttkd_bsc.ct_bsc_ptm a
    where thang_ptm = 202412
    and ma_pb = 'VNP0703000' 
    and dich_vu = 'VNPTT'
    and loaitb_id = 21
;

SELECT
  a.loaihd_id, a.loaitb_id, a.trangthaitb_id, a.MA_TB, a.MANV_PTM
  , (select x.ma_vtcv from ttkd_bsc.nhanvien x where x.thang = 202412 and a.MANV_PTM =x.ma_nv) MA_VTCV
  , a.MA_PB,  a.TEN_PB,  a.MA_TO,  a.TEN_TO, a.THANG_PTM as thang_ptm
FROM TTKD_BSC.CT_BSC_PTM a
WHERE
 a.dich_vu = 'VNPTT'
 AND a.THANG_PTM in (202412)
 AND a.TENKIEU_LD in ('ptm','Hòa mạng mới di động')
 and a.ma_pb = 'VNP0703000';

--Dạ dữ liệu trong bảng gom đây ạ. tháng 12 này chưa có, chờ VA đổ vào nha a.

*/
select count(sl_vnptt)sl from Tuyenngo.BHOL_temp ;
select count(sl_vnptt)sl from Tuyenngo.BHOL_temp1 ;
select * from Tuyenngo.BHOL_temp ;
select * from Tuyenngo.BHOL_temp1 ;

-- drop table Tuyenngo.BHOL_temp1 purge ;
create table Tuyenngo.BHOL_temp1 as 
select manv_ptm, ma_vtcv, ma_to, ma_pb, loai_kpi
     , sum(case when loaitb_id in(58,59) then 1 else 0 end)sl_fiber
     , sum(case when loaitb_id in(61,171) then 1 else 0 end)sl_mytv
     , sum(case when loaitb_id = 210 then 1 else 0 end)sl_wfm
     , sum(case when loaitb_id = 20 then 1 else 0 end)sl_vnpts
     , sum(case when loaitb_id = 21 then 1 else 0 end)sl_vnptt
--     , count(*)sl_ptm 
from 
(
    select thang_ptm, manv_ptm, tennv_ptm, ma_vtcv, ma_to, ten_to, ma_pb, loaitb_id, dichvuvt_id
           ,( case when ma_vtcv in('VNP-HNHCM_KDOL_18','VNP-HNHCM_KDOL_23') then 'KPI_TT' 
                   when ma_vtcv = 'VNP-HNHCM_KDOL_24.1' then 'KPI_TCA'
                   when ma_vtcv = 'VNP-HNHCM_KDOL_2' then 'KPI_PGD' 
              else 'KPI_NV' end )loai_kpi
    from ttkd_bsc.ct_bsc_ptm a
    where thang_ptm = 202412
    and ma_pb = 'VNP0703000' 
    and loaitb_id in(20,58,59,61,171,210)
    and trangthaitb_id not in(7,9) 
    and loaihd_id = 1
    union all
    SELECT thang_ptm, manv_ptm, tennv_ptm, ma_vtcv, ma_to, ten_to, ma_pb, loaitb_id, dichvuvt_id
        ,( case when ma_vtcv in('VNP-HNHCM_KDOL_18','VNP-HNHCM_KDOL_23') then 'KPI_TT' 
                   when ma_vtcv = 'VNP-HNHCM_KDOL_24.1' then 'KPI_TCA'
                   when ma_vtcv = 'VNP-HNHCM_KDOL_2' then 'KPI_PGD' 
              else 'KPI_NV' end )loai_kpi
    FROM
    (
        select thang_ptm, ma_tb, dich_vu, manv_ptm, tennv_ptm, ma_pb, ten_pb, ma_to, ten_to, ma_vtcv, loaitb_id, dichvuvt_id
        from ttkd_bsc.ct_bsc_ptm a
        where thang_ptm = 202412 
        and ma_pb = 'VNP0703000' 
        and loaitb_id = 21 
        and loaihd_id = 1 and TIEN_DNHM > 0
/*
        select thang_ptm, ma_tb, dich_vu, manv_ptm, tennv_ptm, ma_pb, ten_pb, ma_to, ten_to
            , (select x.ma_vtcv from ttkd_bsc.nhanvien x where x.thang = 202412 and a.MANV_PTM =x.ma_nv)ma_vtcv, loaitb_id, dichvuvt_id
        from ttkd_bsc.ct_bsc_ptm a
        where thang_ptm = 202412
        and ma_pb = 'VNP0703000' 
        and dich_vu = 'VNPTT'
        and loaitb_id = 21
*/
     )

    
) group by manv_ptm, ma_vtcv, ma_to, ma_pb, loai_kpi
;

select * from Tuyenngo.BHOL_temp_to ;
-- drop table Tuyenngo.BHOL_temp_to purge ;
create table Tuyenngo.BHOL_temp_to as 
select ma_to, ma_pb
     , sum(case when loaitb_id in(58,59) then 1 else 0 end)sl_fiber
     , sum(case when loaitb_id in(61,171) then 1 else 0 end)sl_mytv
     , sum(case when loaitb_id = 210 then 1 else 0 end)sl_wfm
     , sum(case when loaitb_id = 20 then 1 else 0 end)sl_vnpts
     , sum(case when loaitb_id = 21 then 1 else 0 end)sl_vnptt
     
from 
(
    select thang_ptm, manv_ptm, ma_vtcv, ma_to, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'LOAI_KPI
    from ttkd_bsc.ct_bsc_ptm 
    where thang_ptm = 202412
    and ma_pb = 'VNP0703000' 
    and ma_to in('VNP0703003','VNP0703005')
    and loaitb_id in(20,58,59,61,171,210)
    and loaihd_id = 1
    and trangthaitb_id not in(7,9) 

    union all

    SELECT thang_ptm, manv_ptm, ma_vtcv, ma_to, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'loai_kpi
    FROM
    (
        select thang_ptm, ma_tb, dich_vu, manv_ptm, tennv_ptm, ma_pb, ten_pb, ma_to, ten_to
            , (select x.ma_vtcv from ttkd_bsc.nhanvien x where x.thang = 202412 and a.MANV_PTM =x.ma_nv)ma_vtcv, loaitb_id, dichvuvt_id
        from ttkd_bsc.ct_bsc_ptm a
        where thang_ptm = 202412
        and ma_pb = 'VNP0703000' 
        and dich_vu = 'VNPTT'
        and loaitb_id = 21
     )

) group by ma_to, ma_pb
;

select * from Tuyenngo.BHOL_temp ;
select * from tuyenngo.KPI_BRVNP_001_202412 where thang = 202412 ;

--alter table KPI_BRVNP_001_202412 add (sl_fiber number, sl_mytv number, sl_codinh number, sl_vnpts number, tong_ptm number) ;
--commit ;
/* ------------ up so thuc hien theo ma_nv ---------------- */
update KPI_BRVNP_001_202412 a set sl_fiber=0, sl_mytv=0, sl_wfm=0, sl_vnpts=0, sl_vnptt=0, tong_ptm = 0 ;
update KPI_BRVNP_001_202412 a set (sl_fiber, sl_mytv, sl_wfm, sl_vnpts, sl_vnptt, tong_ptm)
                            = ( select nvl(sl_fiber,0), nvl(sl_mytv,0), nvl(sl_wfm,0), nvl(sl_vnpts,0), nvl(sl_vnptt,0)
                                    , (nvl(sl_fiber,0) + nvl(sl_mytv,0) + round(nvl(sl_wfm,0)/2,0) + nvl(sl_vnpts,0) + nvl(sl_vnptt,0))
                                from Tuyenngo.BHOL_temp where manv_ptm = a.ma_nv and ma_vtcv = a.ma_vtcv)
where thang = 202412
;
commit ;
select * from tuyenngo.KPI_BRVNP_001_202412 where thang = 202412 ;
/* ------------ up so thuc hien theo ma_to ---------------- */

update KPI_BRVNP_001_202412 a set (sl_fiber, sl_mytv, sl_wfm, sl_vnpts, sl_vnptt, tong_ptm)
                                 = ( select sl_fiber, sl_mytv, sl_wfm, sl_vnpts, sl_vnptt
                                         , (nvl(sl_fiber,0) + nvl(sl_mytv,0) + round(nvl(sl_wfm,0)/2,0) + nvl(sl_vnpts,0) + nvl(sl_vnptt,0))
                                     from Tuyenngo.BHOL_temp_to b
                                     where b.ma_to = a.ma_to
                                    )
where a.loai_kpi in('KPI_TT','KPI_TCA') ;
commit ;
select * from tuyenngo.KPI_BRVNP_001_202412 where thang = 202412 ;
/* ------------ cong so thuc hien theo ma_to cho PGD ---------------- */

update KPI_BRVNP_001_202412 a set (sl_fiber, sl_mytv, sl_wfm, sl_vnpts, sl_vnptt, tong_ptm)
                                 = ( select sum(nvl(sl_fiber,0)), sum(nvl(sl_mytv,0)), sum(nvl(sl_wfm,0))
                                          , sum(nvl(sl_vnpts,0)), sum(nvl(sl_vnptt,0)), sum(nvl(tong_ptm,0))
                                     from KPI_BRVNP_001_202412 b
                                     where loai_kpi in('KPI_TT')
                                    )
where a.loai_kpi = 'KPI_PGD' 
;
commit ;
select * from tuyenngo.KPI_BRVNP_001_202412 where thang = 202412 ;

select * from ttkd_bsc.blkpi_dm_to_pgd
where thang=202412
and dichvu is null
and ma_pb = 'VNP0703000'
;

select * from ttkd_bsc.blkpi_dm_to_pgd where ma_pb = 'VNP0703000' and thang = 202412 ;


select * from ttkd_bsc.x_tuyenngo_tl_bsc ;
select * from ttkd_bsc.tuyenngo_tl_bsc where thang = 202412 and ma_kpi = 'HCM_SL_BRVNP_001' ;
--delete from ttkd_bsc.tuyenngo_tl_bsc where thang = 202412 and ma_kpi = 'HCM_SL_BRVNP_001' ;
--commit ;
--rollback ;
INSERT INTO ttkd_bsc.tuyenngo_tl_bsc(THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, MA_NV, TEN_NV, LOAI_KPI, TL_MANV
                           , SL_FIBER, SL_MYTV, SL_WFM, SL_VNPTS, SL_VNPTT, TONG_PTM, ty_trong, dinhmuc_giao, tinh_bsc, thaydoi_vtcv)

SELECT THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, MA_NV, TEN_NV, LOAI_KPI, TT_MANV
     , SL_FIBER, SL_MYTV, SL_WFM, SL_VNPTS, SL_VNPTT, TONG_PTM, ty_trong, dinhmuc_giao, tinh_bsc, thaydoi_vtcv
FROM TUYENNGO.KPI_BRVNP_001_202412 
;
commit ;
;
/*
update ttkd_bsc.tuyenngo_tl_bsc a set (tinh_bsc, thaydoi_vtcv) = (select tinh_bsc, thaydoi_vtcv 
                                                                    from TUYENNGO.KPI_BRVNP_001_202412 where ma_nv = a.ma_nv)
where thang = 202412 
;
commit ;
*/
/* ------------ UP VAO BANG KPI ----------------- */
select * from ttkd_bsc.bangluong_kpi a 
    where thang = 202412 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
/* ---------- NGAY 10/12/2024 HOC YC DELETE 03 BAN NAY, CO NHU Y LAM CHUNG --------------- */
update ttkd_bsc.bangluong_kpi a 
        set thuchien = ''
 where thang = 202412 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
commit ; 

update ttkd_bsc.bangluong_kpi a 
        set thuchien = (select nvl(tong_ptm,0) from TUYENNGO.KPI_BRVNP_001_202412 where ma_nv = a.ma_nv )
    where thang = 202412 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
commit ; 

/* -------- UP COT (GIAO = 1, THUCHIEN = 1) ----------- */
select * from ttkd_bsc.blkpi_danhmuc_kpi where thang = 202412 and ma_kpi = 'HCM_SL_BRVNP_001' ;
select * from ttkd_bsc.bangluong_kpi where thang = 202412 and ma_kpi = 'HCM_SL_BRVNP_001' 
and ma_nv in('CTV082375','CTV087435','VNP016547','VNP016581','VNP016763','VNP017103','VNP017141','VNP017852') ;

/* ------------- UP VAO BANG LUONG ----------------- */
select * from bangluong_kpi_bhol_luu where thang = 202412 and nvl(thuchien,0) > 0 ;
select * from bangluong_kpi_bhol_luu where nvl(mucdo_hoanthanh,0) > 0 ;

select * from bangluong_kpi_bhol_luu a
where not exists(select 1 from bangluong_kpi_bhol where thang = a.thang and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
;

select * from bangluong_kpi_bhol where thang = 202412 and nvl(mucdo_hoanthanh,0) > 0  ;
rollback ;

update bangluong_kpi_bhol a set thuchien = (select thuchien from bangluong_kpi_bhol_luu    
                                                where nvl(thuchien,0) > 0 
                                                    and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
-- select * from bangluong_kpi_bhol_luu a
where a.thang = 202412 
and exists(select 1 from bangluong_kpi_bhol_luu where nvl(thuchien,0) > 0 
            and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
;
commit ;

update bangluong_kpi_bhol a set tyle_thuchien = (select tyle_thuchien from bangluong_kpi_bhol_luu    
                                                where nvl(tyle_thuchien,0) > 0 
                                                    and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
-- select * from bangluong_kpi_bhol_luu a
where a.thang = 202412 
and exists(select 1 from bangluong_kpi_bhol_luu where nvl(tyle_thuchien,0) > 0 
            and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
;
commit ;

update bangluong_kpi_bhol a set mucdo_hoanthanh = (select nvl(mucdo_hoanthanh,0) from bangluong_kpi_bhol_luu    
                                                    where nvl(mucdo_hoanthanh,0) > 0 
                                                        and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang )
-- select * from bangluong_kpi_bhol_luu a
where a.thang = 202412 
and exists(select 1 from bangluong_kpi_bhol_luu where nvl(mucdo_hoanthanh,0) > 0 
            and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
;
commit ;

update bangluong_kpi_bhol a set diem_cong = (select diem_cong from bangluong_kpi_bhol_luu    
                                                    where ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang )
-- select * from bangluong_kpi_bhol_luu a
where a.thang = 202412 
and exists(select 1 from bangluong_kpi_bhol_luu where ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
;
commit ;

update bangluong_kpi_bhol a set diem_tru = (select diem_tru from bangluong_kpi_bhol_luu    
                                                    where ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang )
-- select * from bangluong_kpi_bhol_luu a
where a.thang = 202412 
and exists(select 1 from bangluong_kpi_bhol_luu where ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
;
commit ;

/* ------------ UP VAO BANGLUONG_KPI ------------- */

select * from ttkd_bsc.bangluong_kpi a where thang = 202412 and ma_pb = 'VNP0703000' ;
update ttkd_bsc.bangluong_kpi a set mucdo_hoanthanh = (select mucdo_hoanthanh from bangluong_kpi_bhol    
                                                where thang = 202412 and nvl(mucdo_hoanthanh,0) > 0
                                                    and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
-- select * from ttkd_bsc.bangluong_kpi a 
where thang = 202412 and ma_pb = 'VNP0703000'
and exists(select 1 from bangluong_kpi_bhol where nvl(mucdo_hoanthanh,0) > 0 
            and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
;

update ttkd_bsc.bangluong_kpi a set thuchien = (select thuchien from bangluong_kpi_bhol    
                                                where thang = 202412 and nvl(thuchien,0) > 0 
                                                    and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
-- select * from ttkd_bsc.bangluong_kpi a
where thang = 202412 and ma_pb = 'VNP0703000' 
and exists(select 1 from bangluong_kpi_bhol_luu where nvl(thuchien,0) > 0 
            and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
;

update ttkd_bsc.bangluong_kpi a set diem_cong = (select diem_cong from bangluong_kpi_bhol    
                                                where thang = 202412 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
-- select * from ttkd_bsc.bangluong_kpi a
where thang = 202412 and ma_pb = 'VNP0703000' 
and exists(select 1 from bangluong_kpi_bhol_luu where ma_nv = a.ma_nv and ma_kpi = a.ma_kpi and thang = a.thang)
;

commit ;
