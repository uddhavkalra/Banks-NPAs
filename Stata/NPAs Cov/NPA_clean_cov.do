cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/NPAs Cov/NPA_clean_cov.log", replace
drop _all
*Import csv
import delimited "Clean Data/asset_quality_cov.csv"
save "Stata/NPAs Cov/asset_quality_cov.dta", replace
*Load data
use "Stata/NPAs Cov/asset_quality_cov.dta", clear
*Dropping Global and overseas variables
drop v1 grossadvances_globaloperation grossadvances_overseasoperation v8 v9 ///
asubstandardadvances_globalopera asubstandardadvances_overseasope ///
bdoubtfuladvances_globaloperatio bdoubtfuladvances_overseasoperat /// 
clossadvances_globaloperation clossadvances_overseasoperation ///
grossnpastogrossadvances_globalo grossnpastogrossadvances_oversea ///
provisionsfornpasatendofthefy_gl provisionsfornpasatendofthefy_ov v26 v27 ///
netadvances_globaloperation netadvances_overseasoperation /// 
netnpas_globaloperation netnpas_overseasoperation /// 
netnpastonetadvances_globalopera netnpastonetadvances_overseasope ///
restructuredstandardadvances_glo restructuredstandardadvances_ove v41 v42 ///
v44 v45 v47 v48 loanssoldtoarcsapriltodate_globa ///
loanssoldtoarcsapriltodate_overs v53 v54
*Renaming variables
rename(grossadvances_domesticoperation grossnpasnpasattheendoftheperiod ///
asubstandardadvances_domesticope bdoubtfuladvances_domesticoperat ///
clossadvances_domesticoperation grossnpastogrossadvances_domesti ///
provisionsfornpasatendofthefy_do provisioncoverageratiowriteoffad) ///
(gross_advances gross_npas substandard_advances doubtful_advances ///
loss_advances npas_to_advances_gross provision_npas provision_coverage)

rename(netadvances_domesticoperation netnpas_domesticoperation ///
netnpastonetadvances_domesticope restructuredstandardadvances_dom ///
restructuredstdadvtogrossadvance stressedadvancesgnpasreststdadv_ ///
stressedadvancesgnpasreststdadvt loanssoldtoarcsapriltodate_domes ///
lossorgainonloansalesapriltodate) ///
(net_advances net_npas npas_to_advances_net restruct_stand_advances ///
restruct_stand_adv_to_gross_adv stressed_adv stressed_adv_to_gross_npas ///
loans_to_ARCs loss_gain)
*IDBI is coded as both private & public
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
save "Stata/NPAs Cov/asset_quality_cov.dta", replace

log close
