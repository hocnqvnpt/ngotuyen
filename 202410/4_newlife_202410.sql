select * from ttkdhcm_ktnv.db_act_593 where to_number(to_char(ngay_imp,'yyyymm'))>=202405;

/* ------------- NHO THAY DOI thang_ptm + 1, ngay_imp + 1 ------------- */
update ttkd_bsc.ct_bsc_ptm a
    set (tien_dnhm, tien_tt, soseri, ngay_tt)=
            (select round(sotien/1.1,0), round(sotien/1.1,0), so_hd, ngay_thu
                from ttkdhcm_ktnv.db_act_593
                where to_number(to_char(ngay_imp,'yyyymm'))>=202405 
                        and sotien>0 and lower(nhomphi) like 'ph_ h_a m_ng%' and username = a.ma_tb
            )
    -- select tien_dnhm, tien_tt, soseri, ngay_tt, manv_ptm from ttkd_bsc.ct_bsc_ptm a
    where thang_ptm>=202405 and chuquan_id=264 and loaihd_id=1 and manv_ptm is not null 
          and exists (select 1 from ttkdhcm_ktnv.db_act_593
                      where 
                      to_number(to_char(ngay_imp,'yyyymm'))>=202405 and 
                       sotien>0 and lower(nhomphi) like 'ph_ h_a m_ng%' and username = a.ma_tb
                     )
;    

update ttkd_bsc.ct_bsc_ptm a set (ghi_chu, xacnhan_khkt, thang_xacnhan_khkt, trangthai_tt_id)=
        (select max(nd_thu), sum(sotien), 202405, 1 
            from ttkdhcm_ktnv.db_act_593
            where to_number(to_char(ngay_imp,'yyyymm'))>=202405 and (lower(nhomphi) like '%tr_ tr__c%' or lower(nhomphi) like '%c__c ph_t sinh%') 
                        and trangthai like '__ thu' and username = a.ma_tb
        )
    -- select thang_ptm, ma_tb, soseri, tien_tt, ngay_tt, tien_dnhm, thang_tldg_dnhm, thang_tldg_dt, thang_tlkpi, xacnhan_khkt, thang_xacnhan_khkt, ghi_chu from ttkd_bsc.ct_bsc_ptm a
    where thang_ptm>=202405 and chuquan_id=264 and xacnhan_khkt is null and thang_tldg_dt is null and 
            and exists (select 1 from ttkdhcm_ktnv.db_act_593 
                          where to_number(to_char(ngay_imp,'yyyymm'))>=202405 
                           and (lower(nhomphi) like '%tr_ tr__c%' or lower(nhomphi) like '%c__c ph_t sinh%') 
                           and trangthai like '__ thu' and username = a.ma_tb
                    )
;

commit;


-- Kiem tra
select thang_ptm, ma_tb, soseri, tien_tt, ngay_tt, tien_dnhm, sothang_dc, thang_tldg_dnhm, thang_tldg_dt, thang_tlkpi
      ,xacnhan_khkt, thang_xacnhan_khkt, ghi_chu
from ttkd_bsc.ct_bsc_ptm a
where thang_ptm>=202405 and manv_ptm is not null
  and chuquan_id=264 and thang_xacnhan_khkt=202405
  and exists (select * from ttkdhcm_ktnv.db_act_593 
              where to_char(ngay_imp,'yyyymm')>='202405' and lower(nhomphi) like '%tr_ tr__c%' and username=a.ma_tb)
  and sothang_dc is null;


select distinct nguon from ttkd_bsc.ct_bsc_ptm where ma_tb='fvn_thangb3117' ;
select thang_luong, thang_ptm, ma_tb, tien_dnhm, tien_tt, soseri, ngay_tt, ghi_chu, xacnhan_khkt, thang_xacnhan_khkt, thang_tldg_dt, nguon
from ttkd_bsc.ct_bsc_ptm a where ma_tb in('fvn_a1008ca') ;

update ttkd_bsc.ct_bsc_ptm a set thang_luong=5, ghi_chu='Tr? tr??c FTTH 6 TH�NG T?NG 1 TH�NG ',xacnhan_khkt=4884000, thang_xacnhan_khkt=202405 
where ma_tb='fvn_sr1s3' ;
commit  ;

select thang_luong, thang_ptm, ma_tb, tien_dnhm, tien_tt, soseri, ngay_tt, ghi_chu, xacnhan_khkt, thang_xacnhan_khkt, thang_tldg_dt 
from ttkd_bsc.ct_bsc_ptm a where ma_tb in('fvn_sr1s3','fvn_54hp3') ;

update ttkd_bsc.ct_bsc_ptm a set thang_luong=5, ghi_chu='Tr? tr??c FTTH 7 TH�NG',xacnhan_khkt=2508000, thang_xacnhan_khkt=202404 
where ma_tb='fvn_54hp3' ;
commit 