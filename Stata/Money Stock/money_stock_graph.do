cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Money Stock/ms_graph.log", replace
drop _all
use "Stata/Money Stock/money_stock.dta", clear
*money stock in billions
gen cp_bil = currency_public/1000000000
gen dd_bil = demand_deposits/1000000000
gen td_bil = time_deposits/1000000000
gen od_bil = other_deposits/1000000000
gen total_deposits_bil = dd_bil + td_bil + od_bil
*Plotting graph
tsset Date_2
graph twoway (tsline cp_bil dd_bil), tline(08nov2016) ///
	ytitle("Rs Billion") xtitle("Time") ///
	legend(pos(6) col(2) lab(1 "Currency with Public") lab(2 "Demand Deposits")) ///
	xlabel(19448 "April 2013" 20178 "April 2015" 20765 "Demonetization" ///
	21274 "April 2018" 21883 "Dec 2019",nogrid) ylabel(,nogrid) ///
	saving("Graphs/gph/money_graph", replace)
graph export "Graphs/jpg/money_graph.jpg", replace

graph twoway (tsline td_bil total_deposits_bil), tline(11nov2016) ///
	ytitle("Rs billion") xtitle("Time") title("Money Stock") ///
	legend(lab(1 "Time Deposits") lab(2 "Total Deposits")) ///
	saving("Graphs/gph/money_graph_2", replace)
graph export "Graphs/jpg/money_graph_2.jpg", replace

log close
