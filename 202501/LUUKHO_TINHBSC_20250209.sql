update ttkd_bsc.ct_bsc_ptm set nop_du = 1, ngay_luuhs_ttkd = '04-NOV-24 14.33' , ngay_luuhs_ttvt = '04-NOV-24 14.33'
                    , bs_luukho = '20250218', ghi_chu = 'BS theo YC của Học'
select * from ttkd_bsc.ct_bsc_ptm
where id = 10626646 ;

commit ;
drop table tam_luuhs_20250214_bs purge ;
create table tam_luuhs_20250214_bs as ;
       select * 
        from ttkd_bct.bangiao_hoso_tinhbsc a
--        from ttkdhcm_ktnv.bangiao_hoso_tinhbsc a
       where trunc(ngay_bg) between to_date('01/07/2024','dd/mm/yyyy') and to_date('14/02/2025','dd/mm/yyyy') 
       and ma_tb = 'hcm_vnedu_content_00000037' ;
       and ma_tb in('hcm_smartca_00424600','hcm_smartca_00411252','hcm_smartca_00424651') ;
       and ma_tb in('dungbt145','kimchi11278730','thanhphat9212','hcmhongchuongfm','hcm2011quangmanh','hcmungngan_2017'
              ,'hcm_vanhanh_24','hcmlynope','hcmnguyenthixuan1','hcmlptrong_f18','hcmtrung-f12','hcmduchan','hcmdqo350','hcmthanhphat9212');

       and ma_tb in('hcm_vantho_72','tthoai_ak7','hcm_thoai2024','nttthuy_sanh2','pndbao_2025','hcm_dbao2025','nvkhoa_2024','lqdung_2024') ;
       -- da bs
       and  ma_tb in('vnpt-tthang1','ltl030125-ny','baokhanh05122024','hcm_baokhanh_11','anhtho23012025') ; -- da bs
       and ma_tb = '84916474538' ;
--       where trunc(ngay_bg) between to_date('01/07/2024','dd/mm/yyyy') and to_date('14/02/2025','dd/mm/yyyy')
--       and ma_tb = 'huylinh_p411' ;
--        and ma_tb in('84848263122','hcm_ivan_00044399','tuongl5','hcm_ivan_00043894') ;
--        ma_tb= 'hcm_ca_00090426' ;
--        ma_tb in('hcm_smartca_00424600','hcm_smartca_00411252','hcm_smartca_00424651') ;
        and ma_tb in('ltl030125-ny','baokhanh05122024','hcm_baokhanh_11','anhtho23012025','hcm_smartca_00424658','vnpt-tthang1'
                    ,'hcm_family_safe_00001617','hcm_smartca_00424645','hcm_smartca_00424643') ;

       and ma_tb = 'huylinh_p411' ; -- da bs
       and ma_tb in('84917505938','84917654938','84918626738','84918232438','84917415138','84917822538','84919466138') ;
--       and ma_tb in('ltl030125-ny','baokhanh05122024','hcm_baokhanh_11','anhtho23012025','hcm_smartca_00424658','vnpt-tthang1'
--    ,'hcm_family_safe_00001617','hcm_smartca_00424645','hcm_smartca_00424643') ;
       and ma_tb in('hcmthanhdat24','hcmthuytram39','hcmthuytram13','hcm196','hcmhuongthi','huamybach2025','hcmhuamybach2025') ; -- da phan hoi
       
       and ma_tb = 'hcm_ioff_00000751' ; -- BS theo YC của Học
--       and ma_gd in('HCM-LD/02065068','HCM-LD/02051607','HCM-LD/02053221') ;
        and ma_tb = 'hcm_ivan_00030210' ;
        and ma_tb = 'pdh1224' ; -- DA BS 13/02/2025
       and ma_tb = 'mamnonlasido' ; -- DA BS 13/02/2025
       and ma_tb in('84845958651','84849612610','84849597827','84849530470','84849708381','84845491630','84848432844') ;
       and ma_tb in('mttm1','mtn1','mtnexus','mth4','mtg8','mtpolux1','84916478797') ;
       and ma_tb in('hcm_ekyc_00000068','hcm_id_check_00001013') ;
       and ma_tb ='hcm_hddt_00017187' ;
and ma_tb in('84845958651','thuyquynh_24','yuri_p1407','hcmtrongan_2024','trongan_2024','duyhoaphat_2024','84916478797','hcmchoi1702','toaanthuduc_2024','84918266872') ;
       and ma_tb = 'sk181224' ;
    and ma_tb in('dung_l22','dung_l23','dung_l24','dung_l25','dung_l26','dung_l27')
    and ma_tb in('ctycargonow','hajongwhee11184670','ctyhightech1205','trieukhiem1224','ctylili5','ctytinhvan','ctyinsp','ctyvags'
        ,'daitan-feco4','media0125','hongthu_eco5','vita0125')
;
 and ma_tb in('hcm_smartca_00108960','sk021224','pht1104','njvq12','thanhnhien10983960','sk181224','njv.binhtan','njv_thuduc','nvd19tvd','njv.tanquy','hcm_thnhung_71') 

       and ma_tb in('pht1104','njvq12','njv.binhtan','njv_thuduc','nvd19tvd','njv.tanquy') ;
        and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
                    where thang_ptm >= 202410 and nop_du is null and ma_tb = a.ma_tb)
;

-- MA_GD = '01030886', ma_tb = 'hcm_smartca_00108960'
commit ;
create index tam_luuhs_20250214_bs_matb on tam_luuhs_20250214_bs (ma_tb) ;
select a.* from ttkd_bct.tam_luuhs_20250214_bs a  ;
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt,ghi_chu, LYDO_KHONGTINH_DONGIA)
                                =( select '20250216', b.nop_du, b.ngay_bg, b.ngay_bg , 'BS theo YC Của Học',''
                                   from ttkd_bct.bangiao_hoso_tinhbsc b
                                   where trunc(ngay_bg) between to_date('01/07/2024','dd/mm/yyyy') and to_date('14/02/2025','dd/mm/yyyy') 
                                   and ma_tb in('hcm_vantho_72','tthoai_ak7','hcm_thoai2024','nttthuy_sanh2','pndbao_2025'
                                               ,'hcm_dbao2025','nvkhoa_2024','lqdung_2024')
                                    and b.econtract_app = 1
                                   and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd
                                   
                                 ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202410 
and ma_tb in('hcm_vantho_72','tthoai_ak7','hcm_thoai2024','nttthuy_sanh2','pndbao_2025'
            ,'hcm_dbao2025','nvkhoa_2024','lqdung_2024')
and exists(select 1 from ttkd_bct.bangiao_hoso_tinhbsc b
                                   where trunc(ngay_bg) between to_date('01/07/2024','dd/mm/yyyy') and to_date('14/02/2025','dd/mm/yyyy') 
                                   and ma_tb in('hcm_vantho_72','tthoai_ak7','hcm_thoai2024','nttthuy_sanh2','pndbao_2025'
                                               ,'hcm_dbao2025','nvkhoa_2024','lqdung_2024')
                                    and b.econtract_app = 1
                                   and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd)
;   
commit ;
rollback ;

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt,ghi_chu, LYDO_KHONGTINH_DONGIA)
                                =( select '20250214', b.nop_du, b.ngay_bg, b.ngay_bg , 'BS theo YC Của Học',''
                                   from ttkd_bct.tam_luuhs_20250214_bs b 
                                    where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd
                                 ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202410 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and nguon is not null
 and exists(select 1 from ttkd_bct.tam_luuhs_20250214_bs b where b.ma_tb=a.ma_tb)
;   
commit ;

--create table ttkd_bct.nt_tam_luuhs_20250214 as 
-- drop table nt_tam_luuhs_20250214 purge ;
create table nt_tam_luuhs_20250214 as 
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
        FROM ttkd_bct.tam_luuhs_20250214 a 
--        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, nhanvien_id, nop_du
      ) a 
  ) a 
-- group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, dinhkem, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20250214_HDID ON nt_tam_luuhs_20250214 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20250214_matb ON nt_tam_luuhs_20250214 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20250214_magd ON nt_tam_luuhs_20250214 (ma_gd ASC) ;

select a.* from ttkd_bct.tam_luuhs_20250214_bs a 
where exists(select 1 from ttkd_bsc.ct_bsc_ptm where ma_tb = a.ma_tb) 
;

/* ----------------------- TEST TRUOC KHI UP -------------------- */

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202410
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm order by nguon, thang_luong, thang_ptm ;

/* --------- UPDATE LOAITB_ID NOT IN(1,58,59,61,171) - UPDATE NGAY 04/01/2025 ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt,ghi_chu)=
                                ( select '20250214', b.nop_du
                                    , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
                                    , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
                           --         , loaitb_id, econtract_app
                                    , 'BS theo YC Của Học'
                                  from ttkd_bct.nt_tam_luuhs_20250214 b 
                                    where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
                                ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202410 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and nguon is not null
 and exists(select 1 from ttkd_bct.nt_tam_luuhs_20250214 b where b.ma_tb=a.ma_tb)
;   
commit ;

select a.* from ttkd_bct.nt_tam_luuhs_20250214 a
where exists(select 1 from ttkd_bsc.ct_bsc_ptm b where b.ma_tb=a.ma_tb)
;
/* --------- UPDATE LOAITB_ID NOT IN(1,58,59,61,171) - UPDATE NGAY 04/01/2025 ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt,ghi_chu)=
                                ( select distinct '20250214', b.nop_du
                                    , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
                                    , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
                           --         , loaitb_id, econtract_app
                                    , 'BS theo YC Của Học'
                                  from ttkd_bct.nt_tam_luuhs_20250214 b 
                                    where b.loaitb_id not in(1,58,59,61,171,20,21)                 
                                        and b.nop_du=1 and b.ngay_nop_du is not null
                                        and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
                                ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202410 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and dich_vu not in('VNPTS','VCC','VNPTT')
 and loaitb_id not in(1,58,59,61,171) 
 and nguon is not null
;   
commit ;
rollback ;
/* --------- UPDATE LOAITB_ID NOT IN(1,58,59,61,171) - UPDATE NGAY 04/01/2025 ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250214', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
   --         , loaitb_id, econtract_app
          from ttkd_bct.nt_tam_luuhs_20250214 b 
            where b.nop_du=1 and b.ngay_nop_du is not null
                and loaitb_id in(1,58,59,61,171)
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) 
 and thang_ptm >= 202410 and thang_ptm < 202412
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
; 
commit ;
/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/01/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250214', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--            , b.econtract_app
          from ttkd_bct.nt_tam_luuhs_20250214 b 
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
 and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500'
             ,'VNP0701800','VNP0701600','VNP0703000','VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHCN'
; 
commit ;
rollback ;

/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) - UPDATE NGAY 09/01/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20250212', b.nop_du
            , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
            , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
--            , b.econtract_app
          from ttkd_bct.nt_tam_luuhs_20250214 b 
            where b.loaitb_id in(1,58,59,61,171) 
                and b.nop_du=1 and b.ngay_nop_du is not null 
 --               and ma_tb in('thpm25','ctylevitek','tthttk24')
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
        ) 
-- select 
--distinct ten_pb
-- thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) 
 and thang_ptm >= 202412 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
-- and ma_pb in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500'
--             ,'VNP0701800','VNP0701600','VNP0703000')
             --(,'VNP0702300','VNP0702400','VNP0702500')
 and doituong_kh = 'KHDN'
--AND ma_tb ='qctuongminh2024' 
; 
commit ;
rollback ;

update ttkd_bsc.ct_bsc_ptm a set bs_luukho =20250210, a.nop_du = 1, a.ngay_luuhs_ttkd = sysdate,a.ngay_luuhs_ttvt = sysdate
                                , ghi_chu =  'Bo sung theo YC cua P.DH - DAN TUYEN'
-- select * from ttkd_bsc.ct_bsc_ptm a
where thang_ptm >= 202412 
--and nop_du is null
and exists(select 1 from ttkd_bsc.hsg_bosung b where b.ma_gd=a.ma_gd and thang = 202501)
and loaitb_id in(1,58,59,61,171) 
--and doituong_kh = 'KHCN'
;
commit ;

select a.* from ttkd_bsc.hsg_bosung a
where a.thang = 202501 
and not exists(select 1 from ttkd_bsc.ct_bsc_ptm where thang_ptm >= 202412 and ma_gd=a.ma_gd)
;
/* ----------------------- TEST TRUOC KHI UP -------------------- */

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202410
and (nop_du is null or nop_du=0)
and dich_vu not in('VNPTS','VCC','VNPTT')
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm order by nguon, thang_luong, thang_ptm ;

/* ------------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT ------------- */
select * from ttkd_bct.nt_tam_luuhs_20250214 
where loaitb_id in(1,58,59,61,171) 
and econtract_app = 1
;

select * from ttkd_bct.tam_luuhs_20250214 
where loaitb_id in(1,58,59,61,171) 
and econtract_app = 1
;

/* --------- UPDATE LOAITB_ID IN(1,58,59,61,171) CO HSG HDDT - UPDATE NGAY 09/01/2025 KHCN ------------------ */
update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt)=
                            ( select distinct '20250214', b.nop_du
                                , (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end)
                                , (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
                     --           , b.econtract_app
                                
                              from ttkd_bct.nt_tam_luuhs_20250214 b 
                                where b.loaitb_id in(1,58,59,61,171) 
                                    and b.nop_du=1 and b.ngay_nop_du is not null 
                           /*
                                    and exists(select 1 from ttkd_bsc.ct_bsc_ptm
                                                    where ma_tb=b.ma_tb and ma_gd=b.ma_gd and hdtb_id=b.hdtb_id
                                                     and (nop_du is null or nop_du=0) 
                                                     and thang_ptm >= 202412 
                                                     and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
                                                     and loaitb_id in(1,58,59,61,171) 
                                                     and nguon is not null
                                                     and ma_pb not in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100'
                                                                     ,'VNP0701400','VNP0701500','VNP0701800','VNP0701600','VNP0703000')
                     
                                              )
                            */
                                    and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
                            ) 
-- select thang_ptm, doituong_kh, ten_pb, ma_tb, ma_gd, dich_vu, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0)
 and thang_ptm >= 202412 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and loaitb_id in(1,58,59,61,171) 
 and nguon is not null
 and ma_pb not in('VNP0701100','VNP0701200','VNP0702200','VNP0701300','VNP0702100','VNP0701400','VNP0701500'
                 ,'VNP0701800','VNP0701600','VNP0703000')
 and exists(select 1 from ttkd_bct.nt_tam_luuhs_20250214 b 
                where b.loaitb_id in(1,58,59,61,171) 
                and b.nop_du=1 and b.ngay_nop_du is not null
                and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd and b.hdtb_id=a.hdtb_id
            )
; 
commit ;

rollback ;
/* ---------- UP VINA.TS ----------- */
select thang_ptm, ma_tb, ma_gd, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202410 
--and (nop_du is null or nop_du=0) 
and nop_du = 1
and DICH_VU in('VNPTS','VCC')
 ;

/* ---------- KIEM TRA TRUOC KHI UP ------------ */
select thang_ptm,nguon, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202410 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
group by thang_ptm, nguon, dichvuvt_id ORDER by thang_ptm, nguon, dichvuvt_id ;

/*---------------- UP THUE BAO econtract_app <> 1 ------------------- */ 
/* ---------- UP THANG N-3 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250214' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/01/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250214 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202410' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202410 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
/* ---------- UP THANG N-2 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250214' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/01/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250214 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202411' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202411
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
/* ---------- UP THANG N-1 -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250214' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/01/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250214 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202412' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202412
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
/* ---------- UP THANG N -------------- */
update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250214' , a.nop_du = 1
                                    , a.ngay_luuhs_ttkd = to_date('07/01/2025','dd/mm/yyyy')
                                    , a.ngay_luuhs_ttvt = to_date('07/01/2025','dd/mm/yyyy')
where exists(select 1 from ttkd_bct.nt_tam_luuhs_20250214 b 
                where nop_du=1 and b.ngay_nop_du is not null and b.ma_gd like 'HCM-LD%'
                and dichvuvt_id = 2 and to_char(ngay_bg,'yyyymm') >= '202501' and b.ma_tb=a.ma_tb 
            ) 
and thang_ptm = 202501 
and (nop_du is null or nop_du=0) 
and DICH_VU in('VNPTS','VCC')
;
COMMIT ;

rollback ;

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt, ghi_chu)
                                =( select distinct '20250211', b.nop_du
                                    , b.ngay_bg, b.ngay_bg
                                    , 'Bo sung theo YC cua HOC trong/ngoai chuong trinh'
                           --         , loaitb_id, econtract_app
                                  from ttkd_bct.bangiao_hoso_tinhbsc b 
                                    where b.nop_du=1 and b.ngay_nop_du is not null
                                        and b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd
                                ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where thang_luong in(86,87) 
--and (nop_du is null or nop_du=0) 
--and thang_ptm >= 202410 
and exists(select 1 from ttkd_bct.bangiao_hoso_tinhbsc where ma_tb = a.ma_tb and ma_gd = a.ma_gd) 

; 
commit ;