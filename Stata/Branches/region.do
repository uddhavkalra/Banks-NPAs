cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Branches/region.log", replace
drop _all
import delimited "Clean Data/state_pop.csv", clear 
save "Stata/Branches/state_pop.dta", replace
use "Stata/Branches/state_pop.dta", clear
keep statename districtname population
replace statename = regexr(statename, "ANDAMAN AND NICOBAR ISLANDS", ///
"ANDAMAN AND NICOBAR ISLAND")
replace statename = regexr(statename, "NCT OF DELHI", "DELHI")
replace statename = regexr(statename, "ORISSA", "ODISHA")
replace statename = regexr(statename, "PONDICHERRY", "PUDUCHERRY")
bysort state: egen pop = sum(population)
drop districtname population
duplicates drop
rename (statename) (state)
save "Stata/Branches/state_pop.dta", replace

// import excel "/Users/uddhav/Desktop/Thesis/state_data/state_nva.xlsx", sheet("2015-16") firstrow clear
// save state_vars.dta, replace
// use state_vars.dta, clear
// rename (State AgricultureForestryandFishin MiningandQuarrying Manufacturing ///
// ElectricityGasWaterSupply Construction TradeRepairHotelsandRestau ///
// TransportStorageCommunicatio FinancialServices RealEstateOwnershipOfDwelli ///
// PublicAdministration OtherServices TOTALNSVAatbasicprices) ///
// (state agri mining manu elec_gas_wat const hosp trans fin estate admin oserv NVA)
//
// gen serv = elec_gas_wat + hosp + trans + fin + estate + admin + oserv
//
// gen id = 1 if (state == "TELANGANA" |state == "ANDHRA PRADESH") 
// local varlist agri mining manu const serv
// foreach var in `varlist' {
//     local new_varname : subinstr local var " " "_", all
//     egen `new_varname'_sum = total(`var') if id ==1
// }
// foreach var in `varlist' {
// 	replace `var' = `var'_sum if state == "ANDHRA PRADESH"
// }
// drop if state == "TELANGANA"
// keep state agri mining manu const serv NVA
//
// replace state = regexr(state, "ANDAMAN & NICOBAR", "ANDAMAN AND NICOBAR ISLAND")
// replace state = regexr(state , "JAMMU & KASHMIR", "JAMMU AND KASHMIR")
// save state_vars.dta, replace
//
// use state_vars.dta, clear
// merge 1:1 state using state_pop.dta
// drop _merge
//
// replace mining =. if mining == 0
//
// egen sum_agri = sum(agri)
// egen sum_mining = sum(mining)
// egen sum_manu = sum(manu)
// egen sum_const = sum(const)
// egen sum_serv = sum(serv)
//
// gen agri_ratio = agri/sum_agri
// gen mining_ratio = mining/sum_mining
// gen const_ratio = const/sum_const
// gen manu_ratio = manu/sum_manu
// gen serv_ratio = serv/sum_serv
//
// egen mean_agri_ratio = mean(agri_ratio)
// egen mean_mining_ratio = mean(mining_ratio)
// egen mean_manu_ratio = mean(manu_ratio)
// egen mean_const_ratio = mean(const_ratio)
// egen mean_serv_ratio = mean(serv_ratio)
//
// gen agri_state = 1 if agri_ratio > mean_agri_ratio
// replace agri_state = 0 if agri_state ==.
//
// gen mining_state = 1 if mining_ratio > mean_mining_ratio
// replace mining_state = 0 if mining_state ==.
//
// gen const_state = 1 if const_ratio > mean_const_ratio
// replace const_state = 0 if const_state ==.
//
// gen manu_state = 1 if manu_ratio > mean_manu_ratio
// replace manu_state = 0 if manu_state ==.
//
// gen serv_state = 1 if serv_ratio > mean_serv_ratio
// replace serv_state = 0 if serv_state ==.
//
// local varlist agri_state mining_state const_state manu_state serv_state
// foreach var in `varlist' {
// 	replace `var' = 0 if (state == "DADRA AND NAGAR HAVELI" ///
// 	|state == "DAMAN AND DIU" |state == "LAKSHADWEEP")
// }
//
// save state_vars.dta, replace

use "Stata/Branches/branch_all.dta", clear
replace state = regexr(state, " TAMILNADU", "TAMIL NADU")
replace state = regexr(state, "TAMILNADU", "TAMIL NADU")
replace state = regexr(state, "TELANGANA", "ANDHRA PRADESH")
replace state = regexr(state, "KARANATAKA", "KARNATAKA")
sort bank state
bysort bank state: egen no_branches = count(state)
keep bank state no_branches
duplicates drop

merge m:1 state using "Stata/Branches/state_pop.dta"
sort bank state
gen pop_thou = pop/1000
gen pop_per_branch = pop_thou/no_branches

bysort state: egen med_bank_pop = median(pop_per_branch)

gen in_state = 1 if pop_per_branch < med_bank_pop
replace in_state = 0 if in_state ==.

tabulate state, generate(state_dummy)

local varlist state_dummy1 state_dummy2 state_dummy3 state_dummy4 state_dummy5 ///
state_dummy6 state_dummy7 state_dummy8 state_dummy9 state_dummy10 state_dummy11 ///
state_dummy12 state_dummy13 state_dummy14 state_dummy15 state_dummy16 state_dummy17 ///
state_dummy18 state_dummy19 state_dummy20 state_dummy21 state_dummy22 state_dummy23 ///
state_dummy24 state_dummy25 state_dummy26 state_dummy27 state_dummy28 state_dummy29 ///
state_dummy30 state_dummy31 state_dummy32 state_dummy33 state_dummy34 state_dummy35

foreach var in `varlist' {
	local new_varname : subinstr local var " " "_", all
	gen `new_varname'_in = `var' * in_state
}

local varlist state_dummy1_in state_dummy2_in state_dummy3_in state_dummy4_in state_dummy5_in ///
state_dummy6_in state_dummy7_in state_dummy8_in state_dummy9_in state_dummy10_in state_dummy11_in ///
state_dummy12_in state_dummy13_in state_dummy14_in state_dummy15_in state_dummy16_in state_dummy17_in ///
state_dummy18_in state_dummy19_in state_dummy20_in state_dummy21_in state_dummy22_in state_dummy23_in ///
state_dummy24_in state_dummy25_in state_dummy26_in state_dummy27_in state_dummy28_in state_dummy29_in ///
state_dummy30_in state_dummy31_in state_dummy32_in state_dummy33_in state_dummy34_in state_dummy35_in

foreach var in `varlist' {
    local new_varname : subinstr local var " " "_", all
    bysort bank: egen `new_varname'_count = total(`var')
}

local varlist state_dummy1_in_count state_dummy2_in_count state_dummy3_in_count state_dummy4_in_count state_dummy5_in_count ///
state_dummy6_in_count state_dummy7_in_count state_dummy8_in_count state_dummy9_in_count state_dummy10_in_count state_dummy11_in_count ///
state_dummy12_in_count state_dummy13_in_count state_dummy14_in_count state_dummy15_in_count state_dummy16_in_count state_dummy17_in_count ///
state_dummy18_in_count state_dummy19_in_count state_dummy20_in_count state_dummy21_in_count state_dummy22_in_count state_dummy23_in_count ///
state_dummy24_in_count state_dummy25_in_count state_dummy26_in_count state_dummy27_in_count state_dummy28_in_count state_dummy29_in_count ///
state_dummy30_in_count state_dummy31_in_count state_dummy32_in_count state_dummy33_in_count state_dummy34_in_count state_dummy35_in_count

foreach var in `varlist' {
	local new_varname : subinstr local var "_in_count" "_f", all
	bysort bank: gen `new_varname' = 1 if `var' >= 1
	replace `new_varname' = 0 if `new_varname' ==.
}

// gen in_agri = agri_state*in_state
//
// gen in_mining = mining_state*in_state
//
// gen in_manu = manu_state*in_state
//
// gen in_const = const_state*in_state
//
// gen in_serv = serv_state*in_state
//
//
// local varlist in_agri in_mining in_manu in_const in_serv
// foreach var in `varlist' {
//     local new_varname : subinstr local var " " "_", all
//     bysort bank: egen `new_varname'_count = total(`var')
// }
//
// local varlist in_agri_count in_mining_count in_manu_count in_const_count ///
// in_serv_count
// foreach var in `varlist' {
// 	local new_varname : subinstr local var "count" "dummy", all
// 	bysort bank: gen `new_varname' = 1 if `var' >= 1
// 	replace `new_varname' = 0 if `new_varname' ==.
// }
//
// keep bank in_agri_dummy in_mining_dummy in_manu_dummy in_const_dummy in_serv_dummy

label variable state_dummy1_f "AN"
label variable state_dummy2_f "AP"
label variable state_dummy3_f "AR"
label variable state_dummy4_f "AS"
label variable state_dummy5_f "BR"
label variable state_dummy6_f "CH"
label variable state_dummy7_f "CT"
label variable state_dummy8_f "DN"
label variable state_dummy9_f "DD"
label variable state_dummy10_f "DL"
label variable state_dummy11_f "GA"
label variable state_dummy12_f "GJ"
label variable state_dummy13_f "HR"
label variable state_dummy14_f "HP"
label variable state_dummy15_f "JK"
label variable state_dummy16_f "JH"
label variable state_dummy17_f "KA"
label variable state_dummy18_f "KL"
label variable state_dummy19_f "LD"
label variable state_dummy20_f "MP"
label variable state_dummy21_f "MH"
label variable state_dummy22_f "MN"
label variable state_dummy23_f "ML"
label variable state_dummy24_f "MZ"
label variable state_dummy25_f "NL"
label variable state_dummy26_f "OR"
label variable state_dummy27_f "PY"
label variable state_dummy28_f "PB"
label variable state_dummy29_f "RJ"
label variable state_dummy30_f "SK"
label variable state_dummy31_f "TN"
label variable state_dummy32_f "TR"
label variable state_dummy33_f "UP"
label variable state_dummy34_f "UK"
label variable state_dummy35_f "WB"

bysort bank: egen no_branches_2 = sum(no_branches)

keep bank no_branches_2 state_dummy1_f state_dummy2_f state_dummy3_f state_dummy4_f ///
state_dummy5_f state_dummy6_f state_dummy7_f state_dummy8_f state_dummy9_f ///
state_dummy10_f state_dummy11_f state_dummy12_f state_dummy13_f state_dummy14_f ///
state_dummy15_f state_dummy16_f state_dummy17_f state_dummy18_f state_dummy19_f ///
state_dummy20_f state_dummy21_f state_dummy22_f state_dummy23_f state_dummy24_f ///
state_dummy25_f state_dummy26_f state_dummy27_f state_dummy28_f state_dummy29_f ///
state_dummy30_f state_dummy31_f state_dummy32_f state_dummy33_f state_dummy34_f state_dummy35_f

duplicates drop 

rename (bank) (banks)

replace banks = regexr(banks, "ABU DHABI COMMERCIAL BANK", ///
"ABU DHABI COMMERCIAL BANK PJSC")

replace banks = regexr(banks, "AXIS BANK", "AXIS BANK LIMITED")

replace banks = regexr(banks, "B N P PARIBAS", "BNP PARIBAS")

drop if banks == "BANK"

replace banks = regexr(banks, "BANK OF AMERICA", "BANK OF AMERICA , NATIONAL ASSOCIATION")

replace banks = regexr(banks, "BANK OF BAHARAIN AND KUWAIT BSC", "BANK OF BAHRAIN & KUWAIT B.S.C.")

replace banks = regexr(banks, "BARCLAYS BANK", "BARCLAYS BANK PLC")

replace banks = regexr(banks, "CITI BANK", "CITIBANK N.A")

replace banks = regexr(banks, "CREDIT AGRICOLE CORPORATE AND INVESTMENT BANK CALYON BANK", ///
"CREDIT AGRICOLE CORPORATE AND INVESTMENT BANK")

replace banks = regexr(banks, "DEUSTCHE BANK", "DEUTSCHE BANK AG")

replace banks = regexr(banks, "DHANALAKSHMI BANK", "THE DHANALAKSHMI BANK LTD")

drop if banks == "DOHA BANK"

replace banks = regexr(banks, "FEDERAL BANK", "FEDERAL BANK LTD")

replace banks = regexr(banks, "FIRSTRAND BANK LIMITED", "FIRSTRAND BANK LTD")

replace banks = regexr(banks, "HDFC BANK", "HDFC BANK LTD.")

replace banks = regexr(banks, "IDBI BANK", "IDBI BANK LIMITED")

replace banks = regexr(banks, "INDUSIND BANK", "INDUSIND BANK LTD")

replace banks = regexr(banks, "INDUSTRIAL AND COMMERCIAL BANK OF CHINA LIMITED", ///
"INDUSTRIAL AND COMMERCIAL BANK OF CHINA")

replace banks = regexr(banks, "JP MORGAN BANK", "JPMORGAN CHASE BANK NATIONAL ASSOCIATION")

replace banks = regexr(banks, "KARNATAKA BANK LIMITED", "KARNATAKA BANK LTD")

replace banks = regexr(banks, "KARUR VYSYA BANK", "KARUR VYSYA BANK LTD")

replace banks = regexr(banks, "KOTAK MAHINDRA BANK LIMITED", "KOTAK MAHINDRA BANK LTD.") 

replace banks = regexr(banks, "LAXMI VILAS BANK", "LAKSHMI VILAS BANK LTD")

replace banks = regexr(banks, "MASHREQBANK PSC", "MASHREQ BANK PSC")

replace banks = regexr(banks, "MIZUHO CORPORATE BANK LIMITED", "MIZUHO BANK LTD")

replace banks = regexr(banks, "NATIONAL AUSTRALIA BANK LIMITED", "NATIONAL AUSTRALIA BANK")

drop if banks == "RBL BANK LIMITED"

replace banks = regexr(banks, "RBL Bank Limited", "RBL BANK LIMITED")

replace banks = regexr(banks, "SBER BANK", "SBERBANK")

replace banks = regexr(banks, "SOUTH INDIAN BANK", "SOUTH INDIAN BANK LTD")

replace banks = regexr(banks, "TAMILNAD MERCANTILE BANK LIMITED", "TAMILNAD MERCANTILE BANK LTD")

replace banks = regexr(banks, "UNITED OVERSEAS BANK LIMITED", "UNITED OVERSEAS BANK LTD")

replace banks = regexr(banks, "YES BANK", "YES BANK LTD.")

duplicates drop

sort banks
by banks: gen dup = cond(_N==1,0,_n)
browse if dup > 0
drop dup

save "Stata/Branches/state_dummies.dta", replace

log close
