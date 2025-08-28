cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Estimation/estimation_robust_cov.log", replace
drop _all
*Liberal
*Foreign Banks
use "Stata/Merged Cov/bank_vars_all_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1 |type_bank == 4)
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
saving("Graphs/gph/for_event_lib_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_event_lib_cov.jpg", replace


*Private vs Public
use "Stata/Merged Cov/bank_vars_all_cov.dta", clear
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
saving("Graphs/gph/all_event_lib_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/all_event_lib_cov.jpg", replace

*Priority/Non-Priority
*Foreign vs Small Finance
use "Stata/Merged Cov/bank_vars_all_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets
gen mse_gnpa_rat = mse_gnpa/total_assets
gen opri_gnpa_rat = other_priority_gnpa/total_assets
keep if (type_bank == 1|type_bank ==4)
drop if quarter_2 < tq(2016q4)

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
saving("Graphs/gph/for_npri_lib_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_npri_lib_cov.jpg", replace

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
saving("Graphs/gph/for_mse_lib_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_mse_lib_cov.jpg", replace

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
saving("Graphs/gph/for_opri_lib_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_opri_lib_cov.jpg", replace

*Private vs Public
use "Stata/Merged Cov/bank_vars_all_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if (type_bank == 2|type_bank ==3)
drop if quarter_2 < tq(2016q4)

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
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/npri_event_lib_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/npri_event_lib_cov.jpg", replace

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
saving("Graphs/gph/mse_event_lib_2_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/mse_event_lib_2_cov.jpg", replace

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
saving("Graphs/gph/opri_event_2_lib_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/opri_event_2_lib_cov.jpg", replace

*All 4
use "Stata/Merged Cov/bank_vars_all_cov.dta", clear
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

*Strict
*Foreign Banks
use "Stata/Merged Cov/bank_vars_strict_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
keep if (type_bank == 1 |type_bank == 4)
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
saving("Graphs/gph/for_event_str_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_event_str_cov.jpg", replace

*Private vs Public
use "Stata/Merged Cov/bank_vars_strict_cov.dta", clear
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
saving("Graphs/gph/all_event_str_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/all_event_str_cov.jpg", replace

*Priority/Non-Priority
*Foreign vs Small Finance
use "Stata/Merged Cov/bank_vars_strict_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets
gen mse_gnpa_rat = mse_gnpa/total_assets
gen opri_gnpa_rat = other_priority_gnpa/total_assets
keep if (type_bank == 1|type_bank ==4)
drop if quarter_2 < tq(2016q4)

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
saving("Graphs/gph/for_npri_str_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_npri_str_cov.jpg", replace

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
saving("Graphs/gph/for_mse_str_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_mse_str_cov.jpg", replace

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
saving("Graphs/gph/for_opri_str_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/for_opri_str_cov.jpg", replace

*Private vs Public
use "Stata/Merged Cov/bank_vars_strict_cov.dta", clear
gen time_to_event = quarter_2 - tq(2020q2)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if (type_bank == 2|type_bank ==3)
drop if quarter_2 < tq(2016q4)

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
lab(3 "95% CI Public Banks") lab(4 "Public Banks")) saving("Graphs/gph/npri_event_str_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/npri_event_str_cov.jpg", replace

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
saving("Graphs/gph/mse_event_str_2_cov", replace))
graph set window fontface "Arial"
graph export "Graphs/jpg/mse_event_str_2_cov.jpg", replace

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
saving("Graphs/gph/opri_event_2_str_cov", replace))
graph set window fontface "Times New Roman"
graph export "Graphs/jpg/opri_event_2_str_cov.jpg", replace

*All 4
use "Stata/Merged Cov/bank_vars_strict_cov.dta", clear
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

log close
