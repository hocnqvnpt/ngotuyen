drop table tam_luuhs_20241119 purge ;
create table tam_luuhs_20241119 as 
        SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du, ngay_insert
            , ngay_nop, ngay_bg, dinhkem, econtract_app -- econtract_app = 1 là qua App
        from ttkd_bct.bangiao_hoso_tinhbsc a 
--        where trunc(ngay_bg) between to_date('01/01/2024','dd/mm/yyyy') and to_date('19/11/2024','dd/mm/yyyy')
--        where ma_tb in('vithiem29','ngocluongmai')
--        where ma_tb in ('84845856762')
  --      and ma_tb in('84849967127','84845628367','84849366715','84849387501','84849358765','84849473664','84839313468','84846276680')
  --      and ma_tb in('84919605111','84847679190','84911464786','84846985563','84846668791','84849907780')
  --      and ma_tb in('84846257702','84849908502','84846773351','84914189486','84848158150','84915999305','84813551242')
        and ma_tb in('hcm_ivan_00039601','84845907880','84845538803','84849365733','84918079859','84847770625','84845165661','hcmquangvuong','84849322712')
--        where a.ngay_insert > trunc(sysdate) ;

;
('84911464786','84848158150','84845165661','84845907880','hcm_ivan_00039601')
commit ;
create table tam_luuhs_20241119 as select * from tuyenngo.tam_luuhs_20241119 ;
select * FROM ttkd_bct.tam_luuhs_20241119 a ;
select * FROM ttkd_bct.nt_tam_luuhs_20241119 a ;

--create table ttkd_bct.nt_tam_luuhs_20241119 as 
-- drop table nt_tam_luuhs_20241119 purge ;
create table nt_tam_luuhs_20241119 as 
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
        SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, econtract_app, hdtb_id, nhanvien_id, nop_du
                , ngay_nop_du, ngay_bg, ngay_nop
--                , max(ngay_nop_du) ngay_nop_du, max(ngay_bg)ngay_bg, max(ngay_nop) ngay_nop
        FROM ttkd_bct.tam_luuhs_20241119 a 
--        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, nhanvien_id, nop_du
      ) a 
  ) a 
-- group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20241119_HDID ON nt_tam_luuhs_20241119 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20241119_matb ON nt_tam_luuhs_20241119 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20241119_magd ON nt_tam_luuhs_20241119 (ma_gd ASC) ;


select * from ttkd_bct.nt_tam_luuhs_20241119 
--where to_char(ngay_nop_du,'yyyymm') >= 202407 ;
where ma_tb in('84849967127','84845628367','84849366715','84849387501','84849358765','84849473664','84839313468','84846276680')

where ma_tb in('84845350517','84848906125','8484935391','84846102785','84848569033','84846863512','84848187762','84845717522'
            ,'84846179390','84846511652','84849380340','84848285581','84849425870','84845079872','84848799651','84849457970'
            ,'84845284130','84846973760','84845289121')
;
/* --------------------------------------------- */
select a.thang_ptm, a.ma_tb, a.nop_du, a.dich_vu, nguon, ngay_luuhs_ttvt, ngay_luuhs_ttkd
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202407 
and nop_du=1 and (a.ngay_luuhs_ttkd is not null or a.ngay_luuhs_ttvt is not null) and dichvuvt_id not in(2) ;

rollback ;

select hdtb_id from ttkd_bsc.ct_bsc_ptm a 
;
/* ----------------------- TEST TRUOC KHI UP -------------------- */

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202407
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm order by nguon, thang_luong, thang_ptm ;

/* --------- UPDATE NGAY 19/05/2023 ------------------ */

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241119', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241119 b 
            where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
              and b.nop_du=1 and b.ngay_nop_du is not null -- and econtract_app <> 1 
        ) 
-- select a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202407 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and nguon is not null
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
        ( select distinct '20241119', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241119 b 
            where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd 
              and b.nop_du=1 and b.ngay_nop_du is not null and econtract_app = 1 
        ) 
-- select a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202407 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and nguon is not null
; 
commit ;

rollback ;
select * from ttkd_bsc.ct_bsc_ptm a where nguon='ptm_codinh_202407' ;

/* ---------- UP VINA.TS ----------- */
select a.* from ttkd_bct.nt_tam_luuhs_20241119 a
where exists(select 1 from (
select ma_tb, ma_gd, count(*)sl
from ttkd_bct.nt_tam_luuhs_20241119 a
where dichvuvt_id = 2 
and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
            where ma_tb = a.ma_tb and ma_gd = a.ma_gd 
                and (nop_du is null or nop_du = 0)
                )
group by ma_tb, ma_gd having count(*) > 1 
) where ma_tb = a.ma_tb and ma_gd = a.ma_gd );


select a.ma_tb, a.ma_gd, ngay_luuhs_ttkd, ngay_luuhs_ttvt, nop_du
from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202407 and (nop_du is null or nop_du=0)
and nguon='dt_ptm_vnp'
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241119 where ma_tb=a.ma_tb and ma_gd = a.ma_gd and nop_du=1) ;

select a.ma_tb, a.ma_gd, ngay_luuhs_ttkd, ngay_luuhs_ttvt, nop_du
from ttkd_bsc.ct_bsc_ptm a
where thang_ptm=202407 and (nop_du is null or nop_du=0)
and nguon='dt_ptm_vnp'
and not exists(select 1 from ttkd_bct.nt_tam_luuhs_20241119 where ma_tb=a.ma_tb) ;


/* ---------- KIEM TRA TRUOC KHI UP ------------ */
select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202407 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;

/*---------------- UP THUE BAO econtract_app <> 1 ------------------- */ 

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241119',b.nop_du
                , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
                , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end) --, ma_tb, ma_gd
          from ttkd_bct.nt_tam_luuhs_20241119 b 
          where nop_du=1 and b.ngay_nop_du is not null --and econtract_app <> 1
          and dichvuvt_id = 2
          and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd
) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202407 
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241119 b 
            where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd
                and nop_du=1 and b.ngay_nop_du is not null --and econtract_app <> 1 
                and dichvuvt_id = 2
           ) 
;
COMMIT ;

drop table ttkd_bct.nt_tam_luuhs_20241119_bs purge ;
create table ttkd_bct.nt_tam_luuhs_20241119_bs as
select distinct ma_tb, nop_du, donvi_nhap, max(ngay_nop_du)ngay_nop_du, max(ngay_bg)ngay_bg
from ttkd_bct.nt_tam_luuhs_20241119 a
where dichvuvt_id = 2
and to_char(ngay_nop_du,'yyyymm') >= '202407'
and econtract_app = 1
and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
            where ma_tb = a.ma_tb and nop_du is null
            and thang_ptm >= 202407 and DICH_VU in('VNPTS','VCC')
            )
group by ma_tb, nop_du, donvi_nhap
;
select ma_tb, count(*)sl from ttkd_bct.nt_tam_luuhs_20241119_bs group by ma_tb ;
/* ----------- UP THUE BAO econtract_app = 1 ------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd)=
        ( select distinct '20241119',b.nop_du, b.ngay_bg
--                , (case when donvi_nhap='TTKD' then  else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241119_bs b 
          where nop_du=1 and b.ngay_nop_du is not null  -- and b.dinhkem <> 4
          and DONVI_NHAP = 'TTKD' 
          and to_char(ngay_nop_du,'yyyymm') >= '202407'
          and b.ma_tb=a.ma_tb --and b.ma_gd=a.ma_gd           
) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202407 
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241119_bs b 
            where b.ma_tb=a.ma_tb --and b.ma_gd=a.ma_gd 
                and nop_du=1 and b.ngay_nop_du is not null   -- and dinhkem <> 4 
          and DONVI_NHAP = 'TTKD' 
            and to_char(ngay_nop_du,'yyyymm') >= '202407'
                ) 
;
COMMIT ;

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttvt)=
        ( select distinct '20241119',b.nop_du, b.ngay_bg
--                , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
--                , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--                , ma_tb
          from ttkd_bct.nt_tam_luuhs_20241119_bs b 
          where nop_du=1 and b.ngay_nop_du is not null  -- and b.dinhkem <> 4
          and DONVI_NHAP = 'TTVT' 
          and to_char(ngay_nop_du,'yyyymm') >= '202407'
          and b.ma_tb=a.ma_tb --and b.ma_gd=a.ma_gd           
) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202407 
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241119_bs b 
            where b.ma_tb=a.ma_tb --and b.ma_gd=a.ma_gd 
                and nop_du=1 and b.ngay_nop_du is not null   -- and dinhkem <> 4 
          and DONVI_NHAP = 'TTVT' 
            and to_char(ngay_nop_du,'yyyymm') >= '202407'
                ) 
;
COMMIT ;

rollback ;

