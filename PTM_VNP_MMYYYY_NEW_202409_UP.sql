select to_number(tien_hm_sim)tien from tuyenngo.A_TMP_ID1896 ;
truncate table tuyenngo.A_TMP_ID1896 ;
commit ;

select	STT, MA_HD, KIEU_LD, SOMAY, SOSIM, MA_KH, MA_CQ, TEN_TB, DC_TT, DC_GBC, DC_CT, DOITUONG, SO_GT, MST, NGUOI_GT, NGAY_LHD
       ,to_date(ngay_lhd,'mm/dd/yyyy')ngay_ld
       ,to_number(replace(replace(replace(tien_hm_sim,'          ',''),',',''),'     ',''))TIEN_HM_SIM
       ,to_number(replace(replace(replace(replace(tien_datcoc,'          ',''),',',''),'     ',''),'    ',''))TIEN_DATCOC
       ,to_number(replace(replace(replace(replace(thucthu,'          ',''),',',''),'     ',''),'    ',''))THUCTHU
       ,to_number(replace(replace(replace(replace(tien_km,'          ',''),',',''),'     ',''),'    ',''))TIEN_KM
       ,USER_CCBS, MA_BC, LOAI_TB, GOI, GHICHU, SO_LH
from tuyenngo.A_TMP_ID1896 
;
/* ---------------------------------------------------------------- */

select a.* from a_cc a where exists(select 1 from DT_ptm_vnp_202410_2 where somay=a.somay and ma_kh=a.ma_kh) ;
select a.* from a_cc a where not exists(select 1 from DT_ptm_vnp_202410_2 where somay=a.somay and ma_kh=a.ma_kh) ;
select a.* from DT_ptm_vnp_202410  a where exists(select 1 from a_cc where somay=a.somay and ma_kh=a.ma_kh) ;

/* TAO FILE DAU THANG */
create table DT_ptm_vnp_202410 as select * from DT_ptm_vnp_202410 ;
truncate table DT_ptm_vnp_202410 ;
commit ;
select * from DT_ptm_vnp_202410 ;

create index DT_ptm_vnp_202410_somay on DT_ptm_vnp_202410 (somay) ;
create index DT_ptm_vnp_202410_makh on DT_ptm_vnp_202410 (ma_kh) ;
create index DT_ptm_vnp_202410_mst on DT_ptm_vnp_202410 (mst) ;
create index DT_ptm_vnp_202410_manv on DT_ptm_vnp_202410 (manv_ptm) ;
create index DT_ptm_vnp_202410_mabc on DT_ptm_vnp_202410 (ma_bc) ;


create table DT_ptm_vnp_202410_2 as select * from DT_ptm_vnp_202410_1 ;
truncate table DT_ptm_vnp_202410_2 ;
commit ;
select * from DT_ptm_vnp_202410_2 ;

create index DT_ptm_vnp_202410_2_somay on DT_ptm_vnp_202410_2 (somay) ;
create index DT_ptm_vnp_202410_2_makh on DT_ptm_vnp_202410_2 (ma_kh) ;
create index DT_ptm_vnp_202410_2_mst on DT_ptm_vnp_202410_2 (mst) ;
create index DT_ptm_vnp_202410_2_manv on DT_ptm_vnp_202410_2 (manv_ptm) ;
create index DT_ptm_vnp_202410_2_mabc on DT_ptm_vnp_202410_2 (ma_bc) ;

select * from DT_ptm_vnp_202410_2 ;

insert into DT_ptm_vnp_202410_2 a
      ( ma_hd, kieu_ld, somay, sosim, ma_kh, ma_cq, ten_tb, dc_tt, dc_gbc, dc_ct, doituong, so_gt, mst, sdt_lh
      , ngay_ld, tien_hm_sim, tien_datcoc, thucthu, tien_km, nguoi_gt, user_ld, ma_bc, goi_cuoc, ghichu, loai_tb )

SELECT a.ma_hd, a.kieu_ld, a.somay, a.sosim, a.ma_kh, a.ma_cq, a.ten_tb, a.dc_tt, a.dc_gbc, a.dc_ct, a.doituong, a.so_gt, a.mst, a.so_lh
       ,to_date(ngay_lhd,'mm/dd/yyyy')ngay_ld
       ,to_number(replace(replace(replace(tien_hm_sim,'          ',''),',',''),'     ',''))TIEN_HM_SIM
       ,to_number(replace(replace(replace(replace(replace(tien_datcoc,'          ',''),',',''),'     ',''),'    ',''),'  ',''))TIEN_DATCOC
       ,to_number(replace(replace(replace(replace(replace(thucthu,'          ',''),',',''),'     ',''),'    ',''),'  ',''))THUCTHU
       ,to_number(replace(replace(replace(replace(tien_km,'          ',''),',',''),'     ',''),'    ',''))TIEN_KM
       ,a.nguoi_gt, a.user_ccbs, a.ma_bc, a.goi, a.ghichu, a.loai_tb
FROM tuyenngo.A_TMP_ID1896 a
;
commit ;
-- rollback ;

update DT_ptm_vnp_202410_2 set nguoi_gt=UPPER(nguoi_gt) ;
update DT_ptm_vnp_202410_2 set nguoi_gt_old=nguoi_gt ;
update DT_ptm_vnp_202410_2 set nguoi_gt='000'||nguoi_gt where length(trim(nguoi_gt))=2 ;
update DT_ptm_vnp_202410_2 set nguoi_gt='00'||nguoi_gt where length(trim(nguoi_gt))=3 ;
update DT_ptm_vnp_202410_2 set nguoi_gt='0'||nguoi_gt where length(trim(nguoi_gt))=4 ;


update DT_ptm_vnp_202410_2 set ma_bc='000'||ma_bc where length(trim(ma_bc))=1 ;
update DT_ptm_vnp_202410_2 set ma_bc='00'||ma_bc where length(trim(ma_bc))=2 ;
update DT_ptm_vnp_202410_2 set ma_bc='0'||ma_bc where length(trim(ma_bc))=3 ;
update DT_ptm_vnp_202410_2 a set a.mst=cast(replace(a.mst,' ','') as varchar(30)),a.so_gt=cast(replace(a.so_gt,' ','') as varchar(30)) ;

/* UPDATE BUU CUC */
--update DT_ptm_vnp_202410_2 a set (a.khu_vuc,a.ten_bc)=(select donvi,tenbuucuc from vien.buucuc@vinadata where ma_bc=a.ma_bc);

update DT_ptm_vnp_202410_2 a set (a.ten_bc,a.khu_vuc)=(select tenbuucuc, donvi from tuyenngo.buucuc where ma_bc=a.ma_bc) where a.khu_vuc is null ;
commit ;

update DT_ptm_vnp_202410_2 set kieu_ld=bo_dau(kieu_ld) ;
commit;

update DT_ptm_vnp_202410_2 set loai_tb=bo_dau(loai_tb) ;
commit;

/* UPDATE NHAN VIEN */
update DT_ptm_vnp_202410_2 a set (a.manv_ptm,a.tennv_ptm,a.ma_vtcv,a.ten_vtcv,a.ma_to,a.ten_to,a.ma_pb,a.ten_pb,a.loai_ld, a.nhom_tiepthi)=
      (select manv_hrm,ten_nv,ma_vtcv,ten_vtcv, ma_to,ten_to,ma_pb,ten_pb,loai_ld,1 
       from ttkd_bsc.nhanvien where thang = 202410 and ma_nv=a.nguoi_gt) 
where a.ten_pb is null 
;
commit;
 /* --------- UP THONG TIN VTTP ------------ */
update DT_ptm_vnp_202410_2 set manv_ptm=nguoi_gt, pbh_nvptm=15,loai_ld='TTVT', nhom_tiepthi=2, loainv_id=0,kenhbh_id=0
where ( UPPER(LPAD(USER_LD,4))='TTVT' or UPPER(LPAD(nguoi_gt,3))='HCM' ) ; --and da_up is null ; 
commit ;
/*
update DT_ptm_vnp_202410_2 a set (manv_ptm, tennv_ptm, ma_to, ten_to, ma_pb, ten_pb, ma_vtcv, loai_ld, 15, nhom_tiepthi)=
                    ( select b.ma_nv, b.ten_nv, b.ma_to, b.ten_to,b.ma_pb,b.ten_pb,b.ma_vtcv, b.loai_ld, pbh_ptm_id, 2 from ttkd_bsc.nhanvien_vttp b 
                      where thang=202310 and b.ma_nv=a.manv_ptm) 
   -- select * from ptm_codinh_202309 a
   where exists(select 1 from ttkd_bsc.nhanvien_vttp where thang=202310 and ma_nv=a.manv_ptm);
commit ;
update DT_ptm_vnp_202309 a set nhom_tiepthi=1 where nhom_tiepthi is null ;
commit ;

select * from ttkd_bsc.nhanvien_vttp where thang=202310 ;
*/
 /* ------------------------------------------------ */
update DT_ptm_vnp_202410_2 set nguoi_gt='',nguoi_gt_old='',manv_ptm='',tennv_ptm='',ma_vtcv='', ten_vtcv='', ma_to='', ten_to='', ma_pb='', ten_pb='', loai_ld='', pbh_nvptm='', loainv_id=''
WHERE (NGUOI_GT IS not NULL) 
AND ( (UPPER(LPAD(USER_LD,3))='DL_') or (USER_LD in('banhangbdtp_hcm','phumylong_hcm','hattt_hcm','child_hcm','huongptl_hcm','chuongtv_hcm')) or khu_vuc='DAI LY') 
AND (UPPER(LPAD(USER_LD,4))<>'QLC_')
;--and da_up is null ;
commit;

*/
update DT_ptm_vnp_202410_2 set pbh_nvptm=16, ma_pb='VNP0700800', ten_pb=(select tenphong from tuyenngo.phongbanhang 
                                                                            where pbh_id=16),loai_ld='?LCN',loainv_id=8,kenhbh_id=6 
       where (UPPER(LPAD(USER_LD,3))='DL_') or (USER_LD in('banhangbdtp_hcm','phumylong_hcm','hattt_hcm','child_hcm','huongptl_hcm','chuongtv_hcm')) ;
       --khu_vuc='DAI LY' ; --and da_up is null ; 
commit;

update DT_ptm_vnp_202410_2 a set a.pbh_nvptm=(select b.pbh_id from dm_phongban b where a.ma_pb=b.ma_pb) where a.pbh_nvptm is null and a.ma_pb is not null ;
update DT_ptm_vnp_202410_2 a set a.loainv_id=(select cv.loainv_id from ttkd_bsc.dm_vtcv cv where a.ma_vtcv=cv.ma_vtcv) where a.loainv_id is null and a.ma_pb is not null ;
update DT_ptm_vnp_202410_2 a set a.kenhbh_id=( select dm.kenhbh_id from ttkd_bsc.nhanvien nv, ttkd_bsc.dm_to dm 
                                               where nv.thang=202410 and trim(nv.ma_to)=trim(dm.ma_to) and trim(nv.ma_nv)=trim(a.manv_ptm) )
where a.kenhbh_id is null and a.ma_pb is not null ;
commit;


update DT_ptm_vnp_202410_2 a set (a.pbh_nvptm,a.loainv_id,a.kenhbh_id)=
  (select (select pbh_id from dm_phongban c where c.ma_pb=b.ma_pb),0,0 from ttkd_bsc.nhanvien b where b.thang=202410 and b.user_ccbs=a.user_ld)
where a.pbh_nvptm is null ;
commit;

update DT_ptm_vnp_202410_2 a set nhom_tiepthi= ( case when upper(bo_Dau(loai_ld))='CHINH THUC' then 1
                                                      when upper(bo_Dau(loai_ld)) like 'CTV%' then 3  
                                                      when upper(bo_Dau(loai_ld))='DLCN' then 4
                                                 end
                                                ) ; 
commit ;
update DT_ptm_vnp_202410_2 a set nhom_tiepthi= 2 where UPPER(LPAD(nguoi_gt,3))='HCM' and nhom_tiepthi is null ;
commit ;
update DT_ptm_vnp_202410_2 a set nhom_tiepthi= 3 where nguoi_gt like 'CTV%' and nhom_tiepthi is null ;
commit ;
update DT_ptm_vnp_202410_2 a set nhom_tiepthi= 5 where nguoi_gt like 'GTGT%' and nhom_tiepthi is null ;
commit ;

update DT_ptm_vnp_202410_2 a set (manv_ptm, ma_to, ten_to, ma_pb,ten_pb)=(select manv_qldaily 
                                                                            ,ma_to,(select distinct ten_to from nhanvien where ma_to=b.ma_to AND THANG = 202409) 
                                                                            ,ma_pb,(select distinct ten_pb from nhanvien where ma_pb=b.ma_pb AND THANG = 202409) 
                                                                            from ttkd_bsc.dm_daily_khdn b where thang='202409' and ma_daily=a.nguoi_gt
                                                                          )
where lpad(a.nguoi_gt,4)='GTGT' and manv_ptm is null ;
commit ;

select * from DT_ptm_vnp_202410_2 where nhom_tiepthi is null ;

--update DT_ptm_vnp_202410 a set loai_ld='DLCN' where upper(bo_Dau(loai_ld))='DLPN' ;

--update ttkd_bsc.DT_ptm_vnp_201911 a set a.ma_pb='',a.ten_pb='',a.pbh_nvptm='',a.loainv_id='',a.kenhbh_id='' WHERE manv_ptm is null and pbh_nvptm<>16 ;
--rollback ;
-- somay in('84919759129','84819992628','84919055888','84941919955','84888920930','84886456297','84837100103','84949281014','84913161671')
select somay,count(*) from DT_ptm_vnp_202410_2 group by somay having count(*) > 1 ;

update DT_ptm_vnp_202410_2 a set nha_mang=ttkd_bsc.check_telconame(somay) ;
commit;

update DT_ptm_vnp_202410_2 a set ten_user_cn=(select distinct ten_daydu from ttkd_bsc.userld_202407_goc where user_ld=a.user_ld)
where ten_user_cn is null ;
commit ;

update DT_ptm_vnp_202410_2 a set a.ten_user_cn=(select distinct nv.ten_nv from admin_hcm.nguoidung nd, admin_hcm.nhanvien_Onebss nv where a.user_ld=nd.user_neo and nd.nhanvien_id=nv.nhanvien_id)
where a.TEN_USER_CN is null 
and exists(select 1 from admin_hcm.nguoidung nd where a.user_ld=nd.user_neo)
;
commit ;

/* INSERT VAO FILE THANG */
insert into DT_ptm_vnp_202410 a
      ( ma_hd, kieu_ld, somay, sosim, ma_kh, ma_cq, ten_tb, dc_tt, dc_gbc, dc_ct, doituong_id, doituong, so_gt, mst, sdt_lh, ngay_ld, tien_hm_sim, tien_datcoc, thucthu, tien_km, 
        nguoi_gt, nguoi_gt_old, manv_ptm, tennv_ptm, ma_vtcv, ten_vtcv, ma_to, ten_to, ma_pb, ten_pb, loai_ld, nhom_tiepthi, pbh_nvptm, loainv_id, kenhbh_id, user_ld, ten_user_cn, 
        ma_bc, a.ten_bc, khu_vuc, goi_cuoc, ghichu, loai_tb, nha_mang, tuan_solieu )
SELECT a.ma_hd, a.kieu_ld, a.somay, a.sosim, a.ma_kh, a.ma_cq, a.ten_tb, a.dc_tt, a.dc_gbc, a.dc_ct, 
       (select doituong_id from ccs_common.doituongs@ttkddbbk2 where upper(bo_dau(ten_dt))=upper(bo_dau(a.doituong)))doituong_id, a.doituong, a.so_gt, a.mst, a.sdt_lh, 
       a.ngay_ld, a.tien_hm_sim, a.tien_datcoc, a.thucthu, a.tien_km, a.nguoi_gt, a.nguoi_gt_old, a.manv_ptm,a.tennv_ptm, a.ma_vtcv, a.ten_vtcv, a.ma_to, a.ten_to, a.ma_pb,a.ten_pb,a.loai_ld, 
       a.nhom_tiepthi,a.pbh_nvptm,a.loainv_id,a.kenhbh_id,a.user_ld,a.ten_user_cn, a.ma_bc,a.ten_bc,a.khu_vuc, a.goi_cuoc,a.ghichu, a.loai_tb, a.nha_mang, substr('DT_ptm_vnp_202410_2',-1,1)
FROM DT_ptm_vnp_202410_2 a
;
commit;

select somay,count(*) from DT_ptm_vnp_202410 group by somay having count(*) > 1 ;
select somay,ma_kh,count(*) from DT_ptm_vnp_202410 group by somay,ma_kh having count(*) > 1 ;

somay in('84913623409','84913118895','84918849249','84915464248','84834637686','84886581744')
-------------------------------------------------- UPDATE LAI NHAN VIEN SAU KHI CHOT DS TU P.NS ----------------------------------------------
update DT_ptm_vnp_202410 a set (a.tennv_ptm, a.ma_vtcv,a.ten_vtcv,a.ma_to,a.ten_to,a.ma_pb,a.ten_pb,a.loai_ld)=
      (select b.ten_nv, b.ma_vtcv, b.ten_vtcv, b.ma_to, b.ten_to, b.ma_pb, b.ten_pb, b.loai_ld 
       from ttkd_bsc.nhanvien b where b.thang=202410 and a.nguoi_gt=b.ma_nv) 
-- where manv_hrm in('CTV031245','CTV021984') ;-- nguoi_gt='79TV0097'
where pbh_nvptm<>16 
;
commit ;

update DT_ptm_vnp_202410 a set (a.manv_ptm, a.tennv_ptm, a.ma_vtcv,a.ten_vtcv,a.ma_to,a.ten_to,a.ma_pb,a.ten_pb,a.loai_ld)=
      (select b.ma_nv, b.ten_nv, b.ma_vtcv, b.ten_vtcv, b.ma_to, b.ten_to, b.ma_pb, b.ten_pb, b.loai_ld 
       from ttkd_bsc.nhanvien b where b.thang=202410 and  b.ma_nv = a.nguoi_gt) 
-- where manv_hrm in('CTV031245','CTV021984') ;-- nguoi_gt='79TV0097'
where a.nguoi_gt = 'CTV087844'
;
commit ;

rollback ;
select * from ttkd_bsc.nhanvien b where b.thang=202410  ;

select * from DT_ptm_vnp_202410 ;
--update DT_ptm_vnp_202410 a set cuoc_dnhm=round( (tien_hm_sim-8500)/1.1,0) where tien_hm_sim > 0 ;
update DT_ptm_vnp_202410 a set cuoc_dnhm=round(35000/1.1,0) where kieu_ld = 'Hoa mang moi' ; --tien_hm_sim > 0 ;
commit ;

update DT_ptm_vnp_202410 a set MANV_HRM=MANV_PTM ;
commit ;

update DT_ptm_vnp_202410 set makh_old=ma_kh ;
update DT_ptm_vnp_202410 set dc_gbc_old=dc_gbc ;
commit ;

update DT_ptm_vnp_202410 a set chuquan_id=145 ;

update DT_ptm_vnp_202410 a set dichvuvt_id=2 ;

update DT_ptm_vnp_202410 a set loaitb_id=20 ;
commit ;

update DT_ptm_vnp_202410 a set doituong_id=( select doituong_id from tuyenngo.doituongs where upper(bo_dau(doituong))=upper(bo_dau(ten_dt)) ) 
where a.doituong_id is null ;
commit ;

update DT_ptm_vnp_202410 a set doituong=( select ten_dt from tuyenngo.doituongs where doituong_id=a.doituong_id ) 
where a.doituong is null ;
commit ;

-- insert into DT_ptm_vnp_202410_KTL(ma_hd, kieu_ld, somay,sosim,ma_kh,ma_cq,ten_tb,dc_tt,dc_gbc,dc_ct,doituong,so_gt,mst,sdt_lh,ngay_ld,nguoi_gt,nguoi_gt_old,manv_ptm,tennv_ptm,
ma_vtcv, ten_vtcv,ma_to,ten_to,ma_pb,ten_pb,loai_ld,pbh_nvptm,loainv_id,kenhbh_id,user_ld,ma_bc,ten_bc,khu_vuc,goi_cuoc,ghichu,loai_tb,nha_mang) 
--create table DT_ptm_vnp_202410_KTL as  
SELECT a.ma_hd, a.kieu_ld, a.somay, a.sosim, a.ma_kh, a.ma_cq, a.ten_tb,a.dc_tt, a.dc_gbc, a.dc_ct, a.doituong, a.so_gt, a.mst, a.sdt_lh,
       a.ngay_ld, a.nguoi_gt, a.nguoi_gt_old, a.manv_ptm, a.tennv_ptm, a.ma_vtcv, a.ten_vtcv, a.ma_to, a.ten_to, a.ma_pb, a.ten_pb,
       a.loai_ld, a.pbh_nvptm, a.loainv_id, a.kenhbh_id, a.user_ld, a.ma_bc, a.ten_bc, a.khu_vuc, a.goi_cuoc, a.ghichu,a.loai_tb, a.nha_mang
FROM DT_ptm_vnp_202410 a where a.kieu_ld='Khoi tao lai' 
and not exists(select 1 from DT_ptm_vnp_202410_KTL where ma_kh=a.ma_kh and somay=a.somay) ;
commit ;
CREATE INDEX DT_ptm_vnp_202410_KTL_SOMAY ON DT_ptm_vnp_202410_KTL (SOMAY) ;
CREATE INDEX DT_ptm_vnp_202410_KTL_MAKH ON DT_ptm_vnp_202410_KTL (MA_KH) ;
--update DT_ptm_vnp_202410_KTL a set a.khu_vuc=(select donvi from tuyenngo.buucuc@vinadata where ma_bc=a.ma_bc) where a.khu_vuc is null ;
--commit ;

delete from DT_ptm_vnp_202410 where kieu_ld='Khoi tao lai' ;
commit ;

delete from DT_ptm_vnp_202410_2 where kieu_ld='Khoi tao lai' ;
commit ;

select * from DT_ptm_vnp_202410_2 where kieu_ld='Khoi tao lai' ;
insert into DT_ptm_vnp_202410_bhmn 
--create table DT_ptm_vnp_202410_bhmn as 
SELECT a.ma_hd, a.kieu_ld, a.somay, a.sosim, a.ma_kh, a.ma_cq, a.ten_tb, a.dc_tt, a.dc_gbc, a.dc_ct, a.doituong_id, a.doituong, a.so_gt, a.mst, a.sdt_lh, 
       a.ngay_ld, a.tien_hm_sim, a.tien_datcoc, a.thucthu, a.tien_km, a.nguoi_gt, a.nguoi_gt_old, a.manv_ptm,a.tennv_ptm, a.ma_vtcv, a.ten_vtcv, a.ma_to, a.ten_to, a.ma_pb,a.ten_pb,a.loai_ld, 
       a.nhom_tiepthi,a.pbh_nvptm,a.loainv_id,a.kenhbh_id,a.user_ld,a.ten_user_cn, a.ma_bc,a.ten_bc,a.khu_vuc, a.goi_cuoc,a.ghichu, a.loai_tb, a.nha_mang
FROM DT_ptm_vnp_202410 a where ma_bc='0001' ;
--where somay in('84911001308','84911041885') ;

commit ;
CREATE INDEX DT_ptm_vnp_202410_bhmn_SOMAY ON DT_ptm_vnp_202410_bhmn (SOMAY) ;
CREATE INDEX DT_ptm_vnp_202410_bhmn_MAKH ON DT_ptm_vnp_202410_bhmn (MA_KH) ;


delete from DT_ptm_vnp_202410_2 where ma_bc='0001' ;
commit ;

delete from DT_ptm_vnp_202410 where ma_bc='0001' ;
commit ;
--ALTER TABLE DT_ptm_vnp_202410 ADD GIA_GOI NUMBER  ;
--COMMIT ;
select * from khanhtdt_ttkd.PTM_VNP_202410 a where gia_goi is not null ;
drop TABLE TAM_VNP purge ;
CREATE TABLE TAM_VNP AS select * from khanhtdt_ttkd.PTM_VNP_202410 a where somay=a.somay and ma_kh=a.ma_kh ;
create index TAM_VNP_somay on TAM_VNP(somay) ;
create index TAM_VNP_makh on TAM_VNP(ma_kh) ;

update DT_ptm_vnp_202410 a set (goi_4135,GIA_GOI)
            =(select upper(bo_dau(loai_goi)),dthu_GOI from TAM_VNP where somay=a.somay and ma_kh=a.ma_kh and dthu_goi is not null) ;
commit ;

update DT_ptm_vnp_202410 a set (goi_4135,GIA_GOI)=
        (select upper(bo_dau(loai_goi)),GIA_GOI 
         from 
         ( select a.* from tam_vnp a 
           where exists(select 1 from (select somay, count(*)sl from tam_vnp group by somay having count(*)=1) 
                            where somay=a.somay and ma_kh=a.ma_kh and gia_goi is not null)
         ) where somay=a.somay and ma_kh=a.ma_kh)
;
commit ;
select * from DT_ptm_vnp_202410 ;
--somay in('84816063500','84889174899','84812681779','84912115335')
select a.* from tam_vnp a 
where exists(select 1 from (select somay, count(*)sl from tam_vnp group by somay having count(*)>1) 
                            where somay=a.somay and ma_kh=a.ma_kh and gia_goi is not null);

