cd "/Users/uddhav/Desktop/Thesis/Stata/Priority"
log close
log using mse_graph.log, replace
drop _all
use bank_vars.dta, clear

gen mse_gnpa_mil = mse_gnpa/1000000
*Plotting
collapse (sum) mse_gnpa_mil, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline mse_gnpa_mil, overlay xline(227) title ("Gross NPA of MSE") ///
ytitle("Rs Million") xtitle("Quarter") ///
legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving(mse_sum_graph, replace)
graph export mse_sum_graph.jpg, replace

use bank_vars.dta, clear
*Plotting
collapse (mean) mse_gnpa_ratio, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline mse_gnpa_ratio, overlay xline(227) ytitle("Mean Gross NPA Ration MSE in Rs Million") ///
xtitle("Quarter") legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving(mse_avg_graph, replace) 
graph export mse_avg_graph.jpg, replace

use bank_vars.dta, clear
gen mse_gnpa_to_gnpa = mse_gnpa/gross_npas
drop if quarter_2 == tq(2012q2)
*Plotting
collapse (mean) mse_gnpa_to_gnpa, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline mse_gnpa_to_gnpa, overlay xline(227) ytitle("Mean Gross NPA Ration MSE in Rs Million") ///
xtitle("Quarter") legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving(mse_rat_graph, replace) 
graph export mse_rat_graph.jpg, replace

use bank_vars.dta, clear
gen priority_gnpa_ratio2 = priority_gnpa/total_assets
collapse (mean) priority_gnpa_ratio2, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline priority_gnpa_ratio, overlay xline(227) title ("Gross NPA of pri") ///
ytitle("Rs Million") xtitle("Quarter") ///
legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving(pri_graph, replace)
graph export pri_graph.jpg, replace

use bank_vars.dta, clear
gen non_priority_gnpa_ratio2 = non_priority_gnpa/total_assets
collapse (mean) non_priority_gnpa_ratio2, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline non_priority_gnpa_ratio, overlay xline(227) title ("Gross NPA of npri") ///
ytitle("Rs Million") xtitle("Quarter") ///
legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving(npri_graph, replace)
graph export npri_graph.jpg, replace

