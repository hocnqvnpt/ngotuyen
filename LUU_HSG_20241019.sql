select a.thang_ptm, a.ma_tb, a.ma_gd, a.hdtb_id, a.dich_vu, a.nop_du
        , a.ma_pb, a.ten_pb, lydo_khongtinh_luong, lydo_khongtinh_dongia, thang_tldg_dt
from ttkd_bsc.ct_bsc_ptm a 
where a.thang_ptm >= 202408 and a.loaitb_id in(58,59,61,171) 
and a.nop_du is null
and a.mien_hsgoc is null
and exists(select 1 from
            (
            select a.* from ttkd_bct.bangiao_hoso_tinhbsc a 
            where loaitb_id in(58,59,61,171) 
            and dinhkem = 4 
            ) where ma_tb = a.ma_tb and ma_gd = a.ma_gd and hdtb_id <> a.hdtb_id
         )
;

select a.* from ttkd_bct.bangiao_hoso_tinhbsc a 
where loaitb_id in(58,59,61,171) 
 and dinhkem = 4 
 and exists(select 1 from ttkd_bsc.ct_bsc_ptm a 
            where a.thang_ptm >= 202408 and a.loaitb_id in(58,59,61,171) 
            and a.nop_du is null
            and a.mien_hsgoc is null
            and ma_tb = a.ma_tb and ma_gd = a.ma_gd and hdtb_id <> a.hdtb_id
        )
;
 drop table tam_luuhs_20241019 purge ;
 create table tam_luuhs_20241019 as 
        SELECT  * -- ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du , ngay_nop, ngay_bg, dinhkem
        from ttkd_bct.bangiao_hoso_tinhbsc
        where loaitb_id in(58,59,61,171) and dinhkem = 4
         and exists(select 1 from ttkd_bsc.ct_bsc_ptm a 
            where a.thang_ptm >= 202408 and a.loaitb_id in(58,59,61,171) 
            and a.nop_du is null
            and a.mien_hsgoc is null
            and ma_tb = a.ma_tb and ma_gd = a.ma_gd 
            --and hdtb_id <> a.hdtb_id
        )

;
create table nt_tam_luuhs_20241019 as 
select distinct ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, donvi_nhap, nhanvien_id, donvi_id_nhap, 
       decode(donvi_id_nhap,283466,'TTVT SG',283452,'TTVT CL',283467,'TTVT GD',283451,'TTVT TB',283453,'TTVT BC',283454,'TTVT CC',
                            283455,'TTVT HM',283468,'TTVT NSG',283469,'TTVT TD') ten_ttvt, nop_du, 
       max(ngay_nop_du)ngay_nop_du, min(ngay_bg)ngay_bg
from 
  ( 
   select ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, ngay_nop_du, ngay_bg, ngay_nop, a.nop_du,
         ( case when (select d.donvi_id from admin_hcm.nhanvien c,admin_hcm.donvi b, admin_hcm.donvi d 
                      where c.nhanvien_id=a.nhanvien_id and c.donvi_id=b.donvi_id 
                        and b.donvi_cha_id=d.donvi_id) in(283466,283452,283467,283451,283453,283454,283455,283468,283469) then 'TTVT' else 'TTKD' end
         ) donvi_nhap, nhanvien_id, 
         ( select d.donvi_id from admin_hcm.nhanvien c,admin_hcm.donvi b, admin_hcm.donvi d 
            where c.nhanvien_id=a.nhanvien_id and c.donvi_id=b.donvi_id and b.donvi_cha_id=d.donvi_id
         ) donvi_id_nhap
    from
      (    
        SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, max(ngay_nop_du) ngay_nop_du, max(ngay_bg)ngay_bg, max(ngay_nop) ngay_nop
        FROM ttkd_bct.tam_luuhs_20241019 a 
        group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg, nop_du
      ) a 
  ) a 
group by ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id,donvi_nhap, nhanvien_id, donvi_id_nhap, nop_du
;
CREATE INDEX nt_tam_luuhs_20241019_HDID ON nt_tam_luuhs_20241019 (hdtb_id ASC) ;
CREATE INDEX nt_tam_luuhs_20241019_matb ON nt_tam_luuhs_20241019 (ma_tb ASC) ;
CREATE INDEX nt_tam_luuhs_20241019_magd ON nt_tam_luuhs_20241019 (ma_gd ASC) ;

select nguon, thang_luong, thang_ptm, count(*)sl 
from ttkd_bsc.ct_bsc_ptm a 
where thang_ptm >= 202408
and (nop_du is null or nop_du=0)
and loaitb_id in(58,59,61,171) 
and nguon is not null
--and mien_hsgoc is not null
group by nguon, thang_luong, thang_ptm 
order by nguon, thang_luong, thang_ptm ;

update ttkd_bsc.ct_bsc_ptm a set (a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt)=
        ( select distinct '20241019', b.nop_du, (case when donvi_nhap='TTKD' then b.ngay_bg else NULL end), (case when donvi_nhap='TTVT' then b.ngay_bg else NULL end)
          from ttkd_bct.nt_tam_luuhs_20241019 b
            where b.ma_tb=a.ma_tb and b.ma_gd=a.ma_gd 
            and b.nop_du=1 and b.ngay_nop_du is not null
        ) 
-- select a.bs_luukho, a.nop_du, a.ngay_luuhs_ttkd,a.ngay_luuhs_ttvt from ttkd_bsc.ct_bsc_ptm a
where (nop_du is null or nop_du=0) and thang_ptm >= 202408 
 and mien_hsgoc is null -- CHI TUNG YC KHONG CAN XET MIEN_HOSO_GOC
 and a.loaitb_id in(58,59,61,171) 
 ; 
rollback ;

commit ;
select * from ct_bsc_ptm where bs_luukho = '20241019' ;

update ct_bsc_ptm set thang_luong = 107 
where bs_luukho = '20241019' ;
commit ;