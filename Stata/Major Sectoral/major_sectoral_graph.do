cd "/Users/uddhav/Desktop/Undergrad Thesis/Banks-NPAs"
*log close
log using "Stata/Major Sectoral/major_sectoral_graph.log", replace
drop _all
use "Stata/Major Sectoral/major_sectoral.dta", clear
*Plot for each sector
replace agri_gnpa =. if agri_gnpa == 0
replace ind_gnpa =. if ind_gnpa == 0
replace serv_gnpa =. if serv_gnpa == 0
replace retail_gnpa =. if retail_gnpa == 0
replace onfc_gnpa =. if onfc_gnpa == 0

gen agri_gnpa_bil = agri_gnpa/1000000000
gen ind_gnpa_bil = ind_gnpa/1000000000
gen serv_gnpa_bil = serv_gnpa/1000000000
gen retail_gnpa_bil = retail_gnpa/1000000000
gen onfc_gnpa_bil = onfc_gnpa/1000000000

browse if retail_gnpa_bil ==.

drop if (banks =="AB BANK LIMITED" | banks =="ABU DHABI COMMERCIAL BANK PJSC" ///
| banks =="AUSTRALIA AND NEW ZEALAND BANKING GROUP LIMITED" ///
| banks =="BANK OF AMERICA , NATIONAL ASSOCIATION" | banks =="BANK OF CHINA LIMITED" ///
| banks =="BHARATIYA MAHILA BANK LTD." | banks =="COMMONWEALTH BANK OF AUSTRALIA" ///
| banks =="COOPERATIEVE RABOBANK U.A." | banks =="CREDIT SUISSE AG" | banks =="DEUTSCHE BANK AG" ///
| banks =="DOHA BANK Q.P.S.C" | banks =="EMIRATES NBD BANK (P.J.S.C.)" ///
| banks =="FIRST ABU DHABI BANK PJSC" | banks =="FIRSTRAND BANK LTD" ///
| banks =="HSBC BANK OMAN S.A.O.G." | banks =="INDUSTRIAL AND COMMERCIAL BANK OF CHINA" ///
| banks =="INDUSTRIAL BANK OF KOREA" | banks =="JPMORGAN CHASE BANK NATIONAL ASSOCIATION" ///
| banks =="KBC BANK NV" | banks =="KEB HANA BANK" | banks =="KOOKMIN BANK" ///
| banks =="KRUNG THAI BANK PUBLIC COMPANY LIMITED" | banks =="MASHREQ BANK PSC" ///
| banks =="MUFG Bank Ltd"| banks =="NATIONAL AUSTRALIA BANK" | banks =="NatWest Markets Plc" ///
| banks =="PT BANK MAYBANK INDONESIA TBK" | banks =="Qatar National Bank (Q.P.S.C.)" ///
| banks =="SBERBANK" | banks =="SHINHAN BANK" | banks =="SOCIETE GENERALE" ///
| banks =="SUMITOMO MITSUI BANKING CORPORATION" | banks =="UBS AG" ///
| banks =="UNITED OVERSEAS BANK LTD" | banks =="WESTPAC BANKING CORPORATION" ///
| banks =="WOORI BANK")  

drop if (banks =="BANK OF BAHRAIN & KUWAIT B.S.C." | banks =="BANK OF CEYLON" ///
| banks == "BANK OF NOVA SCOTIA" | banks =="BARCLAYS BANK PLC" | banks =="BNP PARIBAS" ///
| banks =="CREDIT AGRICOLE CORPORATE AND INVESTMENT BANK" | banks =="CTBC BANK CO., LTD." ///
| banks =="MIZUHO BANK LTD" | banks =="SBM BANK (INDIA) LTD." ///
| banks =="SONALI BANK" | banks =="STATE BANK OF HYDERABAD" ///
| banks =="STATE BANK OF TRAVANCORE" | banks =="UNITED BANK OF INDIA")

drop if (banks =="DBS BANK INDIA LTD." |banks =="ESAF SMALL FINANCE BANK LIMITED" ///
|banks =="IDFC FIRST BANK LIMITED" |banks =="MIZUHO BANK LTD" ///
|banks =="NORTH EAST SMALL FINANCE BANK LIMITED" |banks =="UCO BANK" ///
|banks =="YES BANK LTD.")

collapse (sum) agri_gnpa_bil ind_gnpa_bil serv_gnpa_bil retail_gnpa_bil ///
onfc_gnpa_bil, by(quarter_2)

tsset quarter_2
graph twoway (tsline agri_gnpa_bil ind_gnpa_bil serv_gnpa_bil ///
retail_gnpa_bil onfc_gnpa_bil), tline(2016q4) legend(lab(1 "Agriculuture") ///
lab(2 "Industry") lab(3 "Services") lab(4 "Retail") lab(5 "Other")) ///
ytitle("Rs Billion") xtitle("Time") title("Sectoral share of NPAs") ///
saving("Graphs/gph/sector_npa_graph", replace)

graph export "Graphs/jpg/sector_npa_graph.jpg", replace

log close

