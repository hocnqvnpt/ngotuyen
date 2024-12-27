
CREATE TABLE "TUYENNGO"."KPI_007_202411_12" 
   (	"THANG" NUMBER, 
	"MA_KPI" VARCHAR2(30 BYTE), 
	"MA_VTCV" VARCHAR2(20 BYTE), 
	"TEN_VTCV" VARCHAR2(200 BYTE), 
	"MA_TO" VARCHAR2(20 BYTE), 
	"MA_NV" VARCHAR2(20 BYTE), 
	"TEN_NV" VARCHAR2(200 BYTE), 
	"MA_PB" VARCHAR2(20 BYTE), 
	"TEN_PB" VARCHAR2(200 BYTE), 
	"LOAI_KPI" VARCHAR2(10 BYTE), 
	"SL_NHANVIEN" NUMBER, 
	"SOLUONG_NHANVIEN" NUMBER, 
	"SLNV_PT" NUMBER, 
	"THUCHIEN" NUMBER, 
	"GIAO" NUMBER, 
    "MDHT" NUMBER, 
	"NV_DAT" NUMBER, 
	"TL_MANV" VARCHAR2(20 BYTE), 
	"PGD_MANV" VARCHAR2(20 BYTE), 
	"SL_DAT" NUMBER, 
	"TLHT" NUMBER, 
    "TLTH" NUMBER, 
	"CONG_TRU" NUMBER, 
	"TINH_BSC" NUMBER,
    "THAYDOI_VTCV" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
;
--drop table KPI_007_202411_12 purge ;
--create table KPI_007_202411_12 as select * from KPI_007_202411_12 ;
select * from KPI_007_202411_12;

select * from ttkd_bsc.bangluong_kpi nv where nv.ma_kpi='HCM_DT_LUYKE_002' and thang = 202411 ;

/* ----------- INSERT NHAN VIEN VAO BANG KPI_007... -------------- */
INSERT INTO KPI_007_202411_12(THANG, ma_kpi, ma_vtcv, ten_vtcv, ma_to, ma_nv, ten_nv, ma_pb, ten_pb, tinh_bsc, thaydoi_vtcv)
select THANG, 'HCM_CL_DHQLY_007', ma_vtcv, ten_vtcv, ma_to, ma_nv, ten_nv, ma_pb, ten_pb, tinh_bsc, thaydoi_vtcv
from ttkd_bsc.nhanvien a
where a.thang = 202411 and a.ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
and exists(select 1 
            from (
                     select bl.THANG, vt.ma_kpi, vt.ma_vtcv, bl.ten_vtcv, bl.ma_to, bl.ma_nv, bl.ten_nv, bl.ma_pb, bl.ten_pb  --, thuchien, giao, tyle_thuchien mdht 
                       from ttkd_bsc.bangluong_kpi bl, ttkd_bsc.blkpi_danhmuc_kpi_vtcv vt
                       where bl.thang = 202411 and vt.thang = 202411
                        and bl.ma_vtcv = vt.ma_vtcv 
                        and bl.ma_kpi = 'HCM_DT_LUYKE_002' 
                        and vt.ma_kpi = 'HCM_CL_DHQLY_007'
                ) 
            where ma_to = a.ma_to and ma_pb = a.ma_pb)
;
commit ;
select a.* from KPI_007_202411_12 a 
where not exists(select 1 from(
select * 
from ttkd_bsc.nhanvien a
where a.thang = 202411
and ma_pb in ('VNP0702300','VNP0702400','VNP0702500') 
and ma_vtcv in('VNP-HNHCM_KHDN_3','VNP-HNHCM_KHDN_2','VNP-HNHCM_KHDN_1','VNP-HNHCM_KHDN_4','VNP-HNHCM_KHDN_3.1','VNP-HNHCM_KHDN_18')
) where ma_nv = a.ma_nv);

VNP017434
VNP017704
VNP016677
VNP016683
VNP002584

select * from tuyenngo.KPI_007_202411_12 ;
select * from ttkd_bsc.blkpi_dm_to_pgd
where thang = 202411 
    and ma_kpi in('HCM_DT_LUYKE_002') 
    and ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
;

select * from ttkd_bsc.nhanvien where thang = 202411 ;
/* ---------- CHUAN LAI LOAI_KPI ------------- */
update tuyenngo.KPI_007_202411_12 a set loai_kpi = '' ;
update tuyenngo.KPI_007_202411_12 a set loai_kpi = ( case when a.ma_vtcv = 'VNP-HNHCM_KHDN_4' then 'KPI_TL'
                                                       when a.ma_vtcv = 'VNP-HNHCM_KHDN_2' then 'KPI_PGD_PT'
                                                       when a.ma_vtcv = 'VNP-HNHCM_KHDN_1' then 'KPI_GD'
                                                  else 'KPI_NV'
                                                  end
                                                ) 
-- where tinh_bsc = 1 and thaydoi_vtcv = 0
;
commit ;
select * from tuyenngo.KPI_007_202411_12 ;

/* ------------- CAP NHAT NHAN VIEN DO PGD_PT --------------- */
update tuyenngo.KPI_007_202411_12 a set pgd_manv= '' ;

update tuyenngo.KPI_007_202411_12 a set pgd_manv=( select distinct ma_nv
                                                from ttkd_bsc.blkpi_dm_to_pgd
                                                         where thang=202411                                                            
                                                            and ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
                                                            and ma_kpi in('HCM_DT_LUYKE_002') 
                                                            and a.ma_to=ma_to
                                                        )
where loai_kpi='KPI_NV'
--and tinh_bsc = 1 and thaydoi_vtcv = 0
;
commit ;
/* ------------- TINH SO LUONG NHAN VIEN DO PGD_PT --------------- */
update tuyenngo.KPI_007_202411_12 a set soluong_nhanvien= '' ;

update tuyenngo.KPI_007_202411_12 a set sl_nhanvien= '' ;
update tuyenngo.KPI_007_202411_12 a set sl_nhanvien=(select count(ma_nv) 
                                                    from tuyenngo.KPI_007_202411_12 
                                                    where loai_kpi='KPI_NV' 
                                                    and tinh_bsc = 1 and thaydoi_vtcv = 0
                                                    and a.ma_nv=pgd_manv)
where loai_kpi='KPI_PGD_PT' 
;
update tuyenngo.KPI_007_202411_12 a set slnv_pt= '' ;
update tuyenngo.KPI_007_202411_12 a set slnv_pt=(select count(ma_nv) 
                                                from tuyenngo.KPI_007_202411_12 
                                                where loai_kpi='KPI_NV' 
                                                and tinh_bsc = 1 and thaydoi_vtcv = 0
                                                and a.ma_nv=pgd_manv)
where loai_kpi='KPI_PGD_PT' 
;
commit ;

update tuyenngo.KPI_007_202411_12 a set tl_manv = '' ;
update tuyenngo.KPI_007_202411_12 a set tl_manv=(select ma_nv from
                                                        ( select distinct ma_nv, ma_to
                                                            from tuyenngo.KPI_007_202411_12 b
                                                            where b.loai_kpi='KPI_TL' 
                                                            and ma_to = b.ma_to
                                                        )
                                              where ma_to=a.ma_to) 
where loai_kpi='KPI_NV' 
;
commit ;

update tuyenngo.KPI_007_202411_12 a set sl_nhanvien=(select count(ma_nv) from tuyenngo.KPI_007_202411_12 
                                                  where loai_kpi='KPI_NV'                                                     
                                                    and ma_vtcv in('VNP-HNHCM_KHDN_3','VNP-HNHCM_KHDN_3.1')
                                                    and tinh_bsc = 1 and thaydoi_vtcv = 0
                                                    and a.ma_nv=tl_manv 
                                                  )
where loai_kpi='KPI_TL' 
;
commit ;
rollback ;

update tuyenngo.KPI_007_202411_12 a set slnv_pt=( select count(ma_nv) from tuyenngo.KPI_007_202411_12 
                                               where loai_kpi='KPI_NV' 
                                                 and a.ma_nv=tl_manv and tinh_bsc = 1 and thaydoi_vtcv = 0
                                                 and ma_vtcv in('VNP-HNHCM_KHDN_3','VNP-HNHCM_KHDN_3.1')
                                              )
where loai_kpi='KPI_TL'
;
commit ;
select * from tuyenngo.KPI_007_202411_12 ;
select ma_nv, count(*)sl from tuyenngo.KPI_007_202411_12 group by ma_nv ;
/* ------------- CAP NHAT NHAN VIEN DO TL_PT --------------- */

update KPI_007_202411_12 set thuchien='', giao='', tlth='', mdht='', nv_dat='', sl_dat='', tlht='', cong_tru='' ;
 commit; 
update KPI_007_202411_12 a set ( thuchien, giao, tlth, mdht, nv_dat )
                          = ( select thuchien, giao, tlth, mdht, 
                                   (case when nvl(mdht,0) >= 95 then 1 else 0 end)
                              from (select ma_nv, thuchien, giao, tyle_thuchien tlth, mucdo_hoanthanh mdht
                                      from ttkd_bsc.bangluong_kpi a 
                                      where thang=202411 and ma_kpi='HCM_DT_LUYKE_002'
                                   ) 
                              where ma_nv=a.ma_nv
                            --  and nvl(thuchien,0) > 0 and nvl(giao,0) > 0
                            )
--where tinh_bsc = 1 and thaydoi_vtcv = 0 --loai_kpi = 'KPI_NV'
;
commit ;
select * from ttkd_bsc.bangluong_kpi a where thang=202411 and ma_kpi='HCM_DT_LUYKE_002';

/* ---------- BO SUNG MA_VTCV = 'VNP-HNHCM_KHDN_18' CHO T10/2024 ------------- */
select * from ttkd_bsc.bangluong_kpi a where thang=202411 and ma_kpi='HCM_DT_PTMOI_021';

update KPI_007_202411_12 a set ( thuchien, giao, tlth, mdht, nv_dat )
                          = ( select thuchien, giao, tlth, mdht, 
                                   (case when nvl(mdht,0) >= 95 then 1 else 0 end)
                              from (select ma_nv, thuchien, giao, tyle_thuchien tlth, mucdo_hoanthanh mdht
                                      from ttkd_bsc.bangluong_kpi a 
                                      where thang=202411 and ma_kpi='HCM_DT_PTMOI_021'
                                      and ma_vtcv = 'VNP-HNHCM_KHDN_18'
                                   ) 
                              where ma_nv=a.ma_nv
                            --  and nvl(thuchien,0) > 0 and nvl(giao,0) > 0
                            )
where ma_vtcv = 'VNP-HNHCM_KHDN_18' and ma_pb = 'VNP0702300'
;
commit ;
rollback ;
select * from ttkd_bsc.bangluong_kpi ;
select * from tuyenngo.KPI_007_202411_12 ;

update tuyenngo.KPI_007_202411_12 a set sl_dat = 0 where loai_kpi = 'KPI_TL' ; 
update tuyenngo.KPI_007_202411_12 a set sl_dat= ( select nvl(sl_dat,0)
                                               from
                                                  ( select ma_to, ma_pb, sum(nvl(nv_dat,0))sl_dat 
                                                    from tuyenngo.KPI_007_202411_12  
                                                    where loai_kpi='KPI_NV' and tl_manv is not null 
                                                      and tinh_bsc = 1 and thaydoi_vtcv = 0
                                                    group by ma_to, ma_pb   
                                                  )
                                                where ma_to=a.ma_to and ma_pb=a.ma_pb
                                             )  
where loai_kpi = 'KPI_TL' and NVL(sl_nhanvien,0) > 0 
;
commit ;

update tuyenngo.KPI_007_202411_12 a set sl_dat = 0 where loai_kpi = 'KPI_PGD_PT' ; 
update tuyenngo.KPI_007_202411_12 a set sl_dat=(select nvl(sl_dat,0) 
                                                      FROM( select pgd_manv, sum(nvl(nv_dat,0))sl_dat
                                                            from tuyenngo.KPI_007_202411_12
                                                            where loai_kpi='KPI_NV' and pgd_manv is not null 
                                                                and tinh_bsc = 1 and thaydoi_vtcv = 0
                                                            group by pgd_manv
                                                           )
                                                       WHERE pgd_manv = a.ma_nv)
where loai_kpi = 'KPI_PGD_PT' 
;
commit ;
update tuyenngo.KPI_007_202411_12 a set TLHT = '' where loai_kpi in('KPI_PGD_PT','KPI_TL') ;
update tuyenngo.KPI_007_202411_12 a set TLHT=( case when ma_vtcv = 'VNP-HNHCM_KHDN_4' and sl_nhanvien > 0
                                                   then round(((case when loai_kpi='KPI_TL' then nvl(sl_dat,0) else 0 end)/sl_nhanvien)*100,2)
                                                 when ma_vtcv = 'VNP-HNHCM_KHDN_2' and sl_nhanvien > 0
                                                   then round(((case when loai_kpi='KPI_PGD_PT' then nvl(sl_dat,0) else 0 end)/sl_nhanvien)*100,2) else 0
                                            end 
                                          )   
where loai_kpi in('KPI_PGD_PT','KPI_TL') ;
commit ;
select * from tuyenngo.KPI_007_202411_12 ;
update tuyenngo.KPI_007_202411_12 a set cong_tru ='' where loai_kpi in('KPI_PGD_PT','KPI_TL') ;
commit ;

update tuyenngo.KPI_007_202411_12 a set cong_tru = ( case when TLHT >= 100 and MDHT >= 100 then +20
                                                  --     when TLHT >= 100 and MDHT < 100 then 0
                                                       when TLHT >= 50 and MDHT >= 50 then 0
                                                       when TLHT < 50 then -20
                                                  end
                                                )
--select * from tuyenngo.KPI_007_202411_12
where loai_kpi in('KPI_PGD_PT','KPI_TL') and NVL(sl_nhanvien,0) > 0

;
commit ;
SELECT * FROM tuyenngo.KPI_007_202411 a ;
SELECT * FROM tuyenngo.KPI_007_202411_12 a ;
/* --------- SAU KHI CHAY XONG BANG KPI -> IMP VAO BANG TUYENNGO.TL_BSC ---------- */
insert into ttkd_bsc.tuyenngo_tl_bsc (THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, MA_NV, TEN_NV, MA_PB, TEN_PB, LOAI_KPI
                                    , SL_NHANVIEN, SOLUONG_NHANVIEN, SLNV_PT, THUCHIEN, GIAO, MDHT, NV_DAT, TL_MANV, PGD_MANV
                                    , SL_DAT, TLHT, CONG_TRU, tinh_BSC, thaydoi_vtcv)

select THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, MA_NV, TEN_NV, MA_PB, TEN_PB, LOAI_KPI
                                    , SL_NHANVIEN, SOLUONG_NHANVIEN, SLNV_PT, THUCHIEN, GIAO, MDHT, NV_DAT, TL_MANV, PGD_MANV
                                    , SL_DAT, TLHT, CONG_TRU, tinh_BSC, thaydoi_vtcv
from tuyenngo.KPI_007_202411_12 a ;
commit ;

select * from ttkd_bsc.tuyenngo_tl_bsc where MA_KPI ='HCM_CL_DHQLY_007' and thang = 202411 ;
-- delete from ttkd_bsc.tuyenngo_tl_bsc where MA_KPI ='HCM_CL_DHQLY_007' and thang = 202411 ;
commit ;

select a.* from tuyenngo.KPI_007_202411_12 a ;
/* ----------- UP VAO BANGLUONG_KPI -------------------------- */
select * from ttkd_bsc.bangluong_kpi a 
    where thang = 202411 and ma_kpi = 'HCM_CL_DHQLY_007' and ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
;

update ttkd_bsc.bangluong_kpi a set DIEM_CONG = '', DIEM_TRU = '' 
where thang = 202411 and ma_kpi = 'HCM_CL_DHQLY_007' and ma_pb in ('VNP0702300','VNP0702400','VNP0702500') ;
commit ;
update ttkd_bsc.bangluong_kpi a 
        set DIEM_CONG = (select nvl(cong_tru,0) from tuyenngo.KPI_007_202411_12 where cong_tru >= 0 and ma_nv = a.ma_nv)
            , DIEM_TRU = (select nvl(cong_tru,0)*(-1) from tuyenngo.KPI_007_202411_12 where cong_tru < 0 and ma_nv = a.ma_nv)
--    select * from ttkd_bsc.bangluong_kpi a
    where thang = 202411 and ma_kpi = 'HCM_CL_DHQLY_007' and ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
    --AND MA_NV = 'VNP022082'
;
commit ; 
update ttkd_bsc.bangluong_kpi a 
        set diem_cong = case when nvl(diem_cong,0) = 0 then 0 else DIEM_CONG end
          , diem_tru  = case when nvl(diem_tru,0) = 0 then 0 else DIEM_TRU end
--    select * from ttkd_bsc.bangluong_kpi a
    where thang = 202411 and ma_kpi = 'HCM_CL_DHQLY_007' and ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
    --AND MA_NV = 'VNP022082'
;
commit ; 

/* -------- UP COT (DIEM_CONG = 1, DIEM_TRU = 1) ----------- */
select * from ttkd_bsc.blkpi_danhmuc_kpi where thang = 202411 and ma_kpi = 'HCM_CL_DHQLY_007' ;


select ma_nv, HCM_CL_DHQLY_007 from ttkd_bsc.bangluong_kpi_202411 a where ma_donvi in ('VNP0702300','VNP0702400','VNP0702500')
;
