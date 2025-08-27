cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Credit Deployment Cov/cred_deploy_cov.log", replace
drop _all
*Import csv
import delimited "Clean Data/cred_deploy_cov.csv"
save "Stata/Credit Deployment Cov/cred_deploy_cov.dta", replace
*Load data
use "Stata/Credit Deployment Cov/cred_deploy_cov.dta", clear
drop v1
rename (index industries21to2192 miningquarryinginclcoal21 foodprocessing22 ///
sugar221 edibleoilsvanaspati222 tea223 others224 beveragetobacco23 textiles24 /// 
cottontextiles241 jutetextiles242 manmadetextiles243 othertextiles244 ///
leatherleatherproducts25 woodwoodproducts26 paperpaperproducts27 ///
petroleumcoalproductsnuclearfuel chemicalschemicalproducts29 fertiliser291 ///
drugspharmaceuticals292 petrochemicals293 others294 glassglassware211 ///
rubberplastictheirproducts210 cementcementproducts212 basicmetalmetalproduct213 ///
ironsteel2131 othermetalmetalproduct2132 allengineering214 electronics2141 ///
others2142 vehiclesvehiclepartstransportequ gemsjewellery216 construction217 ///
infrastructure218 power2181 telecommunications2182 roads2183 airports2184 ///
ports2185 railways2186 otherinfrastructure2187 otherindustries219) ///
(Date industry mining food_proce sugar ed_oil tea other_food bev_tob ///
textile cotton jute man_made other_textile leather wood paper petrol ///
chemicals fertiliser pharma petro_chem other_chem glass rub_platsic ///
cement metal iron_steel other_metal engineer electronics other_engineer ///
auto gems construction infra elec_power telecomms road airport port ///
railway other_infra other_industry)

gen Date_2 = date(Date, "MDY")
format Date_2 %td
gen quarter_2 = qofd(Date_2)
format quarter_2 %tq
drop Date Date_2
order quarter_2
sort quarter_2
save "Stata/Credit Deployment Cov/cred_deploy_cov.dta", replace

log close

