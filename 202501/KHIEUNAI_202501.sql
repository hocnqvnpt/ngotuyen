select thang_luong, thang_ptm, ma_gd, ma_tb, dich_vu, ten_tb, manv_ptm, tennv_ptm, ma_to, ten_pb, nop_du, bs_luukho
    , dthu_goi, ghi_chu, lydo_khongtinh_dongia, thang_tldg_dt, doituong_kh
from ttkd_bsc.ct_bsc_ptm 
where  ma_tb in('vnpt-tthang1','ltl030125-ny','baokhanh05122024','hcm_baokhanh_11','anhtho23012025') ;

ma_tb = '84916474538' ;
ma_tb in('84848263122','hcm_ivan_00044399','tuongl5','hcm_ivan_00043894') ;
ma_tb = 'hcm_ca_00090426' ;
ma_tb in('hcm_smartca_00424600','hcm_smartca_00411252','hcm_smartca_00424651') ;
ma_tb in('ltl030125-ny','baokhanh05122024','hcm_baokhanh_11','anhtho23012025','hcm_smartca_00424658','vnpt-tthang1'
    ,'hcm_family_safe_00001617','hcm_smartca_00424645','hcm_smartca_00424643') ;
ma_tb = 'huylinh_p411' ;
ma_tb in('84917505938','84917654938','84918626738','84918232438','84917415138','84917822538','84919466138') ;
ma_tb in('hcmthanhdat24','hcmthuytram39','hcmthuytram13','hcm196','hcmhuongthi','huamybach2025','hcmhuamybach2025') ;
ma_tb in('dcismart60','visimexsg','dongd26','garanf9') ;

ma_tb = 'hcm_ioff_00000751' ;
ma_gd = '01059464' ;
ma_tb = 'hcm_ivan_00030210' ;
ma_tb = '84912340903' ;
MA_GD = 'HCM-LD/02058688' ;
--ma_gd in('HCM-LD/02065068','HCM-LD/02051607','HCM-LD/02053221') ;
ma_tb = 'mamnonlasido' ;
ma_tb in('84919156646','84844868768','84842468068','84844268068') ;
ma_tb in('mttm1','mtn1','mtnexus','mth4','mtg8','mtpolux1') ; 

select somay, ma_hd ma_gd, kieu_ld, ten_tb, dc_gbc, ngay_ld, doituong, nguoi_gt, manv_ptm, tennv_ptm, ten_to, ten_pb
    ,ghichu, trangthai, dthu_ps, loai_goi, dthu_goi
from ttkd_bsc.dt_ptm_vnp_202501_bs 
where somay = '84912340903' ;


select a.* from ttkd_bsc.ct_bsc_ptm a 
where  exists(select 1 from (select * 
                               from ttkd_bct.bangiao_hoso_tinhbsc a
                               where trunc(ngay_insert) = to_date('14/02/2025','dd/mm/yyyy')
                            ) where ma_tb = a.ma_tb ) 
--and thang_ptm >= 202410 
;