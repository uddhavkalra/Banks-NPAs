cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Farmers Deposits/farm_graph.log", replace
drop _all
import excel "Clean Data/Farmers_deposits.xlsx", sheet("Sheet1") cellrange(A1:D8) firstrow case(upper)

save "Stata/Farmers Deposits/farm_dep.dta", replace

use "Stata/Farmers Deposits/farm_dep.dta", clear

gen ca_mil = CURRENTACCOUNT/1000000
gen sa_mil = SAVINGSACCOUNT/1000000
gen td_mil = TERMAMOUNT/1000000

tsset YEAR

graph twoway (tsline ca_mil, lcolor(blue)) (tsline sa_mil, lcolor(red)) ///
	(tsline td_mil, lcolor(green)), xline(2016.5) ///
	ytitle("Rs Million") xtitle("Year") ///
	legend(pos(6) col(2) lab(1 "Current Account") lab(2 "Savings Account") ///
	lab(3 "Time Deposits")) xlabel(#7, nogrid) ylabel(,nogrid) ///
	saving("Graphs/gph/farm_dep", replace)
graph export "Graphs/jpg/farm_dep.jpg", replace

log close
