cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Profitability Cov/profiatbility_cov.log", replace
drop _all
*Import csv
import delimited "Clean Data/profitability_cov.csv"
save "Stata/Profitability Cov/profitability_cov.dta", replace
*Load data
use "Stata/Profitability Cov/profitability_cov.dta", clear
*Dropping Global and Overseas variables
drop v1 v5 v6 interestexpenseapriltodate_globa interestexpenseapriltodate_overs ///
v11 v12 v14 v15 v17 v18 operatingexpenseoeapriltodate_gl ///
operatingexpenseoeapriltodate_ov v23 v24 v26 v27 ///
capitalgainslossesapriltodate_gl capitalgainslossesapriltodate_ov v32 v33 v35 ///
v36 riskprovisionstotalapriltodate_g riskprovisionstotalapriltodate_o ///
writeoffstotalapriltodate_global writeoffstotalapriltodate_overse v44 v45 ///
v47 v48 v50 v51 v53 v54
*renaming variables
rename(totalinterestincomenetofinterest interestexpenseapriltodate_domes ///
netinterestincomeniiapriltodate1 otheroperatingincomeooiapriltoda ///
totaloperatingincomeapriltodate3 operatingexpenseoeapriltodate_do ///
ofwhichstaffexpensesapriltodate_ netoperatingincomeapriltodate56_ ///
capitalgainslossesapriltodate_do othernonoperatingincomeexpensesa ///
earningbeforeprovisionsamptaxese riskprovisionstotalapriltodate_d ///
writeoffstotalapriltodate_domest provisionsforliabilitiesapriltod ///
profitlossbeforetaxpbtapriltodat provisionforincometaxesapriltoda ///
netprofitlosspatapriltodate1415_) ///
(total_int_inc int_exp NII OOI total_oi OE staff_exp net_oi capital_gains ///
other_noi EBPT risk_prov write_offs liability_ptov PBT IT_prov PAT)
*IDBI BANK LIMITED is coded as both private & public
browse if private_dummy == 1 & public_dummy == 1
*Fix IDBI
duplicates drop
replace private_dummy = 0 if (private_dummy == 1 & public_dummy == 1)
*quarter as datetime
gen quarter_2 = quarterly(quarter, "YQ")
format quarter_2 %tq
drop quarter
*sort data
sort(banks quarter_2)
order banks quarter_2
save "Stata/Profitability Cov/profitability_cov.dta", replace

log close
