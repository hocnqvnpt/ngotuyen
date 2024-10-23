
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
drop table DINHMUC_GIAO_DTHU_PTM_TEMP purge ;
CREATE TABLE "TTKD_BSC"."DINHMUC_GIAO_DTHU_PTM_TEMP" 
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
    "CANHAN_GIAO" NUMBER, 
	"DATEINPUT" DATE DEFAULT sysdate, 
	"DINHMUC_1" NUMBER, 
	"DINHMUC_2" NUMBER, 
	"DINHMUC_3" NUMBER, 
	"KHDK" NUMBER, 
	"TLTH" NUMBER, 
	"KQTH" NUMBER,
	"HESO_QD_DT_PTM" NUMBER, 
	"LOAI_KPI" VARCHAR2(20 BYTE), 
	"TT_MANV" VARCHAR2(20 BYTE),
    "TINH_BSC" NUMBER
   ) ;


select * from ttkd_bsc.dinhmuc_giao_dthu_ptm_temp ;

insert into ttkd_bsc.dinhmuc_giao_dthu_ptm_temp (THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, tinh_bsc)
select THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB,tinh_bsc
from ttkd_bsc.nhanvien where thang = 202409 and donvi = 'TTKD' 
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm_temp a set 
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
    from (select a.*, rank() over (partition by a.manv_hrm order by a.dateinput desc) rnk 
          from ttkdhcm_ktnv.ID430_DANGKY_CHOTTHANG a where a.thang = 202409) a
    where rnk = 1 
    --and manv_hrm in('VNP017601','VNP017604','VNP017622','VNP017721','VNP017813','VNP017853','VNP019529','VNP019931','VNP020231','VNP017014')
    order by 1,2,3
    ) 
    where thang = a.thang and ma_nv = a.ma_nv)
where a.thang = 202409 ;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm_temp a set dinhmuc_1='', dinhmuc_2='', dinhmuc_3='' 
where thang = 202409 ;
commit ;

/* -------------- KHONG GAN GIA TRI KHDK = 0 -------------- */
-- delete from ttkd_bsc.dinhmuc_giao_dthu_ptm where thang = 202409 ;
-- commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm set KHDK = 0
where thang = 202409 ;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set tinh_bsc_new = '' 
where thang = 202409 ;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set tinh_bsc_new = (select tinh_bsc from ttkd_bsc.nhanvien where thang = 202409 and ma_nv = a.ma_nv and donvi = 'TTKD')
where thang = 202409 and exists(select 1 from ttkd_bsc.nhanvien where thang = 202409 and ma_nv = a.ma_nv and donvi = 'TTKD') ;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm_202409 a set tinh_bsc_new = (select tinh_bsc from ttkd_bsc.nhanvien where thang = 202409 and ma_nv = a.ma_nv and donvi = 'TTKD')
where thang = 202409 and exists(select 1 from ttkd_bsc.nhanvien where thang = 202409 and ma_nv = a.ma_nv and donvi = 'TTKD') ;
commit ;

create table ttkd_bsc.dinhmuc_giao_dthu_ptm_202409 as select * from ttkd_bsc.dinhmuc_giao_dthu_ptm ;
select ma_nv, count(*)sl from ttkd_bsc.nhanvien where thang = 202409 group by ma_nv having count(*)> 1 ;

--alter table ttkd_bsc.dinhmuc_giao_dthu_ptm add CANHAN_GIAO number ;
--commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set KHDK = nvl(CANHAN_GIAO,0)
where thang = 202409 and CANHAN_GIAO > 0 ;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set KHDK = nvl(TONG_DTGIAO,0)
where thang = 202409 and CANHAN_GIAO = 0 and KHDK = 0 ;
commit ;
rollback ;

select * from ttkd_bsc.bldg_danhmuc_vtcv_p1 ;
select * from ttkd_bsc.dinhmuc_giao_dthu_ptm where thang = 202409 ;
commit ;

insert into ttkd_bsc.dinhmuc_giao_dthu_ptm
     (THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO
     , VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO
     , NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, DINHMUC_1, DINHMUC_2, DINHMUC_3, KHDK,tinh_bsc)

select THANG, MA_NV, TEN_NV, MA_TO, TEN_TO, TEN_VTCV, MA_VTCV, MA_PB, TEN_PB, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO
    , VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO
    , NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT, DINHMUC_1, DINHMUC_2, DINHMUC_3, KHDK,tinh_bsc
from ttkd_bsc.dinhmuc_giao_dthu_ptm_temp
;
commit ;

select distinct ma_pb, ten_pb from ttkd_bsc.dinhmuc_giao_dthu_ptm 
where thang = 202409
and ma_pb in('VNP0700100','VNP0700200','VNP0700600','VNP0700700','VNP0700900','VNP0700400','VNP0700800','VNP0700500','VNP0700300')
;
/* ------------- XOA CAC PHONG CN --------------- */
delete from ttkd_bsc.dinhmuc_giao_dthu_ptm 
where thang = 202409
and ma_pb in('VNP0700100','VNP0700200','VNP0700600','VNP0700700','VNP0700900','VNP0700400','VNP0700800','VNP0700500','VNP0700300')
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set loai_kpi
                                        = ( case when a.ma_vtcv in('VNP-HNHCM_BHKV_27') then 'KPI_CHT_GDV'
                                                 when a.ma_vtcv in('VNP-HNHCM_BHKV_28') then 'KPI_CHT'
                                                 when a.ma_vtcv in('VNP-HNHCM_BHKV_42','VNP-HNHCM_KDOL_5','VNP-HNHCM_BHKV_51'
                                                                  ,'VNP-HNHCM_BHKV_17','VNP-HNHCM_BHKV_52','VNP-HNHCM_KHDN_10','VNP-HNHCM_BHKV_19'
                                                                  ,'VNP-HNHCM_KDOL_10','VNP-HNHCM_KDOL_6','VNP-HNHCM_KDOL_18')
                                                    then 'KPI_TT'
                                                 when ma_vtcv in('VNP-HNHCM_KHDN_4') then 'KPI_TL'
                                                 when ma_vtcv in('VNP-HNHCM_BHKV_2','VNP-HNHCM_BHKV_2.1','VNP-HNHCM_KHDN_2') then 'KPI_PGD'
                                                 when ma_vtcv in('VNP-HNHCM_BHKV_1','VNP-HNHCM_KHDN_1','VNP-HNHCM_KDOL_1') then 'KPI_GD'
                                                 when ma_vtcv in('VNP-HNHCM_GP_1') then 'KPI_TP'
                                                 when ma_vtcv in('VNP-HNHCM_GP_2') then 'KPI_PP'
                                              else 'KPI_NV'
                                            end
                                          ) 
where thang = 202409 and loai_kpi is null
;
commit ;
SELECT DISTINCT MA_VTCV, TEN_VTCV FROM ttkd_bsc.dinhmuc_giao_dthu_ptm
WHERE thang = 202409 and  LOAI_KPI = 'KPI_NV' ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set tt_manv=(select ma_nv from
                                                        ( select distinct ma_nv, ma_to, ten_to, thang
                                                            from ttkd_bsc.dinhmuc_giao_dthu_ptm 
                                                            where loai_kpi in('KPI_TT','KPI_CHT','KPI_CHT_GDV','KPI_TL') and thang = 202409                                                        
                                                        ) b
                                                       where b.ma_to=a.ma_to and thang = 202409) 
-- select * from ttkd_bsc.dinhmuc_giao_dthu_ptm a
where loai_kpi='KPI_NV' and thang = 202409 and tt_manv is null
--and ma_vtcv in('VNP-HNHCM_BHKV_27','VNP-HNHCM_BHKV_28','VNP-HNHCM_BHKV_42','VNP-HNHCM_KDOL_5','VNP-HNHCM_BHKV_51'
--              ,'VNP-HNHCM_BHKV_17','VNP-HNHCM_BHKV_52','VNP-HNHCM_KHDN_4')
and tinh_bsc = 1
;
commit ;
/* ------------- TINH SO LUONG NHAN VIEN DO PGD_PT --------------- */

/*
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set pgd_manv=( select distinct ma_nv
                                                        from (  select distinct ma_nv, ten_to, ten_pb, thang
                                                                    from ttkd_bsc.dinhmuc_giao_dthu_ptm 
                                                                    where loai_kpi in('KPI_NV') and thang = 202409 
                                                                    and ma_vtcv = 'VNP-HNHCM_BHKV_53'
                                                             )
                                                        where ma_pb = a.ma_pb     
                                                        )
where loai_kpi='KPI_NV' and tinh_bsc = 1
--and ma_nv in('VNP016983','VNP016659','VNP017947 ','VNP017585','VNP016898','VNP017456','VNP017853','VNP017496','VNP017947')
;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set soluong_nhanvien= '' ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set sl_nhanvien= '' ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set sl_nhanvien=(select count(ma_nv) from ttkd_bsc.dinhmuc_giao_dthu_ptm where loai_kpi='KPI_NV' and a.ma_nv=pgd_manv)
where loai_kpi='KPI_PGD_PT' and tinh_bsc = 1
;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set slnv_pt= '' ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set slnv_pt=(select count(ma_nv) from ttkd_bsc.dinhmuc_giao_dthu_ptm where loai_kpi='KPI_NV' and a.ma_nv=pgd_manv)
where loai_kpi='KPI_PGD_PT' and tinh_bsc = 1
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set sl_nhanvien=(select count(ma_nv) from ttkd_bsc.dinhmuc_giao_dthu_ptm 
                                                  where loai_kpi='KPI_NV' 
                                                    and a.ma_nv=tl_manv 
                                                    and ma_vtcv in('VNP-HNHCM_KHDN_3','VNP-HNHCM_KHDN_3.1')
                                                  )
where loai_kpi='KPI_TL' and tinh_bsc = 1
;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set slnv_pt=( select count(ma_nv) from ttkd_bsc.dinhmuc_giao_dthu_ptm 
                                               where loai_kpi='KPI_NV' 
                                                 and a.ma_nv=tl_manv 
                                                 and ma_vtcv in('VNP-HNHCM_KHDN_3','VNP-HNHCM_KHDN_3.1')
                                              )
where loai_kpi='KPI_TL' and tinh_bsc = 1
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set dinhmuc_1='', dinhmuc_2='', dinhmuc_3='' 
where thang = 202409 ;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1, dinhmuc_2, dinhmuc_3) 
                                        = (select dinhmuc_1, dinhmuc_2, dinhmuc_3 
                                            from ttkd_bsc.bldg_danhmuc_vtcv_p1 c 
                                            where c.thang                                 = 202409
                                              and c.thang_kt is null and c.dinhmuc_1 is not null
                                              and a.ma_vtcv = c.ma_vtcv )
where thang = 202409 and dinhmuc_1 is null
;
commit ;

*/
/* -------- CONG DINHMUC VAO TT, TL, CHT ------------ */
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2
                                                           , sum(nvl(dinhmuc_3,0))dinhmuc_3
                                        from ttkd_bsc.dinhmuc_giao_dthu_ptm
                                        where loai_kpi in('KPI_NV') and thang = 202409 
                                          and tinh_bsc = 1 and dinhmuc_1 is not null
                                  --      and tt_manv = 'VNP017619'
                                        group by ma_to, ten_to
                                     ) b
                           where a.ma_to = b.ma_to 
                         )
where thang = 202409 and tinh_bsc = 1
and loai_kpi not in('KPI_NV','KPI_CHT_GDV') 
;
commit ;

rollback ;
/* -------- CHT kGDV ------------ */

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =(select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select ma_to, ten_to, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2
                                                   , sum(nvl(dinhmuc_3,0))dinhmuc_3
                                        from ttkd_bsc.dinhmuc_giao_dthu_ptm
                                        where loai_kpi in('KPI_NV','KPI_CHT_GDV') and thang = 202409 
                                          and tinh_bsc = 1 and dinhmuc_1 is not null
                                  --      and tt_manv = 'VNP017619'
                                        group by ma_to, ten_to
                                      ) b
                          where a.ma_to = b.ma_to 
                         )
where loai_kpi in('KPI_CHT_GDV') and thang = 202409 and tinh_bsc = 1
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
                                    from ttkd_bsc.NHANVIEN where thang = 202409 and ma_nv = a.ma_nv and donvi = 'TTKD')
where thang = 202409
;
commit ;

update DINHMUC_GIAO_DTHU_PGDPT a set NHOMBRCD_DTGIAO = nvl(BRCD_DTGIAO,0)+nvl(MYTV_DTGIAO,0)
                                   , NHOMVINA_DTGIAO = nvl(VNPTT_DTGIAO,0)+nvl(VNPTS_DTGIAO,0)
                                   , NHOMTSL_DTGIAO  = nvl(TSL_DTGIAO,0)+nvl(ITT_DTGIAO,0)
                                   , NHOMCNTT_DTGIAO = nvl(CNTT_DTGIAO,0)
WHERE THANG = 202409
;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm_202409 a set (BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO
                                          , CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO)
                                    = (select BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO
                                          , CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO
                                        from DINHMUC_GIAO_DTHU_PGDPT where ma_nv = a.ma_nv and thang = 202409)
-- select a.* from ttkd_bsc.dinhmuc_giao_dthu_ptm_202409 a
where thang = 202409 
and exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_nv = a.ma_nv and thang = 202409)
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm  a set TONG_DTGIAO = nvl(NHOMBRCD_DTGIAO,0) + nvl(NHOMVINA_DTGIAO,0) + nvl(NHOMTSL_DTGIAO,0) +nvl(NHOMCNTT_DTGIAO,0)
WHERE THANG = 202409 and tinh_bsc = 1
and exists(select 1 from DINHMUC_GIAO_DTHU_PGDPT where ma_nv = a.ma_nv)
;
rollback ;
commit ;

commit ;

-- ma_vtcv in('VNP-HNHCM_BHKV_1','VNP-HNHCM_BHKV_2','VNP-HNHCM_BHKV_1 VNP-HNHCM_BHKV_2.1')
select * from DINHMUC_GIAO_DTHU_PGDPT a
where thang = 202409
and not exists(select 1 from ttkd_bsc.dinhmuc_giao_dthu_ptm where ma_nv = a.ma_nv)
;
/* ----- VI TRI GD, PGD --- */
-- ma_vtcv in('VNP-HNHCM_BHKV_1','VNP-HNHCM_BHKV_2','VNP-HNHCM_BHKV_1 VNP-HNHCM_BHKV_2.1')

/* ---------- UPDATE CHO VI TRI : MA_VTCV = 'VNP-HNHCM_BHKV_53' -------------- */
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set TONG_DTGIAO = 5600000 
-- SELECT * FROM ttkd_bsc.dinhmuc_giao_dthu_ptm a
WHERE MA_VTCV = 'VNP-HNHCM_BHKV_53' and thang = 202409
;
commit ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set TONG_DTGIAO
                        =( select TONG_DTGIAO
                                from ( select ma_to, ten_to, sum(nvl(TONG_DTGIAO,0))TONG_DTGIAO
                                        from ttkd_bsc.dinhmuc_giao_dthu_ptm
                                        where loai_kpi in('KPI_NV') and thang = 202409 
                                          and tinh_bsc = 1 and TONG_DTGIAO is not null
                                          and ma_vtcv = 'VNP-HNHCM_BHKV_53'
                                  --      and tt_manv = 'VNP017619'
                                        group by ma_to, ten_to
                                     ) b
                           where a.ma_to = b.ma_to 
                         )
where thang = 202409 and tinh_bsc = 1
and ma_vtcv = 'VNP-HNHCM_BHKV_52'
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set TONG_DTGIAO = 13000000
-- SELECT * FROM ttkd_bsc.dinhmuc_giao_dthu_ptm a
WHERE MA_VTCV = 'VNP-HNHCM_BHKV_15' and thang = 202409
;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set TONG_DTGIAO = 104000000
-- SELECT * FROM ttkd_bsc.dinhmuc_giao_dthu_ptm a
WHERE MA_VTCV = 'VNP-HNHCM_BHKV_17' and thang = 202409
;
commit ;

/* ---------- UP TLTH TU HCM_DT_LUYKE_002 VAO COT TLTH, CHI AP DUNG T08/2024 ---------------- */
select ma_nv, count(*)sl from ttkd_bsc.bangluong_kpi a 
where ma_kpi='HCM_DT_LUYKE_002' 
and ma_pb in ('VNP0702300','VNP0702400','VNP0702500') 
and thang=202409 group by ma_nv having count(*)>1;

select ma_nv, count(*)sl from ttkd_bsc.dinhmuc_giao_dthu_ptm a 
where ma_pb in ('VNP0702300','VNP0702400','VNP0702500') 
and thang=202409 group by ma_nv having count(*)>1;


update ttkd_bsc.dinhmuc_giao_dthu_ptm a set TLTH = (SELECT tyle_thuchien
                                                    from ttkd_bsc.bangluong_kpi  
                                                        where ma_kpi='HCM_DT_LUYKE_002' 
                                                        and ma_pb in ('VNP0702300','VNP0702400','VNP0702500') 
                                                        and thang=202409 and ma_nv = a.ma_nv)
where a.ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
and a.thang = 202409
and exists(select 1 from ttkd_bsc.bangluong_kpi  
                where ma_kpi='HCM_DT_LUYKE_002' 
                and ma_pb in ('VNP0702300','VNP0702400','VNP0702500') 
                and thang=202409 and ma_nv = a.ma_nv)
;

commit ;
rollback ;
select distinct ten_pb, ma_pb, ma_nv, ten_nv, ma_vtcv, ten_vtcv, dichvu
from ttkd_bsc.blkpi_dm_to_pgd a where thang = 202409 
order by ten_pb, ma_pb, ma_nv, ten_nv, ma_vtcv, ten_vtcv, dichvu ;

select distinct ma_pb, ten_pb from ttkd_bsc.dinhmuc_giao_dthu_ptm where thang = 202409 ;
select * from ttkd_bsc.dinhmuc_giao_dthu_ptm
where thang = 202409
and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600'
            ,'VNP0703000','VNP0702600','VNP0702300','VNP0702400','VNP0702500')
;


select a.*, rank() over (partition by a.manv_hrm order by a.dateinput desc) rnk 
              from ttkdhcm_ktnv.ID430_DANGKY_CHOTTHANG a where a.thang = 202409
;
select 
THANG, DONVI, TEN_TO, MANV_HRM, TEN_NV, BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO
, CNTT_DTGIAO, NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, TONG_DTGIAO, CANHAN_GIAO, DATEINPUT
from 
(
    select a.*, rank() over (partition by a.manv_hrm order by a.dateinput desc) rnk 
     from ttkdhcm_ktnv.ID430_DANGKY_CHOTTHANG a where a.thang = 202409
)
;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set dinhmuc_1=0, dinhmuc_2=0, dinhmuc_3=0 
where ma_vtcv in('VNP-HNHCM_BHKV_27') and thang = 202409;

commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set heso_qd_dt_ptm='' where thang = 202409 ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a 
set heso_qd_dt_ptm=(case when KHDK < dinhmuc_3 and KQTH < dinhmuc_3 then 0.8 --12
                         when KHDK < dinhmuc_3 and KQTH < dinhmuc_2 and KQTH >= dinhmuc_3 then 0.85	--11
                         when KHDK < dinhmuc_2 and KHDK >= dinhmuc_3 and KQTH < dinhmuc_3 then 0.85	--9
                         when KHDK < dinhmuc_3 and KQTH >= dinhmuc_2 then 0.9		--10
                         when KHDK < dinhmuc_2 and KHDK >= dinhmuc_3 and KQTH < dinhmuc_2 and KQTH >= dinhmuc_3 then 0.9		--8
                         when KHDK < dinhmuc_1  and KHDK >= dinhmuc_2 and KQTH < dinhmuc_3 then 0.9		--6
                         when KHDK < dinhmuc_2 and KHDK >= dinhmuc_3 and KQTH >= dinhmuc_2 then 0.95		--7
                         when KHDK < dinhmuc_1 and KHDK >= dinhmuc_2 and KQTH < dinhmuc_2 and KQTH >= dinhmuc_3 then 0.95	--5
                         when KHDK >= dinhmuc_1 and KQTH < dinhmuc_2 then 0.95		--3
                         when KHDK < dinhmuc_1 and KHDK >= dinhmuc_2 and KQTH >= dinhmuc_2 then 1  --4
                         when KHDK >= dinhmuc_1 and KQTH < dinhmuc_1 and KQTH >= dinhmuc_2 then 1		--2
                         when KHDK >= dinhmuc_1 and KQTH >= dinhmuc_1 then 1.1		--1
                      else null
                    end )
where thang = 202409 and khdk is not null and dinhmuc_1 > 0 
--and ma_vtcv = 'VNP-HNHCM_BHKV_27'
--and ma_nv in('CTV021926','VNP016681','VNP016905','VNP017407','CTV028802')
--and ma_to = 'VNP0702116' --  ma_nv = 'CTV028802'
;
commit ;
select * from ttkd_bsc.dinhmuc_giao_dthu_ptm a where dinhmuc_1 > 0 and khdk is null ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set khdk = 0 where dinhmuc_1 > 0 and khdk is null ;
commit ;
rollback ;
update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                           from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 where ma_vtcv= a.ma_vtcv
                         )
where thang = 202409 and ma_vtcv in('VNP-HNHCM_BHKV_27') 
and exists(select 1 from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 where ma_vtcv= a.ma_vtcv)
;
rollback ;

select tt_manv, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2, sum(nvl(dinhmuc_3,0))dinhmuc_3
from ttkd_bsc.dinhmuc_giao_dthu_ptm
where loai_kpi is not null
and tt_manv = 'VNP017619'
group by tt_manv
;

select * from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =( select dinhmuc_1,dinhmuc_2,dinhmuc_3
                           from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 where ma_vtcv= a.ma_vtcv
                         )
where loai_kpi = 'KPI_NV' and thang = 202409 
--and ( dinhmuc_1 is null or dinhmuc_1 is null )
and exists(select 1 from ttkd_bsc.BLDG_DANHMUC_VTCV_P1 where ma_vtcv= a.ma_vtcv)
;
commit ;
rollback ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =(select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select tt_manv, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2, sum(nvl(dinhmuc_3,0))dinhmuc_3
                                        from ttkd_bsc.dinhmuc_giao_dthu_ptm
                                        where loai_kpi='KPI_NV' and thang = 202409
                                  --      and tt_manv = 'VNP017619'
                                        group by tt_manv
                                      )
                          where a.ma_nv=tt_manv
                         )
where loai_kpi in('KPI_TT','KPI_CHT','KPI_TT','KPI_TL') and thang = 202409 and tinh_bsc = 1
;
commit ;

update ttkd_bsc.dinhmuc_giao_dthu_ptm a set (dinhmuc_1,dinhmuc_2,dinhmuc_3)
                        =(select dinhmuc_1,dinhmuc_2,dinhmuc_3
                                from ( select tt_manv, sum(nvl(dinhmuc_1,0))dinhmuc_1, sum(nvl(dinhmuc_2,0))dinhmuc_2, sum(nvl(dinhmuc_3,0))dinhmuc_3
                                        from ttkd_bsc.dinhmuc_giao_dthu_ptm
                                        where loai_kpi='KPI_NV' and thang = 202409 and ma_vtcv = 'VNP-HNHCM_BHKV_15' and tinh_bsc = 1
                                  --      and tt_manv = 'VNP017619'
                                        group by tt_manv
                                      )
                          where a.ma_nv=tt_manv
                         )
where ma_vtcv = 'VNP-HNHCM_BHKV_17' and thang = 202409 and tinh_bsc = 1
;
commit ;


--rollback ;


select * from ttkd_bsc.dinhmuc_giao_dthu_ptm where thang = 202409 
and ( ma_vtcv in('VNP-HNHCM_BHKV_27','VNP-HNHCM_BHKV_28')  -- CHT 
or ma_vtcv in('VNP-HNHCM_BHKV_42','VNP-HNHCM_KDOL_5','VNP-HNHCM_BHKV_51','VNP-HNHCM_BHKV_17')  -- TT
--or ma_vtcv in('VNP-HNHCM_KHDN_4')
or ma_vtcv in('VNP-HNHCM_BHKV_1','VNP-HNHCM_BHKV_2.1') -- GD, PGD 
)
;

select * from ttkdhcm_ktnv.ID430_DANGKY_CHOTTHANG a ;
create table ttkd_bsc.xx_bldg_danhmuc_vtcv_p1 as select * from ttkd_bsc.bldg_danhmuc_vtcv_p1 ;
select *  from ttkd_bsc.bldg_danhmuc_vtcv_p1 ;
select distinct ma_vtcv, ten_vtcv from ttkd_bsc.bldg_danhmuc_vtcv_p1 ;


select distinct a.thang, a.MANV_HRM ma_nv, b.TEN_NV, b.ma_to, b.ten_to, b.ten_vtcv, b.ma_vtcv, b.ma_pb, b.ten_pb
                , BRCD_DTGIAO, MYTV_DTGIAO, VNPTT_DTGIAO, VNPTS_DTGIAO, TSL_DTGIAO, ITT_DTGIAO, CNTT_DTGIAO
                , NHOMBRCD_DTGIAO, NHOMVINA_DTGIAO, NHOMTSL_DTGIAO, NHOMCNTT_DTGIAO, nvl(TONG_DTGIAO,0)TONG_DTGIAO, DATEINPUT
                , nvl(c.dinhmuc_1,0)dinhmuc_1, nvl(c.dinhmuc_2,0)dinhmuc_2
                , nvl(TONG_DTGIAO,0) KHDK, 93 KQTH
from (select a.*, rank() over (partition by a.manv_hrm order by a.dateinput desc) rnk 
      from ttkdhcm_ktnv.ID430_DANGKY_CHOTTHANG a where a.thang = 202409) a
left join ttkd_bsc.nhanvien b on a.thang= b.thang and a.manv_hrm = b.manv_hrm
left join ttkd_bsc.bldg_danhmuc_vtcv_p1 c on b.ma_vtcv = c.ma_vtcv and c.thang_kt is null and dinhmuc_1 is not null
where rnk = 1 
--and manv_hrm in('VNP017601','VNP017604','VNP017622','VNP017721','VNP017813','VNP017853','VNP019529','VNP019931','VNP020231','VNP017014')
order by 1,2,3
;

commit ;

select * from ttkd_bsc.blkpi_danhmuc_kpi_vtcv where thang = 202409 and ma_kpi = 'HCM_DT_PTMOI_021' ;

insert into dinhmuc_giao_dthu_ptm(thang, ma_nv, ten_nv, ma_to, ten_to, ma_vtcv, ten_vtcv, ma_pb, ten_pb )
select nv.thang, nv.ma_nv, nv.ten_nv, nv.ma_to, nv.ten_to, nv.ma_vtcv, nv.ten_vtcv, nv.ma_pb, nv.ten_pb 
from ttkd_bsc.nhanvien nv 
where nv.thang = 202409 and nv.donvi = 'TTKD'
and exists(select 1 from(select a.* from ttkd_bsc.blkpi_danhmuc_kpi_vtcv a where a.thang = 202409 and a.ma_kpi = 'HCM_DT_PTMOI_021') b
           where b.ma_vtcv = nv.ma_vtcv
          )
and not exists(select 1 from ttkd_bsc.dinhmuc_giao_dthu_ptm where ma_nv = nv.ma_nv)
;

commit ;