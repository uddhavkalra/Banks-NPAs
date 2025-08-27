cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Priority Cov/Priority_cov.log", replace
drop _all
*Import csv
import delimited "Clean Data/priority_break_up_cov.csv"
save "Stata/Priority Cov/priority_cov.dta", replace
*Load data
use "Stata/Priority Cov/priority_cov.dta", clear
*Dropping variables with no info
drop v1
*Renaming variables
rename(grossadvances_domesticoperation grossnpas_domesticoperation ///
grossnpastogrossadvances_domesti prioritysectorgrossadvances_dome ///
prioritysectorgrossnpas_domestic prioritysectorgnparatio_domestic ///
otherthanprioritygrossadvances_d otherthanprioritygnpas_domestico ///
otherthanprioritygnparatio_domes priorityagricultureandalliedacti v14 v15 ///
prioritymsegrossadvances_domesti prioritymsegnpas_domesticoperati ///
prioritymsegnparatio_domesticope otherprioritysectorgrossadvances ///
otherprioritysectorgnpas_domesti otherprioritysectorgnparatio_dom) ///
(gross_advances gross_npas npas_to_advances_gross priority_gadv priority_gnpa ///
priority_gnpa_ratio non_priority_gadv non_priority_gnpa ///
non_priority_gnpa_ratio agri_gadv agri_gnpa agri_gnpa_ratio mse_gadv mse_gnpa ///
mse_gnpa_ratio other_priority_gadv other_priority_gnpa other_priority_gnpa_ratio)
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
save "Stata/Priority Cov/priority_cov.dta", replace

log close
