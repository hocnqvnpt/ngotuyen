select kieu_ld, somay, ma_kh, ten_tb, ngay_ld, nguoi_gt, manv_ptm, tennv_ptm, ma_to, ten_to, ma_pb, ten_pb
    , ghichu_nguoi_gt, dthu_ps, tocdo_id, loai_goi goicuoc, package_name, dthu_goi, cuoc_dnhm, heso_dichvu, heso_tratruoc
    , sothang_tratruoc, ngay_bd, ngay_kt, loaihd_id, kieuld_id, dichvuvt_id, loaitb_id
from ttkd_bsc.dt_ptm_vnp_202409
union all
select  kieu_ld, somay, ma_kh, ten_tb, ngay_ld, nguoi_gt, manv_ptm, tennv_ptm, ma_to, ten_to, ma_pb, ten_pb
    , ghichu_nguoi_gt, dthu_ps, tocdo_id, loai_goi goicuoc, package_name, dthu_goi, cuoc_dnhm, heso_dichvu, heso_tratruoc
    , sothang_tratruoc, ngay_bd, ngay_kt, loaihd_id, kieuld_id, dichvuvt_id, loaitb_id
from ttkd_bsc.dt_ptm_vnp_202409_bs a
where exists(select 1 from ttkd_bsc.dt_ptm_vnp_202409 where somay = a.somay)
;

--TEST SUA CODE 