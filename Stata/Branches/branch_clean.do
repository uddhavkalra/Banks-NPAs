cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Branches/branch.log", replace
drop _all
*Import csv
import delimited "Clean Data/branch_all.csv"
save "Stata/Branches/branch_all.dta", replace
*Load data
use "Stata/Branches/branch_all.dta", clear
*dropping first row as it's col names
drop if v1 == .
*Dropping variable with no info
drop v1
*sorting data
order bank district city state
sort bank
save "Stata/Branches/branch_all.dta", replace
