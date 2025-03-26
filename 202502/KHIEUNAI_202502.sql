select thang_luong, thang_ptm, doituong_kh, ma_gd, ma_tb, dich_vu, ten_tb, manv_ptm, tennv_ptm, ma_to, ten_pb
    , ngay_luuhs_ttkd, nop_du, bs_luukho, dthu_goi, dthu_ps, ghi_chu, lydo_khongtinh_dongia, lydo_khongtinh_luong, thang_tldg_dt
    ,nguon, trangthai_tt_id, thoihan_id
from ttkd_bsc.ct_bsc_ptm 
where ma_gd = 'HCM-LD/02132906' ;
ma_tb in('fvn_soviet1','fvn_soviet2','fvn_shadow')
;
select * from css.v_hd_khachhang@dataguard where ma_gd = 'HCM-LD/02132906' ;
select * from css.v_hd_thuebao@dataguard where hdkh_id = 26204117 ;
ma_tb in('hcm_smartca_00427372','hcm_family_safe_00002170','hcm_smartca_00426392','hcm_family_safe_00002316','hcm_smartca_00417247'
            ,'hcm_family_safe_00002281','hcm_smartca_00425425','hcm_smartca_00425922','thanhtrung-qgv','hcm_smartca_00377086') ;
ma_tb in('ntkien_2','joo_eco2','hongthu_eco5','hcm_ivan_00044828','khacquang25','hcm_ivan_00044782','hcm_hddt_00025349') -- BHTD
;
ma_tb in('84911003836','hcm_smartca_00424622') ;
ma_tb in('mt0125','hcmmt0125','84917305128') ;

ma_tb in('hcm_smartca_00417247','hcm_smartca_00423754','hcm_smartca_00427776','hcm_smartca_00430425'
,'hcm_smartca_00428564','hcm_ca_00080898','84916128079','hcm_hddt_00025435','hcm_hddt_00025385','tranganh1224','khacquang25'
,'hcm_ca_00123116','hcm_ivan_00044485','kianbon','hcm_ivan_00044399', '84917305128') 
and thang_ptm >= 202411 ;

ma_tb in('hcm_smartca_00417247','hcm_smartca_00423754','hcm_smartca_00427776','hcm_smartca_00430425'
,'hcm_smartca_00428564','hcm_ca_00080898') ;
--ma_tb = 'hcm_ca_00048540' ;
;
ma_tb = '84917305128' ;
ma_tb = 'hcm_smartca_ps_00007914' ;
ma_tb in('hcm_econtract_00000722','hcm_id_check_00001012','84916128079') ;
ma_tb = 'hcm_ca_00080898' ;
ma_tb = 'hcm_ivan_00044399' ;
ma_gd = 'HCM-LD/02099428' ;

ma_tb in('mt0125','hcmmt0125') ;  -- BHOL
ma_tb in('hcm_smartca_00417247','hcm_smartca_00423754','hcm_smartca_00427776','hcm_smartca_00430425','hcm_smartca_00428564') - BHOL
HCM-LD/02064349 - hcm_smartca_00417247 
HCM-LD/02090781 - hcm_smartca_00423754 
HCM-LD/02108609 - hcm_smartca_00427776 
HCM-LD/02116458 - hcm_smartca_00430425 
HCM-LD/02110702 - hcm_smartca_00428564

thang_luong in(86,87,88) and ma_tb in('hcm_econtract_00000722','hcm_id_check_00001012','84916128079') ; -- DN2 r
ma_tb in('like3','giaminhd','jihun3','namtae','kianbon','xiayong','hcm_ca_00123116','hcm_ivan_00044485'
        ,'tranganh1224','hcm_hddt_00025435','hcm_hddt_00025385','khacquang25')
ma_tb in('hcm_id_check_00001013') -- DN3
ma_tb in('mt475','mt475a-25','84886033736','84888067157','84888087041'
        ,'84888074412','84888081494','84888079071','84889003643','84889003921','84889003764','84889003897','84889003805','84889003613') ; -- BHTD
--lydo_khongtinh_dongia like '%KHCN, Thuê bao ĐTCĐ, FIBER, MYTV PTM không ký qua Hđđt%' ;
--ma_tb in('thdat12244','dinhthi1224','tienphong25','thuhien1224','ngoccuong25','thiquy25') 
ma_tb in('ntkien_2','joo_eco2','hongthu_eco5','hcm_ivan_00044828','khacquang25','hcm_ivan_00044782','hcm_hddt_00025349') -- BHTD
ma_tb in('hcm_hddt_00025377','hcm_hddt_00024484','hcm_ioff_00000647','hcm_connect_00000117','hcm_vnedu_content_00000062'
,'hcm_vnedu_lms_00001216','hcm_vnedu_lms_00001226','hcm_connect_00000178','hcm_connect_00000291','hcm_connect_00000256')
;
hcm_id_check_00001012	HCM-LD/02045318
hcm_econtract_00000722	01065795
hcm_econtract_00000722	01043519
update ttkd_bsc.ct_bsc_ptm set nop_du = 1, LYDO_KHONGTINH_DONGIA = '', LYDO_KHONGTINH_LUONG = '', BS_LUUKHO = '20250312', THANG_TLDG_DT = 202502
where ma_tb = 'tienphong25' and thang_ptm = 202501
;
commit ;
       select * 
        from ttkd_bct.bangiao_hoso_tinhbsc a
--        from ttkdhcm_ktnv.bangiao_hoso_tinhbsc a
       where trunc(ngay_bg) between to_date('01/09/2024','dd/mm/yyyy') and to_date('16/03/2025','dd/mm/yyyy')
       and ma_tb in('84911003836','hcm_smartca_00424622') ;
       and ma_tb in('hcm_smartca_00417247','hcm_smartca_00423754','hcm_smartca_00427776','hcm_smartca_00430425'
                ,'hcm_smartca_00428564','hcm_ca_00080898')
       and ma_tb in('ntkien_2','joo_eco2','hongthu_eco5') ;
       and ma_tb = '84917305128' ;
       and ma_tb = 'hcm_smartca_ps_00007914' ;
       and ma_tb in('hcm_econtract_00000722','hcm_id_check_00001012','84916128079') ;
       and ma_tb = 'hcm_ca_00080898' ;
       
       and ma_tb = 'hcm_ivan_00044399'
       and ma_gd = 'HCM-LD/02099428'
       and ma_tb in('hcm_smartca_00417247','hcm_smartca_00423754','hcm_smartca_00427776','hcm_smartca_00430425','hcm_smartca_00428564')
       and ma_tb in('hcm_econtract_00000722','hcm_id_check_00001012')
        and ma_tb in('mt475','mt475a-25','84886033736','84888067157','84888087041'
        ,'84888074412','84888081494','84888079071','84889003643','84889003921','84889003764','84889003897','84889003805','84889003613') ; -- BHTD

        and ma_tb in('ntkien_2','joo_eco2','hongthu_eco5','hcm_ivan_00044828','khacquang25','hcm_ivan_00044782','hcm_hddt_00025349') -- BHTD
--        and ma_tb in('thdat12244','dinhthi1224','tienphong25','thuhien1224','ngoccuong25','thiquy25')
          and ma_tb in('hcm_hddt_00025377','hcm_hddt_00024484','hcm_ioff_00000647','hcm_connect_00000117','hcm_vnedu_content_00000062'
            ,'hcm_vnedu_lms_00001216','hcm_vnedu_lms_00001226','hcm_connect_00000178','hcm_connect_00000291','hcm_connect_00000256')

        and ma_tb in('ntkien_2','joo_eco2','hongthu_eco5','hcm_ivan_00044828')
        and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
                    where lydo_khongtinh_dongia like '%KHCN, Thuê bao ĐTCĐ, FIBER, MYTV PTM không ký qua Hđđt%' 
                    and ma_tb = a.ma_tb)
;
select * from ttkd_bct.nt_tam_luuhs_20250309
where 
 ma_tb in('hcm_econtract_00000722','hcm_id_check_00001012','84916128079') ;

create table tam_luuhs_20250314 as 
       select * from ttkd_bct.bangiao_hoso_tinhbsc a
--        from ttkdhcm_ktnv.bangiao_hoso_tinhbsc a
       where trunc(ngay_bg) between to_date('01/10/2024','dd/mm/yyyy') and to_date('07/03/2025','dd/mm/yyyy')
        and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
                    where thang_luong in(86,87,88) and nop_du is null and ma_tb = a.ma_tb)
;
create index tam_luuhs_20250314_matb on tam_luuhs_20250314 (ma_tb) ;

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt, ghi_chu)=
                                ( select distinct '20250316', b.nop_du, b.ngay_bg, b.ngay_bg
                                , 'Học YC bổ sung ngày 16/03/2025'
                                  from ttkd_bct.tam_luuhs_20250316 b 
                                    where trunc(ngay_bg) between to_date('01/09/2024','dd/mm/yyyy') and to_date('07/03/2025','dd/mm/yyyy')
                                    and ma_tb = 'hcm_smartca_ps_00007914'
                                ) 
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, loaitb_id, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where ma_tb = 'hcm_smartca_ps_00007914'
; 

create table tam_luuhs_20250316 as 
       select * from ttkd_bct.bangiao_hoso_tinhbsc a
--        from ttkdhcm_ktnv.bangiao_hoso_tinhbsc a
       where
       --ngay_insert > trunc(sysdate)
        
--       ma_tb in('ntkien_2','hongthu_eco5')
        trunc(ngay_bg) between to_date('01/10/2024','dd/mm/yyyy') and to_date('16/03/2025','dd/mm/yyyy')
        and exists(select 1 from ttkd_bsc.ct_bsc_ptm 
                    where thang_ptm >= 202411 and nop_du is null and ma_tb = a.ma_tb)
;

-- MA_GD = '01030886', ma_tb = 'hcm_smartca_00108960'
commit ;
create index tam_luuhs_20250316_matb on tam_luuhs_20250316 (ma_tb) ;

commit ;
select a.* from ttkd_bct.tam_luuhs_20250316 a
where ma_tb in('hcm_smartca_00417247','hcm_smartca_00423754','hcm_smartca_00427776','hcm_smartca_00430425'
,'hcm_smartca_00428564','hcm_ca_00080898')
or ma_tb in('84916128079','hcm_hddt_00025435','hcm_hddt_00025385','tranganh1224','khacquang25','hcm_ca_00123116'
    ,'hcm_ivan_00044485','kianbon','hcm_ivan_00044399') ;

hcm_smartca_00417247 hcm_smartca_00423754
hcm_smartca_00427776  hcm_smartca_00430425  hcm_smartca_00428564 hcm_ca_00080898 

select thang_luong, thang_ptm, ma_tb, ma_gd, hdtb_id, loaitb_id, bs_luukho, a.nop_du
    , a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt, thang_tldg_dt, lydo_khongtinh_dongia, lydo_khongtinh_luong
from ttkd_bsc.ct_bsc_ptm a
where bs_luukho >= '20250309' ;
commit ;

update ttkd_bsc.ct_bsc_ptm a set a.bs_luukho = '20250316', a.nop_du = 1 , LYDO_KHONGTINH_DONGIA = '', LYDO_KHONGTINH_LUONG = ''
-- select thang_ptm, ma_tb, ma_gd, hdtb_id, loaitb_id, bs_luukho, a.nop_du, a.ngay_luuhs_ttkd, a.ngay_luuhs_ttvt
, LYDO_KHONGTINH_DONGIA, LYDO_KHONGTINH_LUONG
from ttkd_bsc.ct_bsc_ptm a
where ma_tb in('ntkien_2','hongthu_eco5') 
;