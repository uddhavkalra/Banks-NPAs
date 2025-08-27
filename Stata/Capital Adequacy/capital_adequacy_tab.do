cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Capital Adequacy/capital_adequacy.log", replace
drop _all
use "Stata/Capital Adequacy/capital_adequacy.dta", clear

*categorical variable for type
gen type_bank = 1 if foreign_dummy == 1
replace type_bank = 2 if private_dummy == 1
replace type_bank = 3 if public_dummy == 1
replace type_bank = 4 if small_finance_dummy == 1

gen tier_1_mil = tier_1/1000000
gen tier_1_comm_mil = tier_1_comm/1000000
gen tier_2_mil = tier_2/1000000
gen total_cap_mil = total_cap/1000000

drop if quarter_2 < tq(2016q3)
drop if quarter_2 > tq(2017q1)

bysort type_bank: tabstat tier_1_mil tier_1_comm_mil tier_2_mil total_cap_mil, ///
by(quarter_2) stat(mean semean)

log close
