drop table tam_luuhs_20241207 purge ;
create table tam_luuhs_20241207 as 
        SELECT * --ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du
--            , ngay_nop, ngay_bg, dinhkem, econtract_app -- econtract_app = 1 l� qua App
        from ttkd_bct.bangiao_hoso_tinhbsc a
        where exists(select 1 from ttkd_bsc.a_bhcl where ma_tb = a.ma_tb)
--        where ma_gd = 'HCM-LD/02007688'
--        where trunc(ngay_bg) between to_date('01/08/2024','dd/mm/yyyy') and to_date('12/12/2024','dd/mm/yyyy')
--        and MA_TB IN('thucphambvn_241','hcm_ivan_00043546','hcm_ca_00121006','39302071','hcm_hddt_00024609','hcm_bldt_00000500','colo_00000103'
--                    ,'colo_00000115','hcm_bldt_00000385','hcm_smartca_00351917','hcm_ioff_00000660','hcm_ioff_00000698','hcm_edu_00010109'
--                      ,'hcm_ca_00035195','hcm_ca_00103203','hcm_ivan_00013201')
--         and ma_tb in('nhai-112024','hcm_ca_00120511','84912983538','84915597178','84917675738','84913967278','84849612610','84847872273'
  --                  ,'84849597827','84848263122','84847796002','thanhthao1251','thaihoc3212','giahoa194','thinhphat122')
--        where ma_gd in('00979304','HCM-LD/01975983','HCM-LD/01975983','HCM-LD/01987766','HCM-LD/01987766','HCM-LD/01975983')
--        where ma_tb in('vithiem29','ngocluongmai','hcm_smartca_00388096','hcm_smartca_00389154','hcm_smartca_00389298','hcm_smartca_00396154')

;
commit ;
create table tam_luuhs_20241207 as select * from tuyenngo.tam_luuhs_20241207 ;
select * FROM ttkd_bct.tam_luuhs_20241207 a where ma_tb = '84822060551';
select * FROM ttkd_bct.nt_tam_luuhs_20241207 a where ma_tb = '84822060551' ; ma_tb in('hcm_edu_00009891','hcm_edu_lms_00001028') ;

--create table ttkd_bct.nt_tam_luuhs_20241207 as 
-- drop table nt_tam_luuhs_20241207 purge ;
create table nt_tam_luuhs_20241207 as 
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
        FROM ttkd_bct.tam_luuhs_20241207 a 
--        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, nhanvien_id, nop_du
      ) a 
  ) a 
-- group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20241207_HDID ON nt_tam_luuhs_20241207 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20241207_matb ON nt_tam_luuhs_20241207 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20241207_magd ON nt_tam_luuhs_20241207 (ma_gd ASC) ;


select * from ttkd_bct.nt_tam_luuhs_20241207 where to_char(ngay_nop_du,'yyyymm') >= 202408 ;
/* --------------------------------------------- */
select a.thang_ptm, a.ma_tb, a.nop_du, a.dich_vu, nguon, ngay_luuhs_ttvt, ngay_luuhs_ttkd
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202408 
and nop_du=1 and (a.ngay_luuhs_ttkd is not null or a.ngay_luuhs_ttvt is not null) and dichvuvt_id not in(2) ;

rollback ;

select hdtb_id from ttkd_bsc.ct_bsc_ptm a 
;
/* ----------------------- TEST TRUOC KHI UP -------------------- */

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202408
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm order by nguon, thang_luong, thang_ptm ;

/* --------- UPDATE NGAY 19/05/2023 ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241210', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241207 b 
            where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd --and b.hdtb_id=a.hdtb_id
              and b.nop_du=1 and b.ngay_nop_du is not null -- and econtract_app <> 1 
        ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) AND thang_luong in(86,87) --and thang_ptm >= 202408 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and nguon is not null
-- and nguon in('thaydoitocdo','ptm_codinh')
; 
commit ;


update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241207', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241207 b 
            where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
              and b.nop_du=1 and b.ngay_nop_du is not null -- and econtract_app <> 1 
        ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202408 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and nguon is not null
-- and nguon in('thaydoitocdo','ptm_codinh')
; 
commit ;
rollback ;
/*
update ttkd_bsc.ct_bsc_ptm a set bs_luukho = '', nop_du = '', ngay_luuhs_ttkd = '', ngay_luuhs_ttvt = ''
-- select * from ttkd_bsc.ct_bsc_ptm 
where bs_luukho = '20241113' ;
commit ;
*/
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241207', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241207 b 
            where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd 
              and b.nop_du=1 and b.ngay_nop_du is not null and econtract_app = 1 
        ) 
-- select a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202408 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and nguon is not null
; 
commit ;

rollback ;
select * from ttkd_bsc.ct_bsc_ptm a where nguon='ptm_codinh_202408' ;

/* ---------- UP VINA.TS ----------- */
select thang_ptm, ma_tb, ma_gd, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202408 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
 ;

/* ---------- KIEM TRA TRUOC KHI UP ------------ */
select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202408 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;

/*---------------- UP THUE BAO econtract_app <> 1 ------------------- */ 
/* ---------- UP THANG N-3 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20241207' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/12/2024','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/12/2024','dd/mm/yyyy')
where exists(select * from ttkd_bct.nt_tam_luuhs_20241207 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') > '202408' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202408 ;
/* ---------- UP THANG N-2 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20241207' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/12/2024','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/12/2024','dd/mm/yyyy')
where exists(select * from ttkd_bct.nt_tam_luuhs_20241207 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202409' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202409 ;
/* ---------- UP THANG N-1 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20241207' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/12/2024','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/12/2024','dd/mm/yyyy')
where exists(select * from ttkd_bct.nt_tam_luuhs_20241207 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202410' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202410 ;
/* ---------- UP THANG N -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20241207' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/12/2024','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/12/2024','dd/mm/yyyy')
where exists(select * from ttkd_bct.nt_tam_luuhs_20241207 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202411' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202411 ;
COMMIT ;

