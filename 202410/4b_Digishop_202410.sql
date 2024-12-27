-- L??ng gói: THANG_TLDG_DT=202404, THANG_TLKPI=202404, THANG_TLKPI_TO=202404, THANG_TLKPI_PHONG=202404
-- L??ng ??n giá ?nhm: n?u ?ã tính thì thôi, còn ch?a tính (NULL) thì m?i c?p nh?t: THANG_TLDG_DNHM=202404, THANG_TLKPI_DNHM=202404, THANG_TLKPI_DNHM_TO=202404, THANG_TLKPI_DNHM_PHONG=202404

INSERT INTO DIGISHOP (THANG, NGAY_TAO_DON, NGAY_CAP_NHAT, MA_DON_HANG, TRANSID, CDPID, MA_DHSX, DIA_BAN, KENH_BAN, MA_GIOITHIEU, TENNV_GIOITHIEU, DONVI_BH
     , PHONG_BH, KHOI_BH, TINH_BH, HINHTHUC_BAN, TEN_KH, SDT_KH, EMAIL_KH, TK_INTERNET_VNPT, TINH_QLKH, ID_PBH_QLKH, BTS_QLKH, DIACHI_CHITIET
     , HINHTHUC_TT, TRANGTHAI_TT, TENGOI, DANHMUC, CHUKY, DONVI_CHUKY, SDT_DATMUA, LOAI_SIM, LOAI_THUE_BAO, TG_CAMKET, CUOC_CAMKET, TIEN_DATCOC
     , GIAGOI, TIEN_HOAMANG, GIASIM, PHI_SHIP, DOANHTHU, HINHTHUC_NHANSIM, NGAY_KICHHOAT, GOICUOC_THUCTE, DTHU_THUCTE, MA_TB, SERIAL, GHI_CHU
     , TG_XL_CONLAI, TRANGTHAI_SHOP, TRANGTHAI_DOITAC, TENNV_XL_DH, MANV_XL_DH, TO_XL_DH, SDTLH_XL_DH, DONVI_XL_DH, TENNV_TAOSIM, MANV_TAOSIM
     , TOQL_TAOSIM, SDTLH_TAOSIM, DONVI_TAOSIM, TENNV_DK_TTTB, MANV_DK_TTTB, TOQL_DK_TTTB, SDTLH_DK_TTTB, DONVI_DK_TTTB, ID_TINH_QLKH
     )
SELECT THANG, NGAY_TAO_DON, NGAY_CAP_NHAT, MA_DON_HANG, TRANSID, CDPID, MA_DHSX, DIA_BAN, KENH_BAN, MA_GIOITHIEU, TENNV_GIOITHIEU, DONVI_BH
     , PHONG_BH, KHOI_BH, TINH_BH, HINHTHUC_BAN, TEN_KH, SDT_KH, EMAIL_KH, TK_INTERNET_VNPT, TINH_QLKH, ID_PBH_QLKH, BTS_QLKH, DIACHI_CHITIET
     , HINHTHUC_TT, TRANGTHAI_TT, TENGOI, DANHMUC, CHUKY, DONVI_CHUKY, SDT_DATMUA, LOAI_SIM, LOAI_THUE_BAO, TG_CAMKET, CUOC_CAMKET, TIEN_DATCOC
     , GIAGOI, TIEN_HOAMANG, GIASIM, PHI_SHIP, DOANHTHU, HINHTHUC_NHANSIM, NGAY_KICHHOAT, GOICUOC_THUCTE, DTHU_THUCTE, MA_TB, SERIAL, GHI_CHU
     , TG_XL_CONLAI, TRANGTHAI_SHOP, TRANGTHAI_DOITAC, TENNV_XL_DH, MANV_XL_DH, TO_XL_DH, SDTLH_XL_DH, DONVI_XL_DH, TENNV_TAOSIM, MANV_TAOSIM
     , TOQL_TAOSIM, SDTLH_TAOSIM, DONVI_TAOSIM, TENNV_DK_TTTB, MANV_DK_TTTB, TOQL_DK_TTTB, SDTLH_DK_TTTB, DONVI_DK_TTTB, ID_TINH_QLKH
FROM DIGISHOP_202410
;
COMMIT ;
ROLLBACK ;


select thang_luong, thang_ptm, thang_tldg_dt, thang_tlkpi, thang_tlkpi_to, thang_tlkpi_phong, heso_tbnganhan, nguon 
from ttkd_bsc.ct_bsc_ptm where thang_ptm in(202410) ;

select * from ttkd_bsc.ct_bsc_ptm where thang_ptm=202410 and dich_vu='MyTV MOBILE' ;
-- delete from ttkd_bsc.ct_bsc_ptm where thang_ptm=202410 and dich_vu='MyTV MOBILE' ;
commit ;
-- Digishop (MyTV Mobile)
--delete from ct_bsc_ptm where thang_ptm=202410 and dich_vu='MyTV MOBILE';
/* ------ KO IMP DONGIA, HOC TU IMP KHI TINH ------------- */
insert into ttkd_bsc.ct_bsc_ptm a
    (thang_luong, thang_ptm, dich_vu, tenkieu_ld, ma_gd, ma_tb, ten_tb, diachi_ld, sdt_lh, chuquan_id, goi_cuoc, ngay_bbbg, dthu_goi_goc, dthu_goi
    ,khhh_khm, diaban, ma_tiepthi, ma_tiepthi_new, datcoc_csd, sothang_dc, manv_ptm, tennv_ptm, ma_to, ten_to, ma_pb, ten_pb, ma_vtcv, loai_ld
    ,nhom_tiepthi, nguon, dichvuvt_id, loaitb_id, soseri, tien_tt, dthu_ps, trangthai_tt_id, trangthaitb_id, mien_hsgoc, heso_khachhang, heso_vtcv_nvptm
    ,heso_quydinh_nvptm, heso_dichvu_dnhm, thang_tldg_dt, thang_tlkpi, thang_tlkpi_to, thang_tlkpi_phong, heso_dichvu, heso_tratruoc )

select thang_luong, thang_ptm, dich_vu, tenkieu_ld, ma_gd, ma_tb, ten_tb, diachi_ld, sdt_lh, chuquan_id, goi_cuoc, ngay_bbbg
        , dthu_goi_goc, dthu_goi, khhh_khm, diaban, ma_tiepthi, ma_tiepthi_new, datcoc_csd, sothang_dc
        , manv_ptm, tennv_ptm, ma_to, ten_to, ma_pb, ten_pb, ma_vtcv, loai_ld, nhom_tiepthi
        , nguon, dichvuvt_id, loaitb_id, soseri, tien_tt, dthu_ps, trangthai_tt_id
        , trangthaitb_id, mien_hsgoc, heso_khachhang, heso_vtcv_nvptm, heso_quydinh_nvptm, heso_dichvu_dnhm
        , thang_tldg_dt, thang_tlkpi, thang_tlkpi_to, thang_tlkpi_phong, heso_dichvu
        ,(case when loaitb_id = 271 and sothang_dc >= 12 then 0.4----vb 353 heso tra truoc MyOTT
               when loaitb_id = 271 and sothang_dc >= 6 and sothang_dc < 12 then 0.3 ----vb 353 heso tra truoc MyOTT
               when loaitb_id = 271 and sothang_dc < 6 then 0.2	----vb 353 heso tra truoc MyOTT
               when loaitb_id = 271 and sothang_dc is null then 0	----vb 353 heso tra truoc MyOTT
		  else (select heso_dichvu from ttkd_bsc.dm_loaihinh_hsqd b where a.loaitb_id=b.loaitb_id)                       
          end
         ) heso_tratruoc 

from 
(
    select 202410 thang_luong, 202410 thang_ptm, danhmuc dich_vu
            ,(case when upper(bo_dau(danhmuc)) like 'MYTV MOBILE' then 'Lap dat moi MyTV OTT' 
                when upper(bo_dau(danhmuc)) not like 'MYTV MOBILE' then 'Lap dat moi'||'-'||danhmuc
                end)tenkieu_ld
            ,ma_don_hang ma_gd, ma_dhsx ma_tb, ten_kh ten_tb
            ,diachi_chitiet diachi_ld, sdt_kh sdt_lh, 145 chuquan_id, tengoi goi_cuoc, ngay_kichhoat ngay_bbbg,  dthu_thucte dthu_goi_goc, dthu_thucte dthu_goi
            , 'KHM' khhh_khm,'Khong xet trong/ngoai CT' diaban, ma_gioithieu ma_tiepthi, ma_gioithieu ma_tiepthi_new, dthu_thucte datcoc_csd, round(chuky/30,0) sothang_dc
            , b.ma_nv manv_ptm, b.ten_nv tennv_ptm, b.ma_to, b.ten_to, b.ma_pb, b.ten_pb, b.ma_vtcv, b.loai_ld, b.nhomld_id nhom_tiepthi
            ,'web Digishop' nguon, 4 dichvuvt_id, 271 loaitb_id, serial soseri, dthu_thucte tien_tt, dthu_thucte dthu_ps, 1 trangthai_tt_id
            ,1 trangthaitb_id, 1 mien_hsgoc,1 heso_khachhang, 1 heso_vtcv_nvptm, 1 heso_quydinh_nvptm, 0.1 heso_dichvu_dnhm, 1 heso_dichvu 
            , 202410 thang_tldg_dt, 202410 thang_tlkpi, 202410 thang_tlkpi_to, 202410 thang_tlkpi_phong  
    from ttkd_bsc.digishop a, ttkd_bsc.nhanvien b    
    where a.thang=202410 
    and a.ma_gioithieu=b.ma_nv 
    and b.thang=202410 and b.donvi='TTKD'
    and a.danhmuc='MyTV MOBILE'
    --and ( upper(bo_dau(danhmuc)) like 'MYTV MOBILE' or upper(bo_dau(danhmuc)) like 'INTERNET%' )
    and a.dia_ban like 'TP H_ Ch_ Minh' and a.ma_gioithieu is not null 
    and a.trangthai_shop like 'Th_nh c_ng' and a.trangthai_doitac like 'Th_nh c_ng'
    and not exists(select 1 from ttkd_bsc.ct_bsc_ptm where ma_tb=a.ma_dhsx)
) a
;

commit ;

select DISTINCT DANHMUC from ttkd_bsc.digishop_202410 ;
select * from ttkd_bsc.digishop a
    where a.thang=202410 
    and a.danhmuc='MyTV MOBILE'
;
--thang_ptm >= 202401 and ma_tb in('84834753888','84822999590','84828666439','84828500131','84843313338','84852345448','84947681782','84948227801','84949019916')

 UPDATE ttkd_bsc.ct_bsc_ptm a set THANG_TLDG_DT=202404, THANG_TLKPI=202404, THANG_TLKPI_TO=202404, THANG_TLKPI_PHONG=202404 
 where thang_luong=9 
 and exists(select 1 from ttkd_bsc.digishop where a.ma_tb=ma_dhsx and thang=202410 ) ;
 commit ;
 rollback ;
 