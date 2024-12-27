select * from ttkd_bsc.ct_bsc_ptm where ma_tb = 'hcm_connect_00000167' ;
where ma_tb in('84852451618','84852451918','84852874718','84852874918','84852875718','84852064573','84852008817','84852016729','84852014332'
                ,'84852015400','84852017242','84852021104','84852021128','84852021634','84852022087','84852023764','84852023884','84852025476'
                ,'84852025557','84852052485','84852053445','84852054292','84852054475','84852062138','84852067247')
and thang_ptm = 202410
;
select * from ttkd_bsc.dt_ptm_vnp_202410 
where somay in('84852451618','84852451918','84852874718','84852874918','84852875718','84852064573','84852008817','84852016729','84852014332'
                ,'84852015400','84852017242','84852021104','84852021128','84852021634','84852022087','84852023764','84852023884','84852025476'
                ,'84852025557','84852052485','84852053445','84852054292','84852054475','84852062138','84852067247')
;


select * FROM ttkdhcm_ktnv.v_bangiao_hoso_new a where MA_TB in('915985698','916446188','945409775') ;
select * FROM ttkdhcm_ktnv.v_bangiao_hoso_new a  
where ma_tb in('84849283390','84849879350','84849566761','84848196202','84845327870','84845327820','84845706891','84847750531')  ;
select * from tam_luuhs a ;

create table tam_luuhs as SELECT * FROM ttkd_bsc.tam_luuhs@dhsxkd ; /* TAO FILE QUA BSC */

drop table tam_luuhs_20241114 purge ;
create table tam_luuhs_20241114 as 
        SELECT * --ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du
--            , ngay_nop, ngay_bg, dinhkem, econtract_app -- econtract_app = 1 l� qua App
        from ttkd_bct.bangiao_hoso_tinhbsc
            where ma_tb in('hcm_ca_00086792','hcm49bishaugiang_1','49bishaugiang_2','ngokhoai_71','hcmngokhoai71','49bishaugiang_1')
--        where trunc(ngay_bg) between to_date('01/01/2024','dd/mm/yyyy') and to_date('13/11/2024','dd/mm/yyyy')
--        where ma_tb in('84845350517','84848906125','84849353910')
        where ma_gd in('00979304','HCM-LD/01975983','HCM-LD/01975983','HCM-LD/01987766','HCM-LD/01987766','HCM-LD/01975983')
--        where ma_tb in('vithiem29','ngocluongmai','hcm_smartca_00388096','hcm_smartca_00389154','hcm_smartca_00389298','hcm_smartca_00396154')

;
commit ;
create table tam_luuhs_20241114 as select * from tuyenngo.tam_luuhs_20241114 ;
select * FROM ttkd_bct.tam_luuhs_20241114 a ;
select * FROM ttkd_bct.nt_tam_luuhs_20241114 a ;

--create table ttkd_bct.nt_tam_luuhs_20241114 as 
-- drop table nt_tam_luuhs_20241114 purge ;
create table nt_tam_luuhs_20241114 as 
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
        FROM ttkd_bct.tam_luuhs_20241114 a 
--        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, nhanvien_id, nop_du
      ) a 
  ) a 
-- group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20241114_HDID ON nt_tam_luuhs_20241114 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20241114_matb ON nt_tam_luuhs_20241114 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20241114_magd ON nt_tam_luuhs_20241114 (ma_gd ASC) ;


select * from ttkd_bct.nt_tam_luuhs_20241114 where to_char(ngay_nop_du,'yyyymm') >= 202407 ;
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
        ( select distinct '20241114', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241114 b 
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
        ( select distinct '20241114', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241114 b 
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

select * from ttkd_bct.nt_tam_luuhs_20241114 a where lpad(ma_tb,4) = '1388' ;
select * from ttkd_bct.bangiao_hoso_tinhbsc a where lpad(ma_tb,4) = '1388' ;

update ttkd_bct.nt_tam_luuhs_20241114 a set ma_tb = '84'||trim(ma_tb)
where lpad(ma_tb,4)='1388' ;
commit ;

select a.* from ttkd_bct.nt_tam_luuhs_20241114 a
where dichvuvt_id = 2 and econtract_app = 1
and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
            where ma_tb = a.ma_tb and nop_du is null
            and thang_ptm >= 202407
            and dich_vu = 'VNPTS'
                )
;


select a.* from ttkd_bct.nt_tam_luuhs_20241114 a
where exists(select 1 from (
select ma_tb, ma_gd, count(*)sl
from ttkd_bct.nt_tam_luuhs_20241114 a
where dichvuvt_id = 2 
and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
            where ma_tb = a.ma_tb and ma_gd = a.ma_gd 
                and (nop_du is null or nop_du = 0)
                )
group by ma_tb, ma_gd having count(*) > 1 
) where ma_tb = a.ma_tb and ma_gd = a.ma_gd );

-- ma_tb in('84911051671','84911010726','84913789337','84837896633','84918697708','84832963222','84835963222','84911780695','84829988282','84813359898','84919630552','84847155302','84836862233')
select * from ttkd_bct.nt_tam_luuhs_20241114 a --where dichvuvt_id = 2 ;
where nop_du=1 and to_char(ngay_nop_du,'yyyymmdd') >= '20240701' and ma_gd like 'HCM-LD%'
and exists(select 1 from ttkd_bsc.dt_ptm_vnp_202407 where somay=a.ma_tb) ;

select a.ma_tb, a.ma_gd, ngay_luuhs_ttkd, ngay_luuhs_ttvt, nop_du
from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202407 and (nop_du is null or nop_du=0)
and nguon='dt_ptm_vnp'
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241114 where ma_tb=a.ma_tb and ma_gd = a.ma_gd and nop_du=1) ;

select a.ma_tb, a.ma_gd, ngay_luuhs_ttkd, ngay_luuhs_ttvt, nop_du
from ttkd_bsc.ct_bsc_ptm a
where thang_ptm=202407 and (nop_du is null or nop_du=0)
and nguon='dt_ptm_vnp'
and not exists(select 1 from ttkd_bct.nt_tam_luuhs_20241114 where ma_tb=a.ma_tb) ;


/* ---------- KIEM TRA TRUOC KHI UP ------------ */
select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202407 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;

/*---------------- UP THUE BAO econtract_app <> 1 ------------------- */ 

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241114',b.nop_du
                , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
                , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end) --, ma_tb, ma_gd
          from ttkd_bct.nt_tam_luuhs_20241114 b 
          where nop_du=1 and b.ngay_nop_du is not null and econtract_app <> 1
          and dichvuvt_id = 2
          and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd
) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202407 
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241114 b 
            where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd
                and nop_du=1 and b.ngay_nop_du is not null and econtract_app <> 1 
                and dichvuvt_id = 2
           ) 
;
COMMIT ;

drop table ttkd_bct.nt_tam_luuhs_20241114_bs purge ;
create table ttkd_bct.nt_tam_luuhs_20241114_bs as
select distinct ma_tb, nop_du, donvi_nhap, max(ngay_nop_du)ngay_nop_du, max(ngay_bg)ngay_bg
from ttkd_bct.nt_tam_luuhs_20241114 a
where dichvuvt_id = 2
and to_char(ngay_nop_du,'yyyymm') >= '202407'
and econtract_app = 1
and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
            where ma_tb = a.ma_tb and nop_du is null
            and thang_ptm >= 202407 and DICH_VU in('VNPTS','VCC')
            )
group by ma_tb, nop_du, donvi_nhap
;
select ma_tb, count(*)sl from ttkd_bct.nt_tam_luuhs_20241114_bs group by ma_tb ;
/* ----------- UP THUE BAO econtract_app = 1 ------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd)=
        ( select distinct '20241114',b.nop_du, b.ngay_bg
--                , (case when donvi_nhap='TTKD' then  else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241114_bs b 
          where nop_du=1 and b.ngay_nop_du is not null  -- and b.dinhkem <> 4
          and DONVI_NHAP = 'TTKD' 
          and to_char(ngay_nop_du,'yyyymm') >= '202407'
          and b.ma_tb=a.ma_tb --and b.ma_gd=a.ma_gd           
) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202407 
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241114_bs b 
            where b.ma_tb=a.ma_tb --and b.ma_gd=a.ma_gd 
                and nop_du=1 and b.ngay_nop_du is not null   -- and dinhkem <> 4 
          and DONVI_NHAP = 'TTKD' 
            and to_char(ngay_nop_du,'yyyymm') >= '202407'
                ) 
;
COMMIT ;

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttvt)=
        ( select distinct '20241114',b.nop_du, b.ngay_bg
--                , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
--                , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--                , ma_tb
          from ttkd_bct.nt_tam_luuhs_20241114_bs b 
          where nop_du=1 and b.ngay_nop_du is not null  -- and b.dinhkem <> 4
          and DONVI_NHAP = 'TTVT' 
          and to_char(ngay_nop_du,'yyyymm') >= '202407'
          and b.ma_tb=a.ma_tb --and b.ma_gd=a.ma_gd           
) 
where (nop_du is null or nop_du=0) and thang_ptm >= 202407 
and DICH_VU in('VNPTS','VCC')
and exists(select 1 from ttkd_bct.nt_tam_luuhs_20241114_bs b 
            where b.ma_tb=a.ma_tb --and b.ma_gd=a.ma_gd 
                and nop_du=1 and b.ngay_nop_du is not null   -- and dinhkem <> 4 
          and DONVI_NHAP = 'TTVT' 
            and to_char(ngay_nop_du,'yyyymm') >= '202407'
                ) 
;
COMMIT ;

rollback ;

