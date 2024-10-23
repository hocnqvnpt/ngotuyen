drop table dt_ptm_vnp_202409_roaming purge ;
create table dt_ptm_vnp_202409_roaming as 
select 202409 thang_luong, 202409 thang_ptm, a.ma_hd, a.ma_kh, a.somay, 'ROAMING' kieu_ld,a.ten_tb, a.dc_gbc, a.so_nha,a.pho_id,a.phuong_id,a.quan_id,
       a.so_gt, a.mst, A.NGAY_LD, 1 heso_DICHVU,  
       a.manv_tt_dai,a.ma_vtcv_dai,a.ma_to_dai, dichvuvt_id, loai_tb, a.loaitb_id, a.trangthai_id, a.doituong_id, a.nguoi_gt, a.GHICHU_NGUOI_GT,
       a.kh_id, a.ma_dt_kh, a.pbh_ql_id, a.manv_ptm, a.pbh_ptm_id, a.ma_pb, a.ten_pb,a.ma_to,a.ten_to, a.ma_vtcv, a.loainv_id, 
       a.loai_ld, NHOM_TIEPTHI, a.user_ld, a.ten_user_cn, 0 dthu_goi, a.chuquan_id
 from dt_ptm_vnp_202408 a
where exists(select 1 from ttkd_bsc.ct_ptm_ngoaictr_imp where ma_tb=a.somay and ma_gd=a.ma_hd and thang=202409 )
;
create index dt_ptm_vnp_202409_roaming_somay on dt_ptm_vnp_202409_roaming (somay) ;
create index dt_ptm_vnp_202409_roaming_makh on dt_ptm_vnp_202409_roaming (ma_kh) ;

select * from dt_ptm_vnp_202409_roaming ;
select THANG_LUONG, THANG_PTM, MA_TB, ma_gd, GHI_CHU, dthu_goi, tenkieu_ld, thang_tldg_dt
from CT_BSC_PTM a
where THANG_PTM = '202405' and DICHVUVT_ID=2
and exists(select 1 from ttkd_bsc.dt_ptm_vnp_202409_roaming where somay=a.ma_tb and ma_hd=a.ma_gd )
;

INSERT INTO ct_bsc_ptm
        (thang_luong,thang_ptm, ma_gd, ma_kh, ma_tb,DICH_VU,TENKIEU_LD,ten_tb, diachi_ld, so_nha, pho_id, phuong_id, quan_id, so_gt, mst, ngay_bbbg, heso_DICHVU, 
           dichvuvt_id, loai_tb, loaitb_id, doituong_id, nguoi_gt, GHI_CHU, trangthaitb_id, loaihd_id, vnp_moi, goi_cuoc,
           kh_id, ma_dt_kh, pbh_ql_id, manv_ptm, pbh_ptm_id, ma_pb, ten_pb,ma_to,ten_to, ma_vtcv, 
           loai_ld, NHOM_TIEPTHI, user_cn, ten_user_cn, dthu_goi, chuquan_id, nguon)

select thang_luong,thang_ptm, a.ma_hd, a.ma_kh, a.somay,'ROAMING', a.kieu_ld,a.ten_tb, a.dc_gbc, a.so_nha, a.pho_id,a.phuong_id,a.quan_id, a.so_gt, a.mst, A.NGAY_LD, heso_DICHVU, 
       dichvuvt_id, loai_tb, a.loaitb_id, a.doituong_id, a.nguoi_gt, ' dthu_gói roaming=7576', trangthai_id, 1 loaihd_id, somay vnp_moi, 'Goi Roaming' goi_cuoc,
       a.kh_id, a.ma_dt_kh, a.pbh_ql_id, a.manv_ptm, a.pbh_ptm_id, a.ma_pb, a.ten_pb,a.ma_to,a.ten_to, a.ma_vtcv, 
       a.loai_ld, nhom_tiepthi, a.user_ld, a.ten_user_cn, (dthu_goi + 7576)dthu_goi, a.chuquan_id, 'dt_ptm_vnp_roaming'
from dt_ptm_vnp_202409_roaming a
;
commit ;

select * from a_roaming ;
update ttkd_bsc.ct_bsc_ptm a set (NGAY_LUUHS_TTKD, nop_du) = (select NGAY_LUUHS_TTKD, nop_du
                                                                from ttkd_bsc.ct_bsc_ptm 
                                                                where nguon = 'dt_ptm_vnp' and thang_ptm = 202408
                                                                and exists(select 1 from dt_ptm_vnp_202409_roaming where somay = a.ma_tb and ma_kh = a.ma_kh)
                                                                and ma_tb = a.ma_tb and ma_kh = a.ma_kh
                                                             )
                                                            
-- select * from CT_BSC_PTM a
where nguon = 'dt_ptm_vnp_roaming' and thang_ptm = 202409 
and exists(select 1 from dt_ptm_vnp_202409_roaming where somay = a.ma_tb and ma_kh = a.ma_kh);

commit ;
select * from CT_BSC_PTM  where nguon = 'dt_ptm_vnp_roaming' and thang_ptm = 202409;

update CT_BSC_PTM a set tenkieu_ld = 'ROAMING' where nguon = 'dt_ptm_vnp_roaming' ;
commit ;

select * from CT_BSC_PTM a
where DICHVUVT_ID=2 --and ten_tb='Công Ty TNHH n??c gi?i khát Coca Cola Vi?t Nam'
and exists(select 1 from ttkd_bsc.dt_ptm_vnp_202409_roaming where somay=a.ma_tb and ma_hd=a.ma_gd )
;

rollback ;
select thang_luong, thang_ptm, tenkieu_ld, dthu_goi, ghi_chu 
from ct_bsc_ptm a 
where thang_ptm=202409 and nguon='dt_ptm_vnp_roaming'   ;

delete from ct_bsc_ptm where thang_ptm=202409 and nguon='dt_ptm_vnp_roaming' ;
commit ;
/*
update ct_bsc_ptm a set a.dthu_goi=9091, a.ghi_chu = '' 
where exists(select 1 from ttkd_bsc.dt_ptm_vnp_202409_roaming where SOMAY=MA_TB and ma_hd=ma_gd) 
and THANG_PTM = '202404' and DICHVUVT_ID=2 ;
commit ;

update ct_bsc_ptm a set a.dthu_goi=a.dthu_goi + 7576, a.ghi_chu = a.ghi_chu || ' + dthu_gói roaming=7576' 
where exists(select 1 from ttkd_bsc.dt_ptm_vnp_202409_roaming where SOMAY=MA_TB and ma_hd=ma_gd) 
and THANG_PTM = '202404' and DICHVUVT_ID=2 ;
commit ;
*/
