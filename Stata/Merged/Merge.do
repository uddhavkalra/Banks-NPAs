cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Merged/merge_all.log", replace
drop _all
use "Stata/NPAs/asset_quality.dta", clear
merge 1:1 banks quarter_2 using "Stata/Balance Sheet/balance_sheet.dta"
rename(_merge)(merge_balance)
merge 1:1 banks quarter_2 using "Stata/Capital Adequacy/capital_adequacy.dta"
rename(_merge)(merge_capad)
merge 1:1 banks quarter_2 using "Stata/Major Sectoral/major_sectoral.dta"
rename(_merge)(merge_sect)
merge 1:1 banks quarter_2 using "Stata/Profitability/profitability.dta"
rename(_merge)(merge_profit)
merge 1:1 banks quarter_2 using "Stata/Infrastructure/infra.dta"
rename(_merge)(merge_infra)
merge 1:1 banks quarter_2 using "Stata/Performance Indicators/perform_ind.dta"
rename(_merge)(merge_perform)
merge 1:1 banks quarter_2 using "Stata/Priority/priority.dta"
rename(_merge)(merge_priority)
save "Stata/Merged/bank_vars.dta", replace
*browse if merge_capad == 1
*browse if merge_infra == 1
*browse if merge_perform == 1
use "Stata/Merged/bank_vars.dta", clear
fillin banks quarter_2
drop if quarter_2 < tq(2014q1)
drop if quarter_2 > tq(2018q3)
keep banks quarter_2 gross_advances gross_npas total_assets total_deposits ///
total_liabilities _fillin
browse if gross_npas ==. | gross_advances == . | total_assets == . | ///
total_deposits ==. | total_liabilities ==.
*KOTAK MAHINDRA BANK LTD. only has one missing at 2015q3
browse if gross_advances == 0
*NATIONAL AUSTRALIA BANK has gorss_adv at 0 for 2014q3 & q4, Natwest has 0 for 2018q2 & q3
use "Stata/Merged/bank_vars.dta", clear
*DENA BANK 2012q2 gnpa ratio is 71k, definitely wrong
drop if banks == "DENA BANK" & quarter_2 == tq(2012q2)
fillin banks quarter_2
*Gen ids for mergers
gen merger = 1 if (banks == "BHARATIYA MAHILA BANK LTD." | banks == "STATE BANK OF INDIA" ///
| banks == "STATE BANK OF BIKANER AND JAIPUR" | banks == "STATE BANK OF HYDERABAD" ///
| banks == "STATE BANK OF MYSORE" | banks == "STATE BANK OF PATIALA" ///
| banks == "STATE BANK OF TRAVANCORE")

replace merger = 2 if (banks == "ING VYSYA BANK LTD" | banks == "KOTAK MAHINDRA BANK LTD.")

*Sum up for merged banks
local varlist gross_advances gross_npas substandard_advances doubtful_advances ///
loss_advances provision_npas provision_coverage net_advances net_npas ///
restruct_stand_advances stressed_adv loans_to_ARCs loss_gain cashfunds ///
due_from_banks slr_securities nslr_inv net_loans_advances net_fixed_assets ///
other_assets total_assets paidup_share_capital reserves_surplus total_deposits ///
customer_deposits current_deposits savings_deposits time_deposits nri_deposits ///
certificate_deposits deposits_banks deposits_ind_banks deposits_nind_banks ///
total_borrowings other_liabilities total_liabilities tier_1 tier_1_comm tier_2 ///
total_cap gross_adv gnpa food_cred_gadv food_cred_gnpa nfc_gadv nfc_gnp ///
agri_gadv agri_gnpa ind_gadv ind_gnpa serv_gadv serv_gnpa retail_gadv retail_gnpa ///
onfc_gadv onfc_gnpa house_gadv house_gnpa auto_gadv auto_gnpa cred_gadv cred_gnpa ///
edu_gadv edu_gnpa oretail_gadv oretail_gnpa total_int_inc int_exp NII OOI ///
total_oi OE staff_exp net_oi capital_gains other_noi EBPT risk_prov write_offs ///
liability_ptov PBT IT_prov PAT infrastructure transport railways urban_pub_transport ///
shipyards logistics_infra logistic_govt_psu energy elec_gen elec_govt_psu ///
state_elec_board elec_transmission elec_distr_govt_psu elec_distr_state elec_distr ///
oil oil_storage oil_others solid_waste water_sanitation water_treatment ///
water_sanitation_2 irrigation strom_water slurry_pipe communication telecom_twr ///
soc_comm_infra edu_infra hospital tourism other_soc_comm fertilizer harv_storage ///
terminal_mkt soil_testing cost_funds yield_funds priority_gadv priority_gnpa ///
non_priority_gadv non_priority_gnpa mse_gadv mse_gnpa other_priority_gadv other_priority_gnpa

foreach var in `varlist' {
    local new_varname : subinstr local var " " "_", all
    bysort quarter_2: egen `new_varname'_sum = total(`var') if merger == 1
}

foreach var in `varlist' {
	replace `var' = `var'_sum if banks == "STATE BANK OF INDIA"
}

foreach var in `varlist' {
	drop `var'_sum
}

foreach var in `varlist' {
    local new_varname : subinstr local var " " "_", all
    bysort quarter_2: egen `new_varname'_sum = total(`var') if merger == 2
}

foreach var in `varlist' {
	replace `var' = `var'_sum if banks == "KOTAK MAHINDRA BANK LTD."
}

foreach var in `varlist' {
	drop `var'_sum
}


drop if (banks == "AU SMALL FINANCE BANK LIMITED" |banks == "BANDHAN BANK LIMITED" ///
|banks == "BANK OF CHINA LIMITED" |banks == "BHARATIYA MAHILA BANK LTD." ///
|banks == "CAPITAL SMALL FINANCE BANK LIMITED" |banks == "COMMONWEALTH BANK OF AUSTRALIA" ///
|banks == "DOHA BANK Q.P.S.C" |banks == "EMIRATES NBD BANK (P.J.S.C.)" ///
|banks == "EQUITAS SMALL FINANCE BANK LIMITED" |banks == "ESAF SMALL FINANCE BANK LIMITED" ///
|banks == "FINCARE SMALL FINANCE BANK LIMITED" |banks == "FIRST ABU DHABI BANK PJSC" ///
|banks == "HSBC BANK OMAN S.A.O.G." |banks == "IDFC FIRST BANK LIMITED" ///
|banks == "INDUSTRIAL BANK OF KOREA" |banks == "ING VYSYA BANK LTD" ///
|banks == "JANA SMALL FINANCE BANK LIMITED" |banks == "KBC BANK NV" ///
|banks == "KEB HANA BANK" |banks == "KOOKMIN BANK" ///
|banks == "NORTH EAST SMALL FINANCE BANK LIMITED" |banks == "Qatar National Bank (Q.P.S.C.)" ///
|banks == "STATE BANK OF BIKANER AND JAIPUR" |banks == "STATE BANK OF HYDERABAD" ///
|banks == "STATE BANK OF MYSORE" |banks == "STATE BANK OF PATIALA" ///
|banks == "STATE BANK OF TRAVANCORE" |banks == "SURYODAY SMALL FINANCE BANK LIMITED" ///
|banks == "UBS AG" |banks == "UJJIVAN SMALL FINANCE BANK LIMITED" ///
|banks == "UTKARSH SMALL FINANCE BANK LIMITED")

egen bank_num = group(banks)
xtset bank_num quarter_2
spbalance 
gen type_bank = 1 if foreign_dummy == 1
replace type_bank = 2 if private_dummy == 1
replace type_bank = 3 if public_dummy == 1
replace type_bank = 4 if small_finance_dummy == 1
save "Stata/Merged/bank_vars.dta", replace

use "Stata/Merged/bank_vars.dta", clear

browse if type_bank ==.

replace foreign_dummy = 0 if banks == "DENA BANK"
replace private_dummy = 0 if banks == "DENA BANK"
replace public_dummy = 1 if banks == "DENA BANK"
replace small_finance_dummy = 0 if banks == "DENA BANK"
replace type_bank = 3 if banks == "DENA BANK"

replace foreign_dummy = 0 if banks == "KOTAK MAHINDRA BANK LTD."
replace private_dummy = 1 if banks == "KOTAK MAHINDRA BANK LTD."
replace public_dummy = 0 if banks == "KOTAK MAHINDRA BANK LTD."
replace small_finance_dummy = 0 if banks == "KOTAK MAHINDRA BANK LTD."
replace type_bank = 2 if banks == "KOTAK MAHINDRA BANK LTD."

replace foreign_dummy = 1 if banks == "NATIONAL AUSTRALIA BANK"
replace private_dummy = 0 if banks == "NATIONAL AUSTRALIA BANK"
replace public_dummy = 0 if banks == "NATIONAL AUSTRALIA BANK"
replace small_finance_dummy = 0 if banks == "NATIONAL AUSTRALIA BANK"
replace type_bank = 1 if banks == "NATIONAL AUSTRALIA BANK"

replace foreign_dummy = 1 if banks == "PT BANK MAYBANK INDONESIA TBK"
replace private_dummy = 0 if banks == "PT BANK MAYBANK INDONESIA TBK"
replace public_dummy = 0 if banks == "PT BANK MAYBANK INDONESIA TBK"
replace small_finance_dummy = 0 if banks == "PT BANK MAYBANK INDONESIA TBK"
replace type_bank = 1 if banks == "PT BANK MAYBANK INDONESIA TBK"

replace foreign_dummy = 1 if banks == "SUMITOMO MITSUI BANKING CORPORATION"
replace private_dummy = 0 if banks == "SUMITOMO MITSUI BANKING CORPORATION"
replace public_dummy = 0 if banks == "SUMITOMO MITSUI BANKING CORPORATION"
replace small_finance_dummy = 0 if banks == "SUMITOMO MITSUI BANKING CORPORATION"
replace type_bank = 1 if banks == "SUMITOMO MITSUI BANKING CORPORATION"

replace foreign_dummy = 0 if banks == "VIJAYA BANK"
replace private_dummy = 0 if banks == "VIJAYA BANK"
replace public_dummy = 1 if banks == "VIJAYA BANK"
replace small_finance_dummy = 0 if banks == "VIJAYA BANK"
replace type_bank = 3 if banks == "VIJAYA BANK"

replace foreign_dummy = 1 if banks == "WESTPAC BANKING CORPORATION"
replace private_dummy = 0 if banks == "WESTPAC BANKING CORPORATION"
replace public_dummy = 0 if banks == "WESTPAC BANKING CORPORATION"
replace small_finance_dummy = 0 if banks == "WESTPAC BANKING CORPORATION"
replace type_bank = 1 if banks == "WESTPAC BANKING CORPORATION"

gen gnpa_ratio = gross_npas/total_assets * 100

*Fixing Sectors
replace food_cred_gnpa =. if food_cred_gadv ==. 
replace nfc_gnp =. if nfc_gadv ==.
replace agri_gnpa =. if agri_gadv ==. 
replace ind_gnpa =. if ind_gadv ==. 
replace serv_gnpa =. if serv_gadv ==. 
replace retail_gnpa =. if retail_gadv ==. 
replace onfc_gnpa =. if onfc_gadv ==. 
replace house_gnpa =. if house_gadv ==. 
replace auto_gnpa =. if auto_gadv ==. 
replace cred_gnpa =. if cred_gadv ==. 
replace edu_gnpa =. if edu_gadv ==. 
replace oretail_gnpa =. if oretail_gadv ==. 

*Fixing Priority
replace priority_gnpa =. if priority_gadv ==.
replace non_priority_gnpa =. if non_priority_gadv ==.
replace mse_gnpa =. if mse_gadv ==.
replace other_priority_gnpa =. if other_priority_gadv ==.

*Sector1
gen fc_dummy = 1 if food_cred_gadv > nfc_gadv
replace fc_dummy = 0 if fc_dummy ==.

gen agri_dummy = 1 if agri_gadv > ind_gadv & agri_gadv > serv_gadv & ///
agri_gadv > retail_gadv & agri_gadv > onfc_gadv
replace agri_dummy = 0 if agri_dummy ==.

gen ind_dummy = 1 if ind_gadv > agri_gadv & ind_gadv > serv_gadv & ///
ind_gadv > retail_gadv & ind_gadv > onfc_gadv
replace ind_dummy = 0 if ind_dummy ==.

gen serv_dummy = 1 if serv_gadv > agri_gadv & serv_gadv > ind_gadv & ///
serv_gadv > retail_gadv & serv_gadv > onfc_gadv
replace serv_dummy = 0 if serv_dummy ==.

gen retail_dummy = 1 if retail_gadv > agri_gadv & retail_gadv > ind_gadv & ///
retail_gadv > serv_gadv & retail_gadv > onfc_gadv
replace retail_dummy = 0 if retail_dummy ==.

gen onfc_dummy = 1 if onfc_gadv > agri_gadv & onfc_gadv > ind_gadv & ///
onfc_gadv > serv_gadv & onfc_gadv > retail_gadv
replace onfc_dummy = 0 if onfc_dummy ==.

*Priority1
gen npri_dummy = 1 if non_priority_gadv > priority_gadv
replace npri_dummy = 0 if npri_dummy ==.

gen mse_dummy = 1 if mse_gadv > other_priority_gadv
replace mse_dummy = 0 if mse_dummy ==.

gen opri_dummy = 1 if other_priority_gadv > mse_gadv
replace opri_dummy = 0 if opri_dummy ==.

*Infrastructure1
gen trans_dummy = 1 if transport > energy & transport > water_sanitation & ///
transport > communication & transport > soc_comm_infra
replace trans_dummy = 0 if trans_dummy ==.

gen energy_dummy = 1 if energy > transport & energy > water_sanitation & ///
energy > communication & energy > soc_comm_infra
replace energy_dummy = 0 if energy_dummy ==.

gen water_dummy = 1 if water_sanitation > transport & water_sanitation > energy & ///
water_sanitation > communication & water_sanitation > soc_comm_infra
replace water_dummy = 0 if water_dummy ==.

gen comm_dummy = 1 if communication > transport & communication > energy & ///
communication > water_sanitation & communication > soc_comm_infra
replace comm_dummy = 0 if comm_dummy ==.

gen soc_comm_dummy = 1 if soc_comm_infra > transport & soc_comm_infra > energy & ///
soc_comm_infra > water_sanitation & soc_comm_infra > communication
replace soc_comm_dummy = 0 if soc_comm_dummy ==.

*Sector2
egen sum_sec_gadv = rowtotal(food_cred_gadv agri_gadv ind_gadv serv_gadv retail_gadv onfc_gadv)
replace sum_sec_gadv =. if sum_sec_gadv == 0

gen food_ratio = food_cred_gadv/sum_sec_gadv
gen agri_ratio = agri_gadv/sum_sec_gadv
gen ind_ratio = ind_gadv/sum_sec_gadv
gen serv_ratio = serv_gadv/sum_sec_gadv
gen retail_ratio = retail_gadv/sum_sec_gadv
gen onfc_ratio = onfc_gadv/sum_sec_gadv

bysort quarter_2: egen food_ratio_med = median(food_ratio)
bysort quarter_2: egen agri_ratio_med = median(agri_ratio)
bysort quarter_2: egen ind_ratio_med = median(ind_ratio)
bysort quarter_2: egen serv_ratio_med = median(serv_ratio)
bysort quarter_2: egen retail_ratio_med = median(retail_ratio)
bysort quarter_2: egen onfc_ratio_med = median(onfc_ratio)

gen fc_dummy2 = 1 if food_ratio >= food_ratio_med
replace fc_dummy2 = 0 if food_ratio < food_ratio_med
// replace fc_dummy2 = 0 if food_ratio ==.
replace fc_dummy2 = . if food_ratio ==. & agri_ratio ==. & ind_ratio ==. & ///
serv_ratio ==. & onfc_ratio ==.

gen agri_dummy2 = 1 if agri_ratio >= agri_ratio_med
replace agri_dummy2 = 0 if agri_ratio < agri_ratio_med
// replace agri_dummy2 = 0 if agri_ratio ==.
replace agri_dummy2 = . if food_ratio ==. & agri_ratio ==. & ind_ratio ==. & ///
serv_ratio ==. & onfc_ratio ==.

gen ind_dummy2 = 1 if ind_ratio >= ind_ratio_med
replace ind_dummy2 = 0 if ind_ratio < ind_ratio_med
// replace ind_dummy2 = 0 if ind_ratio ==.
replace ind_dummy2 = . if food_ratio ==. & agri_ratio ==. & ind_ratio ==. & ///
serv_ratio ==. & onfc_ratio ==.

gen serv_dummy2 = 1 if serv_ratio >= serv_ratio_med
replace serv_dummy2 = 0 if serv_ratio < serv_ratio_med
// replace serv_dummy2 = 0 if serv_ratio ==.
replace serv_dummy2 = . if food_ratio ==. & agri_ratio ==. & ind_ratio ==. & ///
serv_ratio ==. & onfc_ratio ==.

gen retail_dummy2 = 1 if retail_ratio >= retail_ratio_med
replace retail_dummy2 = 0 if retail_ratio < retail_ratio_med
// replace retail_dummy2 = 0 if retail_ratio ==.
replace retail_dummy2 = . if food_ratio ==. & agri_ratio ==. & ind_ratio ==. & ///
serv_ratio ==. & onfc_ratio ==.

gen onfc_dummy2 = 1 if onfc_ratio >= onfc_ratio_med
replace onfc_dummy2 = 0 if onfc_ratio < onfc_ratio_med
// replace onfc_dummy2 = 0 if onfc_ratio ==.
replace onfc_dummy2 = . if food_ratio ==. & agri_ratio ==. & ind_ratio ==. & ///
serv_ratio ==. & onfc_ratio ==.


*Priority2
egen sum_pri_gadv = rowtotal(non_priority_gadv mse_gadv other_priority_gadv)
replace sum_pri_gadv =. if sum_pri_gadv == 0

gen npri_ratio = non_priority_gadv/sum_pri_gadv
gen mse_ratio = mse_gadv/sum_pri_gadv
gen opri_ratio = other_priority_gadv/sum_pri_gadv

bysort quarter_2: egen npri_ratio_med = median(npri_ratio)
bysort quarter_2: egen mse_ratio_med = median(mse_ratio)
bysort quarter_2: egen opri_ratio_med = median(opri_ratio)

gen npri_dummy2 = 1 if npri_ratio >= npri_ratio_med
replace npri_dummy2 = 0 if npri_ratio < npri_ratio_med
replace npri_dummy2 = 0 if npri_ratio ==.
replace npri_dummy2 = . if npri_ratio ==. & mse_ratio ==. & opri_ratio ==.

gen mse_dummy2 = 1 if mse_ratio >= mse_ratio_med
replace mse_dummy2 = 0 if mse_ratio < mse_ratio_med
replace mse_dummy2 = 0 if mse_ratio ==.
replace mse_dummy2 = . if npri_ratio ==. & mse_ratio ==. & opri_ratio ==.

gen opri_dummy2 = 1 if opri_ratio >= opri_ratio_med
replace opri_dummy2 = 0 if opri_ratio < opri_ratio_med
replace opri_dummy2 = 0 if opri_ratio ==.
replace opri_dummy2 = . if npri_ratio ==. & mse_ratio ==. & opri_ratio ==.

*Infrastructure2
egen sum_infra_gadv = rowtotal(transport energy water_sanitation communication soc_comm_infra)
replace sum_infra_gadv =. if sum_infra_gadv == 0

bysort quarter_2: gen trans_ratio = transport/sum_infra_gadv
bysort quarter_2: gen energy_ratio = energy/sum_infra_gadv
bysort quarter_2: gen water_san_ratio = water_sanitation/sum_infra_gadv
bysort quarter_2: gen comm_ratio = communication/sum_infra_gadv
bysort quarter_2: gen soc_comm_ratio = soc_comm_infra/sum_infra_gadv

egen trans_ratio_med = median(trans_ratio)
egen energy_ratio_med = median(energy_ratio)
egen water_san_ratio_med = median(water_san_ratio)
egen comm_ratio_med = median(comm_ratio)
egen soc_comm_ratio_med = median(soc_comm_ratio)

gen trans_dummy2 = 1 if trans_ratio >= trans_ratio_med
replace trans_dummy2 = 0 if trans_ratio < trans_ratio_med
// replace trans_dummy2 = 0 if trans_ratio ==.
replace trans_dummy2 = . if trans_ratio ==. & energy_ratio ==. & ///
water_san_ratio ==. & comm_ratio ==. & soc_comm_dummy ==.

gen energy_dummy2 = 1 if energy_ratio >= energy_ratio_med
replace energy_dummy2 = 0 if energy_ratio < energy_ratio_med
// replace energy_dummy2 = 0 if energy_ratio ==.
replace energy_dummy2 = . if trans_ratio ==. & energy_ratio ==. & ///
water_san_ratio ==. & comm_ratio ==. & soc_comm_dummy ==.

gen water_dummy2 = 1 if water_san_ratio >= water_san_ratio_med
replace water_dummy2 = 0 if water_san_ratio < water_san_ratio_med
// replace water_dummy2 = 0 if water_san_ratio ==.
replace water_dummy2 = . if trans_ratio ==. & energy_ratio ==. & ///
water_san_ratio ==. & comm_ratio ==. & soc_comm_dummy ==.

gen comm_dummy2 = 1 if comm_ratio >= comm_ratio_med
replace comm_dummy2 = 0 if comm_ratio < comm_ratio_med
// replace comm_dummy2 = 0 if comm_ratio ==.
replace comm_dummy2 = . if trans_ratio ==. & energy_ratio ==. & ///
water_san_ratio ==. & comm_ratio ==. & soc_comm_dummy ==.

gen soc_comm_dummy2 = 1 if soc_comm_ratio >= soc_comm_ratio_med
replace soc_comm_dummy2 = 0 if soc_comm_ratio < soc_comm_ratio_med
// replace soc_comm_dummy2 = 0 if soc_comm_ratio ==.
replace soc_comm_dummy2 = . if trans_ratio ==. & energy_ratio ==. & ///
water_san_ratio ==. & comm_ratio ==. & soc_comm_dummy ==.

*Sector3
egen sec_tot = rowtotal(food_cred_gadv agri_gadv ind_gadv serv_gadv retail_gadv ///
onfc_gadv)

gen food_ratio2 = food_cred_gadv/sec_tot
gen agri_ratio2 = agri_gadv/sec_tot
gen ind_ratio2 = ind_gadv/sec_tot
gen serv_ratio2 = serv_gadv/sec_tot
gen retail_ratio2 = retail_gadv/sec_tot
gen onfc_ratio2 = onfc_gadv/sec_tot

gen fc_dummy3 = 1 if food_ratio2 > agri_ratio2 & food_ratio2 > ind_ratio2 & ///
food_ratio2 > serv_ratio2 & food_ratio2 > retail_ratio2 & food_ratio2 > onfc_ratio2
replace fc_dummy3 = 0 if fc_dummy3 ==.
replace fc_dummy3 =. if food_cred_gadv ==. | agri_gadv ==. | ind_gadv ==. | ///
serv_gadv ==. | retail_gadv ==.

gen agri_dummy3 = 1 if agri_ratio2 > food_ratio2 & agri_ratio2 > ind_ratio2 & ///
agri_ratio2 > serv_ratio2 & agri_ratio2 > retail_ratio2 & agri_ratio2 > onfc_ratio2
replace agri_dummy3 = 0 if agri_dummy3 ==.
replace agri_dummy3 =. if food_cred_gadv ==. | agri_gadv ==. | ind_gadv ==. | ///
serv_gadv ==. | retail_gadv ==.

gen ind_dummy3 = 1 if ind_ratio2 > food_ratio2 & ind_ratio2 > agri_ratio2 & ///
ind_ratio2 > serv_ratio2 & ind_ratio2 > retail_ratio2 & ind_ratio2 > onfc_ratio2
replace ind_dummy3 = 0 if ind_dummy3 ==.
replace ind_dummy3 =. if food_cred_gadv ==. | agri_gadv ==. | ind_gadv ==. | ///
serv_gadv ==. | retail_gadv ==.

gen serv_dummy3 = 1 if serv_ratio2 > food_ratio2 & serv_ratio2 > agri_ratio2 & ///
serv_ratio2 > ind_ratio2 & serv_ratio2 > retail_ratio2 & serv_ratio2 > onfc_ratio2
replace serv_dummy3 = 0 if serv_dummy3 ==.
replace serv_dummy3 =. if food_cred_gadv ==. | agri_gadv ==. | ind_gadv ==. | ///
serv_gadv ==. | retail_gadv ==.

gen retail_dummy3 = 1 if retail_ratio2 > food_ratio2 & retail_ratio2 > agri_ratio2 & ///
retail_ratio2 > ind_ratio2 & retail_ratio2 > serv_ratio2 & retail_ratio2 > onfc_ratio2
replace retail_dummy3 = 0 if retail_dummy3 ==.
replace retail_dummy3 =. if food_cred_gadv ==. | agri_gadv ==. | ind_gadv ==. | ///
serv_gadv ==. | retail_gadv ==.

gen onfc_dummy3 = 1 if onfc_ratio2 > food_ratio2 & onfc_ratio2 > agri_ratio2 & ///
onfc_ratio2 > ind_ratio2 & onfc_ratio2 > serv_ratio2 & onfc_ratio2 > retail_ratio2
replace onfc_dummy3 = 0 if onfc_dummy3 ==.
replace onfc_dummy3 =. if food_cred_gadv ==. | agri_gadv ==. | ind_gadv ==. | ///
serv_gadv ==. | retail_gadv ==. | onfc_gadv ==.

*food cred and agri all 0s

*Priority3
egen pri_tot = rowtotal(non_priority_gnpa mse_gadv other_priority_gadv)

gen npri_ratio2 = non_priority_gnpa/pri_tot
gen mse_ratio2 = mse_gadv/pri_tot
gen opri_ratio2 = other_priority_gadv/pri_tot

gen npri_dummy3 = 1 if npri_ratio2 > mse_ratio2 & npri_ratio2 > opri_ratio2
replace npri_dummy3 = 0 if npri_dummy3 ==.
replace npri_dummy3 =. if non_priority_gadv ==. | mse_gadv ==. | other_priority_gadv ==.

gen mse_dummy3 = 1 if mse_ratio2 > npri_ratio2 & mse_ratio2 > opri_ratio2
replace mse_dummy3 = 0 if mse_dummy3 ==.
replace mse_dummy3 =. if non_priority_gadv ==. | mse_gadv ==. | other_priority_gadv ==.

gen opri_dummy3 = 1 if opri_ratio2 > npri_ratio2 & opri_ratio2 > mse_ratio2
replace opri_dummy3 = 0 if opri_dummy3 ==.
replace opri_dummy3 =. if non_priority_gadv ==. | mse_gadv ==. | other_priority_gadv ==.

*Infrastructure3
egen tot_infra = rowtotal(transport energy water_sanitation communication soc_comm_infra)

gen trans_ratio2 = transport/tot_infra
gen energy_ratio2 = energy/tot_infra
gen water_san_ratio2 = water_sanitation/tot_infra
gen comm_ratio2 = communication/tot_infra
gen soc_comm_ratio2 = soc_comm_infra/tot_infra

gen trans_dummy3 = 1 if trans_ratio2 > energy_ratio2 & trans_ratio2 > water_san_ratio2 & ///
trans_ratio2 > comm_ratio2 & trans_ratio2 > soc_comm_ratio2
replace trans_dummy3 = 0 if trans_dummy3 ==.
replace trans_dummy3 = . if transport ==. | energy ==. | water_sanitation ==. | ///
communication ==. | soc_comm_infra ==.

gen energy_dummy3 = 1 if energy_ratio2 > trans_ratio2 & energy_ratio2 > water_san_ratio2 & ///
energy_ratio2 > comm_ratio2 & energy_ratio2 > soc_comm_ratio2
replace energy_dummy3 = 0 if energy_dummy3 ==.
replace energy_dummy3 = . if transport ==. | energy ==. | water_sanitation ==. | ///
communication ==. | soc_comm_infra ==.

gen water_dummy3 = 1 if water_san_ratio2 > trans_ratio2 & water_san_ratio2 > energy_ratio2 & ///
water_san_ratio2 > comm_ratio2 & water_san_ratio2 > soc_comm_ratio2
replace water_dummy3 = 0 if water_dummy3 ==.
replace water_dummy3 = . if transport ==. | energy ==. | water_sanitation ==. | ///
communication ==. | soc_comm_infra ==.

gen comm_dummy3 = 1 if comm_ratio2 > trans_ratio2 & comm_ratio2 > energy_ratio2 & ///
comm_ratio2 > water_san_ratio2 & comm_ratio2 > soc_comm_ratio2
replace comm_dummy3 = 0 if comm_dummy3 ==.
replace comm_dummy3 = . if transport ==. | energy ==. | water_sanitation ==. | ///
communication ==. | soc_comm_infra ==.

gen soc_comm_dummy3 = 1 if soc_comm_ratio2 > trans_ratio2 & soc_comm_ratio2 > energy_ratio2 & ///
soc_comm_ratio2 > water_san_ratio2 & soc_comm_ratio2 > comm_ratio2
replace soc_comm_dummy3 = 0 if soc_comm_dummy3 ==.
replace soc_comm_dummy3 = . if transport ==. | energy ==. | water_sanitation ==. | ///
communication ==. | soc_comm_infra ==.

*Region
merge m:1 banks using "Stata/Branches/state_dummies.dta"
drop if _merge == 2
sort banks quarter_2

// gen pbt_ratio = PBT/total_assets * 100
//
// tssmooth shwinters pbt_ratio_2 = pbt_ratio
//
// gen pat_ratio = PAT/total_assets * 100
//
// tssmooth shwinters pat_ratio_2 = pat_ratio
//
// gen ebpt_ratio = EBPT/total_assets * 100
//
// tssmooth shwinters ebpt_ratio_2 = ebpt_ratio

save "Stata/Merged/bank_vars.dta", replace

// use "Stata/Merged/bank_vars.dta", clear
// keep if quarter_2 == tq(2016q4)
// count if type_bank == 1 
// *38 foreign banks
// count if type_bank == 2
// *19 private banks
// count if type_bank == 3
// *21 public banks
// count if type_bank == 4
// *0 small finance

log close
