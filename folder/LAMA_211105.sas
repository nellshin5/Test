libname a 'C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data';

proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_BNC_1000.xlsx" out = BNC dbms = xlsx replace; getnames = yes; run;
proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_BND_1000.xlsx" out = BND dbms = xlsx replace; getnames = yes; run;
proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_M20_1000.xlsx" out = M20 dbms = xlsx replace; getnames = yes; run;
proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_M30_1000.xlsx" out = M30 dbms = xlsx replace; getnames = yes; run;
proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_M40_1000.xlsx" out = M40 dbms = xlsx replace; getnames = yes; run;
proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_M60_1000.xlsx" out = M60 dbms = xlsx replace; getnames = yes; run;
proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_G1E_0208_1000.xlsx" out = G1E_0208 dbms = xlsx replace; getnames = yes; run;
proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_G1E_0915_1000.xlsx" out = G1E_0915 dbms = xlsx replace; getnames = yes; run;
proc import datafile = "C:\Users\nells\Downloads\demo\NSC2_INST_1000.xlsx" out = INST dbms = xlsx replace; getnames = yes; run;
proc import out=cci2002 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2002.csv"; run;
proc import out=cci2003 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2003.csv"; run;
proc import out=cci2004 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2004.csv"; run;
proc import out=cci2005 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2005.csv"; run;
proc import out=cci2006 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2006.csv"; run;
proc import out=cci2007 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2007.csv"; run;
proc import out=cci2008 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2008.csv"; run;
proc import out=cci2009 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2009.csv"; run;
proc import out=cci2010 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2010.csv"; run;
proc import out=cci2011 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2011.csv"; run;
proc import out=cci2012 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2012.csv"; run;
proc import out=cci2013 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2013.csv"; run;
proc import out=cci2014 datafile="C:\Users\nells\Desktop\Post_doc_Korea\논문\LAMA_CHD\data\Charlson_2014.csv"; run;


data M30; set M30; attrib _all_ label=''; /* Use ATTRIB statement to clear labels */ run;
data M40; set M40; attrib _all_ label=''; /* Use ATTRIB statement to clear labels */ run;
data M60; set M60; attrib _all_ label=''; /* Use ATTRIB statement to clear labels */ run;


/*1번, censored 날짜, 12월 31일까지로 통일*/
proc sort data = bnc out = bnc_2; by RN_INDI descending STD_YYYY; run; 
proc sort data = bnc_2 out = bnc_3 nodupkey; by RN_INDI; run;
data censor_f(keep = RN_INDI censor_date); set bnc_3;
if STD_YYYY = 2002 then censor_date = '20021231'; 
if STD_YYYY = 2003 then censor_date = '20031231'; 
if STD_YYYY = 2004 then censor_date = '20041231'; 
if STD_YYYY = 2005 then censor_date = '20051231'; 
if STD_YYYY = 2006 then censor_date = '20061231'; 
if STD_YYYY = 2007 then censor_date = '20071231'; 
if STD_YYYY = 2008 then censor_date = '20081231'; 
if STD_YYYY = 2009 then censor_date = '20091231'; 
if STD_YYYY = 2010 then censor_date = '20101231'; 
if STD_YYYY = 2011 then censor_date = '20111231'; 
if STD_YYYY = 2012 then censor_date = '20121231'; 
if STD_YYYY = 2013 then censor_date = '20131231'; 
if STD_YYYY = 2014 then censor_date = '20141231'; 
if STD_YYYY = 2015 then censor_date = '20141231'; 
run;
/*proc freq data=Bnc_3; table STD_YYYY; run;*/


/*2번, dead 날짜, 월까지 밖에 없기 때문에 15일로 통일*/
data dead_f(keep = RN_INDI death_date); set bnd;
length death_date $8;
if DTH_YYYYMM = . then delete;
day_d=15; death_date= cats(DTH_YYYYMM, day_d);
run;


/*3-1번, COPD환자 추려내기, M40 테이블 요양급여상병기호(주,부상병)에서 추출*/
/*Consider the following data step statements using the colon modifier:
if surname =: 'B' then do; 
In this case the colon transform the meaning of ‘=’ to ‘begin with’. This will find all 5 surnames.*/
data M40_2; set M40;
if MCEX_SICK_SYM =:'C34' or MCEX_SICK_SYM =:'J42' or MCEX_SICK_SYM =:'J43' or MCEX_SICK_SYM =:'J44' or MCEX_SICK_SYM =:'J430' or MCEX_SICK_SYM =:'J45' or MCEX_SICK_SYM =:'J46' then dz=1; else delete; 
if MCEX_SICK_SYM =:'J45' or MCEX_SICK_SYM =:'J46' then asthma=1; else asthma=0;
if MCEX_SICK_SYM =:'C34' then lungca=1; else lungca=0;
if MCEX_SICK_SYM =:'J42' or MCEX_SICK_SYM =:'J43' or MCEX_SICK_SYM =:'J44' then copd_0=1; else copd_0=0;
if MCEX_SICK_SYM =:'J430' then j430=1; else j430=0;

if copd_0 = 1 and  j430 = 0 then copd = 1; else copd = 0; 
run;

proc sql noprint;
	create table M40_3 as
	select  RN_INDI, RN_KEY, MDCARE_STRT_DT, STD_YYYY, sum(asthma) as asthma_count, sum(lungca) as lungca_count, sum(copd) as copd_count
	from M40_2
	group by RN_INDI, STD_YYYY; quit;

/*3-2번, 2002~2003 washout period에 진단 받은 사람 찾기, 한번만 진단받아도 지움*/ 
data M40_4; set M40_3;
if STD_YYYY='2002' or STD_YYYY='2003' then a = 1; else a = 0; 
if copd_count > 0 then b = 1; else b = 0;
if a = 1 and b = 1 then copd_washout = 1; else delete; run; 

proc sort data=M40_4 out = washout_f(keep=RN_INDI copd_washout) nodupkey; by RN_INDI; run;

/*3-3번, copd 첫 진단 받은 날짜 기록, asthma, lungca, copd 데이터 분리*/
data M40_6; set M40_3;
if asthma_count > 1 then asthma = 1; else asthma = 0;
if lungca_count > 1 then lungca = 1; else lungca = 0;
if copd_count > 1 then copd = 1; else copd = 0; run;

data asthma; set M40_6; if asthma = 0 then delete; rename MDCARE_STRT_DT = asthma_first; run;
proc sort data = asthma; by RN_INDI asthma_first; run;
proc sort data = asthma out = asthma_f(keep = RN_INDI asthma_first asthma) nodupkey; by RN_INDI; run; 

data lungca; set M40_6; if lungca = 0 then delete; rename MDCARE_STRT_DT = lungca_first; run;
proc sort data = lungca; by RN_INDI lungca_first; run;
proc sort data = lungca out = lungca_f(keep = RN_INDI lungca_first lungca) nodupkey; by RN_INDI; run; 

data copd; set M40_6; if copd = 0 then delete; rename MDCARE_STRT_DT = copd_first; run;
proc sort data = copd; by RN_INDI copd_first; run;
proc sort data = copd out = copd_f(keep = RN_INDI copd_first copd) nodupkey; by RN_INDI; run; 


/*4번 CVD 환자 추려내기*/
/*질병코드, 서식코드, cvd 치료코드 다시 바꿔야함*/
data M40_7; set M40;
if MCEX_SICK_SYM =:'I20' or MCEX_SICK_SYM =:'I21' or MCEX_SICK_SYM =:'I22' or MCEX_SICK_SYM =:'I23' or MCEX_SICK_SYM =:'I24' or MCEX_SICK_SYM =:'I25' then cvd=1; else delete; 
run;

proc sql noprint;
	create table M40_8 as
	select  RN_INDI, RN_KEY, MDCARE_STRT_DT, FORM_CD, STD_YYYY, MCEX_SICK_SYM, sum(cvd) as cvd_count
	from M40_7
	group by RN_INDI, form_cd; quit;

/*이부분 다시 수정 및 체크 필요*/
data M40_9(keep = RN_INDI MDCARE_STRT_DT cvd); set M40_8;
if FORM_CD = '02' and cvd_count > 0 then a = 1; 
if FORM_CD = '03' and cvd_count > 1 then b = 1;
if a = . and b = . then delete;
cvd = 1;
run;

data M30_2(keep = RN_INDI MDCARE_STRT_DT cvd); set M30;
if MCARE_DIV_CD in ('AA100', 'U0060', 'U0101') then cvd = 1; else delete; run;

data cvd; set M40_9 M30_2; rename MDCARE_STRT_DT = cvd_first; run;
proc sort data = cvd; by RN_INDI cvd_first; run;
proc sort data = cvd out = cvd_f nodupkey; by RN_INDI; run;


/*5번, 건강검진 데이터 코딩, CVD환자는 CVD 진단년도에서 가장 가까운 기록을 확인(가까운게 두개면 더 옛날꺼 기준) non-CVD는 가장 최근의 기록 확인*/
data gj0208; set G1e_0208;
HCHK_year_2=EXMD_BZ_YYYY+0; SMK_STAT_TYPE_RSPS_CD_2=Q_SMK_YN+0; DSQTY_RSPS_CD_2 = Q_SMK_NOW_AMT_V0108+0; SMK_TERM_RSPS_CD_2=Q_SMK_DRT+0;

if SMK_TERM_RSPS_CD_2 = 1 then SMK_TERM_RSPS_CD_c=3; 
if SMK_TERM_RSPS_CD_2 = 2 then SMK_TERM_RSPS_CD_c=8; 
if SMK_TERM_RSPS_CD_2 = 3 then SMK_TERM_RSPS_CD_c=15; 
if SMK_TERM_RSPS_CD_2 = 4 then SMK_TERM_RSPS_CD_c=25; 
if SMK_TERM_RSPS_CD_2 = 5 then SMK_TERM_RSPS_CD_c=35;

if DSQTY_RSPS_CD_2=1 then pack=0.5 ; 
if DSQTY_RSPS_CD_2=2 then pack=0.8 ; 
if DSQTY_RSPS_CD_2=3 then pack=1.5 ; 
if DSQTY_RSPS_CD_2=4 then pack=2.5 ; 

pack_year = SMK_TERM_RSPS_CD_c*pack ;

if SMK_STAT_TYPE_RSPS_CD_2=1 or SMK_STAT_TYPE_RSPS_CD_2=2 then smoke_cur=0 ;
if SMK_STAT_TYPE_RSPS_CD_2=3 then smoke_cur=1;
run; 

data gj0915; set G1e_0915;
HCHK_year_2=EXMD_BZ_YYYY+0; PAST_SMK_TERM_RSPS_CD_2 = Q_SMK_PRE_DRT+0; PAST_DSQTY_RSPS_CD_2 = Q_SMK_PRE_AMT+0; *매뉴얼에 Q_SMK_PRE_AMT_V09N으로 되어있는데 체크 필요; CUR_SMK_TERM_RSPS_CD_2 = Q_SMK_NOW_DRT+0; CUR_DSQTY_RSPS_CD_2=Q_SMK_NOW_AMT_V09N+0; SMK_STAT_TYPE_RSPS_CD_2=Q_SMK_YN+0; 

past_pack_year = PAST_SMK_TERM_RSPS_CD_2*PAST_DSQTY_RSPS_CD_2/20 ; 
cur_pack_year = CUR_SMK_TERM_RSPS_CD_2*CUR_DSQTY_RSPS_CD_2/20; 

if past_pack_year=. and cur_pack_year=. then pack_year=. ; 
if past_pack_year>0 and cur_pack_year=. then pack_year=past_pack_year ; 
if past_pack_year=. and cur_pack_year>0 then pack_year=cur_pack_year ; 
if past_pack_year>0 and cur_pack_year>0 then pack_year=cur_pack_year; 

if SMK_STAT_TYPE_RSPS_CD_2=1 or SMK_STAT_TYPE_RSPS_CD_2=2 then smoke_cur=0 ;
if SMK_STAT_TYPE_RSPS_CD_2=3 then smoke_cur=1;run; 

data gj2002_2013; set gj0208 gj0915; run;
data gj2002_2013_k2; set gj2002_2013; if SMK_STAT_TYPE_RSPS_CD_2='.' then delete; if HCHK_year_2>0 then gk=1; run;

proc sort data = gj2002_2013_k2(keep = HCHK_year_2 RN_INDI G1E_BMI SMK_STAT_TYPE_RSPS_CD_2 gk); by RN_INDI descending hchk_year_2; run;  
proc sort data = cvd_f; by RN_INDI; run;

data gj; merge gj2002_2013_k2 cvd_f; by RN_INDI; 
if gk = . then delete; if HCHK_year_2 = 2015 then delete;
if cvd = . then cvd_first = '20141231'; 
year=substr(cvd_first,1,4)*1;
diff = abs(year - HCHK_year_2);
run;

proc sort data = gj; by RN_INDI diff HCHK_year_2; run;
proc sort data = gj out =gj_f(keep = RN_INDI G1E_BMI SMK_STAT_TYPE_RSPS_CD_2 HCHK_year_2 gk) nodupkey; by RN_INDI; run;


/*6번 CCI 관련 코딩, CVD환자는 CVD 진단년도에서 가장 가까운 기록을 확인(가까운게 두개면 더 옛날꺼 기준) non-CVD는 가장 최근의 기록 확인*/
data a.ch_2002; set M40; if STD_YYYY = '2002' then a = 1; else delete; run;
data a.ch_2003; set M40; if STD_YYYY = '2003' then a = 1; else delete; run;
data a.ch_2004; set M40; if STD_YYYY = '2004' then a = 1; else delete; run;
data a.ch_2005; set M40; if STD_YYYY = '2005' then a = 1; else delete; run;
data a.ch_2006; set M40; if STD_YYYY = '2006' then a = 1; else delete; run;
data a.ch_2007; set M40; if STD_YYYY = '2007' then a = 1; else delete; run;
data a.ch_2008; set M40; if STD_YYYY = '2008' then a = 1; else delete; run;
data a.ch_2009; set M40; if STD_YYYY = '2009' then a = 1; else delete; run;
data a.ch_2010; set M40; if STD_YYYY = '2010' then a = 1; else delete; run;
data a.ch_2011; set M40; if STD_YYYY = '2011' then a = 1; else delete; run;
data a.ch_2012; set M40; if STD_YYYY = '2012' then a = 1; else delete; run;
data a.ch_2013; set M40; if STD_YYYY = '2013' then a = 1; else delete; run;
data a.ch_2014; set M40; if STD_YYYY = '2014' then a = 1; else delete; run; *그다음 R로 전환;

%MACRO a; %Do Y =2002 % TO 2014;  
data cci&Y._2; set cci&Y. (keep= RN_INDI Charlson);
cci_year=&Y.; run; 
%END; %MEND a; %a;
data cci ;set cci2002_2 cci2003_2 cci2004_2 cci2005_2 cci2006_2 cci2007_2 cci2008_2 cci2009_2 cci2010_2 cci2011_2 cci2012_2 cci2013_2 cci2014_2 ; run; 

proc sort data = cci; by RN_INDI descending cci_year; run;  
proc sort data = cvd_f; by RN_INDI; run;

data cci_2; merge cci cvd_f; by RN_INDI; 
if cvd = . then cvd_first = '20141231'; 
year=substr(cvd_first,1,4)*1;
diff = abs(year - cci_year);
run;

proc freq data = cci_2; table charlson; run;

proc sort data = cci_2; by RN_INDI diff cci_year; run;
proc sort data = cci_2 out =cci_f(keep = RN_INDI Charlson) nodupkey; by RN_INDI; run;


/*7-1번 inhaler 쓴 환자 추출*/
/*의과&보건기관의 진료내역&처방내역에서만 가져옴*/
/*T30 주성분코드 MCARE_DIV_CD, T60 주성분코드 GNL_NM_CD*/
/*COPD진단 후에 잘라야 할듯? -> ㄴㄴ 일단 날짜 다 적어놓고 COPD보다 이전에 썼으면 나중에 지우면 됨*/
/*inhaler 2번 쓴 환자의 첫 inhaler 사용 날짜 추출, inhaler 종류별 사용 여부 추출*/  
data M30_2; set M30; /*M30 내에도 여러개의 중복된 RN_KEY가 있다*/
if MCARE_DIV_CD in ('114502CSI','114503CSI', '114506CSI','114508CSI', '114509CSI','114510CSI', '119402CAE','119403CAE', '119407CAE','119404CSI', '119502CSI','119504CAE', '119505CSI', '119506CSI', '157902CLQ', '157903CAE', '162202CSI', '162203CLQ', '162203CSS', '162204CSI', '162205CSI', '162206CSS', '163102CSI', '163105CSI', '177101CLQ', '177103CLQ', '177104CAE', '218304CSI', '225502CSI', '225504CSI', '225506CSI', '225508CSI', '225509CSI', '225801CSI', '225802CSI', '235803CSI', '235805CLQ', '334400CAE', '334500CSI', '334600CSI', '334700CSI', '334800CAE', '391800CSI', '401800CSI', '407100CSI', '407200CSI', '407300CSI', '441700COS', '441700CSI', '453400CSI', '497101CSI', '497102CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '611901CSI', '611902CSI', '114502CSI', '114503CSI', '114506CSI', '119402CAE', '119404CSI', '119502CSI', '119504CAE', '119505CSI', '157902CLQ', '157903CAE', '157904CAE', '162202CSI', '162203CSS', '162204CSI', '162205CSI', '162205CSI', '162206CSS', '163102CSI', '163105CSI', '177101CLQ', '177103CLQ', '177104CAE', '218304CSI', '225502CSI', '225504CSI', '225506CSI', '225508CSI', '225509CSI', '225801CSI', '225802CSI', '235803CSI', '235805CLQ', '243306CSI', '334500CSI', '334600CSI', '334700CSI', '334800CAE', '391800CSI', '407100CSI', '407200CSI', '407300CSI', '441700CSI', '453400CSI', '497101CSI', '497102CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '157930CLQ', '177131CLQ', '177131CLQ', '218304CSI', '218330CSI', '225502CSI', '225508CSI', '225530CSI', '225531CSI', '225531CSI', '225532CSI', '225532CSI', '235830CLQ', '334500CSI', '334500CSI', '334500CSI', '334600CSI', '334600CSI', '334600CSI', '334700CSI', '334700CSI', '334700CSI', '391800CSI', '391800CSI', '391800CSI', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '542800CSI', '542900CSI', '543000CSI', '543100CSI', '543100CSI', '543100CSI', '543200CSI', '543300CSI', '543300CSI', '543300CSI', '543400CSI', '543500CSI', '543500CSI', '543500CSI', '543600CSI', '543800CSI', '543900CSI', '543900CSI', '543900CSI', '544000CSI', '544100CSI', '544100CSI', '544200CSI', '544200CSI', '544300CSI', '544400CSI', '544500CSI', '611901CSI', '611901CSI', '611902CSI', '611902CSI', '636700CSI', '636800CSI', '640400CSI', '801100CSI', '114508CSI', '114509CSI', '114510CSI', '114530CSI', '114532CSI', '114533CSI', '119404CSI', '119404CSI', '119404CSI', '119438CAE', '119502CSI', '119502CSI', '119505CSI', '119506CSI', '119530CSI', '119530CSI', '119531CSI', '119532CSI', '119533CSI', '119533CSI', '119533CSI', '157902CLQ', '157930CLQ', '162202CSI', '162203CSS', '162204CSI', '162205CSI', '162205CSI', '162206CSS', '162230CSS', '162231CSS', '162232CSI', '162233CSI', '162235CSI', '162236CSI', '177103CLQ', '177131CLQ', '218304CSI', '218330CSI', '225502CSI', '225506CSI', '225508CSI', '225530CSI', '225531CSI', '225532CSI', '235830CLQ', '334500CSI', '334600CSI', '334700CSI', '391800CSI', '441700CSI', '453400CSI', '497101CSI', '497102CSI', '497130CSI', '497131CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '542800CSI', '542900CSI', '543000CSI', '543100CSI', '543200CSI', '543300CSI', '543400CSI', '543500CSI', '543600CSI', '543800CSI', '543900CSI', '544000CSI', '544100CSI', '544200CSI', '544300CSI', '544400CSI', '544500CSI', '611901CSI', '611902CSI', '636700CSI', '636800CSI', '640400CSI', '801100CSI', '457301CCH', '457301CPK', '457301CSI', '503401CSI', '457301CCH', '457301CSI', '503401CSI', '457301CCH', '457301CCH', '457301CSI', '457301CSI', '457330CSI', '457330CSI', '503401CSI', '503430CSI', '633701CSI', '633730CSI', '635903CSI', '641101CSI', '457301CCH', '457301CSI', '457330CSI', '503401CSI', '503430CSI','633701CSI', '633730CSI', '635903CSI', '641101CSI'
) then inhalator = 1; else delete;

if MCARE_DIV_CD in ('114502CSI', '114503CSI', '114506CSI', '114508CSI', '114509CSI', '114510CSI', '119402CAE', '119403CAE', '119407CAE', '119404CSI', '119502CSI', '119504CAE', '119505CSI', '119506CSI', '162202CSI', '162203CLQ', '162203CSS', '162204CSI', '162205CSI', '162206CSS', '497101CSI', '497102CSI', '114502CSI', '114503CSI', '114506CSI', '119402CAE', '119404CSI', '119502CSI', '119504CAE', '119505CSI', '162202CSI', '162203CSS', '162204CSI', '162205CSI', '162205CSI', '162206CSS', '243306CSI', '497101CSI', '497102CSI', '114508CSI', '114509CSI', '114510CSI', '114530CSI', '114532CSI', '114533CSI', '119404CSI', '119404CSI', '119404CSI', '119438CAE', '119502CSI', '119502CSI', '119505CSI', '119506CSI', '119530CSI', '119530CSI', '119531CSI', '119532CSI', '119533CSI', '119533CSI', '119533CSI', '162202CSI', '162203CSS', '162204CSI', '162205CSI', '162205CSI', '162206CSS', '162230CSS', '162231CSS', '162232CSI', '162233CSI', '162235CSI', '162236CSI', '497101CSI', '497102CSI', '497130CSI', '497131CSI'
) then ICS = 1; else ICS = 0; 
if MCARE_DIV_CD in ('334500CSI', '334600CSI', '334700CSI', '391800CSI', '407100CSI', '407200CSI', '407300CSI', '441700COS', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '334500CSI', '334600CSI', '334700CSI', '391800CSI', '407100CSI', '407200CSI', '407300CSI', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '334500CSI', '334500CSI', '334500CSI', '334600CSI', '334600CSI', '334600CSI', '334700CSI', '334700CSI', '334700CSI', '391800CSI', '391800CSI', '391800CSI', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '636700CSI', '636800CSI', '334500CSI', '334600CSI', '334700CSI', '391800CSI', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '542800CSI', '542900CSI', '543000CSI', '543100CSI', '543200CSI', '543300CSI', '543400CSI', '543500CSI', '543600CSI', '543800CSI', '543900CSI', '544000CSI', '544100CSI', '544200CSI', '544300CSI', '544400CSI', '544500CSI', '636700CSI', '636800CSI', '640400CSI', '801100CSI'
) then ICSLABA = 1; else ICSLABA = 0;
if MCARE_DIV_CD in ('163102CSI', '163105CSI', '225801CSI', '225802CSI', '611901CSI', '611902CSI', '163102CSI', '163105CSI', '225801CSI', '225802CSI', '542800CSI', '542900CSI', '543000CSI', '543100CSI', '543100CSI', '543100CSI', '543200CSI', '543300CSI', '543300CSI', '543300CSI', '543400CSI', '543500CSI', '543500CSI', '543500CSI', '543600CSI', '543800CSI', '543900CSI', '543900CSI', '543900CSI', '544000CSI', '544100CSI', '544100CSI', '544200CSI', '544200CSI', '544300CSI', '544400CSI', '544500CSI', '611901CSI', '611901CSI', '611902CSI', '611902CSI', '640400CSI', '801100CSI', '611901CSI', '611902CSI'
) then LABA = 1; else LABA = 0;
if MCARE_DIV_CD in ('457301CCH', '457301CPK', '457301CSI', '503401CSI', '457301CCH', '457301CSI', '503401CSI', '457301CCH', '457301CCH', '457301CSI', '457301CSI', '457330CSI', '457330CSI', '503401CSI', '503430CSI', '633701CSI', '633730CSI', '635903CSI', '641101CSI', '457301CCH', '457301CSI', '457330CSI', '503401CSI', '503430CSI', '633701CSI', '633730CSI', '635903CSI', '641101CSI'
) then LAMA = 1; else LAMA = 0;
if MCARE_DIV_CD in ('157902CLQ', '157903CAE', '218304CSI', '225502CSI', '225504CSI', '225506CSI', '225508CSI', '225509CSI', '235803CSI', '235805CLQ', '157902CLQ', '157903CAE', '157904CAE', '218304CSI', '225502CSI', '225504CSI', '225506CSI', '225508CSI', '225509CSI', '235803CSI', '235805CLQ', '157930CLQ', '218304CSI', '218330CSI', '225502CSI', '225508CSI', '225530CSI', '225531CSI', '225531CSI', '225532CSI', '225532CSI', '235830CLQ', '157902CLQ', '157930CLQ', '218304CSI', '218330CSI', '225502CSI', '225506CSI', '225508CSI', '225530CSI', '225531CSI', '225532CSI', '235830CLQ'
) then SABA = 1; else SABA = 0;
if MCARE_DIV_CD in ('334400CAE', '334800CAE', '401800CSI', '334800CAE'
) then SABASAMA = 1; else SABASAMA = 0;
if MCARE_DIV_CD in ('177101CLQ', '177103CLQ', '177104CAE', '177101CLQ', '177103CLQ', '177104CAE', '177131CLQ', '177131CLQ', '177103CLQ', '177131CLQ'
) then SAMA = 1; else SAMA = 0;
run;

data M60_2; set M60; /*M60 내에도 여러개의 중복된 RN_KEY가 있다*/
if GNL_NM_CD in ('114502CSI','114503CSI', '114506CSI','114508CSI', '114509CSI','114510CSI', '119402CAE','119403CAE', '119407CAE','119404CSI', '119502CSI','119504CAE', '119505CSI', '119506CSI', '157902CLQ', '157903CAE', '162202CSI', '162203CLQ', '162203CSS', '162204CSI', '162205CSI', '162206CSS', '163102CSI', '163105CSI', '177101CLQ', '177103CLQ', '177104CAE', '218304CSI', '225502CSI', '225504CSI', '225506CSI', '225508CSI', '225509CSI', '225801CSI', '225802CSI', '235803CSI', '235805CLQ', '334400CAE', '334500CSI', '334600CSI', '334700CSI', '334800CAE', '391800CSI', '401800CSI', '407100CSI', '407200CSI', '407300CSI', '441700COS', '441700CSI', '453400CSI', '497101CSI', '497102CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '611901CSI', '611902CSI', '114502CSI', '114503CSI', '114506CSI', '119402CAE', '119404CSI', '119502CSI', '119504CAE', '119505CSI', '157902CLQ', '157903CAE', '157904CAE', '162202CSI', '162203CSS', '162204CSI', '162205CSI', '162205CSI', '162206CSS', '163102CSI', '163105CSI', '177101CLQ', '177103CLQ', '177104CAE', '218304CSI', '225502CSI', '225504CSI', '225506CSI', '225508CSI', '225509CSI', '225801CSI', '225802CSI', '235803CSI', '235805CLQ', '243306CSI', '334500CSI', '334600CSI', '334700CSI', '334800CAE', '391800CSI', '407100CSI', '407200CSI', '407300CSI', '441700CSI', '453400CSI', '497101CSI', '497102CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '157930CLQ', '177131CLQ', '177131CLQ', '218304CSI', '218330CSI', '225502CSI', '225508CSI', '225530CSI', '225531CSI', '225531CSI', '225532CSI', '225532CSI', '235830CLQ', '334500CSI', '334500CSI', '334500CSI', '334600CSI', '334600CSI', '334600CSI', '334700CSI', '334700CSI', '334700CSI', '391800CSI', '391800CSI', '391800CSI', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '542800CSI', '542900CSI', '543000CSI', '543100CSI', '543100CSI', '543100CSI', '543200CSI', '543300CSI', '543300CSI', '543300CSI', '543400CSI', '543500CSI', '543500CSI', '543500CSI', '543600CSI', '543800CSI', '543900CSI', '543900CSI', '543900CSI', '544000CSI', '544100CSI', '544100CSI', '544200CSI', '544200CSI', '544300CSI', '544400CSI', '544500CSI', '611901CSI', '611901CSI', '611902CSI', '611902CSI', '636700CSI', '636800CSI', '640400CSI', '801100CSI', '114508CSI', '114509CSI', '114510CSI', '114530CSI', '114532CSI', '114533CSI', '119404CSI', '119404CSI', '119404CSI', '119438CAE', '119502CSI', '119502CSI', '119505CSI', '119506CSI', '119530CSI', '119530CSI', '119531CSI', '119532CSI', '119533CSI', '119533CSI', '119533CSI', '157902CLQ', '157930CLQ', '162202CSI', '162203CSS', '162204CSI', '162205CSI', '162205CSI', '162206CSS', '162230CSS', '162231CSS', '162232CSI', '162233CSI', '162235CSI', '162236CSI', '177103CLQ', '177131CLQ', '218304CSI', '218330CSI', '225502CSI', '225506CSI', '225508CSI', '225530CSI', '225531CSI', '225532CSI', '235830CLQ', '334500CSI', '334600CSI', '334700CSI', '391800CSI', '441700CSI', '453400CSI', '497101CSI', '497102CSI', '497130CSI', '497131CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '542800CSI', '542900CSI', '543000CSI', '543100CSI', '543200CSI', '543300CSI', '543400CSI', '543500CSI', '543600CSI', '543800CSI', '543900CSI', '544000CSI', '544100CSI', '544200CSI', '544300CSI', '544400CSI', '544500CSI', '611901CSI', '611902CSI', '636700CSI', '636800CSI', '640400CSI', '801100CSI', '457301CCH', '457301CPK', '457301CSI', '503401CSI', '457301CCH', '457301CSI', '503401CSI', '457301CCH', '457301CCH', '457301CSI', '457301CSI', '457330CSI', '457330CSI', '503401CSI', '503430CSI', '633701CSI', '633730CSI', '635903CSI', '641101CSI', '457301CCH', '457301CSI', '457330CSI', '503401CSI', '503430CSI','633701CSI', '633730CSI', '635903CSI', '641101CSI'
) then inhalator = 1; else delete;

if GNL_NM_CD in ('114502CSI', '114503CSI', '114506CSI', '114508CSI', '114509CSI', '114510CSI', '119402CAE', '119403CAE', '119407CAE', '119404CSI', '119502CSI', '119504CAE', '119505CSI', '119506CSI', '162202CSI', '162203CLQ', '162203CSS', '162204CSI', '162205CSI', '162206CSS', '497101CSI', '497102CSI', '114502CSI', '114503CSI', '114506CSI', '119402CAE', '119404CSI', '119502CSI', '119504CAE', '119505CSI', '162202CSI', '162203CSS', '162204CSI', '162205CSI', '162205CSI', '162206CSS', '243306CSI', '497101CSI', '497102CSI', '114508CSI', '114509CSI', '114510CSI', '114530CSI', '114532CSI', '114533CSI', '119404CSI', '119404CSI', '119404CSI', '119438CAE', '119502CSI', '119502CSI', '119505CSI', '119506CSI', '119530CSI', '119530CSI', '119531CSI', '119532CSI', '119533CSI', '119533CSI', '119533CSI', '162202CSI', '162203CSS', '162204CSI', '162205CSI', '162205CSI', '162206CSS', '162230CSS', '162231CSS', '162232CSI', '162233CSI', '162235CSI', '162236CSI', '497101CSI', '497102CSI', '497130CSI', '497131CSI'
) then ICS = 1; else ICS = 0; 
if GNL_NM_CD in ('334500CSI', '334600CSI', '334700CSI', '391800CSI', '407100CSI', '407200CSI', '407300CSI', '441700COS', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '334500CSI', '334600CSI', '334700CSI', '391800CSI', '407100CSI', '407200CSI', '407300CSI', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '334500CSI', '334500CSI', '334500CSI', '334600CSI', '334600CSI', '334600CSI', '334700CSI', '334700CSI', '334700CSI', '391800CSI', '391800CSI', '391800CSI', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '636700CSI', '636800CSI', '334500CSI', '334600CSI', '334700CSI', '391800CSI', '441700CSI', '453400CSI', '502000CSI', '506400CSI', '506500CSI', '506600CSI', '542800CSI', '542900CSI', '543000CSI', '543100CSI', '543200CSI', '543300CSI', '543400CSI', '543500CSI', '543600CSI', '543800CSI', '543900CSI', '544000CSI', '544100CSI', '544200CSI', '544300CSI', '544400CSI', '544500CSI', '636700CSI', '636800CSI', '640400CSI', '801100CSI'
) then ICSLABA = 1; else ICSLABA = 0;
if GNL_NM_CD in ('163102CSI', '163105CSI', '225801CSI', '225802CSI', '611901CSI', '611902CSI', '163102CSI', '163105CSI', '225801CSI', '225802CSI', '542800CSI', '542900CSI', '543000CSI', '543100CSI', '543100CSI', '543100CSI', '543200CSI', '543300CSI', '543300CSI', '543300CSI', '543400CSI', '543500CSI', '543500CSI', '543500CSI', '543600CSI', '543800CSI', '543900CSI', '543900CSI', '543900CSI', '544000CSI', '544100CSI', '544100CSI', '544200CSI', '544200CSI', '544300CSI', '544400CSI', '544500CSI', '611901CSI', '611901CSI', '611902CSI', '611902CSI', '640400CSI', '801100CSI', '611901CSI', '611902CSI'
) then LABA = 1; else LABA = 0;
if GNL_NM_CD in ('457301CCH', '457301CPK', '457301CSI', '503401CSI', '457301CCH', '457301CSI', '503401CSI', '457301CCH', '457301CCH', '457301CSI', '457301CSI', '457330CSI', '457330CSI', '503401CSI', '503430CSI', '633701CSI', '633730CSI', '635903CSI', '641101CSI', '457301CCH', '457301CSI', '457330CSI', '503401CSI', '503430CSI', '633701CSI', '633730CSI', '635903CSI', '641101CSI'
) then LAMA = 1; else LAMA = 0;
if GNL_NM_CD in ('157902CLQ', '157903CAE', '218304CSI', '225502CSI', '225504CSI', '225506CSI', '225508CSI', '225509CSI', '235803CSI', '235805CLQ', '157902CLQ', '157903CAE', '157904CAE', '218304CSI', '225502CSI', '225504CSI', '225506CSI', '225508CSI', '225509CSI', '235803CSI', '235805CLQ', '157930CLQ', '218304CSI', '218330CSI', '225502CSI', '225508CSI', '225530CSI', '225531CSI', '225531CSI', '225532CSI', '225532CSI', '235830CLQ', '157902CLQ', '157930CLQ', '218304CSI', '218330CSI', '225502CSI', '225506CSI', '225508CSI', '225530CSI', '225531CSI', '225532CSI', '235830CLQ'
) then SABA = 1; else SABA = 0;
if GNL_NM_CD in ('334400CAE', '334800CAE', '401800CSI', '334800CAE'
) then SABASAMA = 1; else SABASAMA = 0;
if GNL_NM_CD in ('177101CLQ', '177103CLQ', '177104CAE', '177101CLQ', '177103CLQ', '177104CAE', '177131CLQ', '177131CLQ', '177103CLQ', '177131CLQ'
) then SAMA = 1; else SAMA = 0;
run;

proc sort data = M30_2; by RN_KEY; run;
proc sort data = M60_2; by RN_KEY; run;

data inhaler; set M30_2 M60_2; 
year=substr(MDCARE_STRT_DT,1,4)*1; 
if year = 2015 then delete; run; /*설명서에는 T60 날짜는 MCARE_STRT_DT라고 써있음, 체크 필요*/ /*2015년 기록은 삭제함*/

proc freq data = inhaler; table ics icslaba laba lama saba sabasama sama; run;

proc sql noprint;
	create table inhaler_2 as
	select  RN_INDI, RN_KEY, year, MDCARE_STRT_DT, sum(inhalator) as inhaler_count
	from inhaler
	group by RN_INDI, year; quit;

data inhaler_3; set inhaler_2;
if inhaler_count < 2 then delete; 
rename MDCARE_STRT_DT = inhaler_first; run;

proc sort data = inhaler_3; by RN_INDI inhaler_first; run;
proc sort data = inhaler_3 out = inhaler_f nodupkey; by RN_INDI; run;

data ICS; set inhaler; if ICS = 0 then delete; rename MDCARE_STRT_DT = ICS_first; run;
proc sort data = ICS; by RN_INDI ICS_first; run;
proc sort data = ICS out = ICS_f(keep = RN_INDI ICS_first ICS) nodupkey; by RN_INDI; run; 

data ICSLABA; set inhaler; if ICSLABA = 0 then delete; rename MDCARE_STRT_DT = ICSLABA_first; run;
proc sort data = ICSLABA; by RN_INDI ICSLABA_first; run;
proc sort data = ICSLABA out = ICSLABA_f(keep = RN_INDI ICSLABA_first ICSLABA) nodupkey; by RN_INDI; run; 

data LABA; set inhaler; if LABA = 0 then delete; rename MDCARE_STRT_DT = LABA_first; run;
proc sort data = LABA; by RN_INDI LABA_first; run;
proc sort data = LABA out = LABA_f(keep = RN_INDI LABA_first LABA) nodupkey; by RN_INDI; run; 

data LAMA; set inhaler; if LAMA = 0 then delete; rename MDCARE_STRT_DT = LAMA_first; run;
proc sort data = LAMA; by RN_INDI LAMA_first; run;
proc sort data = LAMA out = LAMA_f(keep = RN_INDI LAMA_first LAMA) nodupkey; by RN_INDI; run; 

data SABA; set inhaler; if SABA = 0 then delete; rename MDCARE_STRT_DT = SABA_first; run;
proc sort data = SABA; by RN_INDI SABA_first; run;
proc sort data = SABA out = SABA_f(keep = RN_INDI SABA_first SABA) nodupkey; by RN_INDI; run; 

data SABASAMA; set inhaler; if SABASAMA = 0 then delete; rename MDCARE_STRT_DT = SABASAMA_first; run;
proc sort data = SABASAMA; by RN_INDI SABASAMA_first; run;
proc sort data = SABASAMA out = SABASAMA_f(keep = RN_INDI SABASAMA_first SABASAMA) nodupkey; by RN_INDI; run; 

data SAMA; set inhaler; if SAMA = 0 then delete; rename MDCARE_STRT_DT = SAMA_first; run;
proc sort data = SAMA; by RN_INDI SAMA_first; run;
proc sort data = SAMA out = SAMA_f(keep = RN_INDI SAMA_first SAMA) nodupkey; by RN_INDI; run; 


/*7-2번 LAMA용량 계산하기*/
/*날짜나 숫자 지우기 할때 0 포함해야지 안그러면 결측값 지워짐*/
proc sort data = lama; by RN_INDI; run;
proc sort data = dead_f; by RN_INDI; run;
proc sort data = copd_f; by RN_INDI; run;
proc sort data = cvd_f; by RN_INDI; run;
proc sort data = censor_f; by RN_INDI; run;

data lamadose; merge lama dead_f copd_f cvd_f censor_f; by RN_INDI; if RN_KEY = . then delete; 
lama_first2 = lama_first*1; copd_first2 = copd_first*1; cvd_first2 = cvd_first*1; censor_date2 = censor_date*1; death_date2 = death_date*1;
if lama_first2 < copd_first2 	  		 then delete;
if lama_first2 > cvd_first2  		 > 0   then delete;
if lama_first2 > censor_date2 > 0   then delete;
if lama_first2 > death_date2  	 > 0   then delete; run;

data lamadose2; set lamadose; 
if MCARE_DIV_CD = '457301CCH' then dose = 22.5; if MCARE_DIV_CD = '457301CPK' then dose = 22.5; if MCARE_DIV_CD = '457301CSI' then dose = 22.5;
if MCARE_DIV_CD = '503401CSI' then dose = 1272.15; if MCARE_DIV_CD = '457301CCH' then dose = 22.5; if MCARE_DIV_CD = '457301CSI' then dose = 22.5;
if MCARE_DIV_CD = '503401CSI' then dose = 1272.15; if MCARE_DIV_CD = '457301CCH' then dose = 22.5; if MCARE_DIV_CD = '457301CCH' then dose = 22.5;
if MCARE_DIV_CD = '457301CSI' then dose = 22.5; if MCARE_DIV_CD = '457301CSI' then dose = 22.5; if MCARE_DIV_CD = '457330CSI' then dose = 22.5;
if MCARE_DIV_CD = '457330CSI' then dose = 22.5; if MCARE_DIV_CD = '503401CSI' then dose = 1272.15; if MCARE_DIV_CD = '503430CSI' then dose = 150;
if MCARE_DIV_CD = '633701CSI' then dose = 24000; if MCARE_DIV_CD = '633730CSI' then dose = 24000; if MCARE_DIV_CD = '635903CSI' then dose = 1890;
if MCARE_DIV_CD = '641101CSI' then dose = 2226; if MCARE_DIV_CD = '457301CCH' then dose = 22.5; if MCARE_DIV_CD = '457301CSI' then dose = 22.5;
if MCARE_DIV_CD = '457330CSI' then dose = 22.5; if MCARE_DIV_CD = '503401CSI' then dose = 1272.15; if MCARE_DIV_CD = '503430CSI' then dose = 150;
if MCARE_DIV_CD = '633701CSI' then dose = 24000; if MCARE_DIV_CD = '633730CSI' then dose = 24000; if MCARE_DIV_CD = '635903CSI' then dose = 1890; if MCARE_DIV_CD = '641101CSI' then dose = 2226; 

if GNL_NM_CD = '457301CCH' then dose = 22.5; if GNL_NM_CD = '457301CPK' then dose = 22.5; if GNL_NM_CD = '457301CSI' then dose = 22.5;
if GNL_NM_CD = '503401CSI' then dose = 1272.15; if GNL_NM_CD = '457301CCH' then dose = 22.5; if GNL_NM_CD = '457301CSI' then dose = 22.5;
if GNL_NM_CD = '503401CSI' then dose = 1272.15; if GNL_NM_CD = '457301CCH' then dose = 22.5; if GNL_NM_CD = '457301CCH' then dose = 22.5;
if GNL_NM_CD = '457301CSI' then dose = 22.5; if GNL_NM_CD = '457301CSI' then dose = 22.5; if GNL_NM_CD = '457330CSI' then dose = 22.5;
if GNL_NM_CD = '457330CSI' then dose = 22.5; if GNL_NM_CD = '503401CSI' then dose = 1272.15; if GNL_NM_CD = '503430CSI' then dose = 150;
if GNL_NM_CD = '633701CSI' then dose = 24000; if GNL_NM_CD = '633730CSI' then dose = 24000; if GNL_NM_CD = '635903CSI' then dose = 1890;
if GNL_NM_CD = '641101CSI' then dose = 2226; if GNL_NM_CD = '457301CCH' then dose = 22.5; if GNL_NM_CD = '457301CSI' then dose = 22.5;
if GNL_NM_CD = '457330CSI' then dose = 22.5; if GNL_NM_CD = '503401CSI' then dose = 1272.15; if GNL_NM_CD = '503430CSI' then dose = 150;
if GNL_NM_CD = '633701CSI' then dose = 24000; if GNL_NM_CD = '633730CSI' then dose = 24000; if GNL_NM_CD = '635903CSI' then dose = 1890; if GNL_NM_CD = '641101CSI' then dose = 2226; 

dose_2 = dose * TOT_MCNT; run;

proc sql noprint;
	create table lamadose_f as
	select RN_INDI, sum(dose_2) as dose_f
    from lamadose2
	    group by RN_INDI; quit;


/*8번 COPD진단 년도의 age, sex, income level 추출*/
data covar; set Copd_f; year_c=substr(copd_first,1,4)*1; run;
data bnc_2; set bnc; STD_YYYY_2 = STD_YYYY*1; run;
data bnd_2; set bnd; BTH_YYYY_2 = BTH_YYYY*1; run;

proc sql; create table covar2 as
select *
from covar as a left join bnc_2 as b
	on a.RN_INDI = b.RN_INDI and a.year_c = b.STD_YYYY_2; quit;

proc sort data = covar2; by RN_INDI; run; 
proc sort data = bnd_2; by RN_INDI; RUN;  
data covar3; merge covar2 bnd_2; by RN_INDI; age =  year_c - BTH_YYYY; RUN;

data covar_f(keep = RN_INDI age SEX CTRB_Q10); set covar3; run;


/*9번, Criteria에 따른 최종 환자 선정*/
proc sort data = bnd; by RN_INDI; run;
proc sort data = asthma_f; by RN_INDI; run;
proc sort data = censor_f; by RN_INDI; run;
proc sort data = copd_f; by RN_INDI; run;
proc sort data = cvd_f; by RN_INDI; run;
proc sort data = dead_f; by RN_INDI; run;
proc sort data = gj_f; by RN_INDI; run;
proc sort data = inhaler_f; by RN_INDI; run;
proc sort data = lama_f; by RN_INDI; run;
proc sort data = lamadose_f; by RN_INDI; run;
proc sort data = lungca_f; by RN_INDI; run;
proc sort data = washout_f; by RN_INDI; run;
proc sort data = covar_f; by RN_INDI; run;
proc sort data = cci_f; by RN_INDI; run;

data final; merge asthma_f censor_f copd_f cvd_f dead_f gj_f inhaler_f lama_f lamadose_f lungca_f washout_f bnd covar_f cci_f; by RN_INDI; 
year_c=substr(censor_date,1,4)*1;   month_c=substr(censor_date,5,2)*1;   day_c=substr(censor_date, 7,2)*1;   censor_date2=MDY(month_c,day_c,year_c); format censor_date2 mmddyy8. ;
year_c=substr(asthma_first,1,4)*1;    month_c=substr(asthma_first,5,2)*1;    day_c=substr(asthma_first, 7,2)*1;    asthma_first2=MDY(month_c,day_c,year_c);  format asthma_first2 mmddyy8. ;
year_c=substr(cvd_first,1,4)*1; 		  month_c=substr(cvd_first,5,2)*1; 	       day_c=substr(cvd_first, 7,2)*1; 		  cvd_first2=MDY(month_c,day_c,year_c);		format cvd_first2 mmddyy8. ;
year_c=substr(copd_first,1,4)*1; 	  month_c=substr(copd_first,5,2)*1; 	   day_c=substr(copd_first, 7,2)*1; 	      copd_first2=MDY(month_c,day_c,year_c); 	    format copd_first2 mmddyy8. ;
year_c=substr(inhaler_first,1,4)*1;  	  month_c=substr(inhaler_first,5,2)*1;     day_c=substr(inhaler_first, 7,2)*1;     inhaler_first2=MDY(month_c,day_c,year_c);   format inhaler_first2 mmddyy8. ;
year_c=substr(lama_first,1,4)*1; 		  month_c=substr(lama_first,5,2)*1; 	   day_c=substr(lama_first, 7,2)*1; 	      lama_first2=MDY(month_c,day_c,year_c); 	    format lama_first2 mmddyy8. ;
year_c=substr(lungca_first,1,4)*1;    month_c=substr(lungca_first,5,2)*1;     day_c=substr(lungca_first, 7,2)*1;      lungca_first2=MDY(month_c,day_c,year_c);  format lungca_first2 mmddyy8. ;
year_c=substr(death_date,1,4)*1; 	  month_c=substr(death_date,5,2)*1; 	   day_c=substr(death_date, 7,2)*1; 	  death_date2=MDY(month_c,day_c,year_c); 	format death_date2 mmddyy8. ; 
run;

data a.final_2; set final(drop = asthma_first cvd_first copd_first inhaler_first lama_first lungca_first death_date);
rename asthma_first2 = asthma_first; rename cvd_first2 = cvd_first; rename copd_first2 = copd_first; rename inhaler_first2 = inhaler_first; rename lama_first2 = lama_first; rename lungca_first2 = lungca_first; rename death_date2 = death_first; run;

data a.final_3; set final_2;
if charlson = . then charlson = 0;

if copd = . then delete; 
if copd_washout = 1 then delete;

if gk = . then delete; 
if age = . then delete; if age < 30 then delete; if age > 90 then delete;

if inhaler_count = . then delete;
if 0< inhaler_first < copd_first then delete; 

if 0< cvd_first < inhaler_first then delete; run;


/*10번, non-LAMA vs. LAMA 비교용 time-dependent set 만들기*/
data a.final_4; set final_2; /*final_2 는 a.final3으로 바꿔서 돌려야함!!!*/
format censor_date3 MMDDYY8. ;
if death_first < censor_date2 then censor_date3 = death_first;
if cvd_first < censor_date2 then censor_date3 = cvd_first;
if censor_date3 = . then censor_date3 = censor_date2; 
if cvd = 1 then event = 1; else event = 0;

if LAMA = 1 then tm_surg = lama_first - inhaler_first; else tm_surg = .; 
futime = censor_date3 - inhaler_first; 
if futime = . then delete; if tm_surg > 0 and tm_surg > futime then delete; if futime < 0 then delete; /*이 줄은 지워야 함*/
run;  


/*11번, LAMA cumulative 비교용 time-dependent set 만들기*/
/*같은 날짜에 처방 받은 용량 합치기*/
proc sql noprint;
	create table cumulative as
	select RN_INDI, lama_first2, sum(dose_2) as dose_cum
    from lamadose2
	    group by RN_INDI, lama_first2; quit;

data cumulative_2(keep = RN_INDI dose_cum lama_first3); set cumulative;
LAMA_first = put(lama_first2, 8.); 
year_c=substr(LAMA_first,1,4)*1;   month_c=substr(LAMA_first,5,2)*1;   day_c=substr(LAMA_first, 7,2)*1;   lama_first3=MDY(month_c,day_c,year_c); format lama_first3 mmddyy8. ; run;

/*pbcseq에 해당하는 데이터만 만든다*/
proc sort data = a.final_4; by RN_INDI; run;
proc sort data = cumulative_2; by RN_INDI; run;

data a.final_5(keep = RN_INDI dose_cum day); merge cumulative_2 a.final_4; by RN_INDI; 
if dose_f > 0 then day = lama_first3 - inhaler_first; else day = censor_date3 - inhaler_first; 
if dose_cum = . then dose_cum = 0; run;


/*용량 확인*/
proc sort data = a.final_3; by RN_INDI; run;
proc sort data = lamadose_f; by RN_INDI; run;
data example; merge lamadose_f a.final_3; by RN_INDI; if censor_date2 = . then delete; run; 

proc univariate data=example; var dose_f; run;







/*BMI, smoking status, CCI -> CVD 환자의 경우 CVD 진단 년도에서 most nearest 년도의 기록을 쓰고, Non-CVD 환자는 가장 recent 기록을 씀*/
/*age, sex, income level -> COPD진단 시기 사용

/*이거 써야하나? if lama_first > cvd_first > 0 then lama_first = .; */
/*lamadose2가지고 용량 time-dependent만들어라*/
