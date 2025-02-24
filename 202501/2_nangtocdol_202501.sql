select * from tuyenngo.thaydoitocdo_202501 ;
drop table tuyenngo.thaydoitocdo_202501 purge ;
drop table tuyenngo.thaydoitocdo_202501_goc purge ;

create table tuyenngo.thaydoitocdo_202501 as
with v_hd as
       ( -- fiber:        
         SELECT hd.*, hd_adsl.tucthi FROM css.v_hd_thuebao@dataguard hd, css.v_hdtb_adsl@dataguard hd_adsl
           WHERE 
              hd.phanvung_id = 28 AND hd_adsl.phanvung_id = 28 AND hd.hdtb_id=hd_adsl.hdtb_id 
             AND hd.loaitb_id = 58
             AND hd.tthd_id IN (5, 6)
             AND hd.nguoi_cn <> 'ccbs'
             AND hd.kieuld_id IN (24, 654, 13080, 743)
             AND hd.ngay_kh  BETWEEN TO_DATE('202412', 'yyyyMM') AND ADD_MONTHS(TO_DATE('202501', 'yyyyMM'), 1) - 1/86400
             AND (hd.ghichu not LIKE 'Tu dong doi toc do%' OR hd.ghichu IS NULL)
             AND hd.ngay_kh = (SELECT MAX(ngay_kh)
                               FROM css.v_hd_thuebao@dataguard
                               WHERE phanvung_id = 28
                                 AND tthd_id IN (5, 6)
                                 AND loaitb_id = 58
                                 AND TO_CHAR(ngay_kh, 'yyyymm') BETWEEN '202412' AND '202501'
                                 AND kieuld_id IN (24, 654, 13080, 743)
                                 AND thuebao_id = hd.thuebao_id
                            )

           UNION ALL
         -- TSL:  
         SELECT hd.*, null as tucthi FROM css.v_hd_thuebao@dataguard hd
           WHERE phanvung_id = 28
             AND dichvuvt_id IN (7, 8, 9)
             AND tthd_id IN (5, 6) 
             AND kieuld_id IN (64, 65, 596, 684, 696, 190, 702, 13127, 952)
             AND ngay_ht BETWEEN TO_DATE('202501', 'yyyyMM') AND ADD_MONTHS(TO_DATE('202501', 'yyyyMM'), 1) - 1/86400            
             AND ngay_ht = (SELECT MAX(ngay_ht)
                               FROM css.v_hd_thuebao@dataguard hd1
                               WHERE --phanvung_id = 28 AND
                                 TO_CHAR(hd1.ngay_ht, 'yyyymm') = '202501' 
                                 AND hd1.kieuld_id IN (64, 65, 596, 684, 696, 190, 702, 13127, 952)
                                 AND hd1.thuebao_id = hd.thuebao_id
                            )
       ) 
  ,v_km_old as
       (SELECT thuebao_id, tyle_sd FROM css.v_khuyenmai_dbtb@dataguard
           WHERE phanvung_id = 28 AND hieuluc = 0
             AND tyle_sd > 0
             AND tyle_sd < 100
             AND thang_kt = 202412
        UNION ALL
        SELECT thuebao_id, tyle_tk FROM css.v_tb_khuyenmai@dataguard
           WHERE phanvung_id = 28 AND hieuluc = 0
             AND tyle_sd > 0
             AND tyle_sd < 100
             AND thang_huy = 202412
        ) 
 ,v_km_new as
       (SELECT * FROM css.v_khuyenmai_dbtb@dataguard
           WHERE phanvung_id = 28 AND hieuluc = 1
             AND tyle_sd > 0
             AND tyle_sd < 100
             AND thang_kt >= 202501
       )        
 ,v_dbtb_new as (select dbtb.thuebao_id, dbtb.thanhtoan_id, dbtb.khachhang_id, dbtb.chuquan_id, dbtb.ten_tb, dbtb.diachi_ld, dbtb.doituong_id
                       ,dbtb.ngay_sd, dbtb.tocdo_id, dbtb.cuoc_tk_goc, dbtb.cuoc_tc_goc, dbtb.cuoc_nix, dbtb.cuoc_isp, dbtb.mucuoctb_id
                       ,dbkh.so_gt, dbkh.mst mst_kh, dbtt.mst mst_tt, dbtb.trangthaitb_id, dbtb.loaitb_id, dbtb.thoihan_id
                 from tinhcuoc.v_dbtb@dataguard dbtb, css.v_db_thanhtoan@dataguard dbtt, css.v_db_khachhang@dataguard dbkh
                 where dbtb.ky_cuoc = 20250101 and dbtb.phanvung_id = 28 and dbtt.phanvung_id = 28 and dbkh.phanvung_id = 28
                   AND dbtb.thanhtoan_id = dbtt.thanhtoan_id (+)
                   AND dbtb.khachhang_id = dbkh.khachhang_id (+)
                   --AND dbtb.doituong_id (+) NOT IN (14, 15, 16, 17, 19, 32, 33, 34, 35, 36, 48, 51, 52, 54, 55, 56, 57, 66, 47, 49, 50)
                   -- may nghiep vu, cong vu, nghiep vu X, VMS,STTTT, BOCA
                 )
 ,v_dbtb_old as (select thuebao_id, thanhtoan_id, khachhang_id, chuquan_id, ten_tb, diachi_ld,doituong_id, ngay_sd, tocdo_id
                        ,cuoc_tk_goc, cuoc_tc_goc, cuoc_nix, cuoc_isp, mucuoctb_id, trangthaitb_id, loaitb_id, thoihan_id
                 from tinhcuoc.v_dbtb@dataguard 
                 where ky_cuoc = 20241201 and phanvung_id = 28 
                 --and ma_tb = 'chiphobao_2'
                 --  AND doituong_id (+) NOT IN (14, 15, 16, 17, 19, 32, 33, 34, 35, 36, 48, 51, 52, 54, 55, 56, 57, 66, 47, 49, 50)
                   -- may nghiep vu, cong vu, nghiep vu X, VMS,STTTT, BOCA
                 )
 ,v_nv as
     ( select nv.nhanvien_id, nv.ma_nv ma_tiepthi, nv.ma_nv ma_tiepthi_new, nv.ten_nv ten_tiepthi, dm1.ten_dv to_tt, dm2.ten_dv donvi_tt
        from admin.v_nhanvien@dataguard nv, admin.v_donvi@dataguard dm1, admin.v_donvi@dataguard dm2
        where nv.donvi_id = dm1.donvi_id AND dm1.donvi_cha_id = dm2.donvi_id
      ) 

SELECT DISTINCT  
      a.ma_gd, a.ma_kh, b.ma_tb, (select loaihinh_tb from css.loaihinh_tb@dataguard where loaitb_id=dbtb_new.loaitb_id)dich_vu
     ,b.kieuld_id, (select ten_kieuld from css.kieu_ld@dataguard where kieuld_id=b.kieuld_id)tenkieu_ld
     ,a.loaihd_id, b.dichvuvt_id, b.loaitb_id, a.hdkh_id, b.hdtb_id, dbtb_new.so_gt, dbtb_new.mst_kh, dbtb_new.mst_tt
     ,dbtb_new.khachhang_id, dbtb_new.thanhtoan_id, b.thuebao_id, dbtb_new.chuquan_id, dbtb_new.ten_tb, dbtb_new.diachi_ld
     ,dbtb_new.doituong_id, dbtb_new.ngay_sd, dbtb_new.thoihan_id thoihan_id_new, b.ngay_ht, b.ngay_kh, b.ngay_ins, dbtb_new.trangthaitb_id
     , a.ma_duan ma_duan_banhang

     ,a.ctv_id, a.nhanvien_id, nv.ma_tiepthi, nv.ma_tiepthi_new, nv.ten_tiepthi, nv.to_tt, nv.donvi_tt
     ,decode(b.tucthi,0,'Thang sau','Tuc thi') tucthi
     ,dbtb_old.tocdo_id tocdo_dbold_id,  dbtb_new.tocdo_id tocdo_dbnew_id
     ,dbtb_old.mucuoctb_id mucuoctb_id_old, b.mucuoctb_id mucuoctb_id_new, dbtb_old.thoihan_id thoihan_id_old
     ,(CASE WHEN b.dichvuvt_id IN (7, 8, 9) THEN (SELECT TO_CHAR(tocdo) || donvi FROM css.tocdo_kenh@dataguard b 
                                                    WHERE b.tocdo_id = dbtb_old.tocdo_id AND dbtb_old.tocdo_id > 0) 
            WHEN b.dichvuvt_id = 4 THEN (SELECT ma_td FROM css.tocdo_adsl@dataguard b WHERE b.tocdo_id = dbtb_old.tocdo_id AND dbtb_old.tocdo_id > 0) 
            ELSE NULL 
       END
      ) ma_td_old

     ,(CASE WHEN b.dichvuvt_id IN (7, 8, 9) THEN ( SELECT TO_CHAR(tocdo) || donvi FROM css.tocdo_kenh@dataguard b
                                                   WHERE b.tocdo_id = dbtb_new.tocdo_id AND dbtb_new.tocdo_id > 0) 
            WHEN b.dichvuvt_id = 4 THEN (SELECT ma_td FROM css.tocdo_adsl@dataguard b 
                                         WHERE b.tocdo_id = dbtb_new.tocdo_id AND dbtb_new.tocdo_id > 0) 
          ELSE NULL 
       END
      ) ma_td_new
            
     ,(CASE WHEN b.dichvuvt_id=4 THEN (SELECT cuoc_tg FROM css.v_muccuoc_tb@dataguard mc WHERE mc.dichvuvt_id=b.dichvuvt_id AND mc.mucuoctb_id=dbtb_old.mucuoctb_id)
                 WHEN b.dichvuvt_id in (7,8,9) AND km_old.tyle_sd IS NULL THEN nvl(dbtb_old.cuoc_tk_goc,0)+nvl(dbtb_old.cuoc_tc_goc,0)+nvl(dbtb_old.cuoc_nix,0)+nvl(dbtb_old.cuoc_isp,0)  
                 WHEN b.dichvuvt_id in (7,8,9) AND km_old.tyle_sd IS NOT NULL THEN round( (nvl(dbtb_old.cuoc_tk_goc,0)+nvl(dbtb_old.cuoc_tc_goc,0)+nvl(dbtb_old.cuoc_nix,0)+nvl(dbtb_old.cuoc_isp,0)) *(100- nvl(km_old.tyle_sd,0) )/100,0)
            ELSE NULL 
       END
       ) dthu_goi_old
            
      ,(CASE WHEN b.dichvuvt_id=4 then (SELECT cuoc_tg FROM css.v_muccuoc_tb@dataguard mc WHERE mc.dichvuvt_id=b.dichvuvt_id AND mc.mucuoctb_id=dbtb_new.mucuoctb_id)
                 WHEN b.dichvuvt_id in (7,8,9) AND km_old.tyle_sd  IS NULL THEN nvl(dbtb_new.cuoc_tk_goc,0)+nvl(dbtb_new.cuoc_tc_goc,0)+nvl(dbtb_new.cuoc_nix,0)+nvl(dbtb_new.cuoc_isp,0)  
                 WHEN b.dichvuvt_id in (7,8,9) AND km_old.tyle_sd  IS NOT NULL THEN round( (nvl(dbtb_new.cuoc_tk_goc,0)+nvl(dbtb_new.cuoc_tc_goc,0)+nvl(dbtb_new.cuoc_nix,0)+nvl(dbtb_new.cuoc_isp,0)) *(100- nvl(km_new.tyle_sd,0) )/100,0)
            ELSE NULL 
        END
        ) dthu_goi_new         
 
  FROM css.v_hd_khachhang@dataguard a, v_hd b, v_km_old km_old, v_km_new km_new, v_dbtb_new dbtb_new, v_dbtb_old dbtb_old, v_nv nv
  WHERE a.hdkh_id = b.hdkh_id and a.phanvung_id = 28 and b.phanvung_id = 28
    AND b.thuebao_id = km_old.thuebao_id (+)
    AND b.thuebao_id = km_new.thuebao_id (+)
    AND b.thuebao_id = dbtb_old.thuebao_id (+)
    AND b.thuebao_id = dbtb_new.thuebao_id (+)
    and a.ctv_id=nv.nhanvien_id
;

create index thaydoitocdo_202501_hdtbid on thaydoitocdo_202501 (hdtb_id) ;
create index thaydoitocdo_202501_thuebaoid on thaydoitocdo_202501 (thuebao_id) ;
create index thaydoitocdo_202501_maduan on thaydoitocdo_202501 (ma_duan_banhang) ;
create index thaydoitocdo_202501_matb on thaydoitocdo_202501 (ma_tb) ;

select * from thaydoitocdo_202501 ;
select * from thaydoitocdo_202501 where MA_TD_OLD <> MA_TD_NEW ;

alter table thaydoitocdo_202501 
    add ( tien_dvgt_bs number, 
              tien_tbi_bs number,
              dthu_ps_old number,
              dthu_ps_new number,
              dthu_duoctinh number,
              lydo_khongtinh_luong varchar2(200),
              ghi_chu varchar2(500),
              trangthai_tt_id number
        );
commit ;

-- ma_duan:

drop table temp_tbduan;
create table temp_tbduan as 
    select thuebao_id, ma_duan from tuyenngo.v_db_duan a
        where exists(select 1 from thaydoitocdo_202501 where thuebao_id=a.thuebao_id)
            and ma_duan is not null;
create index temp_tbduan on temp_tbduan (thuebao_id);

alter table thaydoitocdo_202501 add ma_duan varchar2(20);
select ma_duan, count(*)sl from temp_tbduan group by ma_duan ;
update thaydoitocdo_202501 a 
        set ma_duan=(select distinct replace(ma_duan,' ','') from temp_tbduan where thuebao_id=a.thuebao_id);
     
commit ;
select * from thaydoitocdo_202501 ; 
-- dthu_ps_old,dthu_ps_new :
/*
update thaydoitocdo_202501 a set dthu_ps_old='', dthu_ps_new='';
update thaydoitocdo_202501 a 
        set dthu_ps_old=(select sum(dthu) from ttkd_bct.cuoc_thuebao_ttkd_202412 where thuebao_id=a.thuebao_id),
            thu_ps_new=(select sum(nogoc) from bcss_hcm.ct_no
                                         where ky_cuoc=20250101 and khoanmuctt_id not in (441,453,520,521,527,3126,3127,3421,3953) -- 453 cuoc GDVP
                                                and thuebao_id=a.thuebao_id);
*/
-- dthu_ps_old,dthu_ps_new :
alter table thaydoitocdo_202501 add dthu_ps_old_1 number ;
commit ;

select ma_tb, count(*)sl from thaydoitocdo_202501 group by ma_tb ;
select ma_tb, count(*)sl from bcss.v_thftth@dataguard
where ky_cuoc=20250101 group by ma_tb having count(*)>1 ;

select * from bcss.v_thftth@dataguard where ky_cuoc = 20250101  ;

drop table a_temp_old purge ;
create table a_temp_old as -- 453 cuoc TT GDVP
select thuebao_id, sum(nogoc)dt from bcss.v_ct_no@dataguard
where ky_cuoc=20241201 and khoanmuctt_id not in (441,453,520,521,527,3126,3127,3421,3953)
group by thuebao_id
;
create index a_temp_old_tbid on a_temp_old (thuebao_id) ;

drop table a_temp_new purge ;
create table a_temp_new as -- 453 cuoc TT GDVP
select thuebao_id, sum(nogoc)dt from bcss.v_ct_no@dataguard
where ky_cuoc=20250101 and khoanmuctt_id not in (441,453,520,521,527,3126,3127,3421,3953)
group by thuebao_id
;
create index a_temp_new_tbid on a_temp_new (thuebao_id) ;

update thaydoitocdo_202501 a set dthu_ps_old='', dthu_ps_new='', dthu_ps_old_1=''
;

update thaydoitocdo_202501 a 
        set dthu_ps_old=(select dt from a_temp_old where thuebao_id=a.thuebao_id),
            dthu_ps_old_1=(select sum(dthu) from ttkd_bct.cuoc_thuebao_ttkd_202412 where thuebao_id=a.thuebao_id),  
            dthu_ps_new=(select dt from a_temp_new where thuebao_id=a.thuebao_id);

commit ;
--  Bo sung dthu_goi_old, dthu_goi_new:

drop table a_temp_thftth purge ;
create table a_temp_thftth as
select ma_tb, cuoc_tggoc, cuoc_ipgoc, dbf_row_id, ky_cuoc
from bcss.v_thftth@dataguard a 
where phanvung_id= 28 and ky_cuoc in('20241201','20250101')
and exists (select 1 from thaydoitocdo_202501 where ma_tb=a.ma_tb);


update thaydoitocdo_202501 a 
    set dthu_goi_old = (select distinct cuoc_tggoc from a_temp_thftth where ky_cuoc=20241201 and ma_tb=a.ma_tb)
   -- select * from thaydoitocdo_202501 a
   where loaitb_id = 58 and chuquan_id in (145,264,266) and nvl(dthu_goi_old,0)=0;
 
update thaydoitocdo_202501 a 
    set dthu_goi_new = (select cuoc_tggoc from a_temp_thftth where ky_cuoc=20250101 and ma_tb=a.ma_tb)
    -- select * from thaydoitocdo_202501 a
    where loaitb_id = 58 and nvl(dthu_goi_new,0)=0;
commit ;

select ma_tb, ky_cuoc, count(*)sl from a_temp_thftth group by ma_tb, ky_cuoc having count(*) > 1 ;
-- Bo sung iptinh
alter table thaydoitocdo_202501 add iptinh number;
commit ;
-- ma_td_new  like '%Ip T?nh%'
drop table a_temp_new purge ;
create table a_temp_new as 
select a.ma_tb, a.cuoc_ipgoc from a_temp_thftth a 
where ky_cuoc = '20250101' 
and dbf_row_id =(select max(dbf_row_id) from a_temp_thftth where ky_cuoc = '20250101' and ma_tb = a.ma_tb) 
and exists (select 1 from thaydoitocdo_202501 where ma_tb=a.ma_tb);
create index a_temp_new_matb on a_temp_new (ma_tb) ;

select * from a_temp_new a where exists (select 1 from thaydoitocdo_202501 where ma_tb=a.ma_tb);
select ma_tb, count(*)sl from a_temp_new group by ma_tb ;

update thaydoitocdo_202501 a 
    set iptinh = (select nvl(cuoc_ipgoc,0) from a_temp_new where ma_tb=a.ma_tb)
   -- select * from thaydoitocdo_202501 a
   where loaitb_id in (58) and chuquan_id in (145,264,266) 
        and exists (select 1 from a_temp_thftth where ky_cuoc=20241201 and cuoc_ipgoc=0 and ma_tb=a.ma_tb)
        and exists (select 1 from a_temp_thftth where ky_cuoc=20250101 and cuoc_ipgoc>0 and ma_tb=a.ma_tb);

commit ;
update thaydoitocdo_202501 a 
    set dthu_goi_new = nvl(dthu_goi_new,0) + nvl(iptinh,0)
    where iptinh > 0 ;
commit ;
rollback ;
select * from thaydoitocdo_202501 ;

drop table a_temp_new purge ;
create table a_temp_new as 
select distinct hdkh_id, ma_gd, trangthai from css.v_phieutt_hd@dataguard a
where ma_gd like 'HCM-TD%' 
and exists(select 1 from thaydoitocdo_202501 where hdkh_id = a.hdkh_id and ma_gd = a.ma_gd)
;
create index a_temp_new_hdkhid on a_temp_new (hdkh_id) ;
create index a_temp_new_magd on a_temp_new (ma_gd) ;

select hdkh_id, ma_gd, count(*)sl from a_temp_new group by hdkh_id, ma_gd ;

update thaydoitocdo_202501 a set trangthai_tt_id = (select trangthai from a_temp_new where hdkh_id = a.hdkh_id) ;
commit ;

-- dthu_duoctinh:
update thaydoitocdo_202501 set dthu_duoctinh='';
update thaydoitocdo_202501 
    set dthu_duoctinh=(case when nvl(dthu_goi_new,0)-nvl(dthu_goi_old,0) > 0  
                            then nvl(dthu_goi_new,0)-nvl(dthu_goi_old,0) else 0 end);
commit ;                                                

--drop table thaydoitocdo_202501_goc purge ;
create table thaydoitocdo_202501_goc as select * from thaydoitocdo_202501 ; -- luu bang truoc khi delete
select * from thaydoitocdo_202501_goc;
select * from thaydoitocdo_202501 where to_char(ngay_sd,'yyyymm') = 202501 ;
select * from ttkd_bsc.ct_bsc_ptm where ma_tb = 'phuochung888' ;

delete from thaydoitocdo_202501 a
    -- select * from thaydoitocdo_202501 a
    where loaitb_id in (58,59) 
                and ( (tucthi='Tuc thi' and to_char(ngay_kh,'yyyymm')='202412') 
                            or (tucthi='Thang sau' and to_char(ngay_kh,'yyyymm')='202501')
                            or exists(select 1 from ttkd_bsc.ct_bsc_ptm where hdtb_id=a.hdtb_id));
 commit ;


-- lydo_khongtinh_luong:
update thaydoitocdo_202501 a set lydo_khongtinh_luong='';
update thaydoitocdo_202501 a 
    set lydo_khongtinh_luong=lydo_khongtinh_luong||'-Tinh luong theo hs lap moi'
    -- select lydo_khongtinh_luong from thaydoitocdo_202501 a
    where exists (select 1 from ttkd_bsc.ct_bsc_ptm where thang_ptm=202501 and loaihd_id=1 and thuebao_id=a.thuebao_id)
    ;
commit ;
--select a.* from thaydoitocdo_202501 a where exists (select 1 from tuyenngo.cdbr_ptm_202501_bctuan where loaihd_id=1 and thuebao_id=a.thuebao_id) ;

--select distinct dichvuvt_id from thaydoitocdo_202501 ;

update thaydoitocdo_202501 
    set lydo_khongtinh_luong=lydo_khongtinh_luong || 'Chu quan khong thuoc TTKD HCM'
    -- select * from thaydoitocdo_202501 
    where chuquan_id not in (145,264,266);
commit ;

update thaydoitocdo_202501
    set lydo_khongtinh_luong=lydo_khongtinh_luong || 'kq2 Doi tuong nghiep vu'
    -- select * from thaydoitocdo_202501 
    where doituong_id in (14,15,16,17,19,32,33,34,35,36,48,51,52,54,55,56,57,66);
commit ;

update thaydoitocdo_202501
    set lydo_khongtinh_luong=lydo_khongtinh_luong || 'kq3 TSL doi tuong VMS, STTTT, Bo CA'
    -- select * from thaydoitocdo_202501 
    where doituong_id in (47,49,50) ;
commit ;

--case when doituong_id in (14,15,16,17,19,32,33,34,35,36,48,51,52,54,55,56,57,66) then ';kq2 Doi tuong nghiep vu' end kq2				   ,
--case when doituong_id in (47,49,50) and dichvuvt_id in (7,8,9) then ';kq3 TSL doi tuong VMS, STTTT, Bo CA' end kq3
    
update thaydoitocdo_202501 
    set lydo_khongtinh_luong=lydo_khongtinh_luong || 'Cuoc phat sinh sau khi doi toc do khong cao hon'
    -- select * from thaydoitocdo_202501 
    where chuquan_id in (145,264,266) and nvl(dthu_ps_old,0) >= nvl(dthu_ps_new,0); -- moi sua doi ngay 18/05/2024 theo yc cua chi Tung
commit ;
/*

1. thang_ptm=202412 and ma_gd like 'HCM-TD/%' and dthu_ps<=dthu_ps_truoc and (thang_tldg_dt=202501 or thang_tldg_dt is null):
- c?t lydo_khongtinh_luong v� c?t lydo_khongtinh_dongia: bs th�m ";Cuoc phat sinh sau khi doi toc do khong cao hon"
- ki?m tra n?u thang_tldg_dt=202501 th� c?p nh?t 4 c?t tr? v? null
thang_tldg_dt='', thang_tlkpi='', thang_tlkpi_to='', thang-tlkpi_phong=''

*/
alter table thaydoitocdo_202501
                add (manv_ptm varchar2(20), tennv_ptm varchar2(100), pbh_ptm_id number(3),
                        ma_pb varchar2(20),ten_pb varchar2(100),ma_to varchar2(20),ten_to varchar2(100),ma_vtcv varchar2(20),
                        loai_ld varchar2(100), manv_hotro varchar2(20), tyle_hotro number(5,2), tyle_am number(6,2), nhom_tiepthi number );

update thaydoitocdo_202501 a 
    set pbh_ptm_id='',manv_ptm='',tennv_ptm='',ma_to='',ten_to='',ma_pb='',ten_pb='',ma_vtcv='',loai_ld='',nhom_tiepthi='';
    
update thaydoitocdo_202501 a set (pbh_ptm_id,manv_ptm,tennv_ptm,ma_to,ten_to,ma_pb,ten_pb,ma_vtcv,loai_ld,nhom_tiepthi)=
          (select pb.pbh_id,b.ma_nv,b.ten_nv,b.ma_to,b.ten_to,b.ma_pb,b.ten_pb,b.ma_vtcv,b.loai_ld,nhomld_id
           from ttkd_bsc.nhanvien b, ttkd_bsc.dm_phongban pb 
           where b.thang=202501 and b.donvi='TTKD' and b.ma_pb=pb.ma_pb and pb.active=1 and b.ma_nv=a.ma_tiepthi_new)
    where exists(select 1 from ttkd_bsc.nhanvien b where b.manv_hrm=a.ma_tiepthi_new and b.thang=202501 and b.donvi='TTKD');
 commit ;
 
/* --------------- INSERT VAO FILE GOM , KO INSERT THANG PTM VAO FILE GOM ---------------- */
insert into ttkd_bsc.ct_bsc_ptm 
                    (thang_luong, thang_ptm, ma_gd, ma_kh, ma_tb, dich_vu, tenkieu_ld,ten_tb, diachi_ld, so_gt, mst, mst_tt
                  , ngay_bbbg, kieuld_id, loaihd_id, dichvuvt_id, loaitb_id, hdkh_id, hdtb_id, khachhang_id, thanhtoan_id
                  , thuebao_id, trangthaitb_id, doituong_id, ma_tiepthi, ma_tiepthi_new, donvi_tt, manv_ptm, tennv_ptm
                  , pbh_ptm_id, ma_pb, ten_pb, ma_to, ten_to, ma_vtcv, loai_ld, nhom_tiepthi, dthu_ps_truoc, dthu_ps, dthu_goi
                  , mien_hsgoc, ghi_chu, nguon, nhanvien_nhan_id, chuquan_id, ma_da, ma_duan_banhang, lydo_khongtinh_luong, tocdo_id
                  , trangthai_tt_id, manv_hotro, tyle_hotro, tyle_am, heso_hotro_nvptm, heso_hotro_nvhotro)  

        select  202501, 202501, ma_gd, ma_kh, ma_tb, dich_vu, tenkieu_ld, ten_tb, diachi_ld, so_gt, mst_kh, mst_tt
                  , ngay_ht, kieuld_id, loaihd_id, dichvuvt_id, loaitb_id, hdkh_id, hdtb_id, khachhang_id, thanhtoan_id
                  , thuebao_id, trangthaitb_id, doituong_id, ma_tiepthi, ma_tiepthi_new, donvi_tt, manv_ptm, tennv_ptm
                  , pbh_ptm_id, ma_pb, ten_pb, ma_to, ten_to, ma_vtcv, loai_ld, nhom_tiepthi, dthu_ps_old, dthu_ps_new, dthu_duoctinh
                  , 1, ghi_chu, 'thaydoitocdo', nhanvien_id, chuquan_id, ma_duan, ma_duan_banhang, lydo_khongtinh_luong, tocdo_dbnew_id
                  , trangthai_tt_id, manv_hotro, tyle_hotro, tyle_am, tyle_am, tyle_hotro
        from tuyenngo.thaydoitocdo_202501 a
        where to_char(NGAY_SD,'yyyymm') < '202501' 
          and not exists (select 1 from ttkd_bsc.ct_bsc_ptm where hdtb_id = a.hdtb_id )          
          and loaitb_id != 39 ;
            
commit; 

/* KIEM TRA LAI DTHU_PS */
/* --------- UP N-1 ----------- */
select thang_luong, thang_ptm, ma_gd, ma_tb, dich_vu, ngay_bbbg, lydo_khongtinh_luong,lydo_khongtinh_dongia
       ,dthu_goi, nvl(dthu_ps_truoc,0)dthu_ps_truoc, nvl(dthu_ps,0)dthu_ps, nvl(dthu_ps_N1,0)dthu_ps_N1
       ,nvl(dthu_ps_N2,0)dthu_ps_N2, nvl(dthu_ps_N3,0)dthu_ps_N3, thang_tldg_dt, luong_dongia_nvptm
from ttkd_bsc.ct_bsc_ptm 
where thang_ptm between 202410 and 202501
and thang_tldg_dt is null and dthu_goi > 0
and nguon='thaydoitocdo' 
--and thang_ptm=202412
--and ma_gd in('HCM-TD/00683087','HCM-TD/00683360','HCM-TD/00685875')
and ( (dthu_ps_truoc < nvl(dthu_ps_N1,0)) or (dthu_ps_truoc < nvl(dthu_ps_N2,0)) or (dthu_ps_truoc < nvl(dthu_ps_N3,0)) )
and lydo_khongtinh_luong like 'Cuoc phat sinh sau khi doi toc do khong cao hon'
;

update  ttkd_bsc.ct_bsc_ptm set lydo_khongtinh_luong = '', LYDO_KHONGTINH_DONGIA = ''
where thang_ptm between 202410 and 202501
and thang_tldg_dt is null and dthu_goi > 0
and nguon='thaydoitocdo' 
and ( (dthu_ps_truoc < nvl(dthu_ps_N1,0)) or (dthu_ps_truoc < nvl(dthu_ps_N2,0)) or (dthu_ps_truoc < nvl(dthu_ps_N3,0)) )
and lydo_khongtinh_luong like 'Cuoc phat sinh sau khi doi toc do khong cao hon'

;
commit ;

