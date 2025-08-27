cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Performance Indicators/perform_ind.log", replace
drop _all
*Import csv
import delimited "Clean Data/performance_indicators.csv"
save "Stata/Performance Indicators/perform_ind.dta", replace
*Load data
use "Stata/Performance Indicators/perform_ind.dta", clear
*Dropping Global and overseas variables
drop v1 costoffundsannualized_globaloper costoffundsannualized_overseasop ///
yieldonfundsannualized_globalope yieldonfundsannualized_overseaso ///
efficiencycostincomeratio_global efficiencycostincomeratio_overse ///
overheadefficiencyratio_globalop overheadefficiencyratio_overseas ///
profitmargin_globaloperation profitmargin_overseasoperation ///
netinterestmarginnimannualized_g netinterestmarginnimannualized_o ///
returnonequityannualized_globalo returnonequityannualized_oversea ///
returnontotalassetsannualized_gl returnontotalassetsannualized_ov v29 v30 ///
interestincometototalincome_glob interestincometototalincome_over ///
noninterestincometototalincome_g noninterestincometototalincome_o ///
staffexpensestototalincome_globa staffexpensestototalincome_overs
*Renaming Variables
rename(costoffundsannualized_domesticop yieldonfundsannualized_domestico ///
efficiencycostincomeratio_domest overheadefficiencyratio_domestic ///
profitmargin_domesticoperation netinterestmarginnimannualized_d ///
returnonequityannualized_domesti returnontotalassetsannualized_do ///
operatingprofittototalworkingfun interestincometototalincome_dome ///
noninterestincometototalincome_d staffexpensestototalincome_domes) ///
(cost_funds yield_funds eff_ratio overhead_eff_ratio profit_margin NIM ///
ROE ROTA op_profit_to_workingfun int_to_total_inc nint_to_total_inc ///
staff_to_toatl_inc)
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
save "Stata/Performance Indicators/perform_ind.dta", replace

log close
