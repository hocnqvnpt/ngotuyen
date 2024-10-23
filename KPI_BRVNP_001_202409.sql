-- drop table TUYENNGO.KPI_BRVNP_001_202409 purge ;
  CREATE TABLE "TUYENNGO"."KPI_BRVNP_001_202409" 
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

--create table TUYENNGO.KPI_BRVNP_001_202409 as select * from TUYENNGO.KPI_BRVNP_001_202407 ;
-- truncate table TUYENNGO.KPI_BRVNP_001_202409 ;
commit ;
select * from TUYENNGO.KPI_BRVNP_001_202409 ;
TRUNCATE TABLE  TUYENNGO.KPI_BRVNP_001_202409 ;
insert into TUYENNGO.KPI_BRVNP_001_202409 (thang, ma_kpi,ma_vtcv,ten_vtcv,ma_to,ten_to,ma_pb,ten_pb, ma_nv,ten_nv,tinh_bsc,THAYDOI_VTCV)
select distinct 202409 thang, a.ma_kpi, b.ma_vtcv, b.ten_vtcv, c.ma_to, c.ten_to, c.ma_pb, c.ten_pb, c.ma_nv, 
                c.ten_nv, C.TINH_BSC, c.thaydoi_vtcv
from ttkd_bsc.blkpi_danhmuc_kpi a, ttkd_bsc.blkpi_danhmuc_kpi_vtcv b, ttkd_bsc.nhanvien c  
where a.ma_kpi=b.ma_kpi and b.ma_vtcv=c.ma_vtcv       
  and a.thang_kt is null and b.thang_kt is null 
  and a.ma_kpi='HCM_SL_BRVNP_001'
  and a.thang = 202409 and B.thang = 202409 and c.thang = 202409 
--  and c.tinh_bsc = 1 and c.thaydoi_vtcv  = 0 
;
commit ;
SELECT * FROM ttkd_bsc.blkpi_danhmuc_kpi_vtcv WHERE ma_kpi='HCM_SL_BRVNP_001' ;
SELECT * from ttkd_bsc.blkpi_danhmuc_kpi WHERE ma_kpi='HCM_SL_BRVNP_001' ;
select * from TUYENNGO.KPI_BRVNP_001_202409 ;
update KPI_BRVNP_001_202409 a set (TY_TRONG, DINHMUC_GIAO) = (SELECT TY_TRONG, DINHMUC_GIAO 
                                                                FROM TTKD_BSC.DINHMUC_GIAO_BHOL
                                                                WHERE MA_NV = A.MA_NV)
WHERE LOAI_KPI = 'KPI_NV'
;
commit ;
update KPI_BRVNP_001_202409 a set loai_kpi = ( case when a.ma_vtcv = 'VNP-HNHCM_KDOL_6' then 'KPI_TT' else 'KPI_NV' end ) ;
commit ;

update tuyenngo.KPI_BRVNP_001_202409 a set tt_manv=(select ma_nv from
                                                        ( select distinct ma_nv, ma_to
                                                            from tuyenngo.KPI_BRVNP_001_202409 b
                                                            where b.loai_kpi='KPI_TT' 
                                                         --   and ma_to = b.ma_to
                                                        )
                                                   --    where ma_to=a.ma_to
                                                   ) 
where loai_kpi='KPI_NV' 
;
commit ;

rollback ;
select * from tuyenngo.KPI_BRVNP_001_202409 where thang = 202409 ;
select * from nhanvien where thang = 202409 and donvi = 'TTKD' and ma_pb = 'VNP0703000' ;

/*
Nhân viên OB Telesale (OA)
Nhân viên OB Telesale (OB CSKH VNPTT vào gói)
Nhân viên OB Telesale (OB Ti?p th? BÁN HÀNG)
Nhân viên OB Telesale (OB Ti?p th? CKD, CKN vào gói), T? Tr??ng t? OB Telesale
nhân viên Telesale chia làm 3 nhóm
*/
drop table BHOL_temp purge ;
create table BHOL_temp as 
select manv_ptm, ma_vtcv, ma_pb, loai_kpi
     , sum(case when loaitb_id in(58,59) then 1 else 0 end)sl_fiber
     , sum(case when loaitb_id in(61,171) then 1 else 0 end)sl_mytv
     , sum(case when loaitb_id = 20 then 1 else 0 end)sl_vnpts
     , sum(case when dichvuvt_id in(1,10,11) then 1 else 0 end)sl_codinh
     , count(*)sl_ptm 
from 
(
    select thang_ptm, manv_tt_dai, manv_ptm, ma_vtcv, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'LOAI_KPI
    from ttkd_bsc.ct_bsc_ptm 
    where thang_ptm = 202409 
    and ma_pb = 'VNP0703000' 
    and ( dichvuvt_id in(1,10,11) or loaitb_id in(20,58,59,61,171) )
    and trangthaitb_id not in(7,9) 
) group by manv_ptm, ma_vtcv, ma_pb, loai_kpi
;

select * from BHOL_temp ;
select * from tuyenngo.KPI_BRVNP_001_202409 where thang = 202409 ;

--alter table KPI_BRVNP_001_202409 add (sl_fiber number, sl_mytv number, sl_codinh number, sl_vnpts number, tong_ptm number) ;
--commit ;

update KPI_BRVNP_001_202409 a set sl_fiber=0, sl_mytv=0, sl_codinh=0, sl_vnpts=0, tong_ptm = 0 ;
update KPI_BRVNP_001_202409 a set (sl_fiber, sl_mytv, sl_codinh, sl_vnpts,tong_ptm)
                            = ( select nvl(sl_fiber,0),nvl(sl_mytv,0),nvl(sl_codinh,0),nvl(sl_vnpts,0), (nvl(sl_fiber,0) + nvl(sl_mytv,0) + nvl(sl_vnpts,0))
                                from BHOL_temp where manv_ptm = a.ma_nv and ma_vtcv = a.ma_vtcv)
where thang = 202409
;
commit ;
update KPI_BRVNP_001_202409 a set tong_ptm = nvl(sl_fiber,0) + nvl(sl_mytv,0) + nvl(sl_vnpts,0) ;
commit ;
select * from tuyenngo.KPI_BRVNP_001_202409 where thang = 202409 ;

update KPI_BRVNP_001_202409 a set (sl_fiber, sl_mytv, sl_vnpts, tong_ptm)
                                 = ( select sl_fiber, sl_mytv, sl_vnpts, tong_ptm 
                                     from ( select ma_to, sum(nvl(sl_fiber,0))sl_fiber, sum(nvl(sl_mytv,0))sl_mytv
                                                , sum(nvl(sl_vnpts,0))sl_vnpts, sum(nvl(tong_ptm,0))tong_ptm
                                            from tuyenngo.KPI_BRVNP_001_202409 
                                            where tinh_bsc = 1 and thaydoi_vtcv = 0
                                            group by ma_to -- tt_manv
                                          ) b
                                     where b.ma_to = a.ma_to
                                    )-- b.tt_manv = a.ma_nv and b.tt_manv is not null
where a.loai_kpi = 'KPI_TT';
commit ;
rollback ;
update KPI_BRVNP_001_202409 a set dinhmuc_giao = 20, 
                                    ty_trong = (case when ma_vtcv = 'VNP-HNHCM_KDOL_17' then 20
                                                        when ma_vtcv = 'VNP-HNHCM_KDOL_3' then 10
                                                end)
where thang = 202409 and loai_kpi != 'KPI_TT' ;
update KPI_BRVNP_001_202409 a set dinhmuc_giao = 40, ty_trong = 20 where thang = 202409 and loai_kpi = 'KPI_TT' ;
--create table ttkd_bsc.x_tuyenngo_tl_bsc as select * from ttkd_bsc.tuyenngo_tl_bsc ;
select * from ttkd_bsc.x_tuyenngo_tl_bsc ;
select * from ttkd_bsc.tuyenngo_tl_bsc ;

INSERT INTO ttkd_bsc.tuyenngo_tl_bsc(THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, MA_NV, TEN_NV, LOAI_KPI, TL_MANV
                           , SL_FIBER, SL_MYTV, SL_CODINH, SL_VNPTS, TONG_PTM, ty_trong, dinhmuc_giao, tinh_bsc, thaydoi_vtcv)

SELECT THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, MA_NV, TEN_NV, LOAI_KPI, TT_MANV
     , SL_FIBER, SL_MYTV, SL_CODINH, SL_VNPTS, TONG_PTM, ty_trong, dinhmuc_giao, tinh_bsc, thaydoi_vtcv
FROM TUYENNGO.KPI_BRVNP_001_202409 
;
commit ;
;
/*
update ttkd_bsc.tuyenngo_tl_bsc a set (tinh_bsc, thaydoi_vtcv) = (select tinh_bsc, thaydoi_vtcv 
                                                                    from TUYENNGO.KPI_BRVNP_001_202409 where ma_nv = a.ma_nv)
where thang = 202409 
;
commit ;
*/
/* ------------ UP VAO BANG KPI ----------------- */
select * from ttkd_bsc.bangluong_kpi a 
    where thang = 202409 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;

update ttkd_bsc.bangluong_kpi a 
        set (giao, thuchien) = (select dinhmuc_giao, nvl(tong_ptm,0)
                                from TUYENNGO.KPI_BRVNP_001_202409 
                                where tong_ptm > 0 and tinh_bsc = 1 and thaydoi_vtcv = 0
                                and ma_nv = a.ma_nv
                        )
    where thang = 202409 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
commit ; 
/* -------- UP COT (GIAO = 1, THUCHIEN = 1) ----------- */
select * from ttkd_bsc.blkpi_danhmuc_kpi where thang = 202409 and ma_kpi = 'HCM_SL_BRVNP_001' ;

