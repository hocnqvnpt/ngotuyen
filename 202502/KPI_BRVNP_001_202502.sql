/* ---------- UP SO GIAO ----------- */
select * from ttkd_bsc.blkpi_dm_to_pgd where thang=202502 ;
select * from ttkd_bsc.bangluong_kpi where thang=202502 and ma_kpi='HCM_SL_BRVNP_001' ;
select distinct ma_vtcv, ten_vtcv, tytrong, giao from ttkd_bsc.bangluong_kpi where thang=202502 and ma_kpi='HCM_SL_BRVNP_001' ;
select * from ttkd_bsc.nhanvien where thang = 202502 ;

update bangluong_kpi a set giao = '', chitieu_giao = ''
-- select * from bangluong_kpi a
where thang=202502 
and ma_kpi='HCM_SL_BRVNP_001' 
and exists(select 1 from bangluong_kpi b
             where b.thang=202502 and b.ma_kpi='HCM_SL_BRVNP_001' 
             and b.ma_nv = a.ma_nv and b.ma_kpi = a.ma_kpi)
;
commit ;

update bangluong_kpi a set giao = '', tytrong = (select tytrong from bangluong_kpi b
                                        where b.thang=202502 and b.ma_kpi='HCM_SL_BRVNP_001' 
                                         and b.ma_nv = a.ma_nv and b.ma_kpi = a.ma_kpi)
-- select * from bangluong_kpi a
where thang=202502 
and ma_kpi='HCM_SL_BRVNP_001' 
and exists(select 1 from bangluong_kpi b
             where b.thang=202502 and b.ma_kpi='HCM_SL_BRVNP_001' 
             and b.ma_nv = a.ma_nv and b.ma_kpi = a.ma_kpi)
;
commit ;

-- drop table TUYENNGO.KPI_BRVNP_001_202502 purge ;
  CREATE TABLE "TUYENNGO"."KPI_BRVNP_001_202502" 
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
    "SL_INDOOR" NUMBER, 
    "SL_OUTDOOR" NUMBER, 
	"SL_VNPTS" NUMBER, 
    "SL_VNPTT" NUMBER, 
	"TONG_PTM" NUMBER,
    "DINHMUC_GIAO" NUMBER,
    "TY_TRONG" NUMBER,
    "TINH_BSC" NUMBER,
    "THAYDOI_VTCV" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
;

--create table TUYENNGO.KPI_BRVNP_001_202502 as select * from TUYENNGO.KPI_BRVNP_001_202407 ;
-- truncate table TUYENNGO.KPI_BRVNP_001_202502 ;
commit ;
select * from TUYENNGO.KPI_BRVNP_001_202502 ;
TRUNCATE TABLE  TUYENNGO.KPI_BRVNP_001_202502 ;
insert into TUYENNGO.KPI_BRVNP_001_202502 (thang, ma_kpi,ma_vtcv,ten_vtcv,ma_to,ten_to,ma_pb,ten_pb, ma_nv,ten_nv,tinh_bsc,THAYDOI_VTCV)
select distinct a.thang, a.ma_kpi, b.ma_vtcv, b.ten_vtcv, c.ma_to, c.ten_to, c.ma_pb, c.ten_pb, c.ma_nv, 
                c.ten_nv, C.TINH_BSC, c.thaydoi_vtcv
from ttkd_bsc.blkpi_danhmuc_kpi a, ttkd_bsc.blkpi_danhmuc_kpi_vtcv b, ttkd_bsc.nhanvien c  
where a.ma_kpi=b.ma_kpi and b.ma_vtcv=c.ma_vtcv       
  and a.thang_kt is null and b.thang_kt is null 
  and a.ma_kpi='HCM_SL_BRVNP_001'
  and a.thang = 202502 and b.thang = 202502 and c.thang = 202502 
--  and c.ma_nv != 'VNP017740'
--  and c.tinh_bsc = 1 and c.thaydoi_vtcv  = 0 
;
commit ;
select * from ttkd_bsc.blkpi_danhmuc_kpi where ma_kpi='HCM_SL_BRVNP_001' and thang = 202502 ;
select * from ttkd_bsc.blkpi_danhmuc_kpi_vtcv where ma_kpi='HCM_SL_BRVNP_001' and thang = 202502 ;

select THANG, MA_KPI, TEN_KPI, MA_NV, TEN_NV, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, NGAYCONG, TYTRONG, DONVI_TINH, GIAO
from ttkd_bsc.bangluong_kpi a 
where ma_pb = 'VNP0703000' and ma_kpi='HCM_SL_BRVNP_001' and thang = 202502 
and not exists(select 1 from TUYENNGO.KPI_BRVNP_001_202502 WHERE THANG = 202502 and ma_nv = a.ma_nv) 
;
/*-------- UP TYTRONG, DINHMUC_GIAO TU BANGLUONG_KPI --------------- */
update TUYENNGO.KPI_BRVNP_001_202502 a set (ty_trong, dinhmuc_giao) = (select tytrong, giao from ttkd_bsc.bangluong_kpi
                                                                        where ma_pb = 'VNP0703000' and ma_kpi='HCM_SL_BRVNP_001' 
                                                                            and thang = 202502 and ma_nv = a.ma_nv)
WHERE THANG = 202502
;
commit ;

/* ------------------ XOA NHAN VIEN KO GIAO ---------------------- */
--delete from TUYENNGO.KPI_BRVNP_001_202502 a
-- select a.* from TUYENNGO.KPI_BRVNP_001_202502 a
WHERE THANG = 202502
and not exists(select 1 from ttkd_bsc.bangluong_kpi 
                WHERE THANG = 202502 and ma_pb = 'VNP0703000' and ma_kpi='HCM_SL_BRVNP_001' and ma_nv = a.ma_nv) 
;
commit ;

select * --THANG, MA_KPI, TEN_KPI, MA_NV, TEN_NV, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, NGAYCONG, TYTRONG, DONVI_TINH, GIAO
from TUYENNGO.KPI_BRVNP_001_202502 a 
where ma_pb = 'VNP0703000' and thang = 202502 
and not exists(select 1 from ttkd_bsc.bangluong_kpi WHERE THANG = 202502 and ma_kpi='HCM_SL_BRVNP_001' and ma_nv = a.ma_nv) 
;

/* ------------------ UP KPI TT, TCA, PGD_PT --------------- */

update KPI_BRVNP_001_202502 a set loai_kpi = ( case when a.ma_vtcv in('VNP-HNHCM_KDOL_18','VNP-HNHCM_KDOL_23') then 'KPI_TT' 
                                                    when ma_vtcv = 'VNP-HNHCM_KDOL_24.1' then 'KPI_TCA'
                                                    when a.ma_vtcv = 'VNP-HNHCM_KDOL_2' then 'KPI_PGD' 
                                              else 'KPI_NV' end ) ;
commit ;

update tuyenngo.KPI_BRVNP_001_202502 a set tt_manv=(select ma_nv from
                                                        ( select distinct ma_nv, ma_to
                                                            from tuyenngo.KPI_BRVNP_001_202502 b
                                                            where b.loai_kpi in('KPI_TT')                                                        
                                                        )
                                                       where ma_to=a.ma_to
                                                   ) 
where loai_kpi='KPI_NV' 
;
commit ;

select a.* from ttkd_bsc.blkpi_dm_to_pgd a where thang = 202502 and ma_pb = 'VNP0703000' ;
select ma_nv, count(*)sl from TUYENNGO.KPI_BRVNP_001_202502 group by ma_nv ;


rollback ;
select * from tuyenngo.KPI_BRVNP_001_202502 where thang = 202502 ;
select * from nhanvien where thang = 202502 and donvi = 'TTKD' and ma_pb = 'VNP0703000' ;

/* ---------------- KIEM TRA GOI LUONG TINH --------------- */
drop table Tuyenngo.a_BHOL_temp purge ;
create table Tuyenngo.a_BHOL_temp as
    select ma_tb, thang_ptm, manv_ptm, ma_vtcv, ma_to, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'LOAI_KPI
    from ttkd_bsc.ct_bsc_ptm 
    where thang_ptm = 202502
    and ma_pb = 'VNP0703000' 
    and ma_to in('VNP0703003','VNP0703005')
    and loaitb_id in(20,58,59,61,171,210,222,224)
    and loaihd_id = 1
    and trangthaitb_id not in(7,9) 

    union all

    SELECT ma_tb, thang_ptm, manv_ptm, ma_vtcv, ma_to, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'loai_kpi
    FROM
    (
        select thang_ptm, ma_tb, dich_vu, manv_ptm, tennv_ptm, ma_pb, ten_pb, ma_to, ten_to
            , (select x.ma_vtcv from ttkd_bsc.nhanvien x where x.thang = 202502 and a.MANV_PTM =x.ma_nv)ma_vtcv, loaitb_id, dichvuvt_id
        from ttkd_bsc.ct_bsc_ptm a
        where thang_ptm = 202502
        and ma_pb = 'VNP0703000' 
        and dich_vu = 'VNPTT'
        and loaitb_id = 21
     )
;

select ma_tb, count(*)sl from Tuyenngo.a_BHOL_temp a
where loaitb_id in(20,21)
and exists(select 1 from ttkd_bsc.dt_ptm_vnp_202502 where goi_luongtinh is not null and somay = a.ma_tb)
group by ma_tb ;
/* --------------------------------------------------- */

select count(sl_vnptt)sl from Tuyenngo.BHOL_temp ;
select * from Tuyenngo.BHOL_temp ;
SELECT * FROM CSS_HCM.LOAIHINH_TB WHERE LOAIHINH_TB LIKE '%Camera%' ;
-- drop table Tuyenngo.BHOL_temp purge ;
create table Tuyenngo.BHOL_temp as 
select manv_ptm, ma_vtcv, ma_to, ma_pb, loai_kpi
     , sum(case when loaitb_id in(58,59) then 1 else 0 end)sl_fiber
     , sum(case when loaitb_id in(61,171) then 1 else 0 end)sl_mytv
     , sum(case when loaitb_id = 210 then 1 else 0 end)sl_wfm
     , sum(case when loaitb_id = 222 then 1 else 0 end)sl_indoor
     , sum(case when loaitb_id = 224 then 1 else 0 end)sl_outdoor
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
    where thang_ptm = 202502
    and ma_pb = 'VNP0703000' 
    and loaitb_id in(20,58,59,61,171,210,222,224)
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
        where thang_ptm = 202502 
        and ma_pb = 'VNP0703000' 
        and loaitb_id = 21 
        and loaihd_id = 1 and TIEN_DNHM > 0
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
     , sum(case when loaitb_id = 222 then 1 else 0 end)sl_indoor
     , sum(case when loaitb_id = 224 then 1 else 0 end)sl_outdoor
     , sum(case when loaitb_id = 20 then 1 else 0 end)sl_vnpts
     , sum(case when loaitb_id = 21 then 1 else 0 end)sl_vnptt
     
from 
(
    select ma_tb, thang_ptm, manv_ptm, ma_vtcv, ma_to, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'LOAI_KPI
    from ttkd_bsc.ct_bsc_ptm 
    where thang_ptm = 202502
    and ma_pb = 'VNP0703000' 
    and ma_to in('VNP0703003','VNP0703005')
    and loaitb_id in(20,58,59,61,171,210,222,224)
    and loaihd_id = 1
    and trangthaitb_id not in(7,9) 

    union all

    SELECT ma_tb, thang_ptm, manv_ptm, ma_vtcv, ma_to, ma_pb, loaitb_id, dichvuvt_id, 'KPI_NV'loai_kpi
    FROM
    (
        select thang_ptm, ma_tb, dich_vu, manv_ptm, tennv_ptm, ma_pb, ten_pb, ma_to, ten_to
            , (select x.ma_vtcv from ttkd_bsc.nhanvien x where x.thang = 202502 and a.MANV_PTM =x.ma_nv)ma_vtcv, loaitb_id, dichvuvt_id
        from ttkd_bsc.ct_bsc_ptm a
        where thang_ptm = 202502
        and ma_pb = 'VNP0703000' 
        and dich_vu = 'VNPTT'
        and loaitb_id = 21
     )

) group by ma_to, ma_pb
;

select * from Tuyenngo.BHOL_temp ;

select * from tuyenngo.KPI_BRVNP_001_202502 where thang = 202502 ;

--alter table KPI_BRVNP_001_202502 add (sl_fiber number, sl_mytv number, sl_codinh number, sl_vnpts number, tong_ptm number) ;
--commit ;
/* ------------ up so thuc hien theo ma_nv ---------------- */
update KPI_BRVNP_001_202502 a set sl_fiber=0, sl_mytv=0, sl_wfm=0, sl_indoor = 0, sl_outdoor = 0, sl_vnpts=0, sl_vnptt=0, tong_ptm = 0 ;
update KPI_BRVNP_001_202502 a set (sl_fiber, sl_mytv, sl_wfm, sl_indoor, sl_outdoor, sl_vnpts, sl_vnptt, tong_ptm)
                            = ( select nvl(sl_fiber,0), nvl(sl_mytv,0), nvl(sl_wfm,0), nvl(sl_indoor,0), nvl(sl_outdoor,0)
                                    , nvl(sl_vnpts,0), nvl(sl_vnptt,0)
                                    , ( nvl(sl_fiber,0) + nvl(sl_mytv,0) + nvl(sl_wfm,0)/2
                                        + nvl(sl_indoor,0) + nvl(sl_outdoor,0) + nvl(sl_vnpts,0) + nvl(sl_vnptt,0) )
                                from Tuyenngo.BHOL_temp where manv_ptm = a.ma_nv and ma_vtcv = a.ma_vtcv)
where thang = 202502
;
commit ;
select * from tuyenngo.KPI_BRVNP_001_202502 where thang = 202502 ;
/* ------------ up so thuc hien theo ma_to ---------------- */

update KPI_BRVNP_001_202502 a set (sl_fiber, sl_mytv, sl_wfm, sl_indoor, sl_outdoor, sl_vnpts, sl_vnptt, tong_ptm)
                                 = ( select sl_fiber, sl_mytv, sl_wfm, sl_indoor, sl_outdoor, sl_vnpts, sl_vnptt
                                         , ( nvl(sl_fiber,0) + nvl(sl_mytv,0) + round(nvl(sl_wfm,0)/2,0)
                                           + nvl(sl_indoor,0) + nvl(sl_outdoor,0) + nvl(sl_vnpts,0) + nvl(sl_vnptt,0) )
                                     from Tuyenngo.BHOL_temp_to b
                                     where b.ma_to = a.ma_to
                                    )
where a.loai_kpi in('KPI_TT','KPI_TCA') ;
commit ;
select * from tuyenngo.KPI_BRVNP_001_202502 where thang = 202502 ;
/* ------------ cong so thuc hien theo ma_to cho PGD ---------------- */

update KPI_BRVNP_001_202502 a set (sl_fiber, sl_mytv, sl_wfm, sl_indoor, sl_outdoor, sl_vnpts, sl_vnptt, tong_ptm)
                                 = ( select sum(nvl(sl_fiber,0)), sum(nvl(sl_mytv,0)), sum(nvl(sl_wfm,0))
                                          , sum(nvl(sl_indoor,0)), sum(nvl(sl_outdoor,0))
                                          , sum(nvl(sl_vnpts,0)), sum(nvl(sl_vnptt,0)), sum(nvl(tong_ptm,0))
                                     from KPI_BRVNP_001_202502 b
                                     where loai_kpi in('KPI_TT')
                                    )
where a.loai_kpi = 'KPI_PGD' 
;
commit ;
select * from tuyenngo.KPI_BRVNP_001_202502 where thang = 202502 ;

select * from ttkd_bsc.blkpi_dm_to_pgd
where thang=202502
and dichvu is null
and ma_pb = 'VNP0703000'
;

select * from ttkd_bsc.blkpi_dm_to_pgd where ma_pb = 'VNP0703000' and thang = 202502 ;


select * from ttkd_bsc.x_tuyenngo_tl_bsc ;
select * from ttkd_bsc.tuyenngo_tl_bsc where ma_pb = 'VNP0703000' and thang = 202502 ;
--delete from ttkd_bsc.tuyenngo_tl_bsc where ma_pb = 'VNP0703000' and thang = 202502 ;
commit ;
INSERT INTO ttkd_bsc.tuyenngo_tl_bsc(THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, MA_NV, TEN_NV, LOAI_KPI, TL_MANV
                           , SL_FIBER, SL_MYTV, SL_WFM, SL_INDOOR, SL_OUTDOOR, SL_VNPTS, SL_VNPTT, TONG_PTM, ty_trong, dinhmuc_giao)

SELECT THANG, MA_KPI, MA_VTCV, TEN_VTCV, MA_TO, TEN_TO, MA_PB, TEN_PB, MA_NV, TEN_NV, LOAI_KPI, TT_MANV
     , SL_FIBER, SL_MYTV, SL_WFM, SL_INDOOR, SL_OUTDOOR, SL_VNPTS, SL_VNPTT, TONG_PTM, ty_trong, dinhmuc_giao
FROM TUYENNGO.KPI_BRVNP_001_202502 
;
commit ;
;
/*
update ttkd_bsc.tuyenngo_tl_bsc a set (tinh_bsc, thaydoi_vtcv) = (select tinh_bsc, thaydoi_vtcv 
                                                                    from TUYENNGO.KPI_BRVNP_001_202502 where ma_nv = a.ma_nv)
where thang = 202502 
;
commit ;
*/
/* ------------ UP VAO BANG KPI ----------------- */
select * from ttkd_bsc.bangluong_kpi a 
    where thang = 202502 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
/* ---------- NGAY 10/12/2024 HOC YC DELETE 03 BAN NAY, CO NHU Y LAM CHUNG --------------- */
update ttkd_bsc.bangluong_kpi a 
        set thuchien = ''
 where thang = 202502 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
commit ; 

update ttkd_bsc.bangluong_kpi a 
        set thuchien = (select round(nvl(tong_ptm,0),0) from TUYENNGO.KPI_BRVNP_001_202502 where ma_nv = a.ma_nv )
    where thang = 202502 and ma_kpi = 'HCM_SL_BRVNP_001' and ma_pb = 'VNP0703000'
;
commit ; 

/* -------- UP COT (GIAO = 1, THUCHIEN = 1) ----------- */
select * from ttkd_bsc.blkpi_danhmuc_kpi where thang = 202502 and ma_kpi = 'HCM_CL_CVIEC_021' ;
select * from ttkd_bsc.bangluong_kpi where thang = 202502 and ma_kpi = 'HCM_SL_BRVNP_001' 
and ma_nv in('CTV082375','CTV087435','VNP016547','VNP016581','VNP016763','VNP017103','VNP017141','VNP017852') ;

/* ------------- UP VAO BANG LUONG ----------------- */
select * from bangluong_kpi_bhol_temp where nvl(thuchien,0) > 0 ;
select * from bangluong_kpi_bhol_temp where nvl(mucdo_hoanthanh,0) > 0 ;

select * from bangluong_kpi_bhol where thang = 202502 and nvl(mucdo_hoanthanh,0) > 0  ;
rollback ;

--update ttkd_bsc.bangluong_kpi_bhol set  thang = 2025029999
--where thang = 202502 and GHICHU like 'KPI khong giao';

update ttkd_bsc.bangluong_kpi a set thang = 2025029999, GHICHU = 'KPI khong giao'

-- select * from ttkd_bsc.bangluong_kpi a
where thang = 2025029999
and exists(select 1 from ttkd_bsc.bangluong_kpi_bhol 
            where thang = 2025029999 and GHICHU like 'KPI khong giao'
            and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
;
commit ;
rollback ;

select * from ttkd_bsc.bangluong_kpi_bhol
where thang = 202502 
and ghichu ='Nhập theo vb đên khi TTKD duyệt nội dung này đang đề xuất tính BSC 1 chỉ tiêu " Mức độ hoàn thành khối lượng công việc trong tháng"'
;

select * from ttkd_bsc.blkpi_danhmuc_kpi where thang = 202502 ;
-- giờ tiếp phàn này, các th ghi chú vầy thì minh hok update từ BHOL vào BANGLUONG nhé, sử dụng số giao của vb
--> có 30 th này 

-- Còn lại thì update lai hêt nếu số BHOL khác số bangluong thì update bhol vào bangluong, còn giông thì hok update gì
select ma_nv, sum(tytrong) tytrong from ttkd_bsc.bangluong_kpi_bhol where thang = 202502 group by ma_nv ;

select * from ttkd_bsc.bangluong_kpi_bhol where thang = 2025029999 and GHICHU like 'KPI khong giao';
select * from ttkd_bsc.bangluong_kpi_bhol where thang = 202502 and GHICHU like '%KPI khong giao%'; 
select * from bangluong_kpi where thang = 2025029999 and GHICHU like '%KPI khong giao%'; 
select * from bangluong_kpi where thang = 202502 ; 

select distinct a.ma_kpi from bangluong_kpi_bhol_temp a 
where exists(select 1 from ttkd_bsc.blkpi_danhmuc_kpi 
                where thang = 202502 and ma_kpi = a.ma_kpi and nguoi_xuly = 'BHOL tự nhập')
;
select distinct a.ma_kpi from bangluong_kpi_bhol_temp a 
where not exists(select 1 from ttkd_bsc.blkpi_danhmuc_kpi 
                where thang = 202502 and ma_kpi = a.ma_kpi and nguoi_xuly = 'BHOL tự nhập')
;
SELECT THANG, MA_KPI, MA_NV, MA_VTCV, MA_TO, MA_PB, NGAYCONG, TYTRONG, DONVI_TINH, CHITIEU_GIAO, GIAO, THUCHIEN, TYLE_THUCHIEN
     , MUCDO_HOANTHANH, DIEM_CONG, DIEM_TRU, GHICHU
FROM bangluong_kpi_bhol where thang = 202502 ;

select * from bangluong_kpi_bhol a
where thang = 202502 
and exists(select 1 from bangluong_kpi_bhol_TEMP where thang = 202502 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
;
update bangluong_kpi_bhol a set (thuchien) 
                              = (select thuchien from bangluong_kpi_bhol_temp    
                                    where thang = 202502 and nvl(thuchien,0) > 0 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
-- select * from bangluong_kpi_bhol a
where a.thang = 202502 
and exists(select 1 from bangluong_kpi_bhol_TEMP where thang = 202502 
            and nvl(thuchien,0) > 0 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
;
commit ;

update bangluong_kpi_bhol a set mucdo_hoanthanh = (select mucdo_hoanthanh from bangluong_kpi_bhol_temp    
                                                where thang = 202502 and nvl(mucdo_hoanthanh,0) > 0 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
-- select * from bangluong_kpi_bhol a
where a.thang = 202502 
and exists(select 1 from bangluong_kpi_bhol_TEMP where thang = 202502 
            and nvl(mucdo_hoanthanh,0) > 0 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
;
commit ;

select * from ttkd_bsc.bangluong_kpi a 
where thang = 202502 and ma_pb = 'VNP0703000'
and exists(select 1 from bangluong_kpi_bhol_TEMP where thang = 202502 
            and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
;
update ttkd_bsc.bangluong_kpi a set mucdo_hoanthanh = (select mucdo_hoanthanh from bangluong_kpi_bhol    
                                                where thang = 202502 and nvl(mucdo_hoanthanh,0) > 0 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
where thang = 202502 and ma_pb = 'VNP0703000'
and exists(select 1 from bangluong_kpi_bhol_TEMP where thang = 202502 
            and nvl(mucdo_hoanthanh,0) > 0 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
;

update ttkd_bsc.bangluong_kpi a set thuchien = (select thuchien from bangluong_kpi_bhol    
                                                where thang = 202502 and nvl(thuchien,0) > 0 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
where thang = 202502 and ma_pb = 'VNP0703000' 
and exists(select 1 from bangluong_kpi_bhol_TEMP where thang = 202502 
            and nvl(thuchien,0) > 0 and ma_nv = a.ma_nv and ma_kpi = a.ma_kpi)
;
commit ;

update ttkd_bsc.bangluong_kpi a set thang = 2025029999, ghichu = 'Khanh YC Delete'

--Select THANG, MA_KPI, TEN_PB, TEN_TO, MA_NV, TEN_NV, MA_VTCV, TEN_VTCV, NGAYCONG, DONVI_TINH, CHITIEU_GIAO From ttkd_bsc.bangluong_kpi
Where thang = 2025029999
      and MA_KPI = 'HCM_TL_CSKH_001'
      and ma_nv in ('VNP065677','VNP016950','VNP017366','VNP020231','VNP019931',
                    'VNP017574','VNP017622','HCM004899','VNP017203','VNP017948',
                    'VNP017729','VNP022074','VNP022082','VNP017763','VNP017751',
                    'VNP017819','VNP017621','VNP017700','VNP017699','VNP001739');
commit ;