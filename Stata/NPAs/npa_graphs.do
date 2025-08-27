cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/NPAs/npa_graph.log", replace 
drop _all
use "Stata/Merged/bank_vars.dta", clear
*gnpas in millions
gen gnpa_mil = gross_npas/1000000
drop if banks == "DENA BANK" & quarter_2 == tq(2012q2)
*Plotting
collapse (mean) gnpa_mil, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline gnpa_mil, overlay xline(227) ytitle("Mean Gross NPA in Rs Million") ///
xtitle("Quarter") title("Mean Gross NPA") legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/gnpa_avg_graph", replace) 
graph export "Graphs/jpg/gnpa_avg_graph.jpg", replace

use "Stata/Merged/bank_vars.dta", clear
*nnpas in millions
gen nnpa_mil = net_npas/1000000
drop if banks == "DENA BANK" & quarter_2 == tq(2012q2)
*Plotting
collapse (mean) nnpa_mil, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline nnpa_mil, overlay xline(227) ytitle("Rs Million") ///
xtitle("Quarter") title ("Mean Net NPAs") legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/nnpa_avg_graph", replace)
graph export "Graphs/jpg/nnpa_avg_graph.jpg", replace

use "Stata/Merged/bank_vars.dta", clear
*gnpas in millions
gen gnpa_mil = gross_npas/1000000
drop if banks == "DENA BANK" & quarter_2 == tq(2012q2)
*Plotting
collapse (sum) gnpa_mil, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline gnpa_mil, overlay xline(227) ytitle("Rs Million") ///
xtitle("Quarter") title("Gross NPA by bank group") ///
legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/gnpa_sum_graph", replace)
graph export "Graphs/jpg/gnpa_sum_graph.jpg", replace

use "Stata/Merged/bank_vars.dta", clear
*nnpas in millions
gen nnpa_mil = net_npas/1000000
drop if banks == "DENA BANK" & quarter_2 == tq(2012q2)
*Plotting
collapse (sum) nnpa_mil, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline nnpa_mil, overlay xline(227) ytitle("Sum Net NPA in Rs Million") ///
xtitle("Quarter") title("Net NPA by Bank Group") ///
legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/nnpa_sum_graph", replace)
graph export "Graphs/jpg/nnpa_sum_graph.jpg", replace

use "Stata/Merged/bank_vars.dta", clear
gen gnpa_assets_ratio = gross_npas/total_assets
drop if banks == "DENA BANK" & quarter_2 == tq(2012q2)
*Plotting
collapse (mean) gnpa_assets_ratio, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline gnpa_assets_ratio, overlay xline(227) ytitle("Fraction of GNPAs") ///
xtitle("Quarter") title("Gross NPA ratio") ///
legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/rat_gnpa_avg_graph", replace) 
graph export "Graphs/jpg/rat_gnpa_avg_graph.jpg", replace

use "Stata/Merged/bank_vars.dta", clear
gen nnpa_asset_ratio = net_npas/total_assets

drop if banks == "DENA BANK" & quarter_2 == tq(2012q2)
*Plotting
collapse (mean) nnpa_asset_ratio, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline nnpa_asset_ratio, overlay xline(227) ytitle("Fraction of NNPAs") ///
xtitle("Quarter") title("Net NPA ratio by Bank Group") ///
legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/rat_nnpa_avg_graph", replace) 
graph export "Graphs/jpg/rat_nnpa_avg_graph.jpg", replace

use "Stata/Merged/bank_vars.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
keep if public_dummy == 1
egen bank_num2 = group(banks)
tsset bank_num2 quarter_2
bysort quarter_2: egen pctile_variable_0 = min(gnpa_ratio)
bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_ratio), p(10)
bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_ratio), p(25)
bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_ratio), p(50)
bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_ratio), p(75)
bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_ratio), p(90)
bysort quarter_2: egen pctile_variable_100 = max(gnpa_ratio)
twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
       (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
       (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
       (line pctile_variable_50 quarter_2, lcolor(red)) ///
       (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
       (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
       legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
              label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
              label(6 "90th Percentile") label(7 "100th Percentile")) ///
       title("Time Series of Percentiles for Public Banks") ///
       graphregion(color(white)) legend(region(lc(none) fc(none))) ///
       xtitle("Quarter") ytitle("Percent") graphregion(fcolor("245 242 238")) ///
	   saving("Graphs/gph/pub_perc", replace) 
graph export "Graphs/jpg/pub_perc.jpg", replace
	   
use "Stata/Merged/bank_vars.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
keep if private_dummy == 1
egen bank_num2 = group(banks)
tsset bank_num2 quarter_2
bysort quarter_2: egen pctile_variable_0 = min(gnpa_ratio)
bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_ratio), p(10)
bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_ratio), p(25)
bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_ratio), p(50)
bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_ratio), p(75)
bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_ratio), p(90)
bysort quarter_2: egen pctile_variable_100 = max(gnpa_ratio)
twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
       (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
       (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
       (line pctile_variable_50 quarter_2, lcolor(red)) ///
       (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
       (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
       legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
              label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
              label(6 "90th Percentile") label(7 "100th Percentile")) ///
       title("Time Series of Percentiles for Private Banks") ///
       graphregion(color(white)) legend(region(lc(none) fc(none))) ///
       xtitle("Quarter") ytitle("Percent") graphregion(fcolor("245 242 238")) ///
	   saving("Graphs/gph/pri_perc", replace)
graph export "Graphs/jpg/pri_perc.jpg", replace

use "Stata/Merged/bank_vars.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
keep if foreign_dummy == 1
egen bank_num2 = group(banks)
tsset bank_num2 quarter_2
bysort quarter_2: egen pctile_variable_0 = min(gnpa_ratio)
bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_ratio), p(10)
bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_ratio), p(25)
bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_ratio), p(50)
bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_ratio), p(75)
bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_ratio), p(90)
bysort quarter_2: egen pctile_variable_100 = max(gnpa_ratio)
twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
       (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
       (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
       (line pctile_variable_50 quarter_2, lcolor(red)) ///
       (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
       (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
       legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
              label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
              label(6 "90th Percentile") label(7 "100th Percentile")) ///
       title("Time Series of Percentiles for Foreign Banks") ///
       graphregion(color(white)) legend(region(lc(none) fc(none))) ///
       xtitle("Quarter") ytitle("Percent") graphregion(fcolor("245 242 238")) ///
	   saving("Graphs/gph/for_perc", replace)
graph export "Graphs/jpg/for_perc.jpg", replace

// use "Stata/Merged/bank_vars.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
// keep if public_dummy == 1
// egen bank_num2 = group(banks)
// tsset bank_num2 quarter_2
// bysort quarter_2: egen pctile_variable_0 = min(gnpa_assets_ratio)
// bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_assets_ratio), p(10)
// bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_assets_ratio), p(25)
// bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_assets_ratio), p(50)
// bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_assets_ratio), p(75)
// bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_assets_ratio), p(90)
// bysort quarter_2: egen pctile_variable_100 = max(gnpa_assets_ratio)
// twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
//        (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
//        (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_50 quarter_2, lcolor(red)) ///
//        (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
// 	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
//        legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
//               label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
//               label(6 "90th Percentile") label(7 "100th Percentile")) ///
//        title("Time Series of Percentiles Public") ///
//        graphregion(color(white)) legend(region(lc(none) fc(none))) ///
//        xtitle("Quarter") ytitle("Ratio") ///
// 	   saving("Graphs/gph/pub_perc_all", replace) 
// graph export "Graphs/jpg/pub_perc_all.jpg", replace
//	   
// use "Stata/Merged/bank_vars.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
// keep if private_dummy == 1
// egen bank_num2 = group(banks)
// tsset bank_num2 quarter_2
// bysort quarter_2: egen pctile_variable_0 = min(gnpa_assets_ratio)
// bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_assets_ratio), p(10)
// bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_assets_ratio), p(25)
// bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_assets_ratio), p(50)
// bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_assets_ratio), p(75)
// bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_assets_ratio), p(90)
// bysort quarter_2: egen pctile_variable_100 = max(gnpa_assets_ratio)
// twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
//        (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
//        (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_50 quarter_2, lcolor(red)) ///
//        (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
// 	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
//        legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
//               label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
//               label(6 "90th Percentile") label(7 "100th Percentile")) ///
//        title("Time Series of Percentiles Private") ///
//        graphregion(color(white)) legend(region(lc(none) fc(none))) ///
//        xtitle("Quarter") ytitle("Ratio") ///
// 	   saving("Graphs/gph/pri_perc_all", replace)
// graph export "Graphs/jpg/pri_perc_all.jpg", replace
//
// use "Stata/Merged/bank_vars.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
// keep if foreign_dummy == 1
// egen bank_num2 = group(banks)
// tsset bank_num2 quarter_2
// bysort quarter_2: egen pctile_variable_0 = min(gnpa_assets_ratio)
// bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_assets_ratio), p(10)
// bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_assets_ratio), p(25)
// bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_assets_ratio), p(50)
// bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_assets_ratio), p(75)
// bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_assets_ratio), p(90)
// bysort quarter_2: egen pctile_variable_100 = max(gnpa_assets_ratio)
// twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
//        (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
//        (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_50 quarter_2, lcolor(red)) ///
//        (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
// 	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
//        legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
//               label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
//               label(6 "90th Percentile") label(7 "100th Percentile")) ///
//        title("Time Series of Percentiles Foreign") ///
//        graphregion(color(white)) legend(region(lc(none) fc(none))) ///
//        xtitle("Quarter") ytitle("Ratio") ///
// 	   saving("Graphs/gph/for_perc_all", replace)
// graph export "Graphs/jpg/for_perc_all.jpg", replace
//
// use "Stata/Merged/bank_vars_strict.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
// keep if public_dummy == 1
// egen bank_num2 = group(banks)
// tsset bank_num2 quarter_2
// bysort quarter_2: egen pctile_variable_0 = min(gnpa_assets_ratio)
// bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_assets_ratio), p(10)
// bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_assets_ratio), p(25)
// bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_assets_ratio), p(50)
// bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_assets_ratio), p(75)
// bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_assets_ratio), p(90)
// bysort quarter_2: egen pctile_variable_100 = max(gnpa_assets_ratio)
// twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
//        (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
//        (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_50 quarter_2, lcolor(red)) ///
//        (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
// 	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
//        legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
//               label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
//               label(6 "90th Percentile") label(7 "100th Percentile")) ///
//        title("Time Series of Percentiles Public") ///
//        graphregion(color(white)) legend(region(lc(none) fc(none))) ///
//        xtitle("Quarter") ytitle("Ratio") ///
// 	   saving("Graphs/gph/pub_perc_strict", replace) 
// graph export "Graphs/jpg/pub_perc_strict.jpg", replace
//	   
// use "Stata/Merged/bank_vars_strict.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
// keep if private_dummy == 1
// egen bank_num2 = group(banks)
// tsset bank_num2 quarter_2
// bysort quarter_2: egen pctile_variable_0 = min(gnpa_assets_ratio)
// bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_assets_ratio), p(10)
// bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_assets_ratio), p(25)
// bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_assets_ratio), p(50)
// bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_assets_ratio), p(75)
// bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_assets_ratio), p(90)
// bysort quarter_2: egen pctile_variable_100 = max(gnpa_assets_ratio)
// twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
//        (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
//        (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_50 quarter_2, lcolor(red)) ///
//        (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
// 	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
//        legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
//               label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
//               label(6 "90th Percentile") label(7 "100th Percentile")) ///
//        title("Time Series of Percentiles Private") ///
//        graphregion(color(white)) legend(region(lc(none) fc(none))) ///
//        xtitle("Quarter") ytitle("Ratio") ///
// 	   saving("Graphs/gph/pri_perc_strict", replace)
// graph export "Graphs/jpg/pri_perc_strict.jpg", replace
//
// use "Stata/Merged/bank_vars_strict.dta", clear
// gen gnpa_assets_ratio = gross_npas/total_assets
// keep if foreign_dummy == 1
// egen bank_num2 = group(banks)
// tsset bank_num2 quarter_2
// bysort quarter_2: egen pctile_variable_0 = min(gnpa_assets_ratio)
// bysort quarter_2: egen pctile_variable_10 = pctile(gnpa_assets_ratio), p(10)
// bysort quarter_2: egen pctile_variable_25 = pctile(gnpa_assets_ratio), p(25)
// bysort quarter_2: egen pctile_variable_50 = pctile(gnpa_assets_ratio), p(50)
// bysort quarter_2: egen pctile_variable_75 = pctile(gnpa_assets_ratio), p(75)
// bysort quarter_2: egen pctile_variable_90 = pctile(gnpa_assets_ratio), p(90)
// bysort quarter_2: egen pctile_variable_100 = max(gnpa_assets_ratio)
// twoway (line pctile_variable_0 quarter_2, lcolor(purple)) ///
//        (line pctile_variable_10 quarter_2, lcolor(blue) lpattern(dash)) ///
//        (line pctile_variable_25 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_50 quarter_2, lcolor(red)) ///
//        (line pctile_variable_75 quarter_2, lcolor(green) lpattern(dash)) ///
//        (line pctile_variable_90 quarter_2, lcolor(blue) lpattern(dash)) ///
// 	   (line pctile_variable_100 quarter_2, lcolor(black)), ///
//        legend(label(1 "0th Percentile") label(2 "10th Percentile") label(3 "25th Percentile") ///
//               label(4 "50th Percentile (Median)") label(5 "75th Percentile") ///
//               label(6 "90th Percentile") label(7 "100th Percentile")) ///
//        title("Time Series of Percentiles Foreign") ///
//        graphregion(color(white)) legend(region(lc(none) fc(none))) ///
//        xtitle("Quarter") ytitle("Ratio") ///
// 	   saving("Graphs/gph/for_perc_strict," replace)
// graph export "Graphs/jpg/for_perc_strict.jpg", replace

use "Stata/Merged/bank_vars.dta", clear
*gen pat_ratio = gross_npas/total_assets
*drop if banks == "DENA BANK" & quarter_2 == tq(2012q2)
*Plotting
collapse (mean) pat_ratio, by(type_bank quarter_2)
egen type_num = group(type_bank)
xtset type_num quarter_2
xtline pat_ratio, overlay xline(227) ytitle("Fraction of GNPAs") ///
xtitle("Quarter") title("Gross NPA ratio") ///
legend(lab(1 "Foreign Banks") lab(2 "Private Banks") ///
lab(3 "Public Banks") lab(4 "Small Finance Banks")) ///
saving("Graphs/gph/rat_gnpa_avg_graph", replace) 
graph export "Graphs/jpg/rat_gnpa_avg_graph.jpg", replace
