cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Estimation Cov/estimation_cov.log", replace
drop _all
*OLS reg
use "Stata/Merged Cov/bank_vars_cov.dta", clear
reg gnpa_ratio private_dummy public_dummy, vce(robust)
reg gnpa_ratio private_dummy public_dummy agri_dummy ind_dummy serv_dummy ///
retail_dummy fc_dummy total_liabilities, vce(robust)
reg gnpa_ratio private_dummy public_dummy npri_dummy mse_dummy ///
total_liabilities, vce(robust)
reg gnpa_ratio private_dummy public_dummy trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities, vce(robust)
reg gnpa_ratio private_dummy public_dummy agri_dummy ind_dummy serv_dummy ///
retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities, noconstant vce(robust)
// local varlist gnpa_ratio total_liabilities
//
// foreach var in `varlist' {
//     local new_varname : subinstr local var " " "_", all
//     gen `new_varname'_d = d.`var'
// }
// reg gnpa_ratio_d private_dummy public_dummy, vce(robust)
// reg gnpa_ratio_d private_dummy public_dummy total_liabilities_d agri_dummy ///
// ind_dummy serv_dummy retail_dummy fc_dummy, vce(robust)
// reg gnpa_ratio_d private_dummy public_dummy npri_dummy mse_dummy ///
// total_liabilities_d, vce(robust)
// reg gnpa_ratio_d private_dummy public_dummy trans_dummy energy_dummy ///
// water_dummy comm_dummy total_liabilities_d, vce(robust)
*rif reg
*Diff in Diff
*private vs foreign 1 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 2)
gen treat = 1 if type_bank == 2
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*public vs foreign 1 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 3)
gen treat = 1 if type_bank == 3
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*small finance vs foreign 1 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 4)
gen treat = 1 if type_bank == 4
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*private vs foreign 2 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 2)
gen treat = 1 if type_bank == 2
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if quarter_2 == tq(2020q2)
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*public vs foreign 2 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 3)
gen treat = 1 if type_bank == 3
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2020q2))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*small finance vs foreign 2 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 4)
gen treat = 1 if type_bank == 4
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2020q2))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*private vs foreign 3 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 2)
gen treat = 1 if type_bank == 2
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2020q2)| quarter_2 == tq(2020q3))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*public vs foreign 3 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 3)
gen treat = 1 if type_bank == 3
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2020q2)| quarter_2 == tq(2020q3))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*small finance vs foreign 3 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 4)
gen treat = 1 if type_bank == 4
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2020q2)| quarter_2 == tq(2020q3))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*private vs foreign 4 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 2)
gen treat = 1 if type_bank == 2
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2020q2)| quarter_2 == tq(2020q3) |quarter_2 == tq(2020q4))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*public vs foreign 4 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 3)
gen treat = 1 if type_bank == 3
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2020q2)| quarter_2 == tq(2020q3) |quarter_2 == tq(2020q4))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*small finance vs foreign 4 after
use "Stata/Merged Cov/bank_vars_cov.dta", clear
keep if (type_bank == 1 |type_bank == 4)
gen treat = 1 if type_bank == 4
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2020q2)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2020q2)| quarter_2 == tq(2020q3) |quarter_2 == tq(2020q4))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)

*event study
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)

eventdd gnpa_ratio private_dummy public_dummy small_finance_dummy, timevar(time_to_event) ///
cluster(banks)

eventdd gnpa_ratio private_dummy public_dummy small_finance_dummy total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy, timevar(time_to_event) cluster(banks)

eventdd gnpa_ratio private_dummy public_dummy small_finance_dummy npri_dummy mse_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks)

eventdd gnpa_ratio private_dummy public_dummy small_finance_dummy trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities, timevar(time_to_event) cluster(banks)
*Foreign
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if type_bank == 1

eventdd gnpa_ratio total_liabilities, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) leads(14) lags(13) keepbal(banks) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Base Event Study") xtitle("Quarters to Event") ///
yscale(r(-5 7)) ytick(-5(3)7) ylabel(-5(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Private Banks")) ///
saving("Graphs/gph/for_event_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/for_event_cov.jpg", replace

// eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
// retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
// water_dummy comm_dummy state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
// saving("Graphs/gph/for_all_event_cov", replace))
// graph set window fontface "Arial"
// graph export "Graphs/jpg/for_all_event_cov.jpg", replace

eventdd gnpa_ratio fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
timevar(time_to_event) cluster(banks) leads(14) lags(13) keepbal(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Sectoral Controls") xtitle("Quarters to Event") ///
yscale(r(-5 7)) ytick(-5(3)7) ylabel(-5(3)7) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

eventdd gnpa_ratio npri_dummy2 mse_dummy2 opri_dummy2, ///
timevar(time_to_event) cluster(banks) leads(14) lags(13) keepbal(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Priority Controls") xtitle("Quarters to Event") ///
yscale(r(-5 7)) ytick(-5(3)7) ylabel(-5(3)7) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

eventdd gnpa_ratio trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2, timevar(time_to_event) cluster(banks) leads(14) lags(13) keepbal(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-5 7)) ytick(-5(3)7) ylabel(-5(3)7) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

eventdd gnpa_ratio state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) leads(14) lags(13) keepbal(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-5 7)) ytick(-5(3)7) ylabel(-5(3)7) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

eventdd gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) leads(14) lags(13) keepbal(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-5 7)) ytick(-5(3)7) ylabel(-5(3)7) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_all_event_2_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/for_all_event_2_cov.jpg", replace

// eventdd gnpa_ratio total_liabilities agri_dummy3 ind_dummy3 serv_dummy3 ///
// retail_dummy3 fc_dummy3 onfc_dummy3 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 ///
// water_dummy2 comm_dummy2 soc_comm_dummy2 in_agri_dummy in_mining_dummy in_manu_dummy ///
// in_const_dummy in_serv_dummy, timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

*Foreign vs Small Finance
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1 | type_bank == 4)
drop if quarter_2 < tq(2016q4)

eventdd gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_event_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_event_cov.jpg", replace

*Public vs Private
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 2 | type_bank == 3)
drop if quarter_2 < tq(2016q4)

eventdd gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/all_event_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/all_event_cov.jpg", replace

*Foreign vs Private
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1|type_bank ==2)
gen treat = 1 if type_bank == 2 & quarter_2 >= tq(2020q2)
replace treat = 0 if treat ==.

// xtdidregress (gnpa_ratio total_liabilities ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f) (treat), group(type_bank) time(quarter_2)
// estat grangerplot
// estat ptrends
// estat trendplots

xtreg gnpa_ratio treat i.quarter_2#treat total_liabilities, vce(robust)

gen after = 1 if quarter_2 >= tq(2020q2)
replace after = 0 if after ==.
replace treat = 1 if type_bank == 2
replace treat = 0 if type_bank == 1
gen treatxafter = treat * after

reg gnpa_ratio treat after treatxafter total_liabilities, vce(robust) noconstant

use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1|type_bank ==2)

gen treat = tq(2020q2) if type_bank == 2 
replace treat = 0 if treat ==.
egen bank_num_2 = group(banks)

csdid gnpa_ratio total_liabilities, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

csdid gnpa_ratio total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

csdid gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 ///
serv_dummy2 retail_dummy2, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

csdid gnpa_ratio total_liabilities trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

csdid gnpa_ratio total_liabilities ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

// eventdd gnpa_ratio, timevar(time_to_event) cluster(banks) over(type_bank)
//
// eventdd gnpa_ratio total_liabilities agri_dummy ///
// ind_dummy serv_dummy retail_dummy fc_dummy, ///
// timevar(time_to_event) cluster(banks) over(type_bank)
//
// eventdd gnpa_ratio npri_dummy mse_dummy total_liabilities, ///
// timevar(time_to_event) cluster(banks) over(type_bank)
//
// eventdd gnpa_ratio trans_dummy energy_dummy water_dummy comm_dummy ///
// total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)
//
// eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
// retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
// water_dummy comm_dummy, timevar(time_to_event) cluster(banks) over(type_bank)

*Foreign vs Public
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1|type_bank ==3)
gen treat = 1 if type_bank == 3 & quarter_2 >= tq(2020q2)
replace treat = 0 if treat ==.

// xtdidregress (gnpa_ratio total_liabilities ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f) (treat), group(type_bank) time(quarter_2)
// // estat grangerplot
// estat ptrends
// estat trendplots

eventdd gnpa_ratio, timevar(time_to_event) cluster(banks) over(type_bank)
//
// eventdd gnpa_ratio total_liabilities agri_dummy ///
// ind_dummy serv_dummy retail_dummy fc_dummy, ///
// timevar(time_to_event) cluster(banks) over(type_bank)
//
// eventdd gnpa_ratio npri_dummy mse_dummy total_liabilities, ///
// timevar(time_to_event) cluster(banks) over(type_bank)
//
// eventdd gnpa_ratio trans_dummy energy_dummy water_dummy comm_dummy ///
// total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)
//
// eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
// retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
// water_dummy comm_dummy, timevar(time_to_event) cluster(banks) over(type_bank)

*Foreign vs Small Finance
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1|type_bank ==4)
gen treat = 1 if type_bank == 4 & quarter_2 >= tq(2020q2)
replace treat = 0 if treat ==.
drop if quarter_2 < tq(2017q2)

// xtdidregress (gnpa_ratio total_liabilities ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f) (treat), group(type_bank) time(quarter_2)
// estat grangerplot
// estat ptrends
// estat trendplots

use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1|type_bank ==4)

eventdd gnpa_ratio, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd gnpa_ratio total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank)

eventdd gnpa_ratio npri_dummy mse_dummy total_liabilities, ///
timevar(time_to_event) cluster(banks) over(type_bank)

eventdd gnpa_ratio trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
water_dummy comm_dummy, timevar(time_to_event) cluster(banks) over(type_bank)

use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1|type_bank ==4)

gen treat = tq(2020q2) if type_bank == 4
replace treat = 0 if treat ==.
egen bank_num_2 = group(banks)

csdid gnpa_ratio total_liabilities, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

csdid gnpa_ratio total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

csdid gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 ///
serv_dummy2 retail_dummy2, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

csdid gnpa_ratio total_liabilities ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(241)

*Private vs Public vs Small Finance
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 2|type_bank ==3|type_bank ==4)

eventdd gnpa_ratio total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
yscale(r(-15 20)) ytick(-15(5)20) ylabel(-15(5)20) ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")) saving("Graphs/gph/base_event_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/base_event_cov.jpg", replace

eventdd gnpa_ratio fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-10 15)) ytick(-10(5)15) ylabel(-10(5)15) ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

eventdd gnpa_ratio npri_dummy2 mse_dummy2 opri_dummy2, ///
timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-10 15)) ytick(-10(5)15) ylabel(-10(5)15) ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

eventdd gnpa_ratio trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-10 15)) ytick(-10(5)15) ylabel(-10(5)15) ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

// eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
// retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
// water_dummy comm_dummy state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")) saving("Graphs/gph/all_cont_event_cov", replace))
// graph set window fontface "Arial"
// graph export "Graphs/jpg/all_cont_event_cov.jpg", replace

eventdd gnpa_ratio state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-10 15)) ytick(-10(5)15) ylabel(-10(5)15) ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

eventdd gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-10 15)) ytick(-10(5)15) ylabel(-10(5)15) ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")) saving("Graphs/gph/all_cont_event_2_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/all_cont_event_2_cov.jpg", replace

// eventdd gnpa_ratio total_liabilities agri_dummy3 ind_dummy3 serv_dummy3 ///
// retail_dummy3 fc_dummy3 onfc_dummy3 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 ///
// water_dummy2 comm_dummy2 soc_comm_dummy2 in_agri_dummy in_mining_dummy in_manu_dummy in_const_dummy ///
// in_serv_dummy, timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks"))) 

*Priority/non-prioity
*Foreign vs Private
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets
gen mse_gnpa_rat = mse_gnpa/total_assets
gen opri_gnpa_rat = other_priority_gnpa/total_assets
keep if (type_bank == 1|type_bank ==2)


eventdd npri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

*Foreign vs Public
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets
gen mse_gnpa_rat = mse_gnpa/total_assets
gen opri_gnpa_rat = other_priority_gnpa/total_assets
keep if (type_bank == 1|type_bank ==3)

eventdd npri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

*Foreign vs Small Finance
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets
gen mse_gnpa_rat = mse_gnpa/total_assets
gen opri_gnpa_rat = other_priority_gnpa/total_assets
keep if (type_bank == 1|type_bank ==4)
drop if quarter_2 < tq(2016q4)

eventdd npri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_npri_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_npri_cov.jpg", replace


eventdd mse_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_mse_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_mse_cov.jpg", replace

eventdd opri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_opri_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_opri_cov.jpg", replace

*Private vs Public
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if (type_bank == 2|type_bank ==3)
drop if quarter_2 < tq(2016q4)

eventdd npri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f agri_dummy ind_dummy serv_dummy retail_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/npri_event_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/npri_event_cov.jpg", replace

eventdd npri_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/npri_event_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/npri_event_cov.jpg", replace

eventdd mse_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f agri_dummy ind_dummy serv_dummy retail_dummy, /// 
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Medium & Small Enterprises GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")) saving("Graphs/gph/mse_event_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/mse_event_cov.jpg", replace

eventdd mse_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, /// 
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/mse_event_2_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/mse_event_2_cov.jpg", replace

eventdd opri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

// eventdd other_priority_gnpa_ratio trans_dummy energy_dummy water_dummy comm_dummy ///
// total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Other Priority GNPAs") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))

eventdd other_priority_gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/opri_event_2_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/opri_event_2_cov.jpg", replace

*Private vs Small Finance
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if (type_bank == 2|type_bank ==4)
drop if quarter_2 < tq(2016q4)

eventdd mse_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, /// 
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(purple))) ci(rcap, g1(color(blue)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") title("Figure6: COVID Medium & Small Enterprises GNPAs") xtitle("Quarters to Event") ///
note("Note: Includes Sectoral, Infrastructure and Regional Controls") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/mse_event_2_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/mse_event_2_cov.pdf", replace

*Sector
*Foreign vs Private
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen food_gnpa_rat = food_cred_gnpa/total_assets
gen agri_gnpa_rat = agri_gnpa/total_assets
gen ind_gnpa_rat = ind_gnpa/total_assets
gen serv_gnpa_rat = serv_gnpa/total_assets
gen retail_gnpa_rat = retail_gnpa/total_assets
gen onfc_gnpa_rat = onfc_gnpa/total_assets
keep if (type_bank == 1| type_bank == 2)

eventdd food_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd food_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd agri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd agri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd ind_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd ind_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd serv_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd serv_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd retail_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd retail_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

*Foreign vs Public
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen food_gnpa_rat = food_cred_gnpa/total_assets
gen agri_gnpa_rat = agri_gnpa/total_assets
gen ind_gnpa_rat = ind_gnpa/total_assets
gen serv_gnpa_rat = serv_gnpa/total_assets
gen retail_gnpa_rat = retail_gnpa/total_assets
gen onfc_gnpa_rat = onfc_gnpa/total_assets
keep if (type_bank == 1| type_bank == 3)

eventdd food_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd food_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd agri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd agri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd ind_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd ind_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd serv_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd serv_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd retail_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd retail_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

*Foreign vs Small Finance
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen food_gnpa_rat = food_cred_gnpa/total_assets
gen agri_gnpa_rat = agri_gnpa/total_assets
gen ind_gnpa_rat = ind_gnpa/total_assets
gen serv_gnpa_rat = serv_gnpa/total_assets
gen retail_gnpa_rat = retail_gnpa/total_assets
gen onfc_gnpa_rat = onfc_gnpa/total_assets
keep if (type_bank == 1| type_bank == 4)
drop if quarter_2 < tq(2016q4)

eventdd agri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_agri_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_agri_cov.jpg", replace

eventdd ind_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_ind_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_ind_cov.jpg", replace

eventdd serv_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_serv_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_serv_cov.jpg", replace

eventdd retail_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_retail_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_retail_cov.jpg", replace

eventdd onfc_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(green)) g2(color(purple))) ci(rcap, g1(color(green)) g2(color(purple))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Small Finance Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/for_onfc_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_onfc_cov.jpg", replace

*Private vs Public
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen food_gnpa_rat = food_cred_gnpa/total_assets * 100
gen agri_gnpa_rat = agri_gnpa/total_assets * 100
gen ind_gnpa_rat = ind_gnpa/total_assets * 100
gen serv_gnpa_rat = serv_gnpa/total_assets * 100
gen retail_gnpa_rat = retail_gnpa/total_assets * 100
gen onfc_gnpa_rat = onfc_gnpa/total_assets * 100
keep if (type_bank == 2| type_bank == 3)
drop if quarter_2 < tq(2016q4)

eventdd food_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd food_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd agri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

// eventdd agri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
// total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f npri_dummy mse_dummy, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")) saving("Graphs/gph/agri_event_cov", replace))
// graph set window fontface "Arial"
// graph export "Graphs/jpg/agri_event_cov.jpg", replace

eventdd agri_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/agri_event_2_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/agri_event_2_cov.jpg", replace

eventdd ind_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

// eventdd ind_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
// total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f npri_dummy mse_dummy, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("COVID Industry GNPAs") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")) saving("Graphs/gph/ind_event_cov", replace))
// graph set window fontface "Arial"
// graph export "Graphs/jpg/ind_event_cov.jpg", replace

eventdd ind_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) /// 
saving("Graphs/gph/ind_event_2_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/ind_event_2_cov.jpg", replace

eventdd serv_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

// eventdd serv_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy soc_comm_dummy2 ///
// total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f npri_dummy mse_dummy opri_dummy, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("COVID Services GNPAs") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")) saving("Graphs/gph/serv_event_cov", replace))
// graph set window fontface "Arial"
// graph export "Graphs/jpg/serv_event_cov.jpg", replace

eventdd serv_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/serv_event_2_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/serv_event_2_cov.jpg", replace

eventdd retail_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

// eventdd retail_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
// total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f npri_dummy mse_dummy, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("COVID Retail GNPAs") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")) saving("Graphs/gph/retail_event_cov", replace))
// graph set window fontface "Arial"
// graph export "Graphs/jpg/retail_event_cov.jpg", replace

eventdd retail_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/retail_event_2_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/retail_event_2_cov.jpg", replace

eventdd onfc_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities npri_dummy mse_dummy opri_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
xscale(r(-14 13)) xtick(-14(5)13) xlabel(-14(5)13) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/onfc_event_2_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/onfc_event_2_cov.jpg", replace

*All 4
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen food_gnpa_rat = food_cred_gnpa/total_assets * 100
gen agri_gnpa_rat = agri_gnpa/total_assets * 100
gen ind_gnpa_rat = ind_gnpa/total_assets * 100
gen serv_gnpa_rat = serv_gnpa/total_assets * 100
gen retail_gnpa_rat = retail_gnpa/total_assets * 100
gen onfc_gnpa_rat = onfc_gnpa/total_assets * 100
drop if quarter_2 < tq(2016q4)

eventdd agri_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd ind_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd serv_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd retail_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank)

*Retail Focus
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen house_gnpa_rat = house_gnpa/total_assets * 100
gen auto_gnpa_rat = auto_gnpa/total_assets * 100
gen cred_gnpa_rat = cred_gnpa/total_assets * 100
gen edu_gnpa_rat = edu_gnpa/total_assets * 100
gen oretail_gnpa_rat = oretail_gnpa/total_assets * 100
keep if (type_bank == 2| type_bank == 3| type_bank == 4)

eventdd house_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank) 

eventdd house_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("COVID Housing GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

eventdd auto_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank) 

eventdd auto_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("COVID Auto GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

eventdd cred_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank) 

eventdd cred_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("COVID Cred GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

eventdd edu_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank) 

eventdd edu_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("COVID Edu GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

eventdd oretail_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank) 

eventdd oretail_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
graph_op(ytitle("Coefficients") title("COVID Other Retail GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
lab(6 "Small Finance Banks")))

use "Stata/Merged Cov/bank_vars_cov.dta", clear
collapse (sum) food_cred_gadv agri_gadv ind_gadv serv_gadv retail_gadv onfc_gadv, by(type_bank quarter_2)
egen sec_tot = rowtotal(food_cred_gadv agri_gadv ind_gadv serv_gadv retail_gadv onfc_gadv)
gen fc_rat = food_cred_gadv/sec_tot
gen agri_rat = agri_gadv/sec_tot
gen ind_rat = ind_gadv/sec_tot
gen serv_rat = serv_gadv/sec_tot
gen retail_rat = retail_gadv/sec_tot
gen onfc_rat = onfc_gadv/sec_tot

tsline fc_rat agri_rat ind_rat serv_rat retail_rat onfc_rat if type_bank == 1
tsline fc_rat agri_rat ind_rat serv_rat retail_rat onfc_rat if type_bank == 2
tsline fc_rat agri_rat ind_rat serv_rat retail_rat onfc_rat if type_bank == 3
tsline fc_rat agri_rat ind_rat serv_rat retail_rat onfc_rat if type_bank == 4

// *Profitability
// *PAT
// *Foreign Banks
// use "Stata/Merged Cov/bank_vars_cov.dta", clear
// gen time_to_event = quarter_2 - tq(2020q2)
// keep if type_bank == 1
//
// eventdd pat_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Size Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pat_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Sector Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pat_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Priority Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pat_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Infra Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pat_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Region Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pat_ratio_2 total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// *Private vs Public vs Small Finance
// use "Stata/Merged Cov/bank_vars_cov.dta", clear
// gen time_to_event = quarter_2 - tq(2020q2)
// keep if (type_bank == 2|type_bank ==3|type_bank ==4)
//
// eventdd pat_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pat_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pat_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pat_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pat_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pat_ratio_2 total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// *Profitability
// *PBT
// *Foreign Banks
// use "Stata/Merged Cov/bank_vars_cov.dta", clear
// gen time_to_event = quarter_2 - tq(2020q2)
// keep if type_bank == 1
//
// eventdd pbt_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Size Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pbt_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Sector Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pbt_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Priority Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pbt_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Infra Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pbt_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Region Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd pbt_ratio_2 total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, ///	
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// *Private vs Public vs Small Finance
// use "Stata/Merged Cov/bank_vars_cov.dta", clear
// gen time_to_event = quarter_2 - tq(2020q2)
// keep if (type_bank == 2|type_bank ==3|type_bank ==4)
//
// eventdd pbt_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pbt_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pbt_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pbt_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pbt_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd pbt_ratio_2 total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// *Profitability
// *EBPT
// *Foreign Banks
// use "Stata/Merged Cov/bank_vars_cov.dta", clear
// gen time_to_event = quarter_2 - tq(2020q2)
// keep if type_bank == 1
//
// eventdd ebpt_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Size Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd ebpt_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Sector Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd ebpt_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Priority Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd ebpt_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Infra Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd ebpt_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Region Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// eventdd ebpt_ratio_2 total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, ///	
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))
//
// *Private vs Public vs Small Finance
// use "Stata/Merged Cov/bank_vars_cov.dta", clear
// gen time_to_event = quarter_2 - tq(2020q2)
// keep if (type_bank == 2|type_bank ==3|type_bank ==4)
//
// eventdd ebpt_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd ebpt_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd ebpt_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd ebpt_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd ebpt_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))
//
// eventdd ebpt_ratio_2 total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
// onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) leads(14) lags(13) keepbal(banks) ///
// coef_op(g1(color(blue)) g2(color(red)) g3(color(black))) ci(rcap, g1(color(blue)) g2(color(red)) g3(color(black))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3 6 5) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks") lab(5 "95% CI Small Finance Banks") ///
// lab(6 "Small Finance Banks")))

*Sector Interactions
*241 event time
use "Stata/Merged Cov/bank_vars_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)

regress gnpa_ratio fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2 ///
i.quarter_2#fc_dummy2 i.quarter_2#agri_dummy2 i.quarter_2#ind_dummy2 i.quarter_2#serv_dummy2 ///
i.quarter_2#retail_dummy2 i.quarter_2#onfc_dummy2 if type_bank == 1, vce(robust)

estimates store F

regress gnpa_ratio fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2 ///
i.quarter_2#fc_dummy2 i.quarter_2#agri_dummy2 i.quarter_2#ind_dummy2 i.quarter_2#serv_dummy2 ///
i.quarter_2#retail_dummy2 i.quarter_2#onfc_dummy2 if type_bank == 2, vce(robust) 

estimates store Pv

regress gnpa_ratio fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2 ///
i.quarter_2#fc_dummy2 i.quarter_2#agri_dummy2 i.quarter_2#ind_dummy2 i.quarter_2#serv_dummy2 ///
i.quarter_2#retail_dummy2 i.quarter_2#onfc_dummy2 if type_bank == 3, vce(robust)

estimates store Pb

coefplot F, keep(*.quarter_2#*.fc_dummy2)

coefplot Pv Pb, keep(*.quarter_2#*.fc_dummy2) 

// coefplot F, keep(*.quarter_2#*.agri_dummy2) omitted
//
// coefplot Pv Pb, keep(*.quarter_2#*.agri_dummy2) omitted
//
// coefplot F, keep(*.quarter_2#*.ind_dummy2) omitted
//
// coefplot Pv Pb, keep(*.quarter_2#*.ind_dummy2) omitted
//
// coefplot F, keep(*.quarter_2#*.serv_dummy2) omitted
//
// coefplot Pv Pb, keep(*.quarter_2#*.serv_dummy2) omitted
//
// coefplot F, keep(*.quarter_2#*.onfc_dummy2) omitted
//
// coefplot Pv Pb, keep(*.quarter_2#*.onfc_dummy2) omitted

*Priority Interactions
regress gnpa_ratio npri_dummy2 mse_dummy2 opri_dummy2 i.quarter_2#npri_dummy2 ///
i.quarter_2#mse_dummy2 i.quarter_2#opri_dummy2 if type_bank == 1, vce(robust)

estimates store F

regress gnpa_ratio npri_dummy2 mse_dummy2 opri_dummy2 i.quarter_2#npri_dummy2 ///
i.quarter_2#mse_dummy2 i.quarter_2#opri_dummy2 if type_bank == 2, vce(robust)

estimates store Pv

regress gnpa_ratio npri_dummy2 mse_dummy2 opri_dummy2 i.quarter_2#npri_dummy2 ///
i.quarter_2#mse_dummy2 i.quarter_2#opri_dummy2 if type_bank == 3, vce(robust)

estimates store Pb

coefplot F, keep(*.quarter_2#*npri_dummy2)

coefplot Pv Pb, keep(*.quarter_2#*npri_dummy2)

// coefplot F, keep(*.quarter_2#*mse_dummy2)
//
// coefplot Pv Pb, keep(*.quarter_2#*mse_dummy2)
//
// coefplot F, keep(*.quarter_2#*opri_dummy2)
//
// coefplot Pv Pb, keep(*.quarter_2#*opri_dummy2)

*Infrastructure Interactions
regress gnpa_ratio trans_dummy2 energy_dummy2 water_dummy2 comm_dummy2 soc_comm_dummy2 ///
i.quarter_2#trans_dummy2 i.quarter_2#energy_dummy2 i.quarter_2#water_dummy2 i.quarter_2#comm_dummy2 ///
i.quarter_2#soc_comm_dummy2 if type_bank == 1, vce(robust)

estimates store F

regress gnpa_ratio trans_dummy2 energy_dummy2 water_dummy2 comm_dummy2 soc_comm_dummy2 ///
i.quarter_2#trans_dummy2 i.quarter_2#energy_dummy2 i.quarter_2#water_dummy2 i.quarter_2#comm_dummy2 ///
i.quarter_2#soc_comm_dummy2 if type_bank == 2, vce(robust)

estimates store Pv

regress gnpa_ratio trans_dummy2 energy_dummy2 water_dummy2 comm_dummy2 soc_comm_dummy2 ///
i.quarter_2#trans_dummy2 i.quarter_2#energy_dummy2 i.quarter_2#water_dummy2 i.quarter_2#comm_dummy2 ///
i.quarter_2#soc_comm_dummy2 if type_bank == 3, vce(robust)

estimates store Pb

coefplot F, keep(*.quarter_2#*.trans_dummy2)

coefplot Pv Pb, keep(*.quarter_2#*.trans_dummy2)

// coefplot F, keep(*.quarter_2#*.energy_dummy2)
//
// coefplot Pv Pb, keep(*.quarter_2#*.energy_dummy2)
//
// coefplot F, keep(*.quarter_2#*.water_dummy2)
//
// coefplot Pv Pb, keep(*.quarter_2#*.water_dummy2)
//
// coefplot F, keep(*.quarter_2#*.comm_dummy2)
//
// coefplot Pv Pb, keep(*.quarter_2#*.comm_dummy2)
//
// coefplot F, keep(*.quarter_2#*.soc_comm_dummy2)
//
// coefplot Pv Pb, keep(*.quarter_2#*.soc_comm_dummy2)

use "Stata/Merged Cov/bank_vars_cov.dta", clear
drop if no_branches_2 ==.
bysort type_bank: egen med_branch = mean(no_branches_2)
* 4.069 Foreign
* 1654.782 Private
* 6321.083 Public
* 363.502 Small Finance

use "Stata/Merged Cov/bank_vars_cov.dta", clear
bysort type_bank quarter_2: egen mean_gnpa_rat = mean(gnpa_ratio)
keep if quarter_2 == tq(2020q1)

*Foreign 1.76%
*Private 3.37%
*Public 7.52%
*Small Finance 1.15%

log close
