cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Branches Cov/branch_cov.log", replace
drop _all
*Import csv
import delimited "Clean Data/branch_all_cov.csv", bindquote(strict)
save "Stata/Branches Cov/branch_all_cov.dta", replace
*Load data
use "Stata/Branches Cov/branch_all_cov.dta", clear
*drop variables not needed
drop v1 contact imps upi rtgs neft micr
*order data
replace bank = strupper(bank)
replace state = strupper(state)
order bank district city state
drop if bank == ""
drop if foreign_dummy ==.
drop if bank == "510 ARMY BASE W/S CREDIT CO-OPERATIVE PRIMARY BANK"
sort bank state

save "Stata/Branches Cov/branch_all_cov.dta", replace
