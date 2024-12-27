-- drop table TUYENNGO.KPI_BRVNP_001_202410 purge ;
  CREATE TABLE "TUYENNGO"."KPI_BRVNP_001_202410" 
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
	"SL_CODINH" NUMBER, 
	"SL_VNPTS" NUMBER, 
	"TONG_PTM" NUMBER,
    "DINHMUC_GIAO" NUMBER,
    "TY_TRONG" NUMBER,
    "TINH_BSC" NUMBER,
    "THAYDOI_VTCV" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
;

--create table TUYENNGO.KPI_BRVNP_001_202410 as select * from TUYENNGO.KPI_BRVNP_001_202407 ;
-- truncate table TUYENNGO.KPI_BRVNP_001_202410 ;
commit ;
select * from TUYENNGO.KPI_BRVNP_001_202410 ;
TRUNCATE TABLE  TUYENNGO.KPI_BRVNP_001_202410 ;
insert into TUYENNGO.KPI_BRVNP_001_202410 (thang, ma_kpi,ma_vtcv,ten_vtcv,ma_to,ten_to,ma_pb,ten_pb, ma_nv,ten_nv,tinh_bsc,THAYDOI_VTCV)
select distinct 202410 thang, a.ma_kpi, b.ma_vtcv, b.ten_vtcv, c.ma_to, c.ten_to, c.ma_pb, c.ten_pb, c.ma_nv, 
                c.ten_nv, C.TINH_BSC, c.thaydoi_vtcv
from ttkd_bsc.blkpi_danhmuc_kpi a, ttkd_bsc.blkpi_danhmuc_kpi_vtcv b, ttkd_bsc.nhanvien c  
where a.ma_kpi=b.ma_kpi and b.ma_vtcv=c.ma_vtcv       
  and a.thang_kt is null and b.thang_kt is null 
  and a.ma_kpi='HCM_SL_BRVNP_001'
  and a.thang = 202410 and b.thang = 202410 and c.thang = 202410 
--  and c.tinh_bsc = 1 and c.thaydoi_vtcv  = 0 
;
commit ;
select a.* from TUYENNGO.KPI_BRVNP_001_202410 a
where not exists(select 1 from TTKD_BSC.DINHMUC_GIAO_BHOL WHERE THANG = 202410 and ma_nv = a.ma_nv) 
;

select * from TUYENNGO.KPI_BRVNP_001_202410 ;
SELECT * FROM ttkd_bsc.blkpi_danhmuc_kpi_vtcv WHERE ma_kpi='HCM_SL_BRVNP_001' and thang = 202410;
SELECT * from ttkd_bsc.blkpi_danhmuc_kpi WHERE ma_kpi='HCM_SL_BRVNP_001' ;
select * from TUYENNGO.KPI_BRVNP_001_202410 ;
SELECT * FROM TTKD_BSC.DINHMUC_GIAO_BHOL WHERE THANG = 202410 ;

update KPI_BRVNP_001_202410 a set (TY_TRONG, DINHMUC_GIAO) = (SELECT TY_TRONG, DINHMUC_GIAO 
                                                                FROM TTKD_BSC.DINHMUC_GIAO_BHOL
                                                                WHERE MA_NV = A.MA_NV AND THANG = 202410)
WHERE THANG = 202410
;
commit ;
select DISTINCT MA_VTCV, TEN_VTCV from TUYENNGO.KPI_BRVNP_001_202410 ;

update KPI_BRVNP_001_202410 a set loai_kpi = ( case when a.ma_vtcv in('VNP-HNHCM_KDOL_18','VNP-HNHCM_KDOL_23') then 'KPI_TT' 
                                                    when a.ma_vtcv in('VNP-HNHCM_KDOL_2') then 'KPI_PGD' 
                                               else 'KPI_NV' end ) ;
commit ;

update tuyenngo.KPI_BRVNP_001_202410 a set tt_manv=(select ma_nv from
                                                        ( select distinct ma_nv, ma_to
                                                            from tuyenngo.KPI_BRVNP_001_202410 b
                                                            where b.loai_kpi='KPI_TT'                                                             
                                                        )
                                                       where ma_to=a.ma_to
                                                   ) 
where loai_kpi='KPI_NV' 
;
commit ;
rollback ;
update tuyenngo.KPI_BRVNP_001_202410 a set PGD_manv= '' ;

update tuyenngo.KPI_BRVNP_001_202410 a set PGD_manv=(select distinct ma_nv
                                                      from ttkd_bsc.blkpi_dm_to_pgd
                                                      where thang=202410
                                                        and dichvu is null
                                                        and ma_pb = 'VNP0703000'
                                                        and a.ma_to=ma_to
                                                     ) 
where loai_kpi='KPI_NV' 
;
commit ;

select a.* from ttkd_bsc.blkpi_dm_to_pgd a where ma_pb = 'VNP0703000' and thang = 202410 ;
select ma_nv, count(*)sl from TUYENNGO.KPI_BRVNP_001_202410 group by ma_nv ;


rollback ;
select * from tuyenngo.KPI_BRVNP_001_202410 where thang = 202410 ;
select * from nhanvien where thang = 202410 and donvi = 'TTKD' and ma_pb = 'VNP0703000' ;


drop table BHOL_temp purge ;
create table BHOL_temp as 
select manv_ptm, ma_vtcv, ma_to, ma_pb, loai_kpi
     , sum(case when loaitb_id in(58,59) then 1 else 0 end)sl_fiber
     , sum(case when loaitb_id in(61,171) then 1 else 0 end)sl_mytv
     , sum(case when loaitb_id = 20 then 1 else 0 end)sl_vnpts
     , sum(case when dichvuvt_id in(1,10,11) then 1 else 0 end)sl_codinh
     , count(*)sl_ptm 
from 
(
    select thang_ptm, dich_vu, manv_tt_dai, manv_ptm, tennv_ptm, ma_vtcv, ma_to, ten_to, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'LOAI_KPI
    from ttkd_bsc.ct_bsc_ptm 
    where thang_ptm = 202410 
    and ma_pb = 'VNP0703000' 
    and ( dichvuvt_id in(1,10,11) or loaitb_id in(20,58,59,61,171) )
    and trangthaitb_id not in(7,9) 
    and loaihd_id = 1
) group by manv_ptm, ma_vtcv, ma_to, ma_pb, loai_kpi
;
select * from BHOL_temp_to ;
drop table BHOL_temp_to purge ;
create table BHOL_temp_to as 
select ma_to, ma_pb
     , sum(case when loaitb_id in(58,59) then 1 else 0 end)sl_fiber
     , sum(case when loaitb_id in(61,171) then 1 else 0 end)sl_mytv
     , sum(case when loaitb_id = 20 then 1 else 0 end)sl_vnpts
     , sum(case when dichvuvt_id in(1,10,11) then 1 else 0 end)sl_codinh
     , count(*)sl_ptm 
from 
(
    select thang_ptm, ma_tb, manv_tt_dai, manv_ptm, ma_vtcv, ma_to, ma_pb, loaitb_id, dichvuvt_id
    from ttkd_bsc.ct_bsc_ptm 
    where thang_ptm = 202410
    and ma_pb = 'VNP0703000' 
    and ma_to in('VNP0703003','VNP0703005')
    and loaitb_id in(20,58,59,61,171)
    and loaihd_id in(1)
    and trangthaitb_id not in(7,9) 
) group by ma_to, ma_pb
;
select * from css_hcm.loaihinh_tb ;
select manv_ptm, ma_vtcv, ma_to, ma_pb, loai_kpi
     , sum(case when loaitb_id in(58,59) then 1 else 0 end)sl_fiber
     , sum(case when loaitb_id in(61,171) then 1 else 0 end)sl_mytv
     , sum(case when loaitb_id = 20 then 1 else 0 end)sl_vnpts
     , sum(case when dichvuvt_id in(1,10,11) then 1 else 0 end)sl_codinh
     , count(*)sl_ptm 
from 
(
    select thang_ptm, manv_tt_dai, manv_ptm, ma_vtcv, ma_to, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'LOAI_KPI
    from ttkd_bsc.ct_bsc_ptm 
    where thang_ptm = 202410 
    and ma_pb = 'VNP0703000' and ma_to = 'VNP0703003'
    and ( dichvuvt_id in(1,10,11) or loaitb_id in(20,58,59,61,171) )
    and trangthaitb_id not in(7,9) and loaihd_id = 1
) group by manv_ptm, ma_vtcv, ma_to, ma_pb, loai_kpi
;

select * from BHOL_temp ;
select * from tuyenngo.KPI_BRVNP_001_202410 where thang = 202410 ;

--alter table KPI_BRVNP_001_202410 add (sl_fiber number, sl_mytv number, sl_codinh number, sl_vnpts number, tong_ptm number) ;
--commit ;

update KPI_BRVNP_001_202410 a set sl_fiber=0, sl_mytv=0, sl_codinh=0, sl_vnpts=0, tong_ptm = 0 ;
update KPI_BRVNP_001_202410 a set (sl_fiber, sl_mytv, sl_codinh, sl_vnpts,tong_ptm)
                            = ( select nvl(sl_fiber,0),nvl(sl_mytv,0),nvl(sl_codinh,0),nvl(sl_vnpts,0), (nvl(sl_fiber,0) + nvl(sl_mytv,0) + nvl(sl_vnpts,0))
                                from BHOL_temp where manv_ptm = a.ma_nv and ma_vtcv = a.ma_vtcv)
where thang = 202410
;
commit ;
update KPI_BRVNP_001_202410 a set tong_ptm = nvl(sl_fiber,0) + nvl(sl_mytv,0) + nvl(sl_vnpts,0) ;
commit ;
select * from tuyenngo.KPI_BRVNP_001_202410 where thang = 202410 ;

update KPI_BRVNP_001_202410 a set (sl_fiber, sl_mytv, sl_vnpts, tong_ptm)
                                 = ( select sl_fiber, sl_mytv, sl_vnpts, sl_ptm
                                     from BHOL_temp_to b
                                     where b.ma_to = a.ma_to
                                    )
where a.loai_kpi in('KPI_TT') ;
commit ;


select * from ttkd_bsc.ct_bsc_ptm 
where manv_ptm in('CTV082375','CTV087435','VNP016547','VNP016581','VNP016763','VNP017103','VNP017141','VNP017852')
and thang_ptm = 202410
;
rollback ;
update KPI_BRVNP_001_202410 a set (sl_fiber, sl_mytv, sl_vnpts, tong_ptm)
                                 = ( select sum(nvl(sl_fiber,0)), sum(nvl(sl_mytv,0)), sum(nvl(sl_vnpts,0)), sum(nvl(sl_ptm,0))
                                     from BHOL_temp_to b
                                     where exists(select * from ttkd_bsc.blkpi_dm_to_pgd
                                                        where thang=202410
                                                        and ma_pb = 'VNP0703000'
                                                        and ma_kpi = 'HCM_SL_BRVNP_001'
                                                        and ma_to = b.ma_to
                                                    )    
                                    )
where a.loai_kpi = 'KPI_PGD' 
;
commit ;

rollback ;

select * from ttkd_bsc.x_tuyenngo_tl_bsc ;
select * from ttkd_bsc.tuyenngo_tl_bsc ;
-- delete from ttkd_bsc.tuyenngo_tl_bsc where thang = 202411 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000' ;
commit ;
INSERT INTO ttkd_bsc.tuyenngo_tl_bsc(THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, MA_NV, TEN_NV, LOAI_KPI, TL_MANV
                           , SL_FIBER, SL_MYTV, SL_CODINH, SL_VNPTS, TONG_PTM, ty_trong, dinhmuc_giao, tinh_bsc, thaydoi_vtcv)

SELECT THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, MA_NV, TEN_NV, LOAI_KPI, TT_MANV
     , SL_FIBER, SL_MYTV, SL_CODINH, SL_VNPTS, TONG_PTM, ty_trong, dinhmuc_giao, tinh_bsc, thaydoi_vtcv
FROM TUYENNGO.KPI_BRVNP_001_202410 
;
commit ;
;
/*
update ttkd_bsc.tuyenngo_tl_bsc a set (tinh_bsc, thaydoi_vtcv) = (select tinh_bsc, thaydoi_vtcv 
                                                                    from TUYENNGO.KPI_BRVNP_001_202410 where ma_nv = a.ma_nv)
where thang = 202410 
;
commit ;
*/
/* ------------ UP VAO BANG KPI ----------------- */
select * from ttkd_bsc.bangluong_kpi a 
    where thang = 202410 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
update ttkd_bsc.bangluong_kpi a set thuchien = 0
    where thang = 202410 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
commit ; 

update ttkd_bsc.bangluong_kpi a 
        set (thuchien) = (select nvl(tong_ptm,0)
                                from TUYENNGO.KPI_BRVNP_001_202410 
                                where ma_nv = a.ma_nv
                        )
    where thang = 202410 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
commit ; 
select * from ttkd_bsc.blkpi_dm_to_pgd where thang = 202410 and ma_pb = 'VNP0703000' and ma_kpi = 'HCM_SL_BRVNP_001' ;

/* -------- UP COT (GIAO = 1, THUCHIEN = 1) ----------- */
select * from ttkd_bsc.blkpi_danhmuc_kpi where thang = 202410 and ma_kpi = 'HCM_SL_BRVNP_001' ;
select * from ttkd_bsc.bangluong_kpi where thang = 202410 and ma_kpi = 'HCM_SL_BRVNP_001' 
and ma_nv in('CTV082375','CTV087435','VNP016547','VNP016581','VNP016763','VNP017103','VNP017141','VNP017852') ;

/* -------- UP COT DINHMUC_GIAO -> COT GIAO ----------- */
update ttkd_bsc.bangluong_kpi a set giao = (select dinhmuc_giao from ttkd_bsc.dinhmuc_giao_bhol where ma_nv = a.ma_nv and thang = 202411)
where thang = 202411 and ma_kpi = 'HCM_SL_BRVNP_001' ;
commit ;

select a.* from ttkd_bsc.dinhmuc_giao_bhol a where thang = 202411
and not exists(select 1 from ttkd_bsc.bangluong_kpi where ma_nv = a.ma_nv and thang = 202411) ;