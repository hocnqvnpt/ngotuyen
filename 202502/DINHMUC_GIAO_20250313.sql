/* ------------ CHOT NGAY 25 HANG THANG, NGÀY 26 CHẠY SỐ LIỆU -------------- */

/* ----- AP DUNG VB 243 ---------- */

insert into BLDG_DANHMUC_VTCV_P1 (MA_VTCV, TEN_VTCV, P1, THANG, THANG_KT, NGAY_INS, DONGIA, DINHMUC_1, DINHMUC_2, DINHMUC_3, VANBAN, GHICHU)
select MA_VTCV, TEN_VTCV, P1, 202502, THANG_KT, sysdate, DONGIA, DINHMUC_1, DINHMUC_2, DINHMUC_3, VANBAN, GHICHU 
from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 
where thang = 202501
;
commit ;
rollback ;
select * from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 where thang = 202502  ;

/* ------------ TAO BANG DINHMUC_GIAO T N TAM --------------- */
-- drop TABLE DINHMUC_GIAO_DTHU_PTM_202502 purge ;
    CREATE TABLE "TUYENNGO"."DINHMUC_GIAO_DTHU_PTM_202502" 
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
	"TINH_BSC" NUMBER,
    "THAYDOI_VTCV" NUMBER,
    "GHICHU" VARCHAR2(200 BYTE)
   ) 
;   
select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 ;
truncate table tuyenngo.dinhmuc_giao_dthu_ptm_202502 ;

insert into tuyenngo.dinhmuc_giao_dthu_ptm_202502 (THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, tinh_bsc, THAYDOI_VTCV)
select THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, tinh_bsc, THAYDOI_VTCV
from ttkd_bsc.nhanvien 
where thang = 202502 and donvi = 'TTKD' 
and MA_PB not IN('VNP0700100','VNP0700200','VNP0700600','VNP0700700','VNP0700900','VNP0700400','VNP0700500','VNP0700300') 
;
commit ;

/* --------- UP LOAI_KPI ----------- */
update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set loai_kpi = '' ;
update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set loai_kpi
                                        = ( case when a.ma_vtcv in('VNP-HNHCM_BHKV_27') then 'KPI_CHT_GDV'
                                                 when a.ma_vtcv in('VNP-HNHCM_BHKV_28') then 'KPI_CHT'
                                                 when a.ma_vtcv in('VNP-HNHCM_BHKV_42','VNP-HNHCM_KDOL_5','VNP-HNHCM_BHKV_51'
                                                                  ,'VNP-HNHCM_BHKV_17','VNP-HNHCM_BHKV_52','VNP-HNHCM_KHDN_10','VNP-HNHCM_BHKV_19'
                                                                  ,'VNP-HNHCM_KDOL_10','VNP-HNHCM_KDOL_6','VNP-HNHCM_KDOL_18','VNP-HNHCM_KDOL_23')
                                                    then 'KPI_TT'
                                                 when ma_vtcv in('VNP-HNHCM_KHDN_4') then 'KPI_TL'
                                                 when ma_vtcv in('VNP-HNHCM_KDOL_17.1','VNP-HNHCM_KDOL_24.1') then 'KPI_TCA'
                                                 when ma_vtcv in('VNP-HNHCM_BHKV_2','VNP-HNHCM_BHKV_2.1','VNP-HNHCM_KHDN_2','VNP-HNHCM_KDOL_2') 
                                                        then 'KPI_PGD'
                                                 when ma_vtcv in('VNP-HNHCM_BHKV_1','VNP-HNHCM_KHDN_1','VNP-HNHCM_KDOL_1') then 'KPI_GD'
                                                 when ma_vtcv in('VNP-HNHCM_GP_1') then 'KPI_TP'
                                                 when ma_vtcv in('VNP-HNHCM_GP_2') then 'KPI_PP'
                                                 when ma_vtcv = 'VNP-HNHCM_PTTT_1' then 'KPI_TP'
                                              else 'KPI_NV'
                                            end
                                          ) 
where thang = 202502 and loai_kpi is null
;
commit ;
SELECT DISTINCT MA_VTCV, TEN_VTCV, LOAI_KPI FROM tuyenngo.dinhmuc_giao_dthu_ptm_202502 ;

SELECT ma_to, ten_to, count(*)sl
FROM tuyenngo.dinhmuc_giao_dthu_ptm_202502 
where loai_kpi in('KPI_TT','KPI_CHT','KPI_CHT_GDV','KPI_TL') 
group by ma_to, ten_to;


/* -------- UP TT_MANV ---------- */
update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set tt_manv=(select ma_nv from
                                                            ( select distinct ma_nv, ma_to, ten_to, thang
                                                                from tuyenngo.dinhmuc_giao_dthu_ptm_202502 
                                                                where loai_kpi in('KPI_TT','KPI_CHT','KPI_CHT_GDV','KPI_TL') 
                                                                and thang = 202502  -- and ma_nv <> 'VNP017789'
                                                            ) b
                                                           where b.ma_to=a.ma_to and thang = 202502 and ma_nv <> 'VNP027770')
-- select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 a
where loai_kpi='KPI_NV' and thang = 202502 and tt_manv is null and ma_nv <> 'VNP027770'
;
commit ;
select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 where ma_nv = 'VNP027770' ;
delete from tuyenngo.dinhmuc_giao_dthu_ptm_202502 where ma_nv = 'VNP027770' ;

select * from ttkd_bsc.nhanvien
where ma_to in('VNP0701205','VNP0701203') and thang = 202502 and donvi = 'TTKD' ;

select * from ttkd_bsc.nhanvien 
where thang = 202502 
AND ma_vtcv in ('VNP-HNHCM_BHKV_42', 'VNP-HNHCM_BHKV_51', 'VNP-HNHCM_BHKV_52');
/* --------- UPDATE SO GIAO ID430 ------------ */
update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set 
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
        from (select * from TTKDHCM_KTNV.ID430_DANGKY_CHOTTHANG 
                where thang = 202502
                and to_char(dateinput,'yyyymm') = 202503
             ) a
        order by 1,2,3
    ) 
    where thang = a.thang and ma_nv = a.ma_nv
   )
where a.thang = 202502 ;
commit ;

/* ----------- UP DINHMUC -------------- */
select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 ;
select * from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 where thang = 202502 ;

update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set (dinhmuc_1, dinhmuc_2, dinhmuc_3)
                                                 = ( select dinhmuc_1, dinhmuc_2, dinhmuc_3
                                                     from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 b
                                                     where b.thang = a.thang and b.ma_vtcv = a.ma_vtcv
                                                   )
--	select distinct ma_vtcv, DINHMUC_1, DINHMUC_2, DINHMUC_3 from tuyenngo.dinhmuc_giao_dthu_ptm_202502 a                                              
where a.thang = 202502 
and exists(select 1 from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 b
                 where b.thang = 202502 and b.ma_vtcv = a.ma_vtcv) 
;
commit ;
rollback ;

select distinct ma_vtcv
from tuyenngo.dinhmuc_giao_dthu_ptm_202502
where ma_vtcv not in ('VNP-HNHCM_BHKV_42', 'VNP-HNHCM_BHKV_51', 'VNP-HNHCM_BHKV_52','VNP-HNHCM_BHKV_17')
and dinhmuc_1 is not null ;


select ma_vtcv, ten_vtcv, dinhmuc_1, dinhmuc_2, dinhmuc_3
from tuyenngo.dinhmuc_giao_dthu_ptm_202502
where ma_vtcv in ('VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_42', 'VNP-HNHCM_BHKV_51', 'VNP-HNHCM_BHKV_52','VNP-HNHCM_BHKV_17') ;


select ma_vtcv, ten_vtcv, dinhmuc_1, dinhmuc_2, dinhmuc_3
from ttkd_bsc.dinhmuc_giao_dthu_ptm
where thang = 202502 and ma_vtcv in ('VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_42', 'VNP-HNHCM_BHKV_51', 'VNP-HNHCM_BHKV_52','VNP-HNHCM_BHKV_17') ;

/* -------- SUM DINHMUC VAO KPI_CHT_GDV ------------ */
update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set dinhmuc_1 = '' , dinhmuc_2 = '', dinhmuc_3 = ''
where thang = 202502 and loai_kpi in('KPI_CHT_GDV') and ma_vtcv in ('VNP-HNHCM_BHKV_27') 
;
select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502
where thang = 202502 and ma_vtcv in ('VNP-HNHCM_BHKV_27','VNP-HNHCM_BHKV_28') 
;

update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2
                                                           , sum(nvl(dinhmuc_3,0))dinhmuc_3
                         --              select * 
                                       from tuyenngo.dinhmuc_giao_dthu_ptm_202502 b
                                       where ma_vtcv in ('VNP-HNHCM_BHKV_22') -- 'VNP-HNHCM_BHKV_27'
                                         and thang = 202502 
                                         and exists(select 1 from ttkd_bsc.nhanvien where thang = 202502 
                                                        and tinh_bsc = 1 and donvi = 'TTKD' and ma_nv=b.ma_nv ) 
                                         and dinhmuc_1 is not null
                                       group by ma_to, ten_to
                                     ) b
                           where a.ma_to = b.ma_to 
                         )
-- select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502
where thang = 202502 
and ma_vtcv in ('VNP-HNHCM_BHKV_27') -- and loai_kpi in('KPI_CHT_GDV') 
;
commit ;

update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set  dinhmuc_1 = nvl(dinhmuc_1,0) + 6000000 
                                                   ,dinhmuc_2 = nvl(dinhmuc_2,0) + 5000000
                                                   ,dinhmuc_3 = nvl(dinhmuc_3,0) + 4000000
--select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502
where thang = 202502 and loai_kpi in('KPI_CHT_GDV') 
;
commit ; 
rollback ;
/* -------- SUM DINHMUC VAO TT, TL, CHT ------------ */

select distinct ma_vtcv, ten_vtcv from tuyenngo.dinhmuc_giao_dthu_ptm_202502
where thang = 202502
--and loai_kpi in('KPI_CHT_GDV') 
and ma_vtcv in ('VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_42', 'VNP-HNHCM_BHKV_51', 'VNP-HNHCM_BHKV_52','VNP-HNHCM_BHKV_17') ;

update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2
                                                           , sum(nvl(dinhmuc_3,0))dinhmuc_3
                                       from tuyenngo.dinhmuc_giao_dthu_ptm_202502 b
                                       where b.loai_kpi in('KPI_NV') 
                                         and b.thang = 202502 
                                         and exists(select 1 from ttkd_bsc.nhanvien where thang = 202502 
                                                        and tinh_bsc = 1 and donvi = 'TTKD' and ma_nv=b.ma_nv ) 
                                       group by ma_to, ten_to
                                     ) b
                           where a.ma_to = b.ma_to 
                         )
--select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502
where thang = 202502 and loai_kpi in('KPI_TT','KPI_CHT') 
and ma_vtcv in ('VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_42', 'VNP-HNHCM_BHKV_51', 'VNP-HNHCM_BHKV_52','VNP-HNHCM_BHKV_17') ;

commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2
                                                           , sum(nvl(dinhmuc_3,0))dinhmuc_3
                                       from tuyenngo.dinhmuc_giao_dthu_ptm_202502 b
                                       where b.loai_kpi in('KPI_NV') 
                                         and b.thang = 202502 
                                         and exists(select 1 from ttkd_bsc.nhanvien where thang = 202502 
                                                        and tinh_bsc = 1 and donvi = 'TTKD' and ma_nv=b.ma_nv ) 
                                       group by ma_to, ten_to
                                     ) b
                           where a.ma_to = b.ma_to 
                         )
--select * from ttkd_bsc.dinhmuc_giao_dthu_ptm
where thang = 202502 and loai_kpi in('KPI_TT') and ma_vtcv in ('VNP-HNHCM_BHKV_17') ;

commit ;

/* ------------ UP SO GIAO PDG_PT -------------- */
insert into DINHMUC_GIAO_DTHU_PGDPT(THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO
                                  , VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO
                                  , NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO, LOAI_KPI)
select 2025029999, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO
     , TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO, LOAI_KPI 
from DINHMUC_GIAO_DTHU_PGDPT a where thang = 202502 ;
COMMIT ;

DELETE FROM DINHMUC_GIAO_DTHU_PGDPT a where thang = 202502 ;
COMMIT ;
select a.* from DINHMUC_GIAO_DTHU_PGDPT a where thang = 2025029999 ;

select * from DINHMUC_GIAO_DTHU_PGDPT where thang = 202502 ;
--update DINHMUC_GIAO_DTHU_PGDPT a set MA_TO='', TEN_TO='', TEN_VTCV='', MA_VTCV='', MA_PB='', TEN_PB='' ;
update DINHMUC_GIAO_DTHU_PGDPT a set (ten_nv, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB)
                                =(select ten_nv, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB 
                                    from ttkd_bsc.NHANVIEN where thang = 202502 and donvi = 'TTKD' and ma_nv = a.ma_nv )
where thang = 202502
;
commit ;
update DINHMUC_GIAO_DTHU_PGDPT a set NHOMBRCD_DTGIAO = NHOMBRCD_DTGIAO*1000000
                                   , NHOMVINA_DTGIAO = NHOMVINA_DTGIAO*1000000
                                   , NHOMTSL_DTGIAO  = NHOMTSL_DTGIAO*1000000
                                   , NHOMCNTT_DTGIAO = NHOMCNTT_DTGIAO*1000000
                                   , TONG_DTGIAO = TONG_DTGIAO*1000000 
where thang = 202502
;
commit ;

rollback ;

update DINHMUC_GIAO_DTHU_PGDPT a set loai_kpi = '' ;
update DINHMUC_GIAO_DTHU_PGDPT a set loai_kpi
                                        = ( case when a.ma_vtcv in('VNP-HNHCM_BHKV_27') then 'KPI_CHT_GDV'
                                                 when a.ma_vtcv in('VNP-HNHCM_BHKV_28') then 'KPI_CHT'
                                                 when a.ma_vtcv in('VNP-HNHCM_BHKV_42','VNP-HNHCM_KDOL_5','VNP-HNHCM_BHKV_51'
                                                                  ,'VNP-HNHCM_BHKV_17','VNP-HNHCM_BHKV_52','VNP-HNHCM_KHDN_10','VNP-HNHCM_BHKV_19'
                                                                  ,'VNP-HNHCM_KDOL_10','VNP-HNHCM_KDOL_6','VNP-HNHCM_KDOL_18','VNP-HNHCM_KDOL_23')
                                                    then 'KPI_TT'
                                                 when ma_vtcv in('VNP-HNHCM_KHDN_4') then 'KPI_TL'
                                                 when ma_vtcv in('VNP-HNHCM_KDOL_17.1','VNP-HNHCM_KDOL_24.1') then 'KPI_TCA'
                                                 when ma_vtcv in('VNP-HNHCM_BHKV_2','VNP-HNHCM_BHKV_2.1','VNP-HNHCM_KHDN_2','VNP-HNHCM_KDOL_2') 
                                                        then 'KPI_PGD'
                                                 when ma_vtcv in('VNP-HNHCM_BHKV_1','VNP-HNHCM_KHDN_1','VNP-HNHCM_KDOL_1') then 'KPI_GD'
                                                 when ma_vtcv in('VNP-HNHCM_GP_1') then 'KPI_TP'
                                                 when ma_vtcv in('VNP-HNHCM_GP_2') then 'KPI_PP'
                                                 when ma_vtcv = 'VNP-HNHCM_PTTT_1' then 'KPI_TP'                                              
                                            end
                                          ) 
where thang = 202502 and loai_kpi is null
;
commit ;

select ma_to, ten_to, ten_pb, count(*)sl from DINHMUC_GIAO_DTHU_PGDPT a 
where thang = 202502 and loai_kpi is null
group by ma_to, ten_to, ten_pb
;

select a.* from DINHMUC_GIAO_DTHU_PGDPT a 
where thang = 202502 and loai_kpi is null
and exists(select 1 from dinhmuc_giao_dthu_ptm 
            where thang = 202502 and ma_to = a.ma_to 
            and loai_kpi in('KPI_TT','KPI_CHT','KPI_CHT_GDV','KPI_TL')  )
;
update dinhmuc_giao_dthu_ptm a set (NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO)
                          = (select NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO
                                      from ttkd_bsc.DINHMUC_GIAO_DTHU_PGDPT where thang = 202502 and ma_to = a.ma_to and loai_kpi is null)
-- select a.* from dinhmuc_giao_dthu_ptm a
where thang = 202502 
and loai_kpi in('KPI_TT','KPI_TCA','KPI_CHT','KPI_CHT_GDV','KPI_TL')
and exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_to = a.ma_to and loai_kpi is null and thang = 202502)
;

update dinhmuc_giao_dthu_ptm a set NHOMBRCD_DTGIAO='', NHOMVINA_DTGIAO='', NHOMTSL_DTGIAO='', NHOMCNTT_DTGIAO='', TONG_DTGIAO=''
-- select a.* from dinhmuc_giao_dthu_ptm a
where thang = 202502 and loai_kpi in('KPI_TT','KPI_TCA','KPI_CHT','KPI_CHT_GDV','KPI_TL')
and exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_to = a.ma_to and loai_kpi is null and thang = 202502)
;
select a.* from dinhmuc_giao_dthu_ptm a
where thang = 202502 and loai_kpi in('KPI_TT','KPI_TCA','KPI_CHT','KPI_CHT_GDV','KPI_TL')
and NOT exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_to = a.ma_to and loai_kpi is null and thang = 202502)
;
commit ;

select ma_pb, ten_pb, sum(NHOMBRCD_DTGIAO)t1, sum(NHOMVINA_DTGIAO)t2, sum(NHOMTSL_DTGIAO)t3, sum(NHOMCNTT_DTGIAO)t4, sum(TONG_DTGIAO)t5
from dinhmuc_giao_dthu_ptm a
where thang = 202502 and loai_kpi in('KPI_TT','KPI_TCA','KPI_CHT','KPI_CHT_GDV','KPI_TL')
and exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_to = a.ma_to and loai_kpi is null and thang = 202502)
group by ma_pb, ten_pb
;

select ma_pb, ten_pb, sum(NHOMBRCD_DTGIAO)t1, sum(NHOMVINA_DTGIAO)t2, sum(NHOMTSL_DTGIAO)t3, sum(NHOMCNTT_DTGIAO)t4, sum(TONG_DTGIAO)t5
from dinhmuc_giao_dthu_ptm a
where thang = 202502 
and exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_nv = a.ma_nv and thang = 202502)
group by ma_pb, ten_pb
;

rollback ;
select a.* from DINHMUC_GIAO_DTHU_PGDPT a 
where thang = 202502 and loai_kpi is null
and not exists(select 1 from dinhmuc_giao_dthu_ptm 
            where thang = 202502 and ma_to = a.ma_to 
            and loai_kpi in('KPI_TT','KPI_CHT','KPI_CHT_GDV','KPI_TL')  )
;

/*
MA_TO           TEN_TO                  MA_PB               TEN_PB
VNP0701503	Tổ Kinh Doanh Dịch Vụ Cntt	VNP0701500	Phòng Bán Hàng Khu Vực Sài Gòn
VNP0701203	Tổ Kinh Doanh Dịch Vụ Cntt	VNP0701200	Phòng Bán Hàng Khu Vực Chợ Lớn
VNP0702203	Tổ Kinh Doanh Di Động Trả Trước	VNP0702200	Phòng Bán Hàng Khu Vực Củ Chi
VNP07018E0	Tổ Kinh Doanh Địa Bàn 2	VNP0701800	Phòng Bán Hàng Khu Vực Thủ Đức
VNP0701205	Tổ Bán Hàng Online	VNP0701200	Phòng Bán Hàng Khu Vực Chợ Lớn
VNP0703004	Phòng Bán Hàng Online_Tổ Outbound Bán Hàng	VNP0703000	Phòng Bán Hàng Online
*/

merge into ttkd_bsc.dinhmuc_giao_dthu_ptm a
using (select MANV_HRM, DOANHTHU 
            from vietanhvh.x_update_KHDK 
            ) b
on (a.ma_nv=b.MANV_HRM)
when matched then
    update set a.KHDK=b.DOANHTHU
where a.thang = 202502
;
commit ;
update TTKD_BSC.dinhmuc_giao_dthu_ptm a set NHOMBRCD_DTGIAO='', NHOMVINA_DTGIAO='', NHOMTSL_DTGIAO='', NHOMCNTT_DTGIAO='', TONG_DTGIAO=''
-- SELECT * FROM TTKD_BSC.dinhmuc_giao_dthu_ptm a
where thang = 202502 
and exists(select 1 from ttkd_bsc.DINHMUC_GIAO_DTHU_PGDPT where thang = 202502 and ma_nv = a.ma_nv) 
;
update TTKD_BSC.dinhmuc_giao_dthu_ptm a set (NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO)
                                 = (select NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO
                                        from ttkd_bsc.DINHMUC_GIAO_DTHU_PGDPT where thang = 202502 and ma_nv = a.ma_nv)
-- SELECT * FROM TTKD_BSC.dinhmuc_giao_dthu_ptm a
where thang = 202502 
and exists(select 1 from ttkd_bsc.DINHMUC_GIAO_DTHU_PGDPT where thang = 202502 and ma_nv = a.ma_nv) 
;
commit ;
rollback ;

update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set (NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO)
                                 = (select NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO
                                        from ttkd_bsc.DINHMUC_GIAO_DTHU_PGDPT where thang = 202502 and ma_nv = a.ma_nv)
where thang = 202502 
and exists(select 1 from ttkd_bsc.DINHMUC_GIAO_DTHU_PGDPT where thang = 202502 and ma_nv = a.ma_nv) 
;
commit ;
select * from dinhmuc_giao_dthu_ptm where thang = 202502 ;
select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 a 
where thang = 202502 
and exists(select 1 from ttkd_bsc.DINHMUC_GIAO_DTHU_PGDPT where thang = 202502 and ma_nv = a.ma_nv)
and CANHAN_GIAO > 0 ;
commit ;

update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set KHDK = '' ;
update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set KHDK = CANHAN_GIAO
-- select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 a
where thang = 202502 and NVL(CANHAN_GIAO,0) > 0 and nvl(KHDK,0) = 0 ;
commit ;



/* ------------ UP LAI KHDK = 0 KHI TONG_DTGIAO is null and dinhmuc_1 is not null ----------- */
update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set KHDK = TONG_DTGIAO
-- select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 
where thang = 202502 and TONG_DTGIAO > 0 and nvl(KHDK,0) = 0; -- and dinhmuc_1 is not null 
commit ;

update tuyenngo.dinhmuc_giao_dthu_ptm_202502 a set KHDK = 0
-- select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 
where thang = 202502 and TONG_DTGIAO is null and KHDK is null ; -- and dinhmuc_1 is not null 
commit ;

/* ----------- IMP VAO FILE CHINH --------- */
insert into ttkd_bsc.dinhmuc_giao_dthu_ptm
     (THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO
     , VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO
     , NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, DINHMUC_1, DINHMUC_2, DINHMUC_3, loai_kpi, tt_manv
     , KHDK,tinh_bsc, thaydoi_vtcv, ghichu)

select THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO
    , VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO
    , NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, DINHMUC_1, DINHMUC_2, DINHMUC_3, loai_kpi, tt_manv
    , KHDK,tinh_bsc, thaydoi_vtcv, ghichu
from tuyenngo.dinhmuc_giao_dthu_ptm_202502
;
commit ;

/* -------------------- LUU LAI THANG 202502 -------------------- */
insert into ttkd_bsc.dinhmuc_giao_dthu_ptm
     (THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO
     , VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO
     , NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, DINHMUC_1, DINHMUC_2, DINHMUC_3, loai_kpi, tt_manv
     , KHDK,tinh_bsc, thaydoi_vtcv, ghichu)

select 2025029999, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO
    , VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO
    , NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, DINHMUC_1, DINHMUC_2, DINHMUC_3, loai_kpi, tt_manv
    , KHDK,tinh_bsc, thaydoi_vtcv, ghichu
from ttkd_bsc.dinhmuc_giao_dthu_ptm
where thang = 202502 
;
commit ;

select * from ttkd_bsc.dinhmuc_giao_dthu_ptm where thang = 202502 ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set KHDK = TONG_DTGIAO
-- select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 
where thang = 202502 and TONG_DTGIAO > 0 and nvl(KHDK,0) = 0; -- and dinhmuc_1 is not null 
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set KHDK = 0
-- select * from tuyenngo.dinhmuc_giao_dthu_ptm_202502 
where thang = 202502 and TONG_DTGIAO is null and KHDK is null ; -- and dinhmuc_1 is not null 
commit ;

/* ---------------- UP P1 ---------------- */
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set xephang_P1 = (select p1 from ttkd_bsc.dinhmuc_p1 where thang = a.thang and ma_nv =a.ma_nv)
-- select * from ttkd_bsc.dinhmuc_giao_dthu_ptm 
where thang = 202502 
and xephang_p1 is null
; 
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set xephang_p1 = '' where thang = 202502 and xephang_p1 = 0 ;
select ma_nv, count(*)sl from ttkd_bsc.dinhmuc_p1 group by ma_nv having count(*) > 1 ;