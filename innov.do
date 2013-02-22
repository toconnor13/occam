use "Z:\home\sheefrex\code\occam\cs_data.dta", clear

cd "Z:\home\sheefrex\code\occam"
est clear

eststo: reg pfs25_means mktrf_4
eststo: reg pfs25_means mktrf_5 hml_5 
eststo: reg pfs25_means mktrf_6 smb_6 
eststo: reg pfs25_means mktrf_7 hml_7 smb_7 

esttab using cs01.tex, ar2 compress booktabs title(Cross Sectional Estimates - Standard CAPM and Fama-French Models \label{tab1})  
est clear


eststo: reg pfs25_means mktrf_8 gt_8 
eststo: reg pfs25_means mktrf_9 hml_9 gt_9 
eststo: reg pfs25_means mktrf_10 smb_10 gt_10 
eststo: reg pfs25_means mktrf_11 hml_11 smb_11 gt_11 

esttab using cs02.tex, ar2 compress booktabs title(Cross Sectional Estimates -  Trademarks Issued Growth\label{tab1})  
est clear

eststo: reg pfs25_means mktrf_12 gp_12 
eststo: reg pfs25_means mktrf_13 hml_13 gp_13 
eststo: reg pfs25_means mktrf_14 smb_14 gp_14 
eststo: reg pfs25_means mktrf_15 hml_15 smb_15 gp_15 

esttab using cs03.tex, ar2 compress booktabs title(Cross Sectional Estimates - Patent Application Growth \label{tab1})  
est clear

eststo: reg pfs25_means mktrf_16 g_pg_16 
eststo: reg pfs25_means mktrf_17 hml_17 g_pg_17 
eststo: reg pfs25_means mktrf_18 smb_18 g_pg_18 
eststo: reg pfs25_means mktrf_19 hml_19 smb_19 g_pg_19

esttab using cs1.tex, ar2 compress booktabs title(Cross Sectional Estimates - Patents Granted Growth \label{tab1})  
est clear



 
eststo: reg pfs25_means mktrf_20 r_ad_g_20 
eststo: reg pfs25_means mktrf_21 hml_21 r_ad_g_21 
eststo: reg pfs25_means mktrf_22 smb_22 r_ad_g_22 
eststo: reg pfs25_means mktrf_23 hml_23 smb_23 r_ad_g_23 

esttab using cs2.tex, ar2 compress booktabs title(Cross Sectional Estimates - Real Advertising Growth \label{tab1})  
est clear

eststo: reg pfs25_means mktrf_24 tradestock_24 
eststo: reg pfs25_means mktrf_25 hml_25 tradestock_25 
eststo: reg pfs25_means mktrf_26 smb_26 tradestock_26 
eststo: reg pfs25_means mktrf_27 hml_27 smb_27 tradestock_27 

esttab using cs3.tex, ar2 compress booktabs title(Cross Sectional Estimates - Trademark Stock Growth \label{tab1})  
est clear

eststo: reg pfs25_means mktrf_28 g_rd_exp_28 
eststo: reg pfs25_means mktrf_29 hml_29 g_rd_exp_29 
eststo: reg pfs25_means mktrf_30 smb_30 g_rd_exp_30 
eststo: reg pfs25_means mktrf_31 hml_31 smb_31 g_rd_exp_31 

esttab using cs4.tex, ar2 compress booktabs title(Cross Sectional Estimates - Growth in R&D Expenditure \label{tab1})  
est clear

eststo: reg pfs25_means mktrf_32 g_vc_firm_32 
eststo: reg pfs25_means mktrf_33 hml_33 g_vc_firm_33 
eststo: reg pfs25_means mktrf_34 smb_34 g_vc_firm_34 
eststo: reg pfs25_means mktrf_35 hml_35 smb_35 g_vc_firm_35 

esttab using cs5.tex, ar2 compress booktabs title(Cross Sectional Estimates - Growth in Number of VC Firms\label{tab1})  
est clear


eststo: reg pfs25_means mktrf_36 g_vc_amount_36 
eststo: reg pfs25_means mktrf_37 hml_37 g_vc_amount_37 
eststo: reg pfs25_means mktrf_38 smb_38 g_vc_amount_38 
eststo: reg pfs25_means mktrf_39 hml_39 smb_39 g_vc_amount_39 

esttab using cs6.tex, ar2 compress booktabs title(Cross Sectional Estimates - Growth in the Amount of Venture Capital Disbursed \label{tab1})  
est clear

eststo: reg pfs25_means mktrf_40 vc_returns_40 
eststo: reg pfs25_means mktrf_41 hml_41 vc_returns_41 
eststo: reg pfs25_means mktrf_42 smb_42 vc_returns_42 
eststo: reg pfs25_means mktrf_43 hml_43 smb_43 vc_returns_43 

esttab using cs7.tex, ar2 compress booktabs title(Cross Sectional Estimates - Verture Capital Returns \label{tab1})  
est clear

eststo: reg pfs25_means mktrf_44 g_ipo_44 
eststo: reg pfs25_means mktrf_45 hml_45 g_ipo_45 
eststo: reg pfs25_means mktrf_46 smb_46 g_ipo_46 
eststo: reg pfs25_means mktrf_47 hml_47 smb_47 g_ipo_47

esttab using cs8.tex, ar2 compress booktabs title(Cross Sectional Estimates - Growth in Number of IPOs \label{tab1})  
est clear

 
eststo: reg pfs25_means mktrf_48 g_fund_no_48 
eststo: reg pfs25_means mktrf_49 hml_49 g_fund_no_49 
eststo: reg pfs25_means mktrf_50 smb_50 g_fund_no_50 
eststo: reg pfs25_means mktrf_51 hml_51 smb_51 g_fund_no_51

esttab using cs9.tex, ar2 compress booktabs title(Cross Sectional Estimates - Growth in Number of Venture Capital Funds \label{tab1})  
est clear

eststo: reg pfs25_means  mktrf_52 vc_returns_l1_52 
eststo: reg pfs25_means mktrf_53 hml_53 vc_returns_l1_53 
eststo: reg pfs25_means  mktrf_54 smb_54 vc_returns_l1_54 
eststo: reg pfs25_means mktrf_55 hml_55 smb_55 vc_returns_l1_55

esttab using cs10.tex, ar2 compress booktabs title(Cross Sectional Estimates - Growth in Number of Venture Capital Funds \label{tab1})  
est clear

clear
