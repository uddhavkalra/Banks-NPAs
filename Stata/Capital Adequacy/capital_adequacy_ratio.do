cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Capital Adequacy/capital_adequacy.log", replace
drop _all
*Import csv
import delimited "Clean Data/capital_adequacy.csv"
save "Stata/Capital Adequacy/capital_adequacy.dta", replace 
*Load data
use "Stata/Capital Adequacy/capital_adequacy.dta", clear
*Dropping Global variables
drop v1 tiericapitalstandalone_globalope commonequitytiericapitalstandalo ///
tieriicapitalstandalone_globalop totalcapitalstandalone_globalope ///
totalrwasstandaloneabc_globalope atotalrwascreditriskstandalone_g ///
btotalrwasmarketriskstandalone_g ctotalrwasoperationalriskstandal ///
capitalratiocrarstandalone_globa tiericapitalratiostandalone_glob ///
ceticapitalratiostandalone_globa tier2capitalratiostandalone_glob
*renaming variables
rename(tiericapitalstandalone_domestico v7 tieriicapitalstandalone_domestic ///
totalcapitalstandalone_domestico totalrwasstandaloneabc_domestico ///
atotalrwascreditriskstandalone_d btotalrwasmarketriskstandalone_d v19 ///
capitalratiocrarstandalone_domes tiericapitalratiostandalone_dome ///
ceticapitalratiostandalone_domes tier2capitalratiostandalone_dome) ///
(tier_1 tier_1_comm tier_2 total_cap total_RWAs cred_RWAs mkt_RWAs op_RWAs ///
CRAR tier_1_ratio CET_1_ratio tier_2_ratio)
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
save "Stata/Capital Adequacy/capital_adequacy.dta", replace

save "Stata/Merged/capital_adequacy.dta", replace

log close
