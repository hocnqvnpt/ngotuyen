create table a_tam_bhcl as
select thang_luong, thang_ptm, ma_gd, ma_tb, dich_vu, hdtb_id, dichvuvt_id, loaitb_id, nop_du, ngay_luuhs_ttkd, lydo_khongtinh_dongia, dthu_ps
from ttkd_bsc.ct_bsc_ptm a
where ma_gd in('HCM-LD/14686656','HCM-LD/14686655','HCM-LD/14687789','HCM-LD/14687841','HCM-LD/14687671','HCM-LD/14687921'
              ,'HCM-LD/14687641','HCM-LD/14684752','HCM-LD/14685516','HCM-LD/14684712','HCM-LD/14686654','HCM-LD/14686657'
              ,'HCM-LD/01996923','HCM-LD/14676112','HCM-LD/14673579','HCM-LD/14670179','HCM-LD/14674971','HCM-LD/14671479'
              ,'HCM-LD/14671190','HCM-LD/14673607','HCM-LD/14668981','HCM-LD/14673578','HCM-LD/14673130')
;
        SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du, ngay_insert
            , ngay_nop, ngay_bg, dinhkem, econtract_app -- econtract_app = 1 là qua App
        from ttkd_bct.bangiao_hoso_tinhbsc a 
where exists(select 1 from a_tam_bhcl where ma_tb = a.ma_tb)
;
select * from a_tam_bhcl ;

drop table a_tam_bhcl purge ;
create table a_tam_bhcl as
select thang_luong, thang_ptm, ma_gd, ma_tb, dich_vu, hdtb_id, dichvuvt_id, loaitb_id, ngay_bbbg, nop_du, ngay_luuhs_ttkd, lydo_khongtinh_dongia, dthu_ps
from ttkd_bsc.ct_bsc_ptm a
where ma_gd in('HCM-LD/14686656','HCM-LD/14686655','HCM-LD/14687789','HCM-LD/14687841','HCM-LD/14687671','HCM-LD/14687921'
              ,'HCM-LD/14687641','HCM-LD/14684752','HCM-LD/14685516','HCM-LD/14684712','HCM-LD/14686654','HCM-LD/14686657'
              ,'HCM-LD/01996923','HCM-LD/14676112','HCM-LD/14673579','HCM-LD/14670179','HCM-LD/14674971','HCM-LD/14671479'
              ,'HCM-LD/14671190','HCM-LD/14673607','HCM-LD/14668981','HCM-LD/14673578','HCM-LD/14673130')
;
        SELECT * ----ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du, ngay_insert
        --    , ngay_nop, ngay_bg, dinhkem, econtract_app -- econtract_app = 1 là qua App
        from ttkd_bct.bangiao_hoso_tinhbsc a 
where ma_tb in('84848336375','84916888974','84845697283','84848814250','84845795722','84918477009','84858666865','84848905293','84846215773','84846541344')
--        where ma_tb in('84848328161','84846813432','84845974710','84847378835','84846082260','84849411162','84845856762','84849378860','84846591683','84846662902','84848946291')
--        from ttkdhcm_ktnv.v_bangiao_hoso_new a
where exists(select 1 from a_tam_bhcl where ma_tb = a.ma_tb)
;

select * from a_tam_bhcl 
where ma_tb in('84848328161','84846813432','84845974710','84847378835','84846082260','84849411162','84845856762'
                ,'84849378860','84846591683','84846662902','84848946291')
                ;

SELECT ma_tb, loaitb_id, dichvuvt_id, ma_gd, hdtb_id, nhanvien_bg nhanvien_id, nop_du, ngay_nop_du, ngay_insert
     , ngay_nop, ngay_bg, dinhkem, econtract_app -- econtract_app = 1 là qua App
from ttkd_bct.bangiao_hoso_tinhbsc a 
where ma_tb in('84848328161','84846813432','84845974710','84847378835','84846082260','84849411162','84845856762'
                ,'84849378860','84846591683','84846662902','84848946291')
                ;

where ma_tb = 'hcm_hddt_00006253'
-- where ma_tb in('hcm_smartca_00388096','hcm_smartca_00389154','hcm_smartca_00389298','hcm_smartca_00396154')
--where ma_tb in('vithiem29','ngocluongmai')
where ma_tb in('84845350517','84848906125','84849353910','84846102785','84848569033','84846863512','84848187762','84845717522'
            ,'84846179390','84846511652','84849380340','84848285581','84849425870','84845079872','84848799651','84849457970'
            ,'84845284130','84846973760','84845289121')
;
where exists(select 1 from a_dn3 where ma_tb = a.ma_tb) 
;


--('84845079872','84846973760','84848569033','84848799651')
select thang_luong, thang_ptm, ma_gd, ma_tb, dich_vu, hdtb_id, dichvuvt_id, loaitb_id, nop_du, ngay_luuhs_ttkd, lydo_khongtinh_dongia, dthu_ps
-- a.ma_tb, a.ma_gd, ngay_luuhs_ttkd, ngay_luuhs_ttvt, nop_du
from ttkd_bsc.ct_bsc_ptm a --where ma_tb = 'hcm_hddt_00006253' ;
--where ma_tb in('hcm_smartca_00388096','hcm_smartca_00389154','hcm_smartca_00389298','hcm_smartca_00396154')
--where ma_tb in('vithiem29','ngocluongmai')
where ma_tb in('84845350517','84848906125','84849353910','84846102785','84848569033','84846863512','84848187762','84845717522'
              ,'84846179390','84846511652','84849380340','84848285581','84849425870','84845079872','84848799651','84849457970'
              ,'84845284130','84846973760','84845289121','vithiem29','ngocluongmai')
--where ma_tb in('84911464786','84848158150','84845165661','84845907880','hcm_ivan_00039601')
--ma_tb in('84849967127','84845628367','84849366715','84849387501','84849358765','84849473664','84839313468','84846276680')

;
where thang_ptm >= 202409 -- and lydo_khongtinh_dongia like '%Chua nop du ho so%'
and exists(select 1 from a_dn3 where ma_tb = a.ma_tb) 
;

select 
thang_ptm, ma_tb, soseri, tien_tt, ngay_tt, tien_dnhm, thang_tldg_dnhm, thang_tldg_dt, thang_tlkpi, xacnhan_khkt, thang_xacnhan_khkt, ghi_chu 
from ttkd_bsc.ct_bsc_ptm 
-- where ma_tb in('84846967970','84847229050','84847626730','84847962667','84847081572','84848912632','84848927213') ;

where ma_tb = 'fvn_med'
where ma_tb in('ntngoc98_1','smart291','thucphamquocte22a');
select * from tuyenngo.thaydoitocdo_202410 
where ma_tb in('ntngoc98_1','smart291','thucphamquocte22a','vanka10509452');

select * from css.v_hd_thuebao@dataguard where ma_tb = 'vanka10509452' ;
select * from css.v_hdtb_adsl@dataguard where hdtb_id = 27400453 ;
select * from css_hcm.tocdo_adsl where tocdo_id = 44782 ;
SELECT * FROM css.v_muccuoc_tb@dataguard ;
select * from nhuy.v_thongtinkm_all where ma_tb = 'vanka10509452' ;
select * from css.v_db_thuebao@dataguard
where ma_tb in('sgtrienvongrivana1','sgtv-052021','rivana3','rivana2');

select * from ttkd_bct.db_thuebao_ttkd
where ma_tb in('sgtrienvongrivana1','sgtv-052021','rivana3','rivana2');

select * FROM ttkd_bct.tam_luuhs_20241118 a 
--where ma_tb in('84849967127','84845628367','84849366715','84849387501','84849358765','84849473664','84839313468') ;
--where ma_tb in('vithiem29','ngocluongmai')
where ma_tb in('84845350517','84848906125','8484935391','84846102785','84848569033','84846863512','84848187762','84845717522'
            ,'84846179390','84846511652','84849380340','84848285581','84849425870','84845079872','84848799651','84849457970'
            ,'84845284130','84846973760','84845289121')

