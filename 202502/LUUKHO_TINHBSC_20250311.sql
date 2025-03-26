drop table tam_luuhs_20250316 purge ;
create table tam_luuhs_20250316 as 
       select * from ttkd_bct.bangiao_hoso_tinhbsc a
--        from ttkdhcm_ktnv.bangiao_hoso_tinhbsc a
       where
       --ngay_insert > trunc(sysdate)
        
--       ma_tb in('ntkien_2','hongthu_eco5')
        trunc(ngay_bg) between to_date('01/10/2024','dd/mm/yyyy') and to_date('15/03/2025','dd/mm/yyyy')
        and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
                    where thang_ptm >= 202411 and nop_du is null and ma_tb = a.ma_tb)
;

-- MA_GD = '01030886', ma_tb = 'hcm_smartca_00108960'
commit ;
create index tam_luuhs_20250316_matb on tam_luuhs_20250316 (ma_tb) ;

select * from tam_luuhs_20250316 a 
where exists(select 1 from ttkd_bsc.ct_bsc_ptm 
                where loaitb_id in(1,58,59,61,171) and nop_du is null 
                    and doituong_kh = 'KHCN'
                    and thang_ptm = 202412
                    and ma_tb = a.ma_tb)
and a.ECONTRACT_APP = 1
and loaitb_id in(1,58,59,61,171)
;
select a.* from ttkd_bsc.ct_bsc_ptm a
where loaitb_id in(1,58,59,61,171) and nop_du is null 
  and doituong_kh = 'KHCN'
  and thang_ptm >= 202412
  and mien_hsgoc is null
  and exists(select 1 from ttkd_bct.tam_luuhs_20250316 
                where ECONTRACT_APP = 1
                and loaitb_id in(1,58,59,61,171)
                and nop_du = 1
                and ma_tb = a.ma_tb)
;

select a.* from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202411
  and nop_du is null
  and exists(select 1 from ttkd_bsc.tam_luuhs_20250316 
                where nop_du = 1
                and ma_tb = a.ma_tb)
;

update ttkd_bsc.ct_bsc_ptm a set bs_luukho = 20250309, a.nop_du = 1, a.ngay_luuhs_ttkd = sysdate,a.ngay_luuhs_ttvt = sysdate
                                , ghi_chu =  'Bo sung theo YC cua P.DH - DAN TUYEN'
-- select * from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202411 and ( nop_du is null or nop_du = 0 )
and exists(select 1 from ttkd_bsc.hsg_bosung b where b.ma_gd=a.ma_gd )
and loaitb_id in(1,58,59,61,171) and doituong_kh = 'KHCN'
;
commit ;

--create table ttkd_bct.nt_tam_luuhs_20250316 as 
-- drop table nt_tam_luuhs_20250316 purge ;
create table nt_tam_luuhs_20250316 as 
select distinct ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, econtract_app, donvi_nhap, nhanvien_id, donvi_id_nhap, 
       decode(donvi_id_nhap,283466,'TTVT SG',283452,'TTVT CL',283467,'TTVT GD',283451,'TTVT TB',283453,'TTVT BC',283454,'TTVT CC',
                            283455,'TTVT HM',283468,'TTVT NSG',283469,'TTVT TD') ten_ttvt, nop_du, 
       ngay_nop_du, ngay_bg, ngay_nop
--       max(ngay_nop_du)ngay_nop_du, min(ngay_bg)ngay_bg
from 
  ( 
   select ma_tb, loaitb_id, dichvuvt_id, ma_gd, econtract_app, hdtb_id, ngay_nop_du, ngay_bg, ngay_nop, a.nop_du,
         ( case when (select d.donvi_id from admin_hcm.nhanvien c,admin_hcm.donvi b, admin_hcm.donvi d 
                      where c.nhanvien_id=a.nhanvien_id and c.donvi_id=b.donvi_id 
                        and b.donvi_cha_id=d.donvi_id) in(283466,283452,283467,283451,283453,283454,283455,283468,283469) then 'TTVT' 
                        else 'TTKD' end
         ) donvi_nhap, nhanvien_id, 
         ( select d.donvi_id from admin_hcm.nhanvien c,admin_hcm.donvi b, admin_hcm.donvi d 
            where c.nhanvien_id=a.nhanvien_id and c.donvi_id=b.donvi_id and b.donvi_cha_id=d.donvi_id
         ) donvi_id_nhap
    from
      (    
        SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, econtract_app, hdtb_id, nhanvien_bg nhanvien_id, nop_du
                , ngay_nop_du, ngay_bg, ngay_nop
--                , max(ngay_nop_du) ngay_nop_du, max(ngay_bg)ngay_bg, max(ngay_nop) ngay_nop
        FROM ttkd_bct.tam_luuhs_20250316 a 
--        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, nhanvien_id, nop_du
      ) a 
  ) a 
-- group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20250316_HDID ON nt_tam_luuhs_20250316 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20250316_matb ON nt_tam_luuhs_20250316 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20250316_magd ON nt_tam_luuhs_20250316 (ma_gd ASC) ;

select * from nt_tam_luuhs_20250316 ;
/* ----------------------- TEST TRUOC KHI UP -------------------- */
select nguon, thang_luong, thang_ptm, ma_tb, ma_gd, hdtb_id, dich_vu, nop_du, bs_luukho, ngay_luuhs_ttkd, ngay_luuhs_ttvt
    , lydo_khongtinh_dongia, doituong_kh, loaitb_id, dichvuvt_id, dthu_ps
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202411
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon = 'ptm_codinh'
;

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202411
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm order by nguon, thang_luong, thang_ptm ;

/* --------- UPDATE LOAITB_ID NOT IN(1,58,59,61,171) - UPDATE NGAY 04/01/2025 ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt)=
                                ( select distinct '20250316', b.nop_du
                                    , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
                                    , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
                           --         , loaitb_id, econtract_app
                                  from ttkd_bct.nt_tam_luuhs_20250316 b 
                                    where b.loaitb_id not in(1,58,59,61,171)                 
                                        and b.nop_du=1 and b.ngay_nop_du is not null
                                        and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
                                ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, loaitb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202411 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and loaitb_id not in(1,58,59,61,171) 
 and nguon is not null
; 
commit ;
rollback ;
/* --------- UPDATE LOAITB_ID NOT IN(1,58,59,61,171) - UPDATE NGAY 04/01/2025 ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250316', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
   --         , loaitb_id, econtract_app
          from ttkd_bct.nt_tam_luuhs_20250316 b 
            where b.nop_du=1 and b.ngay_nop_du is not null
                and loaitb_id in(1,58,59,61,171)
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) 
 and thang_ptm = 202411
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
; 
commit ;

/* --------- KHDN ------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250316', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--            , b.econtract_app
          from ttkd_bct.nt_tam_luuhs_20250316 b 
            where b.loaitb_id in(1,58,59,61,171) 
                and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202412 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and doituong_kh = 'KHDN'
; 
commit ;
/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/03/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250316', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--            , b.econtract_app
          from ttkd_bct.nt_tam_luuhs_20250316 b 
            where b.loaitb_id in(1,58,59,61,171) 
                and b.econtract_app = 1
                and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202412 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000')
 and doituong_kh = 'KHCN'
; 
commit ;

/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/03/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250316', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--            , b.econtract_app
          from ttkd_bct.nt_tam_luuhs_20250316 b 
            where b.loaitb_id in(1,58,59,61,171) 
                and b.econtract_app = 1
                and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202501
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
; 
commit ;

/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/03/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250316', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--            , b.econtract_app
          from ttkd_bct.nt_tam_luuhs_20250316 b 
            where b.loaitb_id in(1,58,59,61,171) 
                 and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm = 202412
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in ('VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
; 
commit ;
select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt
from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202411
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and nguon is not null
 and dich_vu not in('VNPTS','VCC','VNPTT')
; 
/* --------------------------------- */
-- ma_pb in ('VNP0702300','VNP0702400','VNP0702500')

/* ----------------------- TEST TRUOC KHI UP -------------------- */

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202411
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm order by nguon, thang_luong, thang_ptm ;

/* ------------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT ------------- */
select * from ttkd_bct.nt_tam_luuhs_20250316 
where loaitb_id in(1,58,59,61,171) 
and econtract_app = 1
;

select * from ttkd_bct.tam_luuhs_20250316 
where loaitb_id in(1,58,59,61,171) 
and econtract_app = 1
;

/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/03/2025 KHCN ------------------ */
--- chay code này HỌC
MERGE INTO ttkd_bsc.ct_bsc_ptm a
USING ( select distinct '20250316', ma_tb, ma_gd, hdtb_id, b.nop_du
						  , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end) ngay_luuhs_ttkd
						  , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end) ngay_luuhs_ttvt
						  , 'KHCN, Thuê bao ĐTCĐ, FIBER, MYTV PTM không ký qua Hđđt' lydo_khongtinh_luong
			 from ttkd_bct.nt_tam_luuhs_20250316 b 
			  where b.loaitb_id in(1,58,59,61,171) 
				 and b.econtract_app = 0
				 and b.nop_du=1 and b.ngay_nop_du is not null 
		) b
ON (b.ma_tb = a.ma_tb and b.ma_gd = a.ma_gd and b.hdtb_id = a.hdtb_id)
WHEN MATCHED THEN
	UPDATE SET 
						a.bs_luukho = '20250316'
						, a.nop_du = b.nop_du
						, a.ngay_luuhs_ttkd = b.ngay_luuhs_ttkd
						, a.ngay_luuhs_ttvt = b.ngay_luuhs_ttvt
						, a.lydo_khongtinh_luong = a.lydo_khongtinh_luong || b.lydo_khongtinh_luong
	WHERE (nop_du is null or nop_du=0) and thang_ptm >= 202412 
				 and mien_hsgoc is null 
				 and loaitb_id in(1,58,59,61,171) 
				 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800'
                             ,'VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
				 and doituong_kh = 'KHCN'
;
commit ;

rollback ;

select thang_ptm, ma_tb, dich_vu, nop_du, bs_luukho, ngay_luuhs_ttkd, ma_pb, ten_pb, doituong_kh, lydo_khongtinh_luong
from ttkd_bsc.ct_bsc_ptm a 
where lydo_khongtinh_luong like  '%KHCN, Thuê bao ĐTCĐ, FIBER, MYTV PTM không ký qua Hđđt%' 
;

select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, lydo_khongtinh_luong
from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202412 
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
;
commit ;
/* ------------------------------ UP VINA.TS ---------------------------------- */
select thang_ptm, ma_tb, ma_gd, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202411 
--and (nop_du is null or nop_du=0) 
and nop_du = 1
and DICH_VU in('VNPTS','VCC')
 ;
select thang_ptm, count(*)sl
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202411 
--and (nop_du is null or nop_du=0) 
and nop_du = 1
and DICH_VU in('VNPTS','VCC')
group by thang_ptm
 ;
/* ---------- KIEM TRA TRUOC KHI UP ------------ */
select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202411 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;

/*---------------- UP THUE BAO econtract_app <> 1 ------------------- */ 
/* ---------- UP THANG N-3 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250316' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('09/03/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('09/03/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250316 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202411' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202411 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;

/* ---------- UP THANG N-2 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250316' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('09/03/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('09/03/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250316 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202412' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202412
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
/* ---------- UP THANG N-1 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250316' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('09/03/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('09/03/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250316 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202411' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202501
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
/* ---------- UP THANG N -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250316' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('09/03/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('09/03/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250316 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202412' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202502 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
COMMIT ;

/* ---------- KIEM TRA TRUOC KHI UP ------------ */
select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202411 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;

