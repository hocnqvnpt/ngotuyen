update ct_bsc_ptm a set (manv_ptm, ma_pb, ten_pb, ma_to, ten_to, pbh_ptm_id)
                       =(select manv_ptm, ma_pb, ten_pb, ma_to, ten_to, pbh_ptm_id from dt_ptm_vnp_202409 where somay = a.ma_tb)
-- select thang_ptm, dich_vu, ma_nguoigt, manv_ptm, ten_to, ten_pb from ct_bsc_ptm
where lpad(ma_nguoigt,4)='GTGT' 
and thang_ptm = 202409 and nguon = 'dt_ptm_vnp'
and manv_ptm is null 
;
commit ;
(select distinct ten_daily from ttkd_bsc.dm_daily_khdn where thang='202407' and ma_daily=nguoi_gt) else '' end)

select ma_nguoigt, nguoi_gt, nhom_gt
from ttkd_bsc.ct_bsc_ptm
where nguon = 'dt_ptm_vnp'  and thang_ptm >= 202407
and ( upper(ma_tiepthi) like 'GTGT_%' or upper(ma_tiepthi) like 'DAILY_%' 
or upper(ma_tiepthi) like 'DL_%' or upper(ma_nguoigt) like 'GTGT_%' 		
or upper(ma_nguoigt) like' DAILY_%' or upper(ma_nguoigt) like 'DL_%')
;
update ttkd_bsc.ct_bsc_ptm a set (nguoi_gt, nhom_gt) = (select ten_nv, ten_dv 
                                                        from 
                                                        ( select nv.ma_nv, nv.ten_nv, dv.ten_dv 
                                                           from admin_hcm.nhanvien nv, admin_hcm.donvi dv 
                                                           where nv.donvi_id = dv.donvi_id 
                                                             and upper(nv.ma_nv) like 'GTGT%' 
                                                        ) where ma_nv = a.ma_nguoigt
                                                        ) 
where nguon = 'dt_ptm_vnp'  and thang_ptm >= 202407
and ( upper(ma_tiepthi) like 'GTGT_%' or upper(ma_tiepthi) like 'DAILY_%' 
or upper(ma_tiepthi) like 'DL_%' or upper(ma_nguoigt) like 'GTGT_%' 		
or upper(ma_nguoigt) like' DAILY_%' or upper(ma_nguoigt) like 'DL_%')
;
commit ;

select count(*)sl from ttkd_bsc.ct_bsc_ptm
where nguon = 'dt_ptm_vnp'  and thang_ptm >= 202407
and ( upper(ma_tiepthi) like 'GTGT_%' or upper(ma_tiepthi) like 'DAILY_%' 
or upper(ma_tiepthi) like 'DL_%' or upper(ma_nguoigt) like 'GTGT_%' 		
or upper(ma_nguoigt) like' DAILY_%' or upper(ma_nguoigt) like 'DL_%')
and lydo_khongtinh_luong is null
;
select * from admin_hcm.donvi where donvi_id = 11555 ;
select * from admin_hcm.nhanvien ;
select * from ttkd_bsc.dm_daily_khdn ;

/* ------------- UP THEO YEU CAU CUA HOC 13/09/2024 ------------ */
update ttkd_bsc.ct_bsc_ptm a set lydo_khongtinh_luong = 'kq5 Phat trien qua Dai ly, chi tinh bsc cho Phong' 
-- select thang_ptm, ma_tiepthi, manv_ptm, ma_nguoigt, lydo_khongtinh_luong, nguon from ttkd_bsc.ct_bsc_ptm a
where nguon in('dt_ptm_vnp','dt_ptm_vnp_bs')  and thang_ptm = 202407
and ( upper(ma_tiepthi) like 'GTGT_%' or upper(ma_tiepthi) like 'DAILY_%' 
or upper(ma_tiepthi) like 'DL_%' or upper(ma_nguoigt) like 'GTGT_%' 		
or upper(ma_nguoigt) like' DAILY_%' or upper(ma_nguoigt) like 'DL_%')
and lydo_khongtinh_luong is null
;
commit ;
rollback ;
/* TRUOC KHI IMP VAO BANG GOM, NHO KET NOI BANG DB_THUE (ONEBSS) DE BS KHACHHANG_ID - BS THEO YEU CAU CUA HOC 29/08/2024 */
/* -------------- UP VNP.TS ---------------- */
INSERT INTO ct_bsc_ptm
       (thang_luong,thang_ptm,ma_gd,ma_kh,MA_TB,DICH_VU, TENKIEU_LD, kieuld_id, loaihd_id, ten_tb,DIACHI_LD,so_nha,pho_id,phuong_id,quan_id,
       so_gt,mst,ma_da,chu_nhom,ngay_bbbg,NGAY_LUUHS_TTKD, ngay_scan, HESO_KHUYENKHICH, HESO_DICHVU, HESO_TRATRUOC, HESO_KVDACTHU,
       manv_tt_dai,Ma_vtcv_dai,ma_to_dai,tocdo_id,goi_cuoc,goi_luongtinh, dichvuvt_id,loai_tb,loaitb_id,trangthaitb_id,doituong_id,
       ma_nguoigt, nguoi_gt,ghi_chu, kh_id,ma_dt_kh,pbh_ql_id, manv_ptm, tennv_ptm, ma_pb, ten_pb, ma_to,ten_to, ma_vtcv, loainv_id,loai_ld, 
       NHOM_TIEPTHI ,user_cn, ten_user_cn, dthu_ps_truoc,dthu_ps,dthu_goi,dthu_goi_goc,SOTHANG_DC,thang_bddc, thang_ktdc, nop_du,
       tien_dnhm, chuquan_id, khachhang_id, nguon)

SELECT 202409,202409,a.ma_hd, a.ma_kh, a.somay,'VNPTS', a.kieu_ld, a.kieuld_id, a.loaihd_id, a.ten_tb, a.dc_gbc, a.so_nha,a.pho_id,a.phuong_id,a.quan_id,
       a.so_gt, a.mst, a.ma_da, a.chu_nhom, a.NGAY_LD, a.ngay_luuhs, a.ngay_scan, a.heso_kk_goivp_m, A.heso_DICHVU, A.HESO_TRATRUOC, A.HESO_DACTHU, 
       a.manv_tt_dai,a.ma_vtcv_dai,a.ma_to_dai,a.tocdo_id, (a.loai_goi||'-'||a.package_name), goi_luongtinh, a.dichvuvt_id,loai_tb,a.loaitb_id, a.trangthai_id,a.doituong_id, 
       a.nguoi_gt, a.nguoi_gt, a.GHICHU_NGUOI_GT, a.kh_id, a.ma_dt_kh, a.pbh_ql_id, a.manv_ptm, a.tennv_ptm, a.ma_pb, a.ten_pb,a.ma_to,a.ten_to, a.ma_vtcv, a.loainv_id,a.loai_ld,
       NHOM_TIEPTHI, user_ld, ten_user_cn, a.dthu_ps_goc, a.dthu_ps, a.dthu_goi,a.dthu_goi_goc,SOTHANG_TRATRUOC,thang_bddc, thang_ktdc, nop_du
       ,a.cuoc_dnhm, a.chuquan_id, db.khachhang_id, 'dt_ptm_vnp'
FROM dt_ptm_vnp_202409 a 
left join css_hcm.db_thuebao db on a.somay = trim('84'||db.ma_tb) and db.loaitb_id = 20 
--and to_char(db.ngay_sd,'yyyymm') = '202409'
;
commit;
/*
SELECT db.ngay_sd, db.khachhang_id, (select mst from css_hcm.db_khachhang where khachhang_id = db.khachhang_id)MST,
       a.ma_hd, a.ma_kh, a.somay,'VNPTS', a.kieu_ld, a.kieuld_id, a.loaihd_id, a.ten_tb, a.dc_gbc, a.so_nha,a.pho_id,a.phuong_id,a.quan_id,
       a.so_gt, a.mst, a.ma_da, a.chu_nhom, a.NGAY_LD, a.ngay_luuhs, a.ngay_scan, a.heso_kk_goivp_m, A.heso_DICHVU, A.HESO_TRATRUOC, A.HESO_DACTHU, 
       a.manv_tt_dai,a.ma_vtcv_dai,a.ma_to_dai,a.tocdo_id, (a.loai_goi||'-'||a.package_name), goi_luongtinh, a.dichvuvt_id,loai_tb,a.loaitb_id, a.trangthai_id,a.doituong_id, 
       a.nguoi_gt, a.nguoi_gt, a.GHICHU_NGUOI_GT, a.kh_id, a.ma_dt_kh, a.pbh_ql_id, a.manv_ptm, a.pbh_ptm_id, a.ma_pb, a.ten_pb,a.ma_to,a.ten_to, a.ma_vtcv, a.loainv_id,a.loai_ld,
       NHOM_TIEPTHI, user_ld, ten_user_cn, a.dthu_ps_goc, a.dthu_ps, a.dthu_goi,a.dthu_goi_goc,SOTHANG_TRATRUOC,thang_bddc, thang_ktdc, nop_du
       ,a.cuoc_dnhm, a.chuquan_id, 'dt_ptm_vnp'
FROM ttkd_bsc.dt_ptm_vnp_202409 a
left join css_hcm.db_thuebao db on a.somay = trim('84'||db.ma_tb) and db.loaitb_id = 20 
;
*/
commit ;
rollback ;
/* ------------- UP VCC -------------------- */
delete from ct_bsc_ptm where nguon = 'dt_ptm_vnp_bs' and thang_ptm = 202409 ;
commit ;

update ct_bsc_ptm a set (manv_ptm, ma_pb, ten_pb, ma_to, ten_to, pbh_ptm_id)
                       =(select manv_ptm, ma_pb, ten_pb, ma_to, ten_to, pbh_ptm_id from dt_ptm_vnp_202409_bs where somay = a.ma_tb)
-- select thang_ptm, dich_vu, ma_nguoigt, nguoi_gt, manv_ptm, ten_to, ten_pb, dthu_goi from ct_bsc_ptm
where thang_ptm = 202409 and nguon = 'dt_ptm_vnp_bs'
and lpad(nguoi_gt,4)='GTGT' 
and manv_ptm is null 
;
commit ;

INSERT INTO ct_bsc_ptm
       (thang_luong,thang_ptm,ma_gd,ma_kh,MA_TB,DICH_VU, KIEULD_ID, TENKIEU_LD, LOAIHD_ID, ten_tb,DIACHI_LD,so_nha,pho_id,phuong_id,quan_id,
       so_gt,mst,ma_da,chu_nhom,vnp_moi,ngay_bbbg,NGAY_LUUHS_TTKD, ngay_scan, HESO_KHUYENKHICH, HESO_DICHVU, HESO_TRATRUOC, 
       HESO_KVDACTHU, manv_tt_dai,Ma_vtcv_dai,ma_to_dai,tocdo_id,goi_cuoc,goi_luongtinh,dichvuvt_id,loai_tb, 
       loaitb_id, trangthaitb_id, doituong_id, ma_nguoigt, nguoi_gt, ghi_chu, manv_ptm, tennv_ptm, 
       ma_pb, ten_pb, ma_to,ten_to,ma_vtcv,loainv_id,loai_ld, NHOM_TIEPTHI ,user_cn, ten_user_cn, 
       dthu_ps_truoc, dthu_ps, dthu_goi, dthu_goi_goc, SOTHANG_DC, chuquan_id, khachhang_id, nguon)

SELECT 202409,202409,a.ma_hd, a.ma_kh, a.somay,'VCC', 19562, a.kieu_ld, 1 LOAIHD_ID, a.ten_tb, a.dc_gbc, a.so_nha,a.pho_id,a.phuong_id,a.quan_id,
       a.so_gt, a.mst, a.ma_da, a.chu_nhom, a.somay, A.NGAY_LD, a.ngay_luuhs, a.ngay_scan, a.heso_kk_goivp_m, A.heso_DICHVU, A.HESO_TRATRUOC,
       A.HESO_DACTHU, a.manv_tt_dai,a.ma_vtcv_dai,a.ma_to_dai,a.tocdo_id, (a.loai_goi||'-'||a.package_name), goi_luongtinh, a.dichvuvt_id,loai_tb,
       a.loaitb_id, a.trangthai_id,a.doituong_id, a.nguoi_gt, a.nguoi_gt, a.GHICHU_NGUOI_GT, a.manv_ptm, a.tennv_ptm, 
       a.ma_pb, a.ten_pb,a.ma_to,a.ten_to, a.ma_vtcv, a.loainv_id,a.loai_ld, a.NHOM_TIEPTHI, a.user_ld, a.ten_user_cn, 
       a.dthu_ps_goc, a.dthu_ps, a.dthu_goi,a.dthu_goi_goc,a.SOTHANG_TRATRUOC, a.chuquan_id, db.khachhang_id, 'dt_ptm_vnp_bs'
FROM dt_ptm_vnp_202409_bs a 
left join css_hcm.db_thuebao db on a.somay = trim('84'||db.ma_tb) and db.loaitb_id = 20 
--and to_char(db.ngay_sd,'yyyymm') = '202409'

WHERE dthu_goi > 0
;
commit;
select * from ct_bsc_ptm where NGUON in('dt_ptm_vnp','dt_ptm_vnp_bs') and thang_ptm=202409 ;
UPDATE ct_bsc_ptm A SET a.ma_dt_kh='',a.pbh_ql_id='',a.kh_id='',a.pbh_ptm_id='' where NGUON in('dt_ptm_vnp','dt_ptm_vnp_bs') and thang_ptm=202409 ;
commit ;

UPDATE ct_bsc_ptm a SET (a.ma_dt_kh,a.pbh_ql_id,a.kh_id,a.pbh_ptm_id,a.chuquan_id)
=(SELECT ma_dt_kh,pbh_ql_id,kh_id,pbh_ptm_id,chuquan_id FROM dt_ptm_vnp_202409 WHERE SOMAY=A.MA_TB AND MA_KH=A.MA_KH and loaitb_id=20) 
where a.loaitb_id=20 and NGUON='dt_ptm_vnp' and thang_ptm=202409 ;
commit ;

UPDATE ct_bsc_ptm A SET (a.ma_dt_kh,a.pbh_ql_id,a.kh_id,a.pbh_ptm_id,a.chuquan_id)
=(SELECT ma_dt_kh,pbh_ql_id,kh_id,pbh_ptm_id,chuquan_id FROM dt_ptm_vnp_202409_bs WHERE SOMAY=A.MA_TB AND MA_KH=A.MA_KH and loaitb_id=149) 
where a.loaitb_id=149 and NGUON='dt_ptm_vnp_bs' and thang_ptm=202409;

commit ;
