drop table tuyenngo.ct_ptm_ngoaictr_imp_temp purge ;
create table tuyenngo.ct_ptm_ngoaictr_imp_temp as select * from tuyenngo.ct_ptm_ngoaictr_imp_temp ;
select * from tuyenngo.ct_ptm_ngoaictr_imp_temp ;
truncate table tuyenngo.ct_ptm_ngoaictr_imp_temp ;


update tuyenngo.ct_ptm_ngoaictr_imp_temp a set manv_ptm=replace(manv_ptm,' ','') ;
update tuyenngo.ct_ptm_ngoaictr_imp_temp a set manv_ptm=lpad(trim(manv_ptm),9) 

where thang=202407 ;
rollback;
commit ;
update tuyenngo.ct_ptm_ngoaictr_imp_temp a set COMMAND='insert' where dichvuvt_id in(4,7,8,9) and thang=202407 ;
commit ;

update tuyenngo.ct_ptm_ngoaictr_imp_temp a set dichvu_vt='Vinaphone tra sau' where dichvu_vt = 'VNPts' and thang=202407 ;
update tuyenngo.ct_ptm_ngoaictr_imp_temp a set COMMAND='roaming' where dichvu_vt = 'VNPts' and thang=202407 ;
commit ;

update tuyenngo.ct_ptm_ngoaictr_imp_temp a set ma_gd=replace(ma_gd, chr(13),'') where thang=202407 ;

rollback ;
update tuyenngo.ct_ptm_ngoaictr_imp_temp a set a.dichvu_vt = 'Vinaphone tra sau' where a.dichvu_vt = 'VNP tra sau' and thang=202407 ;
commit ;

select max(thang_luong) from ct_bsc_ptm where thang_luong<100 group by thang_luong;

update tuyenngo.ct_ptm_ngoaictr_imp_temp set command = 'roaming', loaitb_id = 20, dichvuvt_id = 2 
--				select * from tuyenngo.ct_ptm_ngoaictr_imp_temp 
				where thang = 202407 and DICHVU_VT= 'Vinaphone tra sau' 
				;			
commit ;

				MERGE INTO tuyenngo.ct_ptm_ngoaictr_imp_temp a
				USING css_hcm.db_thuebao b
				ON 	('84' || b.ma_tb = a.ma_tb and b.loaitb_id = a.loaitb_id)
				WHEN MATCHED THEN
					UPDATE
					SET a.thuebao_id = b.thuebao_id
					WHERE a.thang = 202407 and a.loaitb_id = 20
					;
commit ;
update tuyenngo.ct_ptm_ngoaictr_imp_temp a set (dichvuvt_id,loaitb_id,thuebao_id)
                                        =(select dichvuvt_id, loaitb_id,thuebao_id
                                          from css_hcm.db_thuebao where ma_tb=a.ma_tb)
where loaitb_id is null and thang = 202407 ;
commit ;
rollback ;
update tuyenngo.ct_ptm_ngoaictr_imp_temp a set doituong_kh=(select (case when ma_dt_kh='cn' then 'KHCN' 
                                                                   when ma_dt_kh='dn' then 'KHDN' end) 
                                                       from ttkd_bct.db_thuebao_ttkd where thuebao_id=a.thuebao_id) 
where thang=202407 ;
commit ;

rollback ;                                               
update tuyenngo.ct_ptm_ngoaictr_imp_temp set TEN_PB = replace(ten_pb, 'P.', '') where instr(ten_pb, 'P.') >0 and thang = 202407;
update tuyenngo.ct_ptm_ngoaictr_imp_temp set dichvu_vt = bo_dau(dichvu_vt) where thang = 202407;
update tuyenngo.ct_ptm_ngoaictr_imp_temp set TENKIEU_LD = bo_dau(TENKIEU_LD) where thang = 202407;
update tuyenngo.ct_ptm_ngoaictr_imp_temp set dien_giai = dien_giai || '; '|| ghichu ;
commit ;

insert into ttkd_bsc.ct_ptm_ngoaictr_imp
(
THANG, TRONG_CT, NGAY_INS, TEN_PB, MANV_PTM, TENNV_PTM, DICHVU_VT, TENKIEU_LD, MA_GD, MA_TB, MA_KH, SO_HD, TEN_KH, NGAY_YC, GOI_CUOC_CU
, GOI_CUOC_MOI, DTHU_GOI_CU, DTHU_GOI_MOI, DTHU_GOI, CHIPHI_DOITAC, HESO_DICHVU, HESO_TRATRUOC, HESO_KHACHHANG, HESO_HOSO, HESO_HOTRO_NVHOTRO
, MANV_HOTRO, DIEN_GIAI, COMMAND, LOAITB_ID, DICHVUVT_ID, DOITUONG_KH, THUEBAO_ID, GHICHU, MA_DUAN_BANHANG, HESO_QUYDINH_NVPTM, MST
)
select THANG, TRONG_CT, NGAY_INS, TEN_PB, MANV_PTM, TENNV_PTM, DICHVU_VT, TENKIEU_LD, MA_GD, MA_TB, MA_KH, SO_HD, TEN_KH, NGAY_YC, GOI_CUOC_CU
, GOI_CUOC_MOI, DTHU_GOI_CU, DTHU_GOI_MOI, DTHU_GOI, CHIPHI_DOITAC, HESO_DICHVU, HESO_TRATRUOC, HESO_KHACHHANG, HESO_HOSO, HESO_HOTRO_NVHOTRO
, MANV_HOTRO, DIEN_GIAI, COMMAND, LOAITB_ID, DICHVUVT_ID, DOITUONG_KH, THUEBAO_ID, GHICHU, MA_DUAN_BANHANG, HESO_QUYDINH_NVPTM, MST
from tuyenngo.ct_ptm_ngoaictr_imp_temp 
;
commit ;

select * from ttkd_bsc.dm_loaihinh_hsqd ;
-- 2. Hop dong chua co trong ttkd_bsc.ct_bsc_ptm
select (select loaitb_id from ttkd_bsc.dm_loaihinh_hsqd where bo_dau(loaihinh_tb)=a.dichvu_vt) loaitb_id, a.*
from ttkd_bsc.a_ptm_ngoaictr_itt_imp a
where not exists(select 1 from ttkd_bsc.ct_bsc_ptm where nvl(ma_gd,' ')=nvl(a.ma_gd,' ') and nvl(ma_tb,' ')=nvl(a.ma_tb,' '))
and dichvu_vt not in ('VNP tr? sau','VCC')
and thuchien is null
and thang=202404
;
--- sau insert va update xong chay file 
insert into ttkd_bsc.ct_bsc_ptm (thang_luong, thang_ptm, ten_pb, ma_pb, ten_to, ma_to, manv_ptm, tennv_ptm, ma_vtcv, loai_ld, NHOM_TIEPTHI, TENKIEU_LD, ma_gd, ma_tb, ma_kh
								, SOHOPDONG, ten_tb, NGAY_BBBG, GOI_CUOC, DTHU_GOI, HESO_DICHVU, HESO_HOTRO_NVHOTRO, MANV_HOTRO, tyle_hotro, GHI_CHU
								, LOAITB_ID, DICHVUVT_ID, DOITUONG_KH, THUEBAO_ID, khachhang_id, nguon, PHANLOAI_KH, MST, DTHU_PS, trangthaitb_id
                                , chuquan_id, dongia, dich_vu, nop_du, mien_hsgoc, trangthai_tt_id, hdkh_id, hdtb_id, loaihd_id, kieuld_id, ma_duan_banhang
                                , thang_tldg_dt, thang_tlkpi, thang_tlkpi_to, thang_tlkpi_phong)

select 70, a.THANG, b.ten_pb, b.ma_pb, b.ten_to, b.ma_to, a.MANV_PTM, a.TENNV_PTM, b.ma_vtcv, b.loai_ld, b.NHOMLD_ID NHOM_TIEPTHI
         , a.TENKIEU_LD, a.MA_GD, nvl(c.MA_TB, 'khongco'||rownum) ma_tb, kh.MA_KH, a.SO_HD
		 , kh.TEN_KH, a.NGAY_YC, a.GOI_CUOC_MOI, a.DTHU_GOI, a.HESO_DICHVU
		 , HESO_HOTRO_NVHOTRO, MANV_HOTRO, HESO_HOTRO_NVHOTRO tyle_hotro, DIEN_GIAI, a.LOAITB_ID, a.DICHVUVT_ID, a.DOITUONG_KH
         , a.THUEBAO_ID, c.khachhang_id, 'ct_ptm_ngoaictr_imp_'||command as nguon, plk.MA_PLKH, nvl(kh.mst, 1) mst, db.dthu_ps
         , nvl(c.trangthaitb_id, 1), 145 chuquan_id, 858 dongia, lh.loaihinh_tb, 1 nop_du, 1 mien_hsgoc, 1 trangthai_tt_id
         , hdkh.hdkh_id, hdtb.hdtb_id, hdkh.loaihd_id, hdtb.kieuld_id, ma_duan_banhang
            ,(case when a.ma_gd like 'HCM-TT%' and a.dichvuvt_id in(4,7,8,9) then 202407 end) thang_tldg_dt
            ,(case when a.ma_gd like 'HCM-TT%' and a.dichvuvt_id in(4,7,8,9) then 999999 end) thang_tlkpi
            ,(case when a.ma_gd like 'HCM-TT%' and a.dichvuvt_id in(4,7,8,9) then 999999 end) thang_tlkpi_to
            ,(case when a.ma_gd like 'HCM-TT%' and a.dichvuvt_id in(4,7,8,9) then 999999 end) thang_tlkpi_phong
from ttkd_bsc.ct_ptm_ngoaictr_imp a
left join ttkd_bsc.nhanvien b on b.thang = a.thang and a.MANV_PTM = b.ma_nv
left join css_hcm.db_thuebao c on a.thuebao_id = c.thuebao_id
left join css_hcm.db_khachhang kh on c.khachhang_id = kh.khachhang_id
left join css_hcm.hd_khachhang hdkh on a.ma_gd = hdkh.ma_gd
left join css_hcm.hd_thuebao hdtb on hdkh.hdkh_id = hdtb.hdkh_id

left join (select x.thuebao_id, plkh_id, sum(dthu) dthu_ps
    		from ttkd_bct.db_thuebao_ttkd x 
        	join ttkd_bct.cuoc_thuebao_ttkd y on x.tb_id = y.tb_id 
			group by x.thuebao_id, plkh_id
          ) db on a.thuebao_id = db.thuebao_id
left join css_hcm.phanloai_kh plk on db.plkh_id = plk.PHANLOAIKH_ID
left join css_hcm.loaihinh_tb lh on a.LOAITB_ID = lh.LOAITB_ID
where a.thang = 202407
  and a.dichvuvt_id in (4, 7,8, 9)-- not in ('VNP tra sau', 'Internet truc tiep')
  and command = 'insert' and a.ma_gd like 'HCM-TT%'
  ;
commit ;  
--  rollback ;

select ma_gd, ma_tb, thang_tldg_dt from ttkd_bsc.ct_bsc_ptm where thang_ptm <= 202407 and thuebao_id in (10775336)
				and thuebao_id in (select thuebao_id from ttkd_bsc.ct_bsc_ptm where thang_ptm <= 202407 and replace(ma_gd, ' ', '') = 'HCM-DV/11080949');

select * from tuyenngo.ct_ptm_ngoaictr_imp_temp a where thang=202407 ;   
select * from ttkd_bsc.ct_bsc_ptm 
where thang_ptm=202407 
and nguon in('Trong co che tinh luong','Ngoai co che tinh luong') ;

delete from ttkd_bsc.ct_bsc_ptm where thang_ptm=202407 and nguon in('Trong co che tinh luong','Ngoai co che tinh luong') ;
commit ;
