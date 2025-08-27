cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Major Sectoral/major_sectoral.log", replace
drop _all
*Import csv
import delimited "Clean Data/major_sectoral.csv"
save "Stata/Major Sectoral/major_sectoral.dta", replace
*Load data
use "Stata/Major Sectoral/major_sectoral.dta", clear
*Dropping variables with no info
drop v1
*renaming variables
rename(grossadvances_domesticoperation grossnpas_domesticoperation ///
grossnpastogrossadvances_domesti foodcreditgrossadvances_domestic ///
foodcreditgnpas_domesticoperatio foodcreditgnparatio_domesticoper ///
nonfoodcreditgrossadvances_domes nonfoodcreditgnpas_domesticopera ///
nonfoodcreditgnparatio_domestico agricultureandalliedactivitiesgr v14 ///
agricultureandalliedactivitiesgn industrygrossadvances_domesticop ///
industrygrossnpas_domesticoperat industrygnparatio_domesticoperat ///
servicesgrossadvances_domesticop servicesgrossnpas_domesticoperat ///
servicesgnparatio_domesticoperat retailloansgrossadvances_domesti ///
retailloansgrossnpas_domesticope retailloansgnparatio_domesticope ///
othernonfoodcreditgrossadvances_ othernonfoodcreditgnpas_domestic ///
othernonfoodcreditgnparatio_dome retailloanshousingloansgrossadva ///
retailloanshousingloansgnpas_dom retailloanshousingloansgnparatio ///
retailloansvehicleautoloansgross retailloansvehicleautoloansgnpas ///
retailloansvehicleautoloansgnpar retailloanscreditcardreceivables v35 v36 ///
retailloanseducationgrossadvance retailloanseducationgnpas_domest ///
retailloanseducationgnparatio_do otherretailloansgrossadvances_do ///
otherretailloansgnpas_domesticop otherretailloansgnparatio_domest) ///
(gross_adv gnpa gnpa_to_gadv food_cred_gadv food_cred_gnpa fc_gnpa_ratio ///
nfc_gadv nfc_gnp nfc_gnpa_ratio agri_gadv agri_gnpa agri_gnpa_ratio ind_gadv ///
ind_gnpa ind_gnpa_ratio serv_gadv serv_gnpa serv_gnpa_ratio retail_gadv ///
retail_gnpa retail_gnpa_ratio onfc_gadv onfc_gnpa onfc_gnpa_ratio ///
house_gadv house_gnpa house_gnpa_ratio auto_gadv auto_gnpa ///
auto_gnpa_ratio cred_gadv cred_gnpa cred_gnpa_ratio edu_gadv edu_gnpa ///
edu_gnpa_ratio oretail_gadv oretail_gnpa oretail_gnpa_ratio)
*IDBI BANK LIMITED is coded as both private & public
browse if private_dummy == 1 & public_dummy == 1
*Fix IDBI
duplicates drop
replace private_dummy = 0 if (private_dummy == 1 & public_dummy == 1)
*quarter as datetime
gen quarter_2 = quarterly(quarter, "YQ")
format quarter_2 %tq
drop quarter
*sort data
sort(banks quarter_2)
order banks quarter_2
save "Stata/Major Sectoral/major_sectoral.dta", replace

save "Stata/Merged/major_sectoral.dta", replace

log close
