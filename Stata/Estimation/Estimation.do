cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Estimation/estimation.log", replace
drop _all
*OLS reg
use "Stata/Merged/bank_vars.dta", clear
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
*regional and sectoral dummies, decile of size before demon
// local varlist gnpa_ratio total_liabilities
// sort banks quarter_2
// foreach var in `varlist' {
//     local new_varname : subinstr local var " " "_", all
//     bysort banks: gen `new_varname'_d = d.`var'
// }
// reg gnpa_ratio_d private_dummy public_dummy, vce(robust)
// reg gnpa_ratio_d private_dummy public_dummy total_liabilities_d agri_dummy ///
// ind_dummy serv_dummy retail_dummy fc_dummy, vce(robust)
// reg gnpa_ratio_d private_dummy public_dummy npri_dummy mse_dummy ///
// total_liabilities_d, vce(robust)
// reg gnpa_ratio_d private_dummy public_dummy trans_dummy energy_dummy ///
// water_dummy comm_dummy total_liabilities_d, vce(robust)
*Diff in Diff
*private vs foreign 1 after
use "Stata/Merged/bank_vars.dta", clear
keep if (type_bank == 1 |type_bank == 2)
gen treat = 1 if type_bank == 2
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2016q3)
replace after = 0 if after ==.
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy2 energy_dummy2 ///
water_dummy2 comm_dummy2 soc_comm_dummy2 fc_dummy2 agri_dummy2 ind_dummy2 ///
serv_dummy2 retail_dummy2 onfc_dummy2 total_liabilities npri_dummy2 opri_dummy2 ///
mse_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f)
*public vs foreign 1 after
use "Stata/Merged/bank_vars.dta", clear
keep if (type_bank == 1 |type_bank == 3)
gen treat = 1 if type_bank == 3
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2016q3)
replace after = 0 if after ==.
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy2 energy_dummy2 ///
water_dummy2 comm_dummy2 soc_comm_dummy2 fc_dummy2 agri_dummy2 ind_dummy2 ///
serv_dummy2 retail_dummy2 onfc_dummy2 total_liabilities npri_dummy2 opri_dummy2 ///
mse_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f)
*private vs foreign 2 after
use "Stata/Merged/bank_vars.dta", clear
keep if (type_bank == 1 |type_bank == 2)
gen treat = 1 if type_bank == 2
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2016q3)
replace after = 0 if after ==.
drop if quarter_2 == tq(2016q3)
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*public vs foreign 2 after
use "Stata/Merged/bank_vars.dta", clear
keep if (type_bank == 1 |type_bank == 3)
gen treat = 1 if type_bank == 3
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2016q3)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2016q3))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*private vs foreign 3 after
use "Stata/Merged/bank_vars.dta", clear
keep if (type_bank == 1 |type_bank == 2)
gen treat = 1 if type_bank == 2
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2016q3)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2016q3)| quarter_2 == tq(2016q4))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*public vs foreign 3 after
use "Stata/Merged/bank_vars.dta", clear
keep if (type_bank == 1 |type_bank == 3)
gen treat = 1 if type_bank == 3
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2016q3)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2016q3)| quarter_2 == tq(2016q4))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*private vs foreign 4 after
use "Stata/Merged/bank_vars.dta", clear
keep if (type_bank == 1 |type_bank == 2)
gen treat = 1 if type_bank == 2
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2016q3)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2016q3)| quarter_2 == tq(2016q4) |quarter_2 == tq(2017q1))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)
*public vs foreign 4 after
use "Stata/Merged/bank_vars.dta", clear
keep if (type_bank == 1 |type_bank == 3)
gen treat = 1 if type_bank == 3
replace treat = 0 if treat ==.
gen after = 1 if quarter_2 > tq(2016q3)
replace after = 0 if after ==.
drop if (quarter_2 == tq(2016q3)| quarter_2 == tq(2016q4) |quarter_2 == tq(2017q1))
diff gnpa_ratio, t(treat) p(after) robust
diff gnpa_ratio , t(treat) p(after) robust cov(total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy)
diff gnpa_ratio , t(treat) p(after) robust cov(npri_dummy mse_dummy ///
total_liabilities)
diff gnpa_ratio , t(treat) p(after) robust cov(trans_dummy energy_dummy ///
water_dummy comm_dummy total_liabilities)

*event study
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)

eventdd gnpa_ratio, timevar(time_to_event) cluster(banks)

eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
retail_dummy, timevar(time_to_event) cluster(banks)

eventdd gnpa_ratio npri_dummy mse_dummy total_liabilities, ///
timevar(time_to_event) cluster(banks)

eventdd gnpa_ratio trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks)

eventdd gnpa_ratio total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks)

eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
retail_dummy npri_dummy mse_dummy  trans_dummy energy_dummy water_dummy ///
comm_dummy state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f i.bank_num, timevar(time_to_event) cluster(banks)

eventdd gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 ///
retail_dummy2 onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
leads(15) lags(12) keepbal(banks) ///
coef_op(g1(color(gs10) msize(small)) g2(color(blue) msize(small)) g3(color(ebblue) msize(small))) ///
ci(rcap, g1(color(gs10)) g2(color(blue)) g3(color(ebblue))) ///
graph_op(ytitle("Coefficients") title("Event Study With All Controls") xtitle("Quarters to Event") ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks") lab(3 "95% CI Private Banks") lab(4 "Private Banks") ///
lab(5 "95% CI Public Banks") lab(6 "Public Banks")))  

eventdd gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 ///
retail_dummy2 onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
leads(15) lags(12) keepbal(banks) ///
coef_op(g1(color(gs10) ms(Oh)) g2(color(blue) ms(Oh)) g3(color(ebblue) ms(Oh))) ///
ci(rarea, g1(color(gs10%30)) g2(color(blue%30)) g3(color(ebblue%30))) ///
graph_op(ytitle("Coefficients") title("Event Study With All Controls") xtitle("Quarters to Event") ///
legend(order(2 1 4 3 6 5) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks") lab(3 "95% CI Private Banks") lab(4 "Private Banks") ///
lab(5 "95% CI Public Banks") lab(6 "Public Banks")))  

*Foreign banks
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if type_bank == 1

eventdd gnpa_ratio total_liabilities, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Size Controls") xtitle("Quarters to Event") ///
yscale(r(-5 5)) ytick(-5(3)5) ylabel(-5(3)5) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/for_event.jpg", replace

// eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
// retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
// water_dummy comm_dummy state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f i.bank_num, timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
// saving("Graphs/gph/for_all_event", replace))
// graph set window fontface "Arial"
// graph export "Graphs/jpg/for_all_event.jpg", replace

eventdd gnpa_ratio fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Sector Controls") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

eventdd gnpa_ratio npri_dummy2 mse_dummy2 opri_dummy2, ///
timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Priority Controls") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

eventdd gnpa_ratio trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2, ///
timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Infra Controls") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

eventdd gnpa_ratio state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Region Controls") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) ///
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
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
yscale(r(-17 10)) ytick(-17(5)10) ylabel(-17(5)10) ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_all_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_all_event_2.jpg", replace

eventdd gnpa_ratio,timevar(time_to_event) cluster(banks) method(hdfe, absorb(banks)) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Event Study With Fixed Effects") xtitle("Quarters to Event") ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

eventdd gnpa_to_gadv total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") subtitle("Figure1: Demonetization Foreign Banks Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-17 10)) ytick(-17(5)10) ylabel(-17(5)10) ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_event_poster", replace))
graph set window fontface "Helvetica Neue"
graph export "Graphs/jpg/for_event_poster.pdf", replace

// eventdd gnpa_ratio total_liabilities fc_dummy3 agri_dummy3 ind_dummy3 ///
// serv_dummy3 retail_dummy3 onfc_dummy3 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 ///
// energy_dummy2 water_dummy2 comm_dummy2 soc_comm_dummy2 in_agri_dummy ///
// in_mining_dummy in_manu_dummy in_const_dummy in_serv_dummy, ///
// timevar(time_to_event) cluster(banks) ///
// coef_op(color(green)) ci(rcap, color(green)) ///
// graph_op(ytitle("Coefficients") title("All Controls Foreign Banks Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

*Foreign vs Private
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if (type_bank == 1|type_bank ==2)

gen treat = 1 if type_bank == 2 & quarter_2 > tq(2016q4)
replace treat = 0 if treat ==.

xtdidregress (gnpa_ratio total_liabilities ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f) (treat), group(type_bank) time(quarter_2) vce(robust)
// estat grangerplot
// etable
// estat ptrends
// estat trendplots
// estat granger

xtreg gnpa_ratio treat i.quarter_2#treat total_liabilities, vce(robust)

gen after = 1 if quarter_2 >= tq(2016q4)
replace after = 0 if after ==.
replace treat = 1 if type_bank == 2
replace treat = 0 if type_bank == 1
gen treatxafter = treat * after

reg gnpa_ratio treat after treatxafter total_liabilities, vce(robust) noconstant

use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if (type_bank == 1|type_bank ==2)

gen treat = tq(2016q4) if type_bank == 2 
replace treat = 0 if treat ==.
egen bank_num_2 = group(banks)

csdid gnpa_ratio total_liabilities, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(227)

csdid gnpa_ratio total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(227)

csdid gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 ///
serv_dummy2 retail_dummy2, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(227)

csdid gnpa_ratio total_liabilities trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(227)

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
csdid_plot, group(227)

// eventdd gnpa_ratio, timevar(time_to_event) cluster(banks) over(type_bank) ///
// graph_op(ytitle("Coefficients") title("Base Event Study"))
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
// eventdd gnpa_ratio in_agri_dummy in_mining_dummy in_manu_dummy ///
// in_const_dummy in_serv_dummy, timevar(time_to_event) cluster(banks) ///
// over(type_bank)
//
// eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
// retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
// water_dummy comm_dummy in_agri_dummy in_mining_dummy in_manu_dummy ///
// in_const_dummy in_serv_dummy, timevar(time_to_event) cluster(banks) over(type_bank)

*Foreign vs Public
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if (type_bank == 1|type_bank ==3)

gen treat = 1 if type_bank == 3 & quarter_2 >= tq(2016q4)
replace treat = 0 if treat ==.

xtdidregress (gnpa_ratio total_liabilities ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f) (treat), group(type_bank) time(quarter_2) vce(robust)
// estat grangerplot
// estat ptrends
// estat trendplots

xtreg gnpa_ratio treat i.quarter_2#treat total_liabilities, vce(robust)

gen after = 1 if quarter_2 >= tq(2016q4)
replace after = 0 if after ==.

reg gnpa_ratio treat after treat#after total_liabilities, vce(robust) noconstant

use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if (type_bank == 1|type_bank ==3)

gen treat = tq(2016q4) if type_bank == 3
replace treat = 0 if treat ==.
egen bank_num_2 = group(banks)

csdid gnpa_ratio total_liabilities, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(227)

csdid gnpa_ratio total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(227)

csdid gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 ///
serv_dummy2 retail_dummy2, i.var(bank_num_2) time(quarter_2) gvar(treat)
csdid_plot, group(227)

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
csdid_plot, group(227)

*Private vs Public
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if (type_bank == 2|type_bank ==3)

eventdd gnpa_ratio total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
yscale(r(-9 7)) ytick(-9(3)7) ylabel(-9(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/base_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/base_event.jpg", replace

eventdd gnpa_ratio fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Sectoral Event Study") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/sectoral_cont_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/sectoral_cont_event.jpg", replace

eventdd gnpa_ratio npri_dummy2 mse_dummy2 opri_dummy2, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Priority Event Study") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/pri_cont_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/pri_cont_event.jpg", replace

eventdd gnpa_ratio trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Infrastructure Event Study") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/infra_cont_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/infra_cont_event.jpg", replace

eventdd gnpa_ratio state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank) coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Regional Event Study") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/region_cont_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/region_cont_event.jpg", replace

eventdd gnpa_ratio total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
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
yscale(r(-9 7)) ytick(-9(3)7) ylabel(-9(3)7) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/all_cont_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/all_cont_event_2.jpg", replace

eventdd gnpa_to_gadv total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
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
graph_op(ytitle("Coefficients") subtitle("Figure2: Demonetization Private & Public Banks Event Study With Controls") xtitle("Quarters to Event") ///
yscale(r(-9 7)) ytick(-9(3)7) ylabel(-9(3)7) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) ///
saving("Graphs/gph/all_cont_event_post", replace))
graph set window fontface "Helvetica Neue"
graph export "Graphs/jpg/all_cont_event_post.pdf", replace

// eventdd gnpa_ratio total_liabilities fc_dummy3 agri_dummy3 ind_dummy3 ///
// serv_dummy3 retail_dummy3 onfc_dummy3 npri_dummy2 mse_dummy2 opri_dummy2 trans_dummy2 ///
// energy_dummy2 water_dummy2 comm_dummy2 soc_comm_dummy2 in_agri_dummy ///
// in_mining_dummy in_manu_dummy in_const_dummy in_serv_dummy, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("All Controls Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Foreign vs Public
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if (type_bank == 1|type_bank ==3)

eventdd gnpa_ratio, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd gnpa_ratio total_liabilities agri_dummy ///
ind_dummy serv_dummy retail_dummy fc_dummy, ///
timevar(time_to_event) cluster(banks) over(type_bank)

eventdd gnpa_ratio npri_dummy mse_dummy total_liabilities, ///
timevar(time_to_event) cluster(banks) over(type_bank)

eventdd gnpa_ratio trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd gnpa_ratio state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank)

eventdd gnpa_ratio total_liabilities agri_dummy ind_dummy serv_dummy ///
retail_dummy fc_dummy npri_dummy mse_dummy trans_dummy energy_dummy ///
water_dummy comm_dummy state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank)
*Priority/non-prioity
*Foreign vs Private
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if (type_bank == 1|type_bank ==2)

eventdd npri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank)

eventdd mse_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank)

eventdd opri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank)

*Foreign vs Public
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if (type_bank == 1|type_bank ==3)

eventdd npri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank)

eventdd mse_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank)

eventdd opri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank)

*Foreign
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if type_bank == 1

eventdd npri_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
yscale(r(-10 5)) ytick(-10(3)5) ylabel(-10(3)5) ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_npri", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_npri.jpg", replace

eventdd mse_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
yscale(r(-2 2)) ytick(-2(1)2) ylabel(-2(1)2) ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_mse", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_mse.jpg", replace

eventdd opri_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
yscale(r(-2 2)) ytick(-2(1)2) ylabel(-2(1)2) ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_opri", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_opri.jpg", replace


*Private vs Public
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if (type_bank == 2|type_bank ==3)

eventdd npri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd npri_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank) 

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
graph_op(ytitle("Coefficients") title("Non-Priority Sector GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/npri_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/npri_event.jpg", replace

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
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) /// 
saving("Graphs/gph/npri_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/npri_event_2.jpg", replace

eventdd non_priority_gnpa_ratio total_liabilities ind_dummy2 serv_dummy2 retail_dummy2 ///
onfc_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Non-Priority Sector GNPAs") xtitle("Quarters to Event") ///
yscale(r(-7 5)) ytick(-7(3)5) ylabel(-7(3)5) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd mse_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd mse_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank)

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
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/mse_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/mse_event.jpg", replace

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
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/mse_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/mse_event_2.jpg", replace

eventdd mse_gnpa_ratio trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Medium & Small Enterprises GNPAs") xtitle("Quarters to Event") ///
graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd opri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd opri_gnpa_rat state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) ///
cluster(banks) over(type_bank)

eventdd opri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
over(type_bank)

eventdd opri_gnpa_rat total_liabilities fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 ///
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
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/opri_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/opri_event_2.jpg", replace

eventdd other_priority_gnpa_ratio trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Medium & Small Enterprises GNPAs") xtitle("Quarters to Event") ///
graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Sector
*Foreign vs Private
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen food_gnpa_rat = food_cred_gnpa/total_assets * 100
gen agri_gnpa_rat = agri_gnpa/total_assets * 100
gen ind_gnpa_rat = ind_gnpa/total_assets * 100
gen serv_gnpa_rat = serv_gnpa/total_assets * 100
gen retail_gnpa_rat = retail_gnpa/total_assets * 100
gen onfc_gnpa_rat = onfc_gnpa/total_assets * 100
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
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen food_gnpa_rat = food_cred_gnpa/total_assets * 100
gen agri_gnpa_rat = agri_gnpa/total_assets * 100
gen ind_gnpa_rat = ind_gnpa/total_assets * 100
gen serv_gnpa_rat = serv_gnpa/total_assets * 100
gen retail_gnpa_rat = retail_gnpa/total_assets * 100
gen onfc_gnpa_rat = onfc_gnpa/total_assets * 100
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

*Foreign
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen food_gnpa_rat = food_cred_gnpa/total_assets * 100
gen agri_gnpa_rat = agri_gnpa/total_assets * 100
gen ind_gnpa_rat = ind_gnpa/total_assets * 100
gen serv_gnpa_rat = serv_gnpa/total_assets * 100
gen retail_gnpa_rat = retail_gnpa/total_assets * 100
gen onfc_gnpa_rat = onfc_gnpa/total_assets * 100
keep if type_bank == 1

eventdd agri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_agri", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_agri.jpg", replace

eventdd ind_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_ind", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_ind.jpg", replace

eventdd serv_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_serv", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_serv.jpg", replace

eventdd retail_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_retail", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_retail.jpg", replace

eventdd onfc_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") xtitle("Quarters to Event") ///
legend(pos(6) col(2) order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")) ///
saving("Graphs/gph/for_onfc", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_onfc.jpg", replace

*Private vs Public
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen food_gnpa_rat = food_cred_gnpa/total_assets * 100
gen agri_gnpa_rat = agri_gnpa/total_assets * 100
gen ind_gnpa_rat = ind_gnpa/total_assets * 100
gen serv_gnpa_rat = serv_gnpa/total_assets * 100
gen retail_gnpa_rat = retail_gnpa/total_assets * 100
gen onfc_gnpa_rat = onfc_gnpa/total_assets * 100
keep if (type_bank == 2| type_bank == 3)

eventdd food_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd food_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd food_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd agri_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd agri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd agri_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Agriculture GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/agri_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/agri_event.jpg", replace

eventdd agri_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
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
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/agri_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/agri_event_2.jpg", replace

eventdd agri_gnpa_ratio total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Agriculture GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd ind_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd ind_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd ind_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Industry GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/ind_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/ind_event.jpg", replace

eventdd ind_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
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
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/ind_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/ind_event_2.jpg", replace

eventdd ind_gnpa_ratio total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Industry GNPAs") xtitle("Quarters to Event") ///
graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd serv_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd serv_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities , timevar(time_to_event) cluster(banks) over(type_bank)

eventdd serv_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy soc_comm_dummy2 ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy opri_dummy, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Services GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/serv_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/serv_event.jpg", replace

eventdd serv_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
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
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/serv_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/serv_event_2.jpg", replace

eventdd serv_gnpa_ratio total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Services GNPAs") xtitle("Quarters to Event") ///
graphregion(fcolor("245 242 238")) ///
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd retail_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd retail_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd retail_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Retail GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/retail_event", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/retail_event.jpg", replace

eventdd retail_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
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
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/retail_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/retail_event_2.jpg", replace

eventdd retail_gnpa_ratio total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Retail GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd onfc_gnpa_rat, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat trans_dummy energy_dummy water_dummy comm_dummy ///
total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f npri_dummy mse_dummy, timevar(time_to_event) cluster(banks) over(type_bank)

eventdd onfc_gnpa_rat total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
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
legend(pos(6) col(2) order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/onfc_event_2", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/onfc_event_2.jpg", replace

eventdd onfc_gnpa_ratio total_liabilities npri_dummy2 mse_dummy2 ///
opri_dummy2 trans_dummy2 energy_dummy2 water_dummy2 ///
comm_dummy2 soc_comm_dummy2 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank)

*All 3
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen food_gnpa_rat = food_cred_gnpa/total_assets * 100
gen agri_gnpa_rat = agri_gnpa/total_assets * 100
gen ind_gnpa_rat = ind_gnpa/total_assets * 100
gen serv_gnpa_rat = serv_gnpa/total_assets * 100
gen retail_gnpa_rat = retail_gnpa/total_assets * 100
gen onfc_gnpa_rat = onfc_gnpa/total_assets * 100

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
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen house_gnpa_rat = house_gnpa/total_assets * 100
gen auto_gnpa_rat = auto_gnpa/total_assets * 100
gen cred_gnpa_rat = cred_gnpa/total_assets * 100
gen edu_gnpa_rat = edu_gnpa/total_assets * 100
gen oretail_gnpa_rat = oretail_gnpa/total_assets * 100
keep if (type_bank == 2| type_bank == 3)

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
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("House GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

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
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Auto GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

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
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Credit GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

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
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Education GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

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
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Other Retail GNPAs") xtitle("Quarters to Event") ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Bank group wise credit over time
use "Stata/Merged/bank_vars.dta", clear
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

*Profitability
// use "Stata/Merged/bank_vars.dta", clear
// gen q1_dummy = 1 if (quarter_2 == tq(2013q1) | quarter_2 == tq(2014q1) | quarter_2 == tq(2015q1) | /// 
// quarter_2 == tq(2016q1) | quarter_2 == tq(2017q1) | quarter_2 == tq(2018q1) | quarter_2 == tq(2019q1))
// replace q1_dummy = 0 if q1_dummy ==.
//
// gen q2_dummy = 1 if (quarter_2 == tq(2012q2) | quarter_2 == tq(2013q2) | quarter_2 == tq(2014q2) | quarter_2 == tq(2015q2) | /// 
// quarter_2 == tq(2016q2) | quarter_2 == tq(2017q2) | quarter_2 == tq(2018q2) | quarter_2 == tq(2019q2))
// replace q2_dummy = 0 if q2_dummy ==.
//
// gen q3_dummy = 1 if (quarter_2 == tq(2012q3) | quarter_2 == tq(2013q3) | quarter_2 == tq(2014q3) | quarter_2 == tq(2015q3) | /// 
// quarter_2 == tq(2016q3) | quarter_2 == tq(2017q3) | quarter_2 == tq(2018q3) | quarter_2 == tq(2019q3))
// replace q3_dummy = 0 if q3_dummy ==.
//
// gen q4_dummy = 1 if (quarter_2 == tq(2012q4) | quarter_2 == tq(2013q4) | quarter_2 == tq(2014q4) | quarter_2 == tq(2015q4) | /// 
// quarter_2 == tq(2016q4) | quarter_2 == tq(2017q4) | quarter_2 == tq(2018q4) | quarter_2 == tq(2019q4))
// replace q4_dummy = 0 if q4_dummy ==.
//
// reg pat_ratio q1_dummy q2_dummy q3_dummy
// predict residuals, resid 
// collapse (mean) residuals, by(type_bank quarter_2)
// egen type_num = group(type_bank)
// xtset type_num quarter_2
// xtline residuals, overlay xline(227) ytitle("Resid") ///
// xtitle("Quarter") title("Resid") ///
// legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
// lab(3 "Public Banks"))
//
// *PAT
// *Foreign Banks
// *Quarter Dummies, wait times on loans, productivity after, bank accounts opening, money stock seasonal
// use "Stata/Merged/bank_vars.dta", clear
// gen time_to_event = quarter_2 - tq(2016q4)
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
// *Private vs Public
// use "Stata/Merged/bank_vars.dta", clear
// gen time_to_event = quarter_2 - tq(2016q4)
// keep if (type_bank == 2|type_bank ==3)
//
// eventdd pat_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd pat_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Sectoral Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd pat_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Priority Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd pat_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Infrastructure Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd pat_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
// over(type_bank) coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Regional Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
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
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// *PBT
// *Foreign Banks
// use "Stata/Merged/bank_vars.dta", clear
// gen time_to_event = quarter_2 - tq(2016q4)
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
// *Private vs Public
// use "Stata/Merged/bank_vars.dta", clear
// gen time_to_event = quarter_2 - tq(2016q4)
// keep if (type_bank == 2|type_bank ==3)
//
// eventdd pbt_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd pbt_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Sectoral Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd pbt_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Priority Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd pbt_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Infrastructure Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd pbt_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
// over(type_bank) coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Regional Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
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
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// *EBPT
// *Foreign Banks
// use "Stata/Merged/bank_vars.dta", clear
// gen time_to_event = quarter_2 - tq(2016q4)
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
// *Private vs Public
// use "Stata/Merged/bank_vars.dta", clear
// gen time_to_event = quarter_2 - tq(2016q4)
// keep if (type_bank == 2|type_bank ==3)
//
// eventdd ebpt_ratio_2 total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd ebpt_ratio_2 fc_dummy2 agri_dummy2 ind_dummy2 serv_dummy2 retail_dummy2 onfc_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Sectoral Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd ebpt_ratio_2 npri_dummy2 mse_dummy2 opri_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Priority Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd ebpt_ratio_2 trans_dummy2 energy_dummy2 water_dummy2 ///
// comm_dummy2 soc_comm_dummy2, ///
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Infrastructure Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
//
// eventdd ebpt_ratio_2 state_dummy1_f state_dummy2_f state_dummy3_f ///
// state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
// state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
// state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
// state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
// state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
// state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
// state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) ///
// over(type_bank) coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Regional Event Study") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))
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
// timevar(time_to_event) cluster(banks) over(type_bank) ///
// coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
// graph_op(ytitle("Coefficients") title("Event Study With Controls") xtitle("Quarters to Event") ///
// legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
// lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Sector Interactions
*227 event time
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)

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

coefplot F, keep(*.quarter_2#*.fc_dummy2) xline(7.5) yline(0) vertical

coefplot Pv Pb, keep(*.quarter_2#*.fc_dummy2) xline(17.5) yline(0) vertical

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

use "Stata/Merged/bank_vars.dta", clear
drop if no_branches_2 ==.
bysort type_bank: egen med_branch = mean(no_branches_2)

*Foreign 9.25
*Private 1534.125
*Public 4191.381

use "Stata/Merged/bank_vars.dta", clear
bysort type_bank quarter_2: egen mean_gnpa_rat = mean(gnpa_ratio)
keep if quarter_2 == tq(2016q3)

*Foreign 2.33%
*Private 2.16%
*Public 7.61%

log close
