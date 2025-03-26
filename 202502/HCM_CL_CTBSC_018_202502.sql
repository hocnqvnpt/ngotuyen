/* ---------- UP SO GIAO ----------- */
select * from ttkd_bsc.bangluong_kpi where thang=202502 and ma_kpi='HCM_CL_CTBSC_018' ;
select * from ttkd_bsc.nhanvien where thang = 202502 ;

select THANG, MA_KPI, TEN_KPI, MA_NV, TEN_NV, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB
    , NGAYCONG, TYTRONG, DONVI_TINH, CHITIEU_GIAO, MUCDO_HOANTHANH
from ttkd_bsc.bangluong_kpi where thang=202502 and ma_kpi='HCM_CL_CTBSC_018' ;

select distinct MA_VTCV, TEN_VTCV from ttkd_bsc.bangluong_kpi where thang=202502 and ma_kpi='HCM_CL_CTBSC_018' ;

update ttkd_bsc.bangluong_kpi a set giao = '', CHITIEU_GIAO = 100, tytrong = 10, DONVI_TINH ='%'
where thang=202502 
and ma_kpi='HCM_CL_CTBSC_018' 
;
commit ;
select * from ttkd_bsc.blkpi_danhmuc_kpi where thang = 202502 and ma_kpi = 'HCM_CL_CTBSC_018' ;


-- drop table TUYENNGO.KPI_CL_CTBSC_018 purge ;
  CREATE TABLE "TUYENNGO"."KPI_CL_CTBSC_018" 
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
	"MDHT" NUMBER, 
	"KQTH" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
;

--create table TUYENNGO.KPI_CL_CTBSC_018 as select * from TUYENNGO.KPI_BRVNP_001_202407 ;
-- truncate table TUYENNGO.KPI_CL_CTBSC_018 ;
commit ;
select * from TUYENNGO.KPI_CL_CTBSC_018 ;
TRUNCATE TABLE  TUYENNGO.KPI_CL_CTBSC_018 ;
insert into TUYENNGO.KPI_CL_CTBSC_018 (thang, ma_kpi,ma_vtcv,ten_vtcv,ma_to,ten_to,ma_pb,ten_pb, ma_nv,ten_nv)
select distinct a.thang, a.ma_kpi, b.ma_vtcv, b.ten_vtcv, c.ma_to, c.ten_to, c.ma_pb, c.ten_pb, c.ma_nv, c.ten_nv
from ttkd_bsc.blkpi_danhmuc_kpi a, ttkd_bsc.blkpi_danhmuc_kpi_vtcv b, ttkd_bsc.nhanvien c  
where a.ma_kpi=b.ma_kpi and b.ma_vtcv=c.ma_vtcv       
  and a.thang_kt is null and b.thang_kt is null 
  and a.ma_kpi='HCM_CL_CTBSC_018'
  and a.thang = 202502 and b.thang = 202502 and c.thang = 202502 
--  and c.ma_nv != 'VNP017740'
--  and c.tinh_bsc = 1 and c.thaydoi_vtcv  = 0 
;
commit ;
select * from TUYENNGO.KPI_CL_CTBSC_018 ;
