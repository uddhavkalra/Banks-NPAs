cd "/Users/uddhav/Desktop/Thesis/Stata/Balance Sheet"
log close
log using balance_sheet_tab.log, replace
drop _all
use balance_sheet.dta, clear
*categorical variable for type
gen type_bank = 1 if foreign_dummy == 1
replace type_bank = 2 if private_dummy == 1
replace type_bank = 3 if public_dummy == 1
replace type_bank = 4 if small_finance_dummy == 1

gen loans_adv_mil = net_loans_advances/1000000
gen fixed_assets_mil = net_fixed_assets/1000000
gen total_assets_mil = total_assets/1000000
gen deposits_mil = total_deposits/1000000
gen liabilities_mil = total_liabilities/1000000

drop if quarter_2 < tq(2016q3)
drop if quarter_2 > tq(2017q1)

bysort type_bank: tabstat loans_adv_mil fixed_assets_mil total_assets_mil ///
deposits_mil liabilities_mil, by(quarter_2) stat(mean semean)

use balance_sheet.dta, clear
gen type_bank = 1 if foreign_dummy == 1
replace type_bank = 2 if private_dummy == 1
replace type_bank = 3 if public_dummy == 1
replace type_bank = 4 if small_finance_dummy == 1
keep if quarter_2 == tq(2018q4)
count if type_bank == 1
count if type_bank == 2
count if type_bank == 3
count if type_bank == 4
