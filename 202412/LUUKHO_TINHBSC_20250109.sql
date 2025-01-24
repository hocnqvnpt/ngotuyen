drop table tam_luuhs_20250114_bs purge ;
create table tam_luuhs_20250114_bs as ;
        SELECT * --ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du
--            , ngay_nop, ngay_bg, dinhkem, econtract_app -- econtract_app = 1 l� qua App
        from ttkd_bct.bangiao_hoso_tinhbsc a
--        from ttkdhcm_ktnv.bangiao_hoso_tinhbsc a
       where trunc(ngay_bg) between to_date('01/01/2024','dd/mm/yyyy') and to_date('14/01/2025','dd/mm/yyyy')
       and ma_tb in('848940933','846443576','hcm_ioff_00000727','84848263122','84849612610','84849597827','84813463674','84813462760','84813464825'
        ,'84813464617','84813464710','84813464643','84813463708','84813462827','84813464373','84813472764','84813470825','84813470324'
        ,'84813468473','84813469173','84813472709','84813468532','84813469271','84813472241','84813472761')

--        and ma_gd in('HCM-LD/01973804','HCM-LD/02048142','HCM-LD/02064927','HCM-LD/02063830')

       and ma_tb = 'hcm_pthau'
       and ma_tb in('84918549598','84917619098','84918849598','84846247114','84849363137','84846640481','84847907875','fahamq1','solar_1224')
        and ma_tb in('hcm_vbn_00001077','hcm_vbn_00000950','hcm_vbn_00000491','hcm_vbn_00000513','hcm_vbn_00001395','hcm_vbn_00001644','hcm_vbn_00001645'
                    ,'hcm_vbn_00001446','hcm_vbn_00001456','hcm_vbn_00001467','hcm_vbn_00001474','hcm_vbn_00001477','hcm_vbn_00001480','hcm_vbn_00001483'
                    ,'hcm_vbn_00001486','hcm_vbn_00000596')
--       and ma_tb in( '84918549598','84917619098','84918849598')
        and ma_tb in('84911544233','84911021437','84911014637','84889128544','84889122884','84819440099','84823986858','84833666858'
                    ,'84911627336','84911870736','84913523933','84915249680','84915713533','84916173533','84916694733','84916694833'
                    ,'84917098933','84918153633','84835027166','84835025575','84835025436','84835025899','84835027155','0886000550')
--ma_tb in('hcm_vbn_00001630','hcm_vbn_00001631','hcm_vbn_00001627','hcm_vbn_00001638','hcm_vbn_00001639','hcm_vbn_00001077')
;
        
        

       and ma_tb in('84819440099','84915249680','84889122884','84889128544','84833666858','84823986858')
        and ma_tb in('hcm_hddt_00008333','hcm_ivan_00044117','hcm_ca_00122275','davilla','hcm_hddt_00016507','hcm_hddt_mtt_00000863'
              ,'hcm_ca_00121792','hcm_ivan_00043898','hcm_ivan_00044274','hcm_ca_00122628','hcm_hddt_00012822','"hcm_ca_00048621'
              ,'hcm_ivan_00043990','hcm_ca_00121999')
              
              and ma_tb in('hcm_vnedu_content_00000038','hcm_vnedu_content_00000037','hcm_vnedu_content_00000036','hcm_edu_lms_00001021')
--       and ma_tb in('hcm_hddt_00024660','hcm_hddt_00025207','gk1224','hcm_hddt_00009150')
       and ma_tb in('foodmarket89','foodmarket84a')
       and ma_tb = 'thienquy122024'
        and ma_tb in('84848263122','84849612610','84849597827','84813463674','84813462760','84813464825','84813464617','84813464710'
                    ,'84813464643','84813463708','84813462827','84813464373','84813472764','84813470825','84813470324','84813468473'
                    ,'84813469173','84813472709','84813468532','84813469271','84813472241','84813472761')
--       and ma_tb in('hcm_ioff_00000727','dung_77','dung_72','diem_0518','hunglk3-1','sinha','tranganh1224','hcm_ca_00080356','hahnbruno1995')
;
        and ma_tb = 'hcm_vantho_72'
        and ma_tb in('hcm_ca_00080635','hcm_ca_00105914','hcm_ca_00120511','hcm_ivan_00043479','hcm_ivan_00044239')

--        and dichvuvt_id = 2
        and exists(select 1 from ttkd_bsc.a_TD where ma_tb = a.ma_tb )
--        and exists(select 1 from ttkd_bsc.a_DN3 where ma_tb = a.ma_tb and ma_gd = a.ma_gd)
--       and exists(select 1 from ttkd_bsc.ct_bsc_ptm where thang_luong = 86 and nop_du is null and ma_tb = a.ma_tb)
        and ma_tb = 'hcm_ioff_00000263'
    and ma_tb in('hcm_smartca_00108960','sk021224','pht1104','njvq12','thanhnhien10983960','sk181224','njv.binhtan','njv_thuduc'
                ,'nvd19tvd','njv.tanquy','hcm_thnhung_71')
;

create table tam_luuhs_20250114_bs as 
        SELECT * from ttkd_bct.bangiao_hoso_tinhbsc a
       where trunc(NGAY_INSERT) = to_date('14/01/2025','dd/mm/yyyy')
        and trunc(ngay_bg) between to_date('01/08/2024','dd/mm/yyyy') and to_date('07/01/2025','dd/mm/yyyy')
        and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
                    where thang_ptm >= 202409 and nop_du is null and ma_tb = a.ma_tb)
;

-- MA_GD = '01030886', ma_tb = 'hcm_smartca_00108960'
commit ;
create index tam_luuhs_20250114_bs_matb on tam_luuhs_20250114_bs (ma_tb) ;

select * from tam_luuhs_20250114_bs a 
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
  and thang_ptm = 202412
  and mien_hsgoc is null
  and exists(select 1 from ttkd_bsc.tam_luuhs_20250114_bs 
                where ECONTRACT_APP = 1
                and loaitb_id in(1,58,59,61,171)
                and nop_du = 1
                and ma_tb = a.ma_tb)
;

select a.* from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202409
  and nop_du is null
  and exists(select 1 from ttkd_bsc.tam_luuhs_20250114_bs 
                where nop_du = 1
                and ma_tb = a.ma_tb)
;

update ttkd_bsc.ct_bsc_ptm a set bs_luukho =20250116, a.nop_du = 1, a.ngay_luuhs_ttkd = sysdate,a.ngay_luuhs_ttvt = sysdate
                                , ghi_chu =  'Bo sung theo YC cua P.DH - DAN TUYEN'
-- select * from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202412 and nop_du is null
and exists(select 1 from ttkd_bsc.hsg_bosung b where b.ma_gd=a.ma_gd )
and loaitb_id in(1,58,59,61,171) and doituong_kh = 'KHCN'
;
commit ;

update ttkd_bsc.ct_bsc_ptm a set (bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt, ghi_chu)
                          =  ( select distinct '20250114', b.nop_du
                                , b.ngay_bg,  b.ngay_bg, 'BO SUNG 14/01/2025'
                              from tam_luuhs_20250114_bs b 
                                where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd
                                and dichvuvt_id <> 2
                            ) 
where thang_ptm >= 202409 and nop_du is null
and exists(select 1 from tam_luuhs_20250114_bs b where b.ma_tb=a.ma_tb and dichvuvt_id <> 2)
;
commit ;

update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250114' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/01/2025','dd/mm/yyyy')
                                    , ghi_chu = 'BO SUNG 14/01/2025'
where exists(select 1 from tam_luuhs_20250114_bs b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202409' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm >= 202409
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
commit ;

rollback ;
drop table tam_luuhs_20250109 purge ;
create table tam_luuhs_20250109 as 
        SELECT * --ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du
--            , ngay_nop, ngay_bg, dinhkem, econtract_app -- econtract_app = 1 l� qua App
        from ttkd_bct.bangiao_hoso_tinhbsc a
--        from ttkdhcm_ktnv.bangiao_hoso_tinhbsc a
        
       where trunc(ngay_bg) between to_date('01/09/2024','dd/mm/yyyy') and to_date('07/01/2025','dd/mm/yyyy')

;
commit ;

--create table ttkd_bct.nt_tam_luuhs_20250109 as 
-- drop table nt_tam_luuhs_20250109 purge ;
create table nt_tam_luuhs_20250109 as 
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
        FROM ttkd_bct.tam_luuhs_20250109 a 
--        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, nhanvien_id, nop_du
      ) a 
  ) a 
-- group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20250109_HDID ON nt_tam_luuhs_20250109 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20250109_matb ON nt_tam_luuhs_20250109 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20250109_magd ON nt_tam_luuhs_20250109 (ma_gd ASC) ;

select * from ttkd_bct.nt_tam_luuhs_20250109 a 
where ma_tb in('foodmarket89','foodmarket84a','hcm_hddt_00025207') ;
create table a_bosung_temp as
select * from ttkd_bct.nt_tam_luuhs_20250109 a 
where loaitb_id in(1,58,59,61,171)
and exists(select 1 from ttkd_bsc.hsg_bosung where ma_gd = a.ma_gd)
and nop_du = 1
;
create index a_bosung_temp_magd on a_bosung_temp (ma_gd) ;

select ma_gd, count(*)sl from a_bosung_temp a group by ma_gd ;
;

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt, ghi_chu)=
        ( select distinct '20250114', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
            , 'Bo sung theo YC cua P.DH - DAN TUYEN'
          from a_bosung_temp b 
            where b.ma_gd=a.ma_gd and ma_tb = a.ma_tb
        ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.bs_luukho, ghi_chu from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202409 
 --and (nop_du is null or nop_du=0) and 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000')
 and doituong_kh = 'KHCN'
 and exists(select 1 from a_bosung_temp where ma_gd = a.ma_gd and ma_tb = a.ma_tb)
; 
commit ;

rollback ;
select * from ttkd_bsc.ct_bsc_ptm a 
where loaitb_id in(58,59,61,171)
and exists(select 1 from ttkd_bsc.hsg_bosung where ma_gd = a.ma_gd)
;

and exists(select 1 from ttkd_bsc.ct_bsc_ptm b
            where b.loaitb_id in(1,58,59,61,171) 
                and b.doituong_kh = 'KHCN'
                and b.nop_du is null
                and b.ma_gd = a.ma_gd
            )

select * from ttkd_bct.nt_tam_luuhs_20250109 
where to_char(ngay_nop_du,'yyyymm') >= 202409
and ma_gd like '%HCM-LD%' ;
/* --------------------------------------------- */
select a.thang_ptm, a.ma_tb, a.nop_du, a.dich_vu, nguon, ngay_luuhs_ttvt, ngay_luuhs_ttkd
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202409 
and nop_du=1 and (a.ngay_luuhs_ttkd is not null or a.ngay_luuhs_ttvt is not null) and dichvuvt_id not in(2) ;

rollback ;

select hdtb_id from ttkd_bsc.ct_bsc_ptm a 
;
/* ----------------------- TEST TRUOC KHI UP -------------------- */

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202409
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm order by nguon, thang_luong, thang_ptm ;

/* ------------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT ------------- */
select * from ttkd_bct.nt_tam_luuhs_20250109 
where loaitb_id in(1,58,59,61,171) 
and econtract_app = 1
;
/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/01/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250109', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--            , b.econtract_app
          from ttkd_bct.nt_tam_luuhs_20250109 b 
            where b.loaitb_id in(1,58,59,61,171) 
                and b.econtract_app = 1
                and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm = 202412 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000')
 and doituong_kh = 'KHCN'
-- and nguon in('thaydoitocdo','ptm_codinh')
; 
commit ;
rollback ;

/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/01/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250109', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
 --           , b.econtract_app
            
          from ttkd_bct.nt_tam_luuhs_20250109 b 
            where b.loaitb_id in(1,58,59,61,171) 
   --             and b.econtract_app = 1
                and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm = 202412 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb not in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000')
-- and doituong_kh = 'KHCN'
-- and nguon in('thaydoitocdo','ptm_codinh')
; 
commit ;

/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/01/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt, ghi_chu)=
        ( select distinct '20250114', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
 --           , b.econtract_app
            , 'BO SUNG HO SO DOITUONG_KH = KHDN, BHKV - BHOL'
          from ttkd_bct.nt_tam_luuhs_20250109 b 
            where b.loaitb_id in(1,58,59,61,171) 
   --             and b.econtract_app = 1
                and b.nop_du=1 and b.ngay_nop_du is not null 
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt, lydo_khongtinh_dongia from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm = 202412 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000')
and doituong_kh = 'KHDN'
-- and nguon in('thaydoitocdo','ptm_codinh')
; 
commit ;
ROLLBACK ;
/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 04/01/2025 ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250109', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
   --         , loaitb_id, econtract_app
          from ttkd_bct.nt_tam_luuhs_20250109 b 
            where b.nop_du=1 and b.ngay_nop_du is not null -- and econtract_app = 0
                and loaitb_id in(1,58,59,61,171)
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd --and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202409 and thang_ptm < 202412
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
-- and nguon in('thaydoitocdo','ptm_codinh')
; 
commit ;

/* --------- UPDATE LOAITB_ID NOT IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 04/01/2025 ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250109', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
   --         , loaitb_id, econtract_app
          from ttkd_bct.nt_tam_luuhs_20250109 b 
            where b.loaitb_id not in(1,58,59,61,171,20)                 
                and b.nop_du=1 and b.ngay_nop_du is not null -- and econtract_app = 0
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd --and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202409 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and loaitb_id not in(1,58,59,61,171) 
 and nguon is not null
-- and nguon in('thaydoitocdo','ptm_codinh')
; 
commit ;

/* ---------- UP VINA.TS ----------- */
select thang_ptm, ma_tb, ma_gd, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202409 
--and (nop_du is null or nop_du=0) 
and nop_du = 1
and DICH_VU in('VNPTS','VCC')
 ;
select thang_ptm, count(*)sl
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202409 
--and (nop_du is null or nop_du=0) 
and nop_du = 1
and DICH_VU in('VNPTS','VCC')
group by thang_ptm
 ;
/* ---------- KIEM TRA TRUOC KHI UP ------------ */
select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202409 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;

/*---------------- UP THUE BAO econtract_app <> 1 ------------------- */ 
/* ---------- UP THANG N-3 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250109' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('09/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('09/01/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250109 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202409' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202409 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
/* ---------- UP THANG N-2 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250109' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('09/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('09/01/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250109 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202410' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202410
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
/* ---------- UP THANG N-1 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250109' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('09/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('09/01/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250109 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202411' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202411
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
/* ---------- UP THANG N -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250109' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('09/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('09/01/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250109 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202412' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202412 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
COMMIT ;

