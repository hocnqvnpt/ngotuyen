/* ----- AP DUNG VB 243 ---------- */

  CREATE TABLE "TTKD_BSC"."BLDG_DANHMUC_VTCV_P1" 
   (	"MA_VTCV" VARCHAR2(20 BYTE), 
	"TEN_VTCV" VARCHAR2(100 BYTE), 
	"P1" NUMBER, 
	"THANG_BD" NUMBER, 
	"THANG_KT" NUMBER, 
	"NGAY_INS" DATE DEFAULT sysdate, 
	"DONGIA" NUMBER, 
	"DINHMUC_1" NUMBER, 
	"DINHMUC_2" NUMBER, 
    "DINHMUC_3" NUMBER, 
	"VANBAN" VARCHAR2(500 BYTE), 
	"GHICHU" VARCHAR2(500 BYTE)
   ) 
;
insert into BLDG_DANHMUC_VTCV_P1 (MA_VTCV, TEN_VTCV, P1, THANG_BD, THANG_KT, NGAY_INS, DONGIA, DINHMUC_1, DINHMUC_2, VANBAN, GHICHU)
select MA_VTCV, TEN_VTCV, P1, THANG_BD, THANG_KT, NGAY_INS, DONGIA, DINHMUC_1, DINHMUC_2, VANBAN, GHICHU 
from ttkd_bsc.BLDG_DANHMUC_VTCV_P11 
;

CREATE TABLE "TTKD_BSC"."DINHMUC_GIAO_DTHU_PTM_202410" 
   (	"THANG" NUMBER, 
	"MA_NV" VARCHAR2(1316 BYTE), 
	"TEN_NV" VARCHAR2(100 BYTE), 
	"MA_TO" VARCHAR2(20 BYTE), 
	"TEN_TO" VARCHAR2(100 BYTE), 
	"TEN_VTCV" VARCHAR2(100 BYTE), 
	"MA_VTCV" VARCHAR2(30 BYTE), 
	"MA_PB" VARCHAR2(20 BYTE), 
	"TEN_PB" VARCHAR2(100 BYTE), 
	"BRCD_DTGIAO" NUMBER, 
	"MYTV_DTGIAO" NUMBER, 
	"VNPTT_DTGIAO" NUMBER, 
	"VNPTS_DTGIAO" NUMBER, 
	"TSL_DTGIAO" NUMBER, 
	"ITT_DTGIAO" NUMBER, 
	"CNTT_DTGIAO" NUMBER, 
	"NHOMBRCD_DTGIAO" NUMBER, 
	"NHOMVINA_DTGIAO" NUMBER, 
	"NHOMTSL_DTGIAO" NUMBER, 
	"NHOMCNTT_DTGIAO" NUMBER, 
	"TONG_DTGIAO" NUMBER, 
	"DATEINPUT" DATE, 
	"DINHMUC_1" NUMBER, 
	"DINHMUC_2" NUMBER, 
	"DINHMUC_3" NUMBER, 
	"KHDK" NUMBER, 
	"TLTH" NUMBER, 
	"KQTH" NUMBER, 
	"HESO_QD_DT_PTM" NUMBER, 
	"LOAI_KPI" VARCHAR2(20 BYTE), 
	"TT_MANV" VARCHAR2(20 BYTE), 
	"NHOMBRCD_KQTH" NUMBER, 
	"NHOMVINATS_KQTH" NUMBER, 
	"NHOMVINATT_KQTH" NUMBER, 
	"NHOMCNTT_KQTH" NUMBER, 
	"NHOMCONLAI_KQTH" NUMBER, 
	"TINH_BSC_OLD" NUMBER, 
	"CANHAN_GIAO" NUMBER, 
	"TINH_BSC" NUMBER
   ) 
;   
select * from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 ;

insert into ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 (THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, tinh_bsc, THAYDOI_VTCV)
select THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB,tinh_bsc, THAYDOI_VTCV
from ttkd_bsc.nhanvien where thang = 202410 and donvi = 'TTKD' 
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set 
                ( BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO
                , NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, KHDK)
=(
    select BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO
         , NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, KHDK
    from
    (
    select distinct a.thang, a.MANV_HRM ma_nv
                    , BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO
                    , NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, nvl(TONG_DTGIAO,0)TONG_DTGIAO
                    , CANHAN_GIAO, DATEINPUT, 0 KHDK
    from (select * from TTKDHCM_KTNV.ID430_DANGKY_CHOTTHANG where thang = 202410) a
    order by 1,2,3
    ) 
    where thang = a.thang and ma_nv = a.ma_nv)
where a.thang = 202410 ;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set (dinhmuc_1, dinhmuc_2, dinhmuc_3)
                                                = (select dinhmuc_1, dinhmuc_2, dinhmuc_3
                                                    from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 b
                                                    where b.thang = 202410 and b.ma_vtcv = a.ma_vtcv)
where a.thang = 202410
;
commit ;
select distinct a.ma_vtcv, a.ten_vtcv from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a 
where not exists(select 1 from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 b
                    where b.thang = 202410 and b.ma_vtcv = a.ma_vtcv)
;
/* ---------- UP LAI TINH_BSC, THAYDOI_VTCV --------------- */

update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set (tinh_bsc_new, thaydoi_vtcv_new)
                                            = (select tinh_bsc, thaydoi_vtcv 
                                                from ttkd_bsc.nhanvien 
                                                where thang = 202410 and donvi = 'TTKD' and ma_nv = a.ma_nv)
where a.thang = 202410 
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set loai_kpi
                                        = ( case when a.ma_vtcv in('VNP-HNHCM_BHKV_27') then 'KPI_CHT_GDV'
                                                 when a.ma_vtcv in('VNP-HNHCM_BHKV_28') then 'KPI_CHT'
                                                 when a.ma_vtcv in('VNP-HNHCM_BHKV_42','VNP-HNHCM_KDOL_5','VNP-HNHCM_BHKV_51'
                                                                  ,'VNP-HNHCM_BHKV_17','VNP-HNHCM_BHKV_52','VNP-HNHCM_KHDN_10','VNP-HNHCM_BHKV_19'
                                                                  ,'VNP-HNHCM_KDOL_10','VNP-HNHCM_KDOL_6','VNP-HNHCM_KDOL_18')
                                                    then 'KPI_TT'
                                                 when ma_vtcv in('VNP-HNHCM_KHDN_4') then 'KPI_TL'
                                                 when ma_vtcv in('VNP-HNHCM_BHKV_2','VNP-HNHCM_BHKV_2.1','VNP-HNHCM_KHDN_2','VNP-HNHCM_KDOL_2') then 'KPI_PGD'
                                                 when ma_vtcv in('VNP-HNHCM_BHKV_1','VNP-HNHCM_KHDN_1','VNP-HNHCM_KDOL_1') then 'KPI_GD'
                                                 when ma_vtcv in('VNP-HNHCM_GP_1') then 'KPI_TP'
                                                 when ma_vtcv in('VNP-HNHCM_GP_2') then 'KPI_PP'
                                              else 'KPI_NV'
                                            end
                                          ) 
where thang = 202410 and loai_kpi is null
;
commit ;
SELECT DISTINCT MA_VTCV, TEN_VTCV, LOAI_KPI FROM ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 ;

SELECT DISTINCT MA_PB, TEN_PB FROM ttkd_bsc.dinhmuc_giao_dthu_ptm_202410  ;
DELETE FROM ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 
WHERE MA_PB IN('VNP0700100','VNP0700200','VNP0700600','VNP0700700','VNP0700900','VNP0700400','VNP0700800','VNP0700500','VNP0700300') ;
COMMIT ;

SELECT DISTINCT MA_VTCV, TEN_VTCV FROM ttkd_bsc.dinhmuc_giao_dthu_ptm_202410
WHERE thang = 202410 and  LOAI_KPI = 'KPI_NV' ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set tt_manv=(select ma_nv from
                                                        ( select distinct ma_nv, ma_to, ten_to, thang
                                                            from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 
                                                            where loai_kpi in('KPI_TT','KPI_CHT','KPI_CHT_GDV','KPI_TL') and thang = 202410                                                        
                                                        ) b
                                                       where b.ma_to=a.ma_to and thang = 202410) 
-- select * from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a
where loai_kpi='KPI_NV' and thang = 202410 and tt_manv is null
--and ma_vtcv in('VNP-HNHCM_BHKV_27','VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_42','VNP-HNHCM_KDOL_5','VNP-HNHCM_BHKV_51'
--              ,'VNP-HNHCM_BHKV_17','VNP-HNHCM_BHKV_52','VNP-HNHCM_KHDN_4')
and tinh_bsc = 1 and thaydoi_vtcv = 0
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set dinhmuc_1='', dinhmuc_2='', dinhmuc_3='' 
where thang = 202410 ;
commit ;

/* -------- CONG DINHMUC VAO TT, TL, CHT ------------ */
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2
                                                           , sum(nvl(dinhmuc_3,0))dinhmuc_3
                                       from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410
                                       where loai_kpi in('KPI_NV') and thang = 202410 
                                         and tinh_bsc = 1 and dinhmuc_1 is not null
                                       group by ma_to, ten_to
                                     ) b
                           where a.ma_to = b.ma_to 
                         )
where thang = 202410 and loai_kpi in('KPI_TT','KPI_CHT') --and tinh_bsc = 1 and thaydoi_vtcv = 0
--and loai_kpi not in('KPI_NV','KPI_CHT_GDV') 
;
commit ;

/* -------- CONG DINHMUC VAO TT, TL, CHT ------------ */
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2
                                                           , sum(nvl(dinhmuc_3,0))dinhmuc_3
                                       from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410
                                       where loai_kpi in('KPI_NV') and thang = 202410 
                                         and tinh_bsc = 1 and dinhmuc_1 is not null
                                         and upper(bo_dau(ten_to)) = 'TO BAN HANG ONLINE'
                                       group by ma_to, ten_to
                                     ) b
                           where a.ma_to = b.ma_to 
                         )
where thang = 202410 and loai_kpi = 'KPI_TT' and upper(bo_dau(ten_to)) = 'TO BAN HANG ONLINE'
--and tinh_bsc = 1 and thaydoi_vtcv = 0
--and loai_kpi not in('KPI_NV','KPI_CHT_GDV') 
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1
                                                            , sum(nvl(dinhmuc_2,0))dinhmuc_2, sum(nvl(dinhmuc_3,0))dinhmuc_3
                                                       from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410
                                                       where loai_kpi in('KPI_NV') and thang = 202410 
                                                         and tinh_bsc = 1 and dinhmuc_1 is not null
                                                         and upper(bo_dau(ten_to)) = 'TO BAN HANG ONLINE'
                                                       group by ma_to, ten_to
                                                     ) b
                                           where a.ma_to = b.ma_to 
                                         )
where thang = 202410 and loai_kpi = 'KPI_TT' and upper(bo_dau(ten_to)) = 'TO BAN HANG ONLINE'
--and tinh_bsc = 1 and thaydoi_vtcv = 0
--and loai_kpi not in('KPI_NV','KPI_CHT_GDV') 
;
commit ;

rollback ;
/* -------- CHT kGDV ------------ */
/*
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =(select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2
                                                   , sum(nvl(dinhmuc_3,0))dinhmuc_3
                                        from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410
                                        where loai_kpi in('KPI_NV','KPI_CHT_GDV') and thang = 202410 
                                          and tinh_bsc = 1 and thaydoi_vtcv = 0 and dinhmuc_1 is not null
                                  --      and tt_manv = 'VNP017619'
                                        group by ma_to, ten_to
                                      ) b
                          where a.ma_to = b.ma_to 
                         )
where loai_kpi in('KPI_CHT_GDV') 
and thang = 202410 
and tinh_bsc = 1 and thaydoi_vtcv = 0
;
commit ;
*/
/* -------------- KHONG GAN GIA TRI KHDK = 0 -------------- */
select * from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a where KHDK = CANHAN_GIAO ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set KHDK = CANHAN_GIAO
where thang = 202410 and CANHAN_GIAO > 0 ;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set KHDK = '' ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set KHDK = CANHAN_GIAO
where thang = 202410 and CANHAN_GIAO > 0 and KHDK = 0 ;
commit ;

/* ------------ UP LAI KHDK = 0 KHI TONG_DTGIAO is null and dinhmuc_1 is not null ----------- */
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set KHDK = 0
-- select * from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 
where thang = 202410 and TONG_DTGIAO is null and KHDK is null ; -- and dinhmuc_1 is not null 
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set KHDK = 0
-- select * from ttkd_bsc.dinhmuc_giao_dthu_ptm
where thang = 202410 and TONG_DTGIAO is null and KHDK is null ; -- and dinhmuc_1 is not null 
commit ;

rollback ;
select * from ttkd_bsc.bldg_danhmuc_vtcv_p1 ;
select * from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 where thang = 202410 ;
commit ;

insert into ttkd_bsc.dinhmuc_giao_dthu_ptm
     (THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO
     , VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO
     , NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, DINHMUC_1, DINHMUC_2, DINHMUC_3, loai_kpi, tt_manv
     , KHDK,tinh_bsc, thaydoi_vtcv, ghichu)

select THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO
    , VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO
    , NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, DINHMUC_1, DINHMUC_2, DINHMUC_3, loai_kpi, tt_manv
    , KHDK,tinh_bsc, thaydoi_vtcv, ghichu
from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (loai_kpi, tt_manv) 
                                        = (select loai_kpi, tt_manv 
                                            from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410
                                            where ma_nv = a.ma_nv and thang = 202410)
where thang = 202410 
;
commit ;
select distinct ma_pb, ten_pb from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 
where thang = 202410
and ma_pb in('VNP0700100','VNP0700200','VNP0700600','VNP0700700','VNP0700900','VNP0700400','VNP0700800','VNP0700500','VNP0700300')
;
/* ------------- XOA CAC PHONG CN --------------- */
delete from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 
where thang = 202410
and ma_pb in('VNP0700100','VNP0700200','VNP0700600','VNP0700700','VNP0700900','VNP0700400','VNP0700800','VNP0700500','VNP0700300')
;
commit ;

/* -------- KIEM TRA VI TRI PGD_PT ----------- */
drop table DINHMUC_GIAO_DTHU_PGDPT purge ;
CREATE TABLE "TTKD_BSC"."DINHMUC_GIAO_DTHU_PGDPT" 
   (	"THANG" NUMBER, 
	"MA_NV" VARCHAR2(1316 BYTE), 
	"TEN_NV" VARCHAR2(100 BYTE), 
	"MA_TO" VARCHAR2(20 BYTE), 
	"TEN_TO" VARCHAR2(100 BYTE), 
	"TEN_VTCV" VARCHAR2(100 BYTE), 
	"MA_VTCV" VARCHAR2(30 BYTE), 
	"MA_PB" VARCHAR2(20 BYTE), 
	"TEN_PB" VARCHAR2(100 BYTE), 
	"BRCD_DTGIAO" NUMBER, 
	"MYTV_DTGIAO" NUMBER, 
	"VNPTT_DTGIAO" NUMBER, 
	"VNPTS_DTGIAO" NUMBER, 
	"TSL_DTGIAO" NUMBER, 
	"ITT_DTGIAO" NUMBER, 
	"CNTT_DTGIAO" NUMBER, 
	"NHOMBRCD_DTGIAO" NUMBER, 
	"NHOMVINA_DTGIAO" NUMBER, 
	"NHOMTSL_DTGIAO" NUMBER, 
	"NHOMCNTT_DTGIAO" NUMBER, 
	"TONG_DTGIAO" NUMBER 
   ) ;
select * from DINHMUC_GIAO_DTHU_PGDPT ;

update DINHMUC_GIAO_DTHU_PGDPT a set MA_TO='', TEN_TO='', TEN_VTCV='', MA_VTCV='', MA_PB='', TEN_PB='' ;
update DINHMUC_GIAO_DTHU_PGDPT a set (ten_nv, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB)
                                =(select ten_nv, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB 
                                    from ttkd_bsc.NHANVIEN where thang = 202410 and ma_nv = a.ma_nv and donvi = 'TTKD')
where thang = 202410
;
commit ;

update DINHMUC_GIAO_DTHU_PGDPT a set NHOMBRCD_DTGIAO = nvl(BRCD_DTGIAO,0)+nvl(MYTV_DTGIAO,0)
                                   , NHOMVINA_DTGIAO = nvl(VNPTT_DTGIAO,0)+nvl(VNPTS_DTGIAO,0)
                                   , NHOMTSL_DTGIAO  = nvl(TSL_DTGIAO,0)+nvl(ITT_DTGIAO,0)
                                   , NHOMCNTT_DTGIAO = nvl(CNTT_DTGIAO,0)
-- select * from DINHMUC_GIAO_DTHU_PGDPT a 
WHERE THANG = 202410
;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a set (BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO
                                          , CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO)
                                    = (select BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO
                                          , CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO
                                        from DINHMUC_GIAO_DTHU_PGDPT where ma_nv = a.ma_nv and thang = 202410)
-- select a.* from ttkd_bsc.dinhmuc_giao_dthu_ptm_202410 a
where thang = 202410 
and exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_nv = a.ma_nv and thang = 202410)
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm  a set TONG_DTGIAO = nvl(NHOMBRCD_DTGIAO,0) + nvl(NHOMVINA_DTGIAO,0) + nvl(NHOMTSL_DTGIAO,0) +nvl(NHOMCNTT_DTGIAO,0)
WHERE THANG = 202410 and tinh_bsc = 1
and exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_nv = a.ma_nv)
;
rollback ;

/* --------------------------------------------------------- */
