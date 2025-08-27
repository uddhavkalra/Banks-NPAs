cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Balance Sheet/balance_sheet.log", replace
drop _all
*Import csv
import delimited "Clean Data/balance_sheet.csv"
save "Stata/Balance Sheet/balance_sheet.dta", replace
*Load data
use "Stata/Balance Sheet/balance_sheet.dta", clear
*Dropping Global and overseas variables
drop v1 cashfunds_globaloperation cashfunds_overseasoperation ///
duefrombanksfisccps_globaloperat duefrombanksfisccps_overseasoper ///
slrapprovedsecurities_globaloper slrapprovedsecurities_overseasop ///
nonslrinvestments_globaloperatio nonslrinvestments_overseasoperat ///
netloansandadvances_globaloperat netloansandadvances_overseasoper ///
fixedassetsnet_globaloperation fixedassetsnet_overseasoperation ///
otherassets_globaloperation otherassets_overseasoperation ///
totalassets_globaloperation totalassets_overseasoperation ///
paidupsharecapital_globaloperati paidupsharecapital_overseasopera ///
reservesampsurplus_globaloperati reservesampsurplus_overseasopera ///
totaldepositsab_globaloperation totaldepositsab_overseasoperatio ///
acustomerdepositsiiiiiiivv_globa acustomerdepositsiiiiiiivv_overs ///
icurrentdeposits_globaloperation icurrentdeposits_overseasoperati ///
iisavingsdeposits_globaloperatio iisavingsdeposits_overseasoperat ///
iiitimedeposits_globaloperation iiitimedeposits_overseasoperatio ///
ivnrideposits_globaloperation ivnrideposits_overseasoperation /// 
vcertificatesofdeposits_globalop vcertificatesofdeposits_overseas ///
bdepositsofbanksiii_globaloperat bdepositsofbanksiii_overseasoper ///
ibanksinindia_globaloperation ibanksinindia_overseasoperation ///
iioverseasbanks_globaloperation iioverseasbanks_overseasoperatio ///
totalborrowings_globaloperation totalborrowings_overseasoperatio ///
otherliabilities_globaloperation otherliabilities_overseasoperati ///
totalcapitalampliabilities_globa totalcapitalampliabilities_overs
*Renaming Variables
rename(cashfunds_domesticoperation duefrombanksfisccps_domesticoper ///
slrapprovedsecurities_domesticop nonslrinvestments_domesticoperat ///
netloansandadvances_domesticoper fixedassetsnet_domesticoperation ///
otherassets_domesticoperation totalassets_domesticoperation ///
paidupsharecapital_domesticopera reservesampsurplus_domesticopera ///
totaldepositsab_domesticoperatio acustomerdepositsiiiiiiivv_domes ///
icurrentdeposits_domesticoperati iisavingsdeposits_domesticoperat ///
iiitimedeposits_domesticoperatio ivnrideposits_domesticoperation ///
vcertificatesofdeposits_domestic bdepositsofbanksiii_domesticoper ///
ibanksinindia_domesticoperation iioverseasbanks_domesticoperatio ///
totalborrowings_domesticoperatio otherliabilities_domesticoperati ///
totalcapitalampliabilities_domes) ///
(cashfunds due_from_banks slr_securities nslr_inv net_loans_advances ///
net_fixed_assets other_assets total_assets paidup_share_capital ///
reserves_surplus total_deposits customer_deposits current_deposits ///
savings_deposits time_deposits nri_deposits certificate_deposits ///
deposits_banks deposits_ind_banks deposits_nind_banks total_borrowings ///
other_liabilities total_liabilities)
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
save "Stata/Balance Sheet/balance_sheet.dta", replace

log close
