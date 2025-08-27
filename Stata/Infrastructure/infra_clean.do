cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Infrastructure/infra.log", replace
drop _all
*Import csv
import delimited "Clean Data/infrastructure.csv"
save "Stata/Infrastructure/infra.dta", replace
*Load data
use "Stata/Infrastructure/infra.dta", clear
*drop variable with no info
drop v1 rb22others_nan
rename(rinfrastructure_nan ratransporta1toa8_nan ra5railways_nan ///
ra6urbanpublictransportexceptrol ra7shipyards_nan ///
ra8logisticsinfrastructure_nan rb11centralgovtpsus_nan rbenergyb1tob6_nan ///
rb1electricitygeneration_nan rb21centralgovtpsus_nan ///
rb22stateelectricityboards_nan rb2electricitytransmission_nan ///
rb31centralgovtpsus_nan rb32stategovtpsusinclsebs_nan ///
rb3electricitydistribution_nan rb4oilstorageandpipeline_nan ///
rb5oilgasliquefiednaturalgaslngs rb6others_nan ///
rc1solidwastemanagement_nan rcwaterandsanitationc1toc7_nan ///
rc3watertreatmentplants_nan rc4watersanitation_nan ///
rc5irrigationdamschannelsembankm rc6stormwaterdrainagesystem_nan ///
rc7slurrypipelines_nan rdcommunicationd1to v31 v32 v33 v34 v35 v36 v37 v38 v39 ///
v40) ///
(infrastructure transport railways urban_pub_transport shipyards ///
logistics_infra logistic_govt_psu energy elec_gen elec_govt_psu ///
state_elec_board elec_transmission elec_distr_govt_psu elec_distr_state ///
elec_distr oil oil_storage oil_others solid_waste water_sanitation ///
water_treatment water_sanitation_2 irrigation strom_water slurry_pipe ///
communication telecom_twr soc_comm_infra edu_infra hospital tourism ///
other_soc_comm fertilizer harv_storage terminal_mkt soil_testing)
rename(v41 v42 v43 v44) ///
(foreign_dummy private_dummy public_dummy small_finance_dummy)
*quarter as datetime
gen quarter_2 = quarterly(quarter, "YQ")
format quarter_2 %tq
drop quarter
drop if quarter_2 ==.
*sort data
sort(banks quarter_2)
order banks quarter_2
save "Stata/Infrastructure/infra.dta", replace

log close
