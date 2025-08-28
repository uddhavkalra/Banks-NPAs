cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Estimation/estimation_2.log", replace
drop _all

*Foreign banks
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if type_bank == 1

eventdd gnpa_ratio total_liabilities, timevar(time_to_event) cluster(banks) ///
coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Base Event Study") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Foreign Banks")))

*Sector
eventdd gnpa_ratio total_liabilities ind_dummy3 serv_dummy3 retail_dummy3 onfc_dummy3, ///
timevar(time_to_event) cluster(banks) coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Sec Control Event Study") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Private Banks")))

*Priority
eventdd gnpa_ratio total_liabilities npri_dummy3 mse_dummy3 opri_dummy3, ///
timevar(time_to_event) cluster(banks) coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Pri Control Event Study") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Private Banks")))

*Infrastructure
eventdd gnpa_ratio total_liabilities trans_dummy3 energy_dummy3 water_dummy3 ///
comm_dummy3 soc_comm_dummy3, timevar(time_to_event) cluster(banks) coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Infra Control Event Study") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Private Banks")))

*Region
eventdd gnpa_ratio total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks Region Control Event Study") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Private Banks")))

*All controls except region and infra
eventdd gnpa_ratio total_liabilities ind_dummy3 serv_dummy3 retail_dummy3 ///
onfc_dummy3 npri_dummy3 mse_dummy3 opri_dummy3, timevar(time_to_event) cluster(banks) coef_op(color(green)) ci(rcap, color(green)) ///
graph_op(ytitle("Coefficients") title("Foreign Banks All Control Event Study") xtitle("Quarters to Event") ///
yscale(r(-17 7)) ytick(-17(3)7) ylabel(-17(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1) lab(1 "95% CI Foreign Banks") lab(2 "Private Banks")))

*Private vs Public
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
keep if (type_bank == 2|type_bank ==3)

eventdd gnpa_ratio total_liabilities, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Base Event Study") xtitle("Quarters to Event") ///
yscale(r(-9 7)) ytick(-9(3)7) ylabel(-9(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Sector
eventdd gnpa_ratio total_liabilities ind_dummy3 serv_dummy3 retail_dummy3 onfc_dummy3, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Sec Event Study") xtitle("Quarters to Event") ///
yscale(r(-9 7)) ytick(-9(3)7) ylabel(-9(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Priority
eventdd gnpa_ratio total_liabilities npri_dummy3 mse_dummy3 opri_dummy3, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Pri Event Study") xtitle("Quarters to Event") ///
yscale(r(-9 7)) ytick(-9(3)7) ylabel(-9(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Infrastructure
eventdd gnpa_ratio total_liabilities trans_dummy3 energy_dummy3 water_dummy3 ///
comm_dummy3 soc_comm_dummy3, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Infra Event Study") xtitle("Quarters to Event") ///
yscale(r(-9 7)) ytick(-9(3)7) ylabel(-9(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Region
eventdd gnpa_ratio total_liabilities state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Region Event Study") xtitle("Quarters to Event") ///
yscale(r(-9 7)) ytick(-9(3)7) ylabel(-9(3)7) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*All
eventdd gnpa_ratio total_liabilities ind_dummy3 serv_dummy3 retail_dummy3 ///
onfc_dummy3 npri_dummy3 mse_dummy3 opri_dummy3 trans_dummy3 energy_dummy3 water_dummy3 ///
comm_dummy3 soc_comm_dummy3 state_dummy1_f state_dummy2_f state_dummy3_f ///
state_dummy4_f state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f ///
state_dummy9_f state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Region Event Study") xtitle("Quarters to Event") ///
yscale(r(-9 18)) ytick(-9(3)18) ylabel(-9(3)18) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Priority/Non-Priority
use "Stata/Merged/bank_vars.dta", clear
gen time_to_event = quarter_2 - tq(2016q4)
gen npri_gnpa_rat = non_priority_gnpa/total_assets * 100
gen mse_gnpa_rat = mse_gnpa/total_assets * 100
gen opri_gnpa_rat = other_priority_gnpa/total_assets * 100
keep if (type_bank == 2|type_bank ==3)

eventdd npri_gnpa_rat total_liabilities ind_dummy3 serv_dummy3 retail_dummy3 ///
onfc_dummy3 trans_dummy3 energy_dummy3 water_dummy3 comm_dummy3 soc_comm_dummy3 ///
state_dummy1_f state_dummy2_f state_dummy3_f state_dummy4_f state_dummy5_f ///
state_dummy6_f state_dummy7_f state_dummy8_f state_dummy9_f state_dummy10_f ///
state_dummy11_f state_dummy12_f state_dummy13_f ///
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

eventdd mse_gnpa_rat total_liabilities ind_dummy3 serv_dummy3 retail_dummy3 ///
onfc_dummy3 trans_dummy3 energy_dummy3 water_dummy3 comm_dummy3 soc_comm_dummy3 ///
state_dummy1_f state_dummy2_f state_dummy3_f state_dummy4_f state_dummy5_f ///
state_dummy6_f state_dummy7_f state_dummy8_f state_dummy9_f state_dummy10_f ///
state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("MSE GNPAs") xtitle("Quarters to Event") ///
yscale(r(-2 2)) ytick(-2(1)2) ylabel(-2(1)2) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd opri_gnpa_rat total_liabilities ind_dummy3 serv_dummy3 retail_dummy3 ///
onfc_dummy3 trans_dummy3 energy_dummy3 water_dummy3 comm_dummy3 soc_comm_dummy3 ///
state_dummy1_f state_dummy2_f state_dummy3_f state_dummy4_f state_dummy5_f ///
state_dummy6_f state_dummy7_f state_dummy8_f state_dummy9_f state_dummy10_f ///
state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Other Priority GNPAs") xtitle("Quarters to Event") ///
yscale(r(-2 2)) ytick(-2(1)2) ylabel(-2(1)2) graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

*Sector
use "Stata/Merged/bank_vars.dta", clear 
gen time_to_event = quarter_2 - tq(2016q4)
gen food_gnpa_rat = food_cred_gnpa/total_assets * 100
gen agri_gnpa_rat = agri_gnpa/total_assets * 100
gen ind_gnpa_rat = ind_gnpa/total_assets * 100
gen serv_gnpa_rat = serv_gnpa/total_assets * 100
gen retail_gnpa_rat = retail_gnpa/total_assets * 100
gen onfc_gnpa_rat = onfc_gnpa/total_assets * 100
keep if (type_bank == 2| type_bank == 3)

eventdd agri_gnpa_rat total_liabilities npri_dummy3 mse_dummy3 opri_dummy3 ///
trans_dummy3 energy_dummy3 water_dummy3 comm_dummy3 soc_comm_dummy3 ///
state_dummy1_f state_dummy2_f state_dummy3_f state_dummy4_f state_dummy5_f ///
state_dummy6_f state_dummy7_f state_dummy8_f state_dummy9_f state_dummy10_f ///
state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Agriculture GNPAs") xtitle("Quarters to Event") ///
graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd ind_gnpa_rat total_liabilities npri_dummy3 mse_dummy3 opri_dummy3 ///
trans_dummy3 energy_dummy3 water_dummy3 comm_dummy3 soc_comm_dummy3 ///
state_dummy1_f state_dummy2_f state_dummy3_f state_dummy4_f state_dummy5_f ///
state_dummy6_f state_dummy7_f state_dummy8_f state_dummy9_f state_dummy10_f ///
state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Agriculture GNPAs") xtitle("Quarters to Event") ///
graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd serv_gnpa_rat total_liabilities npri_dummy3 mse_dummy3 opri_dummy3 ///
trans_dummy3 energy_dummy3 water_dummy3 comm_dummy3 soc_comm_dummy3 ///
state_dummy1_f state_dummy2_f state_dummy3_f state_dummy4_f state_dummy5_f ///
state_dummy6_f state_dummy7_f state_dummy8_f state_dummy9_f state_dummy10_f ///
state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Agriculture GNPAs") xtitle("Quarters to Event") ///
graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

eventdd retail_gnpa_rat total_liabilities npri_dummy3 mse_dummy3 opri_dummy3 ///
trans_dummy3 energy_dummy3 water_dummy3 comm_dummy3 soc_comm_dummy3 ///
state_dummy1_f state_dummy2_f state_dummy3_f state_dummy4_f state_dummy5_f ///
state_dummy6_f state_dummy7_f state_dummy8_f state_dummy9_f state_dummy10_f ///
state_dummy11_f state_dummy12_f state_dummy13_f ///
state_dummy14_f state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f ///
state_dummy19_f state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f ///
state_dummy24_f state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f ///
state_dummy29_f state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f ///
state_dummy34_f state_dummy35_f, ///
timevar(time_to_event) cluster(banks) over(type_bank) ///
coef_op(g1(color(blue)) g2(color(red))) ci(rcap, g1(color(blue)) g2(color(red))) ///
graph_op(ytitle("Coefficients") title("Demonetization Agriculture GNPAs") xtitle("Quarters to Event") ///
graphregion(fcolor("245 242 238")) ///
legend(order(2 1 4 3) lab(1 "95% CI Private Banks") lab(2 "Private Banks") ///
lab(3 "95% CI Public Banks") lab(4 "Public Banks")))

log close
