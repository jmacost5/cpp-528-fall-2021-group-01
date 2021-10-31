
> df.years[!(is.null())]
Error in is.null() : 0 arguments passed to 'is.null' which requires 1
> df.years[!(is.null(x1970.f))]
Error in `[.data.frame`(df.years, !(is.null(x1970.f))) : 
  object 'x1970.f' not found
> df.years[!(is.null("x1970.f"))]
root   root2        category
1     state   state              id
2    county  county              id
3     tract   tract              id
4     trtid   trtid              id
5      cbsa    cbsa tract attribute
6    ccflag  ccflag tract attribute
7    metdiv  metdiv tract attribute
8   placefp placefp tract attribute
9     globd   globd tract attribute
10    globg   globg tract attribute
11  placefp placefp tract attribute
12     cbsa    cbsa tract attribute
13   metdiv  metdiv tract attribute
14   ccflag  ccflag tract attribute
15   a15asn  a15asn        age-race
16   a15blk  a15blk        age-race
17   a15hsp  a15hsp        age-race
18   a15ntv  a15ntv        age-race
19   a15wht  a15wht        age-race
20   a18und  a18und             age
21   a60asn  a60asn        age-race
22   a60blk  a60blk        age-race
23   a60hsp  a60hsp        age-race
24   a60ntv  a60ntv        age-race
25    a60up   a60up             age
26   a60wht  a60wht        age-race
27   a65asn  a65asn        age-race
28   a65blk  a65blk        age-race
29   a65hsp  a65hsp        age-race
30   a65ntv  a65ntv        age-race
31   a65wht  a65wht        age-race
32    a75up   a75up             age
33   ag15up  ag15up             age
34   ag16cv  ag16cv             age
35   ag18cv  ag18cv             age
36   ag25up  ag25up             age
37    ag5up   ag5up             age
38   ageasn  ageasn        age-race
39   ageblk  ageblk        age-race
40   agehsp  agehsp        age-race
41   agentv  agentv        age-race
42   agewht  agewht        age-race
43    asian   asian            race
44    black   black            race
45    china   china            race
46      clf     clf             ses
47   cni16u  cni16u         ses-age
48      col     col             ses
49    cuban   cuban       ethnicity
50    dapov   dapov        ses-race
51    dbpov   dbpov        ses-race
52      dfb     dfb    demographics
53   dflabf  dflabf             age
54   dfmpov  dfmpov             ses
55    dhpov   dhpov        ses-race
56      dis     dis             ses
57   dmulti  dmulti         housing
58   dnapov  dnapov        ses-race
59     dpov    dpov             ses
60    dwpov   dwpov        ses-race
61   empclf  empclf         ses-age
62   family  family    demographics
63       fb      fb                
64      fhh     fhh      ses-gender
65    filip   filip            race
66    flabf   flabf      ses-gender
67    geanc   geanc       ethnicity
68     gefb    gefb     immigration
69   h10yrs  h10yrs         housing
70   h30old  h30old         housing
71      haw     haw            race
72       hh      hh    demographics
73      hha     hha       ethnicity
74      hhb     hhb       ethnicity
75      hhh     hhh       ethnicity
76      hhw     hhw       ethnicity
77     hinc    hinc             ses
78    hinca   hinca        ses-race
79    hincb   hincb        ses-race
80    hinch   hinch        ses-race
81    hincw   hincw        ses-race
82     hisp    hisp       ethnicity
83       hs      hs             ses
84       hu      hu         housing
85     hu00    hu00                
86     hu70    hu70                
87     hu80    hu80                
88     hu90    hu90                
89    incpc   incpc             ses
90    india   india            race
91    iranc   iranc       ethnicity
92     irfb    irfb     immigration
93    itanc   itanc       ethnicity
94     itfb    itfb     immigration
95    japan   japan            race
96    korea   korea            race
97      lep     lep        language
98    manuf   manuf             ses
99      mar     mar             ses
100     mar    mar.             ses
101     mar   x12.m             ses
102     mex     mex       ethnicity
103  mhmval  mhmval         housing
104   mrent   mrent         housing
105   multi   multi         housing
106  n10imm  n10imm     immigration
107  n65pov  n65pov         ses-age
108   napov   napov        ses-race
109     nat     nat     immigration
110   nbpov   nbpov        ses-race
111  nfmpov  nfmpov             ses
112   nhblk   nhblk            race
113   nhpov   nhpov        ses-race
114   nhwht   nhwht            race
115  nnapov  nnapov        ses-race
116    npov    npov             ses
117     ntv     ntv            race
118   nwpov   nwpov        ses-race
119     ohu     ohu         housing
120   ohu00   ohu00                
121   ohu70   ohu70                
122   ohu80   ohu80                
123   ohu90   ohu90                
124   olang   olang        language
125     own     own         housing
definition
1                                                                                                                                                                      
2                                                                                                                                                                      
3                                                                                                                                                                      
4                                                                                                                                                                      
5                                                                                                                                                                      
6                                                                                                                                                                      
7                                                                                                                                                                      
8                                                                                                                                                                      
9                                                                                                                                                                      
10                                                                                                                                                                     
11                                                                                                                                                                     
12                                                                                                                                                                     
13                                                                                                                                                                     
14                                                                                                                                                                     
15  0-15 years old of Asians and Pacific Islanders (in 1980, 0-14 years old of Asians/Pacific Islanders; in 2008-12 ACS, 0-14 years old of Asian/Pacific Islander race)
16                                                  0-15 years old of black race (in 1980, 0-14 years old of black race; in 2006- 10 ACS, 0-14 years old of black race)
17       0-15 years old, persons of Hispanic origins (in 1980, 0-14 years old, persons of Hispanic origin; in 2008-12 ACS, 0-14 years old, persons of Hispanic origins)
18                     0-15 years old of Native American race (in 1980, 0-14 years old of Native American race; in 2008-12 ACS, 0-14 years old of Native American race)
19                                                  0-15 years old of white race (in 1980, 0-14 years old of white race; in 2006- 10 ACS, 0-14 years old of white race)
20                                                                                                                                       persons age 17 years and under
21                                                                                                                   60 years and older of Asians and Pacific Islanders
22                                                                                                                                     60 years and older of black race
23                                                                                                                      60 years and older, persons of Hispanic origins
24                                                                                                                           60 years and older of Native American race
25                                                                                                                                        persons age 60 years and over
26                                                                                                                                     60 years and older of white race
27                                                                                                                   65 years and older of Asians and Pacific Islanders
28                                                                                                                                     65 years and older of black race
29                                                                                                                      65 years and older, persons of Hispanic origins
30                                                                                                                           65 years and older of Native American race
31                                                                                                                            65 years and older of non-Hispanic whites
32                                                                                                                                        persons age 75 years and over
33                                                                                                 population 15 years and over (in 1970, population 14 years and over)
34                                                                                                                                civilian population 16 years and over
35                                                                                                                                civilian population 18 years and over
36                                                                                                                                         population 25 years and over
37                                                                                                                                             persons 5 years and over
38                                                                                                    Asian and Pacific Islander population with known age distribution
39                                                                                                                         black population with known age distribution
40                                                                                                                      Hispanic population with known age distribution
41                                                                                                               Native American population with known age distribution
42                                                                                                                         white population with known age distribution
43                                                                                                                         persons of Asian race (and Pacific Islander)
44                                                                                                                                                persons of black race
45                                                                                                                                              persons of Chinese race
46                                                                                                                               civilian labor force 16 years and over
47                                                                                                               civilian non-institutionalized persons 16-64 years old
48                                                                                                                                                    college education
49                                                                                                                                                               Cubans
50                                                                                                   Asians and Pacific Islanders for whom poverty status is determined
51                                                                                                                  black persons for whom poverty status is determined
52                                                                                                                              total population from sample-based data
53                                                                                                                    females 16 years and over, except in armed forces
54                                                                                                                       families for whom poverty status is determined
55                                                                                                                      Hispanics for whom poverty status is determined
56                                                                                                                                              percent with disability
57                                                                                                                                                        housing units
58                                                                                                                Native American for whom poverty status is determined
59                                                                                                                        persons for whom poverty status is determined
60                                                                                                                  white persons for whom poverty status is determined
61                                                                                                                                   employed persons 16 years and over
62                                                                                                                                                       total families
63                                                                                                                                                         foreign-born
64                                                                                                                                 female-headed families with children
65                                                                                                                                             persons of Filipino race
66                                                                                                                                               females in labor force
67                                                                                                                              persons of German parentage or ancestry
68                                                                                                                                     persons who were born in Germany
69                                                         household heads moved into unit less than 10 years ago (in 2008-12 ACS, householders moved in 2000 or later)
70                                                                           structures built more than 30 years ago (in 2008-12 ACS, structures built 1979 or earlier)
71                                                                                                                                             persons of Hawaiian race
72                                                                                                                                total households in sample-based data
73                                                                                                         total Asian/Pacific Islander households in sample-based data
74                                                                                                                          total black households in sample-based data
75                                                                                                                       total hispanic households in sample-based data
76                                                                                                                          total white households in sample-based data
77                                                                                                                                              Median HH income, total
78                                                                                                                                           Median HH income, Asian/PI
79                                                                                                                                             Median HH income, blacks
80                                                                                                                                          Median HH income, Hispanics
81                                                                                                                                             Median HH income, whites
82                                                                                                                                           persons of Hispanic origin
83                                                                                                                              persons with high school degree or less
84                                                                                                                                                        housing units
85                                                                                                                                                                     
86                                                                                                                                                                     
87                                                                                                                                                                     
88                                                                                                                                                                     
89                                                                                                                                                    Per capita income
90                                                                                                                                         persons of Asian Indian race
91                                                                                                                               persons of Irish parentage or ancestry
92                                                                                                                                     persons who were born in Ireland
93                                                                                                                             persons of Italian parentage or ancestry
94                                                                                                                                       persons who were born in Italy
95                                                                                                                                             persons of Japanese race
96                                                                                                                                               persons of Korean race
97                                                                                                                                   persons who speak English not well
98                                                                                                                              manufacturing employees (by industries)
99                                                                                                                              currently married (excluding separated)
100                                                                                                                             currently married (excluding separated)
101                                                                                                                             currently married (excluding separated)
102                                                                                                                                                            Mexicans
103                                                                                                                                                   Median home value
104                                                                                                                                                         Median rent
105                                                                                                                              housing units in multi-unit structures
106                                                                                                                        recent immigrants (within the past 10 years)
107                                                                                                                               persons 65 years and older in poverty
108                                                                                                                             Asians and Pacific Islanders in poverty
109                                                                                                                                            naturalized foreign-born
110                                                                                                                                                   blacks in poverty
111                                                                                                                                   families with children in poverty
112                                                                                                                          persons of black race, not Hispanic origin
113                                                                                                                                                Hispanics in poverty
114                                                                                                                          persons of white race, not Hispanic origin
115                                                                                                                                         Native Americans in poverty
116                                                                                                                                                  persons in poverty
117                                                                                                                                     persons of Native American race
118                                                                                                                                                   whites in poverty
119                                                                                                                                              occupied housing units
120                                                                                                                                                                    
121                                                                                                                                                                    
122                                                                                                                                                                    
123                                                                                                                                                                    
124                                                                                                               persons who speak language other than English at home
125                                                                                                                                        owner-occupied housing units
X1970.f   X1970.s   X1980.f   X1980.s
1       state     state     state     state
2      county    county    county    county
3       tract     tract     tract     tract
4     TRTID10   TRTID10   TRTID10   trtid10
5      cbsa10    cbsa10    cbsa10    cbsa10
6    ccflag10  ccflag10  ccflag10  ccflag10
7    metdiv10  metdiv10  metdiv10  metdiv10
8   placefp10 placefp10 placefp10 placefp10
9                         GlobD80          
10                        GlobG80          
11                      placefp10 placefp10
12                         cbsa10    cbsa10
13                       metdiv10  metdiv10
14                       ccflag10  ccflag10
15                                 a15asn80
16   A15BLK70                      a15blk80
17                                 a15hsp80
18                                 a15ntv80
19   A15WHT70                      a15wht80
20   A18UND70            A18UND80          
21                                 a60asn80
22   A60BLK70                      a60blk80
23                                 a60hsp80
24                                 a60ntv80
25    A60UP70             A60UP80          
26   A60WHT70                      a60wht80
27                                         
28                                         
29                                         
30                                         
31                                         
32    A75UP70             A75UP80          
33   AG15UP70            AG15UP80          
34             AG16CV70            ag16cv80
35                                         
36             AG25UP70            ag25up80
37                                  ag5up80
38                                 ageasn80
39   AGEBLK70                      ageblk80
40                                 agehsp80
41                                 agentv80
42   AGEWHT70                      agewht80
43    ASIAN70             ASIAN80          
44    BLACK70                              
45    CHINA70             CHINA80          
46                CLF70               clf80
47             CNI16U70            cni16u80
48                COL70               col80
49              CUBAN70   CUBAN80          
50                                  dapov80
51              DBPOV70             dbpov80
52                                    dfb80
53             DFLABF70            dflabf80
54             DFMPOV70            dfmpov80
55                                  dhpov80
56                DIS70               dis80
57   DMULTI70                      dmulti80
58                                 dnapov80
59               DPOV70              dpov80
60              DWPOV70             dwpov80
61             EMPCLF70            empclf80
62             FAMILY70            family80
63                 FB70                fb80
64                FHH70               fhh80
65    FILIP70             FILIP80          
66              FLABF70             flabf80
67              GEANC70             geanc80
68               GEFB70              gefb80
69             H10YRS70            h10yrs80
70             H30OLD70            h30old80
71      HAW70               HAW80          
72                 HH70                hh80
73                                    hha80
74                                    hhb80
75                                    hhh80
76                                    hhw80
77               HINC70              hinc80
78                                  hinca80
79                                  hincb80
80                                  hinch80
81                                  hincw80
82                         HISP80          
83                 HS70                hs80
84       HU70                HU80          
85                                         
86               HU70SP                    
87                                   hu80sp
88                                         
89              INCPC70             incpc80
90    INDIA70             INDIA80          
91              IRANC70             iranc80
92               IRFB70              irfb80
93              ITANC70             itanc80
94               ITFB70              itfb80
95    JAPAN70             JAPAN80          
96    KOREA70             KOREA80          
97                                    lep80
98              MANUF70             manuf80
99     Mar-70              Mar-80          
100                                        
101                                        
102               MEX70     MEX80          
103            MHMVAL70  MHMVAL80          
104             MRENT70   MRENT80          
105   MULTI70                       multi80
106            N10IMM70            n10imm80
107            N65POV70            n65pov80
108                                 napov80
109               NAT70               nat80
110             NBPOV70             nbpov80
111            NFMPOV70            nfmpov80
112                       NHBLK80          
113                                 nhpov80
114                       NHWHT80          
115                                nnapov80
116              NPOV70              npov80
117                         NTV80          
118             NWPOV70             nwpov80
119     OHU70               OHU80          
120                                        
121             OHU70SP                    
122                                 ohu80sp
123                                        
124                                 olang80
125     OWN70               OWN80          
[ reached 'max' / getOption("max.print") -- omitted 86 rows ]
> df.years[!(is.null(df.years$x1970.f))]
data frame with 0 columns and 211 rows
> head(df.years)
root  root2        category definition  X1970.f  X1970.s  X1980.f  X1980.s
1  state  state              id               state    state    state    state
2 county county              id              county   county   county   county
3  tract  tract              id               tract    tract    tract    tract
4  trtid  trtid              id             TRTID10  TRTID10  TRTID10  trtid10
5   cbsa   cbsa tract attribute              cbsa10   cbsa10   cbsa10   cbsa10
6 ccflag ccflag tract attribute            ccflag10 ccflag10 ccflag10 ccflag10
> head(df.years, 20)
root   root2        category
1    state   state              id
2   county  county              id
3    tract   tract              id
4    trtid   trtid              id
5     cbsa    cbsa tract attribute
6   ccflag  ccflag tract attribute
7   metdiv  metdiv tract attribute
8  placefp placefp tract attribute
9    globd   globd tract attribute
10   globg   globg tract attribute
11 placefp placefp tract attribute
12    cbsa    cbsa tract attribute
13  metdiv  metdiv tract attribute
14  ccflag  ccflag tract attribute
15  a15asn  a15asn        age-race
16  a15blk  a15blk        age-race
17  a15hsp  a15hsp        age-race
18  a15ntv  a15ntv        age-race
19  a15wht  a15wht        age-race
20  a18und  a18und             age
definition
1                                                                                                                                                                     
2                                                                                                                                                                     
3                                                                                                                                                                     
4                                                                                                                                                                     
5                                                                                                                                                                     
6                                                                                                                                                                     
7                                                                                                                                                                     
8                                                                                                                                                                     
9                                                                                                                                                                     
10                                                                                                                                                                    
11                                                                                                                                                                    
12                                                                                                                                                                    
13                                                                                                                                                                    
14                                                                                                                                                                    
15 0-15 years old of Asians and Pacific Islanders (in 1980, 0-14 years old of Asians/Pacific Islanders; in 2008-12 ACS, 0-14 years old of Asian/Pacific Islander race)
16                                                 0-15 years old of black race (in 1980, 0-14 years old of black race; in 2006- 10 ACS, 0-14 years old of black race)
17      0-15 years old, persons of Hispanic origins (in 1980, 0-14 years old, persons of Hispanic origin; in 2008-12 ACS, 0-14 years old, persons of Hispanic origins)
18                    0-15 years old of Native American race (in 1980, 0-14 years old of Native American race; in 2008-12 ACS, 0-14 years old of Native American race)
19                                                 0-15 years old of white race (in 1980, 0-14 years old of white race; in 2006- 10 ACS, 0-14 years old of white race)
20                                                                                                                                      persons age 17 years and under
X1970.f   X1970.s   X1980.f   X1980.s
1      state     state     state     state
2     county    county    county    county
3      tract     tract     tract     tract
4    TRTID10   TRTID10   TRTID10   trtid10
5     cbsa10    cbsa10    cbsa10    cbsa10
6   ccflag10  ccflag10  ccflag10  ccflag10
7   metdiv10  metdiv10  metdiv10  metdiv10
8  placefp10 placefp10 placefp10 placefp10
9                        GlobD80          
10                       GlobG80          
11                     placefp10 placefp10
12                        cbsa10    cbsa10
13                      metdiv10  metdiv10
14                      ccflag10  ccflag10
15                                a15asn80
16  A15BLK70                      a15blk80
17                                a15hsp80
18                                a15ntv80
19  A15WHT70                      a15wht80
20  A18UND70            A18UND80          
> head(df.years, 15)
root   root2        category
1    state   state              id
2   county  county              id
3    tract   tract              id
4    trtid   trtid              id
5     cbsa    cbsa tract attribute
6   ccflag  ccflag tract attribute
7   metdiv  metdiv tract attribute
8  placefp placefp tract attribute
9    globd   globd tract attribute
10   globg   globg tract attribute
11 placefp placefp tract attribute
12    cbsa    cbsa tract attribute
13  metdiv  metdiv tract attribute
14  ccflag  ccflag tract attribute
15  a15asn  a15asn        age-race
definition
1                                                                                                                                                                     
2                                                                                                                                                                     
3                                                                                                                                                                     
4                                                                                                                                                                     
5                                                                                                                                                                     
6                                                                                                                                                                     
7                                                                                                                                                                     
8                                                                                                                                                                     
9                                                                                                                                                                     
10                                                                                                                                                                    
11                                                                                                                                                                    
12                                                                                                                                                                    
13                                                                                                                                                                    
14                                                                                                                                                                    
15 0-15 years old of Asians and Pacific Islanders (in 1980, 0-14 years old of Asians/Pacific Islanders; in 2008-12 ACS, 0-14 years old of Asian/Pacific Islander race)
X1970.f   X1970.s   X1980.f   X1980.s
1      state     state     state     state
2     county    county    county    county
3      tract     tract     tract     tract
4    TRTID10   TRTID10   TRTID10   trtid10
5     cbsa10    cbsa10    cbsa10    cbsa10
6   ccflag10  ccflag10  ccflag10  ccflag10
7   metdiv10  metdiv10  metdiv10  metdiv10
8  placefp10 placefp10 placefp10 placefp10
9                        GlobD80          
10                       GlobG80          
11                     placefp10 placefp10
12                        cbsa10    cbsa10
13                      metdiv10  metdiv10
14                      ccflag10  ccflag10
15                                a15asn80
> helP(across)
Error in helP(across) : could not find function "helP"
> help(across)
> df.years <- data %>%
  +   select(root, root2, category, definition, contains(search.years)) %>%
  +   mutate(across(where(!(isl.null))))
Error: Problem with `mutate()` input `..1`.
i `..1 = across(where(!(isl.null)))`.
x object 'isl.null' not found
Run `rlang::last_error()` to see where the error occurred.
> df.years <- data %>%
  +   select(root, root2, category, definition, contains(search.years)) %>%
  +   mutate(across(where(!(is.null))))
Error: Problem with `mutate()` input `..1`.
i `..1 = across(where(!(is.null)))`.
x invalid argument type
Run `rlang::last_error()` to see where the error occurred.
> df.years <- data %>%
  +   select(root, root2, category, definition, contains(search.years)) %>%
  +   na.omit(>4)
Error: unexpected '>' in:
  "  select(root, root2, category, definition, contains(search.years)) %>%
  na.omit(>"
> df.years <- data %>%
  +   select(root, root2, category, definition, contains(search.years)) %>%
  +   na.omit(4)
> head(df.years, 15)
root   root2        category
1    state   state              id
2   county  county              id
3    tract   tract              id
4    trtid   trtid              id
5     cbsa    cbsa tract attribute
6   ccflag  ccflag tract attribute
7   metdiv  metdiv tract attribute
8  placefp placefp tract attribute
9    globd   globd tract attribute
10   globg   globg tract attribute
11 placefp placefp tract attribute
12    cbsa    cbsa tract attribute
13  metdiv  metdiv tract attribute
14  ccflag  ccflag tract attribute
15  a15asn  a15asn        age-race
definition
1                                                                                                                                                                     
2                                                                                                                                                                     
3                                                                                                                                                                     
4                                                                                                                                                                     
5                                                                                                                                                                     
6                                                                                                                                                                     
7                                                                                                                                                                     
8                                                                                                                                                                     
9                                                                                                                                                                     
10                                                                                                                                                                    
11                                                                                                                                                                    
12                                                                                                                                                                    
13                                                                                                                                                                    
14                                                                                                                                                                    
15 0-15 years old of Asians and Pacific Islanders (in 1980, 0-14 years old of Asians/Pacific Islanders; in 2008-12 ACS, 0-14 years old of Asian/Pacific Islander race)
X1970.f   X1970.s   X1980.f   X1980.s
1      state     state     state     state
2     county    county    county    county
3      tract     tract     tract     tract
4    TRTID10   TRTID10   TRTID10   trtid10
5     cbsa10    cbsa10    cbsa10    cbsa10
6   ccflag10  ccflag10  ccflag10  ccflag10
7   metdiv10  metdiv10  metdiv10  metdiv10
8  placefp10 placefp10 placefp10 placefp10
9                        GlobD80          
10                       GlobG80          
11                     placefp10 placefp10
12                        cbsa10    cbsa10
13                      metdiv10  metdiv10
14                      ccflag10  ccflag10
15                                a15asn80
> df.years <- data %>%
  +   select(root, root2, category, definition, contains(search.years)) %>%
  +   na.omit()
> head(df.years, 15)
root   root2        category
1    state   state              id
2   county  county              id
3    tract   tract              id
4    trtid   trtid              id
5     cbsa    cbsa tract attribute
6   ccflag  ccflag tract attribute
7   metdiv  metdiv tract attribute
8  placefp placefp tract attribute
9    globd   globd tract attribute
10   globg   globg tract attribute
11 placefp placefp tract attribute
12    cbsa    cbsa tract attribute
13  metdiv  metdiv tract attribute
14  ccflag  ccflag tract attribute
15  a15asn  a15asn        age-race
definition
1                                                                                                                                                                     
2                                                                                                                                                                     
3                                                                                                                                                                     
4                                                                                                                                                                     
5                                                                                                                                                                     
6                                                                                                                                                                     
7                                                                                                                                                                     
8                                                                                                                                                                     
9                                                                                                                                                                     
10                                                                                                                                                                    
11                                                                                                                                                                    
12                                                                                                                                                                    
13                                                                                                                                                                    
14                                                                                                                                                                    
15 0-15 years old of Asians and Pacific Islanders (in 1980, 0-14 years old of Asians/Pacific Islanders; in 2008-12 ACS, 0-14 years old of Asian/Pacific Islander race)
X1970.f   X1970.s   X1980.f   X1980.s
1      state     state     state     state
2     county    county    county    county
3      tract     tract     tract     tract
4    TRTID10   TRTID10   TRTID10   trtid10
5     cbsa10    cbsa10    cbsa10    cbsa10
6   ccflag10  ccflag10  ccflag10  ccflag10
7   metdiv10  metdiv10  metdiv10  metdiv10
8  placefp10 placefp10 placefp10 placefp10
9                        GlobD80          
10                       GlobG80          
11                     placefp10 placefp10
12                        cbsa10    cbsa10
13                      metdiv10  metdiv10
14                      ccflag10  ccflag10
15                                a15asn80
> search.years
[1] "1970" "1980"
> years.columns
[1] FALSE FALSE FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
[19] FALSE FALSE FALSE FALSE
> search.years <- c("1980", "1970")
> years.columns <- grepl(search.years, names(dd))
Warning message:
  In grepl(search.years, names(dd)) :
  argument 'pattern' has length > 1 and only the first element will be used
> # keyword search
  > search_word(dd, c("income", "age")
                + 
                  + keyword <- c("age","income")
                Error: unexpected symbol in:
                  "
keyword"
                > keyword <- c("age","income")
                > keyword.search <- grepl( keyword, dd$definition, ignore.case = TRUE)                          #dd -> data
                Warning message:
                  In grepl(keyword, dd$definition, ignore.case = TRUE) :
                  argument 'pattern' has length > 1 and only the first element will be used
                > keyword.search <- grep( keyword, dd$definition, ignore.case = TRUE)                          #dd -> data
                Warning message:
                  In grep(keyword, dd$definition, ignore.case = TRUE) :
                  argument 'pattern' has length > 1 and only the first element will be used
                > search.years <- c("1970", "1980")
                > data <- dd
                > df.years <- data %>%
                  +   select(root, root2, category, definition, contains(search.years))
                > head(df.years, 15)
                root   root2        category
                1    state   state              id
                2   county  county              id
                3    tract   tract              id
                4    trtid   trtid              id
                5     cbsa    cbsa tract attribute
                6   ccflag  ccflag tract attribute
                7   metdiv  metdiv tract attribute
                8  placefp placefp tract attribute
                9    globd   globd tract attribute
                10   globg   globg tract attribute
                11 placefp placefp tract attribute
                12    cbsa    cbsa tract attribute
                13  metdiv  metdiv tract attribute
                14  ccflag  ccflag tract attribute
                15  a15asn  a15asn        age-race
                definition
                1                                                                                                                                                                     
                2                                                                                                                                                                     
                3                                                                                                                                                                     
                4                                                                                                                                                                     
                5                                                                                                                                                                     
                6                                                                                                                                                                     
                7                                                                                                                                                                     
                8                                                                                                                                                                     
                9                                                                                                                                                                     
                10                                                                                                                                                                    
                11                                                                                                                                                                    
                12                                                                                                                                                                    
                13                                                                                                                                                                    
                14                                                                                                                                                                    
                15 0-15 years old of Asians and Pacific Islanders (in 1980, 0-14 years old of Asians/Pacific Islanders; in 2008-12 ACS, 0-14 years old of Asian/Pacific Islander race)
                X1970.f   X1970.s   X1980.f   X1980.s
                1      state     state     state     state
                2     county    county    county    county
                3      tract     tract     tract     tract
                4    TRTID10   TRTID10   TRTID10   trtid10
                5     cbsa10    cbsa10    cbsa10    cbsa10
                6   ccflag10  ccflag10  ccflag10  ccflag10
                7   metdiv10  metdiv10  metdiv10  metdiv10
                8  placefp10 placefp10 placefp10 placefp10
                9                        GlobD80          
                10                       GlobG80          
                11                     placefp10 placefp10
                12                        cbsa10    cbsa10
                13                      metdiv10  metdiv10
                14                      ccflag10  ccflag10
                15                                a15asn80
                > # Test grep
                  > strings <- c("^ab", "ab", "abc", "abd", "abe", "ab 12", "ab$")
                > grep(".", strings, value = TRUE)
                [1] "^ab"   "ab"    "abc"   "abd"   "abe"   "ab 12" "ab$"  
                > # Test grep
                  > strings <- c("^ab", "ab", "abc", "abd", "abe", "ab 12", "ab$", "")
                > grep(".", strings, value = TRUE)
                [1] "^ab"   "ab"    "abc"   "abd"   "abe"   "ab 12" "ab$"  
                > df.years <- data %>%
                  +   select(root, root2, category, definition, contains(search.years)) %>%
                  +   grep( ".", search.years, value=T )
                Warning message:
                  In grep(., ".", search.years, value = T) :
                  argument 'pattern' has length > 1 and only the first element will be used
                > search.years <- c("1970")
                > data <- dd
                > df.years <- data %>%
                  +   select(root, root2, category, definition, contains(search.years)) %>%
                  +   grep( ".", search.years, value=T )
                Warning message:
                  In grep(., ".", search.years, value = T) :
                  argument 'pattern' has length > 1 and only the first element will be used
                > search.years <- c("1970", "1980")
                > data <- dd
                > df.years <- data %>%
                  +   select(root, root2, category, definition, contains(search.years)) %>%
                  +   grep( ".", dd, value=T )
                Warning message:
                  In grep(., ".", dd, value = T) :
                  argument 'pattern' has length > 1 and only the first element will be used
                > grep( ".", dd, value=T )
                root 
                "c(\"state\", \"county\", \"tract\", \"trtid\", \"cbsa\", \"ccflag\", \"metdiv\", \"placefp\", \"globd\", \"globg\", \"placefp\", \"cbsa\", \"metdiv\", \"ccflag\", \"a15asn\", \"a15blk\", \"a15hsp\", \"a15ntv\", \"a15wht\", \"a18und\", \"a60asn\", \"a60blk\", \"a60hsp\", \"a60ntv\", \"a60up\", \"a60wht\", \"a65asn\", \"a65blk\", \"a65hsp\", \"a65ntv\", \"a65wht\", \"a75up\", \"ag15up\", \"ag16cv\", \"ag18cv\", \"ag25up\", \"ag5up\", \"ageasn\", \"ageblk\", \"agehsp\", \"agentv\", \"agewht\", \"asian\", \"black\", \"china\", \"clf\", \"cni16u\", \"col\", \"cuban\", \"dapov\", \"dbpov\", \"dfb\", \"dflabf\", \n\"dfmpov\", \"dhpov\", \"dis\", \"dmulti\", \"dnapov\", \"dpov\", \"dwpov\", \"empclf\", \"family\", \"fb\", \"fhh\", \"filip\", \"flabf\", \"geanc\", \"gefb\", \"h10yrs\", \"h30old\", \"haw\", \"hh\", \"hha\", \"hhb\", \"hhh\", \"hhw\", \"hinc\", \"hinca\", \"hincb\", \"hinch\", \"hincw\", \"hisp\", \"hs\", \"hu\", \"hu00\", \"hu70\", \"hu80\", \"hu90\", \"incpc\", \"india\", \"iranc\", \"irfb\", \"itanc\", \"itfb\", \"japan\", \"korea\", \"lep\", \"manuf\", \"mar\", \"mar\", \"mar\", \"mex\", \"mhmval\", \"mrent\", \"multi\", \"n10imm\", \"n65pov\", \"napov\", \"nat\", \"nbpov\", \"nfmpov\", \"nhblk\", \"nhpov\", \n\"nhwht\", \"nnapov\", \"npov\", \"ntv\", \"nwpov\", \"ohu\", \"ohu00\", \"ohu70\", \"ohu80\", \"ohu90\", \"olang\", \"own\", \"p10imm\", \"p10yrs\", \"p15asn\", \"p15blk\", \"p15hsp\", \"p15ntv\", \"p15wht\", \"p18und\", \"p30old\", \"p60up\", \"p65asn\", \"p65blk\", \"p65hsp\", \"p65ntv\", \"p65pov\", \"p65wht\", \"p75up\", \"papov\", \"pasian\", \"pbpov\", \"pchina\", \"pcol\", \"pcuban\", \"pfb\", \"pfhh\", \"pfilip\", \"pflabf\", \"pfmpov\", \"pgeanc\", \"pgefb\", \"phaw\", \"phisp\", \"phpov\", \"phs\", \"pindia\", \"piranc\", \"pirfb\", \"pitanc\", \"pitfb\", \"pjapan\", \"pkorea\", \"plep\", \"pmanuf\", \n\"pmar\", \"pmex\", \"pmulti\", \"pnapov\", \"pnat\", \"pnhblk\", \"pnhwht\", \"pntv\", \"polang\", \"pop\", \"pop\", \"pop\", \"pop\", \"pop\", \"pown\", \"ppov\", \"ppr\", \"pprof\", \"pr\", \"prof\", \"pruanc\", \"prufb\", \"pscanc\", \"pscfb\", \"psemp\", \"punemp\", \"pvac\", \"pvet\", \"pviet\", \"pwds\", \"pwpov\", \"rent\", \"ruanc\", \"rufb\", \"scanc\", \"scfb\", \"semp\", \"unemp\", \"vac\", \"vet\", \"viet\", \"wds\", \"white\")" 
                root2 
                "c(\"state\", \"county\", \"tract\", \"trtid\", \"cbsa\", \"ccflag\", \"metdiv\", \"placefp\", \"globd\", \"globg\", \"placefp\", \"cbsa\", \"metdiv\", \"ccflag\", \"a15asn\", \"a15blk\", \"a15hsp\", \"a15ntv\", \"a15wht\", \"a18und\", \"a60asn\", \"a60blk\", \"a60hsp\", \"a60ntv\", \"a60up\", \"a60wht\", \"a65asn\", \"a65blk\", \"a65hsp\", \"a65ntv\", \"a65wht\", \"a75up\", \"ag15up\", \"ag16cv\", \"ag18cv\", \"ag25up\", \"ag5up\", \"ageasn\", \"ageblk\", \"agehsp\", \"agentv\", \"agewht\", \"asian\", \"black\", \"china\", \"clf\", \"cni16u\", \"col\", \"cuban\", \"dapov\", \"dbpov\", \"dfb\", \"dflabf\", \n\"dfmpov\", \"dhpov\", \"dis\", \"dmulti\", \"dnapov\", \"dpov\", \"dwpov\", \"empclf\", \"family\", \"fb\", \"fhh\", \"filip\", \"flabf\", \"geanc\", \"gefb\", \"h10yrs\", \"h30old\", \"haw\", \"hh\", \"hha\", \"hhb\", \"hhh\", \"hhw\", \"hinc\", \"hinca\", \"hincb\", \"hinch\", \"hincw\", \"hisp\", \"hs\", \"hu\", \"hu00\", \"hu70\", \"hu80\", \"hu90\", \"incpc\", \"india\", \"iranc\", \"irfb\", \"itanc\", \"itfb\", \"japan\", \"korea\", \"lep\", \"manuf\", \"mar\", \"mar.\", \"x12.m\", \"mex\", \"mhmval\", \"mrent\", \"multi\", \"n10imm\", \"n65pov\", \"napov\", \"nat\", \"nbpov\", \"nfmpov\", \"nhblk\", \"nhpov\", \n\"nhwht\", \"nnapov\", \"npov\", \"ntv\", \"nwpov\", \"ohu\", \"ohu00\", \"ohu70\", \"ohu80\", \"ohu90\", \"olang\", \"own\", \"p10imm\", \"p10yrs\", \"p15asn\", \"p15blk\", \"p15hsp\", \"p15ntv\", \"p15wht\", \"p18und\", \"p30old\", \"p60up\", \"p65asn\", \"p65blk\", \"p65hsp\", \"p65ntv\", \"p65pov\", \"p65wht\", \"p75up\", \"papov\", \"pasian\", \"pbpov\", \"pchina\", \"pcol\", \"pcuban\", \"pfb\", \"pfhh\", \"pfilip\", \"pflabf\", \"pfmpov\", \"pgeanc\", \"pgefb\", \"phaw\", \"phisp\", \"phpov\", \"phs\", \"pindia\", \"piranc\", \"pirfb\", \"pitanc\", \"pitfb\", \"pjapan\", \"pkorea\", \"plep\", \"pmanuf\", \n\"pmar\", \"pmex\", \"pmulti\", \"pnapov\", \"pnat\", \"pnhblk\", \"pnhwht\", \"pntv\", \"polang\", \"pop\", \"popsf3\", \"popsf4\", \"popsp1\", \"popsp2\", \"pown\", \"ppov\", \"ppr\", \"pprof\", \"pr\", \"prof\", \"pruanc\", \"prufb\", \"pscanc\", \"pscfb\", \"psemp\", \"punemp\", \"pvac\", \"pvet\", \"pviet\", \"pwds\", \"pwpov\", \"rent\", \"ruanc\", \"rufb\", \"scanc\", \"scfb\", \"semp\", \"unemp\", \"vac\", \"vet\", \"viet\", \"wds\", \"white\")" 
                category 
                "c(\"id\", \"id\", \"id\", \"id\", \"tract attribute\", \"tract attribute\", \"tract attribute\", \"tract attribute\", \"tract attribute\", \"tract attribute\", \"tract attribute\", \"tract attribute\", \"tract attribute\", \"tract attribute\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age\", \"age\", \"age\", \"age\", \"age\", \"age\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \n\"race\", \"race\", \"race\", \"ses\", \"ses-age\", \"ses\", \"ethnicity\", \"ses-race\", \"ses-race\", \"demographics\", \"age\", \"ses\", \"ses-race\", \"ses\", \"housing\", \"ses-race\", \"ses\", \"ses-race\", \"ses-age\", \"demographics\", \"\", \"ses-gender\", \"race\", \"ses-gender\", \"ethnicity\", \"immigration\", \"housing\", \"housing\", \"race\", \"demographics\", \"ethnicity\", \"ethnicity\", \"ethnicity\", \"ethnicity\", \"ses\", \"ses-race\", \"ses-race\", \"ses-race\", \"ses-race\", \"ethnicity\", \"ses\", \"housing\", \"\", \"\", \"\", \"\", \"ses\", \"race\", \"ethnicity\", \"immigration\", \n\"ethnicity\", \"immigration\", \"race\", \"race\", \"language\", \"ses\", \"ses\", \"ses\", \"ses\", \"ethnicity\", \"housing\", \"housing\", \"housing\", \"immigration\", \"ses-age\", \"ses-race\", \"immigration\", \"ses-race\", \"ses\", \"race\", \"ses-race\", \"race\", \"ses-race\", \"ses\", \"race\", \"ses-race\", \"housing\", \"\", \"\", \"\", \"\", \"language\", \"housing\", \"immigration\", \"housing\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"age\", \"housing\", \"age\", \"age-race\", \"age-race\", \"age-race\", \"age-race\", \"ses-age\", \"age-race\", \n\"age\", \"ses-race\", \"race\", \"ses-race\", \"race\", \"ses\", \"ethnicity\", \"immigration\", \"ses-gender\", \"race\", \"ses-gender\", \"ses\", \"ethnicity\", \"immigration\", \"race\", \"race\", \"ses-race\", \"ses\", \"race\", \"ethnicity\", \"immigration\", \"ethnicity\", \"immigration\", \"race\", \"race\", \"language\", \"ses\", \"ses\", \"ethnicity\", \"housing\", \"ses-race\", \"immigration\", \"race\", \"race\", \"race\", \"language\", \"demographics\", \"demographics\", \"demographics\", \"demographics\", \"demographics\", \"housing\", \"ses\", \"ethnicity\", \"ses\", \"ethnicity\", \n\"ses\", \"ethnicity\", \"immigration\", \"ethnicity\", \"immigration\", \"ses\", \"ses\", \"housing\", \"ses\", \"race\", \"ses\", \"ses-race\", \"housing\", \"ethnicity\", \"immigration\", \"ethnicity\", \"immigration\", \"ses\", \"ses\", \"housing\", \"ses\", \"race\", \"ses\", \"race\")" 
                definition 
                "c(\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"0-15 years old of Asians and Pacific Islanders (in 1980, 0-14 years old of Asians/Pacific Islanders; in 2008-12 ACS, 0-14 years old of Asian/Pacific Islander race)\", \"0-15 years old of black race (in 1980, 0-14 years old of black race; in 2006- 10 ACS, 0-14 years old of black race)\", \"0-15 years old, persons of Hispanic origins (in 1980, 0-14 years old, persons of Hispanic origin; in 2008-12 ACS, 0-14 years old, persons of Hispanic origins)\", \n\"0-15 years old of Native American race (in 1980, 0-14 years old of Native American race; in 2008-12 ACS, 0-14 years old of Native American race)\", \"0-15 years old of white race (in 1980, 0-14 years old of white race; in 2006- 10 ACS, 0-14 years old of white race)\", \"persons age 17 years and under\", \"60 years and older of Asians and Pacific Islanders\", \"60 years and older of black race\", \"60 years and older, persons of Hispanic origins\", \"60 years and older of Native American race\", \"persons age 60 years and over\", \n\"60 years and older of white race\", \"65 years and older of Asians and Pacific Islanders\", \"65 years and older of black race\", \"65 years and older, persons of Hispanic origins\", \"65 years and older of Native American race\", \"65 years and older of non-Hispanic whites\", \"persons age 75 years and over\", \"population 15 years and over (in 1970, population 14 years and over)\", \"civilian population 16 years and over\", \"civilian population 18 years and over\", \"population 25 years and over\", \"persons 5 years and over\", \n\"Asian and Pacific Islander population with known age distribution\", \"black population with known age distribution\", \"Hispanic population with known age distribution\", \"Native American population with known age distribution\", \"white population with known age distribution\", \"persons of Asian race (and Pacific Islander)\", \"persons of black race\", \"persons of Chinese race\", \"civilian labor force 16 years and over\", \"civilian non-institutionalized persons 16-64 years old\", \"college education\", \"Cubans\", \n\"Asians and Pacific Islanders for whom poverty status is determined\", \"black persons for whom poverty status is determined\", \"total population from sample-based data\", \"females 16 years and over, except in armed forces\", \"families for whom poverty status is determined\", \"Hispanics for whom poverty status is determined\", \"percent with disability\", \"housing units\", \"Native American for whom poverty status is determined\", \"persons for whom poverty status is determined\", \"white persons for whom poverty status is determined\", \n\"employed persons 16 years and over\", \"total families\", \"foreign-born\", \"female-headed families with children\", \"persons of Filipino race\", \"females in labor force\", \"persons of German parentage or ancestry\", \"persons who were born in Germany\", \"household heads moved into unit less than 10 years ago (in 2008-12 ACS, householders moved in 2000 or later)\", \"structures built more than 30 years ago (in 2008-12 ACS, structures built 1979 or earlier)\", \"persons of Hawaiian race\", \"total households in sample-based data\", \n\"total Asian/Pacific Islander households in sample-based data\", \"total black households in sample-based data\", \"total hispanic households in sample-based data\", \"total white households in sample-based data\", \"Median HH income, total\", \"Median HH income, Asian/PI\", \"Median HH income, blacks\", \"Median HH income, Hispanics\", \"Median HH income, whites\", \"persons of Hispanic origin\", \"persons with high school degree or less\", \"housing units\", \"\", \"\", \"\", \"\", \"Per capita income\", \"persons of Asian Indian race\", \n\"persons of Irish parentage or ancestry\", \"persons who were born in Ireland\", \"persons of Italian parentage or ancestry\", \"persons who were born in Italy\", \"persons of Japanese race\", \"persons of Korean race\", \"persons who speak English not well\", \"manufacturing employees (by industries)\", \"currently married (excluding separated)\", \"currently married (excluding separated)\", \"currently married (excluding separated)\", \"Mexicans\", \"Median home value\", \"Median rent\", \"housing units in multi-unit structures\", \n\"recent immigrants (within the past 10 years)\", \"persons 65 years and older in poverty\", \"Asians and Pacific Islanders in poverty\", \"naturalized foreign-born\", \"blacks in poverty\", \"families with children in poverty\", \"persons of black race, not Hispanic origin\", \"Hispanics in poverty\", \"persons of white race, not Hispanic origin\", \"Native Americans in poverty\", \"persons in poverty\", \"persons of Native American race\", \"whites in poverty\", \"occupied housing units\", \"\", \"\", \"\", \"\", \"persons who speak language other than English at home\", \n\"owner-occupied housing units\", \"pct immigrated in past 10 years\", \"pct HH in neighborhood 10 years or less\", \"pct 15 and under, Asian/PI\", \"pct 15 and under, non-Hispanic black\", \"pct 15 and under, Hispanic\", \"pct 15 and under, Native American\", \"pct 15 and under, non-Hispanic white\", \"pct 17 and under, total\", \"pct structures more than 30 years old\", \"pct 60 and older, total\", \"percentage of 65 years and older of Asians and Pacific Islanders\", \"percentage of 65 years and older of black race\", \"percentage of 65 years and older, persons of Hispanic origins\", \n\"percentage of 65 years and older of Native American race\", \"pct in poverty, 65+\", \"percentage of 65 years and older of non-Hispanic whites\", \"pct 75 and older, total\", \"pct in poverty, Asian/PI\", \"pct Asian and Pacific Islander race\", \"pct in poverty, African Americans\", \"pct Chinese birth/race\", \"pct with 4-year college degree or more\", \"pct Cuban birth/ethnicity\", \"pct foreign born\", \"pct female-headed families with children\", \"pct Filipino birth/race\", \"pct female labor force participation\", \n\"pct in poverty, families with children\", \"pct German parentage/ancestry\", \"pct German birth\", \"pct Hawaiian race\", \"pct Hispanic\", \"pct in poverty, Hispanics\", \"pct with high school degree or less\", \"pct Indian birth/race\", \"pct Irish parentage/ancestry\", \"pct Irish birth\", \"pct Italian parentage/ancestry\", \"pct Italian birth\", \"pct Japanese birth/race\", \"pct Korean birth/race\", \"pct speaking English not well, age 5+\", \"pct manufacturing employees\", \"pct currently married, not separated\", \"pct Mexican birth/ethnicity\", \n\"pct multi-family units\", \"pct in poverty, Native Americans\", \"pct Naturalized\", \"percentage of persons of black race, not Hispanic origin\", \"percentage of persons white, not Hispanic origin\", \"pct Native American race\", \"pct speaking other language at home, age 5+\", \"total population\", \"total population\", \"total population\", \"total population\", \"total population\", \"pct owner-occupied units\", \"pct in poverty, total\", \"pct Puerto Rican birth/ethnicity\", \"pct professional employees\", \"puerto rican\", \n\"count of professional employees\", \"pct Russian/USSR parentage/ancestry\", \"pct Russian/USSR birth\", \"pct Scandinavian parentage/ancestry\", \"pct Scandinavian birth\", \"pct self-employed\", \"pct unemployed\", \"pct vacant units\", \"pct veteran\", \"pct Vietnamese race\", \"pct widowed, divorced and separated\", \"pct in poverty, whites\", \"renter-occupied housing units\", \"persons of Russian/USSR parentage or ancestry\", \"persons who were born in Russia/ USSR\", \"persons of Scandinavian parentage/ancestry (Finnish, Swedish, Danish, Norwegian)\", \n\"persons who were born in Scandinavian Countries (Swedish, Norwegian, Finnish, Danish)\", \"self-employed\", \"unemployed\", \"vacant housing units\", \"veterans\", \"persons of Vietnamese race\", \"widowed, divorced, and separated\", \"persons of white race\")" 
                X1970.f 
                "c(\"state\", \"county\", \"tract\", \"TRTID10\", \"cbsa10\", \"ccflag10\", \"metdiv10\", \"placefp10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"A15BLK70\", \"\", \"\", \"A15WHT70\", \"A18UND70\", \"\", \"A60BLK70\", \"\", \"\", \"A60UP70\", \"A60WHT70\", \"\", \"\", \"\", \"\", \"\", \"A75UP70\", \"AG15UP70\", \"\", \"\", \"\", \"\", \"\", \"AGEBLK70\", \"\", \"\", \"AGEWHT70\", \"ASIAN70\", \"BLACK70\", \"CHINA70\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"DMULTI70\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"FILIP70\", \"\", \"\", \"\", \"\", \"\", \"HAW70\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"HU70\", \"\", \"\", \"\", \"\", \"\", \"INDIA70\", \"\", \"\", \"\", \"\", \"JAPAN70\", \"KOREA70\", \"\", \"\", \"Mar-70\", \"\", \"\", \"\", \"\", \"\", \"MULTI70\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"OHU70\", \"\", \"\", \"\", \"\", \"\", \"OWN70\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"POP70\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"\", \"\", \"\", \"\", \"RENT70\", \"\", \"\", \"\", \"\", \"\", \"\", \"VAC70\", \"\", \"\", \"WDS70\", \"WHITE70\")" 
                X1970.s 
                "c(\"state\", \"county\", \"tract\", \"TRTID10\", \"cbsa10\", \"ccflag10\", \"metdiv10\", \"placefp10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"AG16CV70\", \"\", \"AG25UP70\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"CLF70\", \"CNI16U70\", \"COL70\", \"CUBAN70\", \"\", \"DBPOV70\", \"\", \"DFLABF70\", \"DFMPOV70\", \"\", \"DIS70\", \"\", \"\", \"DPOV70\", \"DWPOV70\", \"EMPCLF70\", \"FAMILY70\", \"FB70\", \"FHH70\", \"\", \"FLABF70\", \"GEANC70\", \"GEFB70\", \"H10YRS70\", \"H30OLD70\", \"\", \"HH70\", \"\", \"\", \"\", \n\"\", \"HINC70\", \"\", \"\", \"\", \"\", \"\", \"HS70\", \"\", \"\", \"HU70SP\", \"\", \"\", \"INCPC70\", \"\", \"IRANC70\", \"IRFB70\", \"ITANC70\", \"ITFB70\", \"\", \"\", \"\", \"MANUF70\", \"\", \"\", \"\", \"MEX70\", \"MHMVAL70\", \"MRENT70\", \"\", \"N10IMM70\", \"N65POV70\", \"\", \"NAT70\", \"NBPOV70\", \"NFMPOV70\", \"\", \"\", \"\", \"\", \"NPOV70\", \"\", \"NWPOV70\", \"\", \"\", \"OHU70SP\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"POP70SP1\", \"POP70SP2\", \"\", \"\", \"\", \"\", \"PR70\", \"PROF70\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"RUANC70\", \"RUFB70\", \"SCANC70\", \"SCFB70\", \"SEMP70\", \"UNEMP70\", \"\", \"VET70\", \"\", \"\", \"\")" 
                X1980.f 
                "c(\"state\", \"county\", \"tract\", \"TRTID10\", \"cbsa10\", \"ccflag10\", \"metdiv10\", \"placefp10\", \"GlobD80\", \"GlobG80\", \"placefp10\", \"cbsa10\", \"metdiv10\", \"ccflag10\", \"\", \"\", \"\", \"\", \"\", \"A18UND80\", \"\", \"\", \"\", \"\", \"A60UP80\", \"\", \"\", \"\", \"\", \"\", \"\", \"A75UP80\", \"AG15UP80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"ASIAN80\", \"\", \"CHINA80\", \"\", \"\", \"\", \"CUBAN80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"FILIP80\", \"\", \"\", \"\", \"\", \"\", \"HAW80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"HISP80\", \"\", \n\"HU80\", \"\", \"\", \"\", \"\", \"\", \"INDIA80\", \"\", \"\", \"\", \"\", \"JAPAN80\", \"KOREA80\", \"\", \"\", \"Mar-80\", \"\", \"\", \"MEX80\", \"MHMVAL80\", \"MRENT80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"NHBLK80\", \"\", \"NHWHT80\", \"\", \"\", \"NTV80\", \"\", \"OHU80\", \"\", \"\", \"\", \"\", \"\", \"OWN80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"POP80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"PR80\", \n\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"RENT80\", \"\", \"\", \"\", \"\", \"\", \"\", \"VAC80\", \"\", \"VIET80\", \"WDS80\", \"\")" 
                X1980.s 
                "c(\"state\", \"county\", \"tract\", \"trtid10\", \"cbsa10\", \"ccflag10\", \"metdiv10\", \"placefp10\", \"\", \"\", \"placefp10\", \"cbsa10\", \"metdiv10\", \"ccflag10\", \"a15asn80\", \"a15blk80\", \"a15hsp80\", \"a15ntv80\", \"a15wht80\", \"\", \"a60asn80\", \"a60blk80\", \"a60hsp80\", \"a60ntv80\", \"\", \"a60wht80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"ag16cv80\", \"\", \"ag25up80\", \"ag5up80\", \"ageasn80\", \"ageblk80\", \"agehsp80\", \"agentv80\", \"agewht80\", \"\", \"\", \"\", \"clf80\", \"cni16u80\", \"col80\", \"\", \"dapov80\", \"dbpov80\", \"dfb80\", \"dflabf80\", \"dfmpov80\", \"dhpov80\", \n\"dis80\", \"dmulti80\", \"dnapov80\", \"dpov80\", \"dwpov80\", \"empclf80\", \"family80\", \"fb80\", \"fhh80\", \"\", \"flabf80\", \"geanc80\", \"gefb80\", \"h10yrs80\", \"h30old80\", \"\", \"hh80\", \"hha80\", \"hhb80\", \"hhh80\", \"hhw80\", \"hinc80\", \"hinca80\", \"hincb80\", \"hinch80\", \"hincw80\", \"\", \"hs80\", \"\", \"\", \"\", \"hu80sp\", \"\", \"incpc80\", \"\", \"iranc80\", \"irfb80\", \"itanc80\", \"itfb80\", \"\", \"\", \"lep80\", \"manuf80\", \"\", \"\", \"\", \"\", \"\", \"\", \"multi80\", \"n10imm80\", \"n65pov80\", \"napov80\", \"nat80\", \"nbpov80\", \"nfmpov80\", \"\", \"nhpov80\", \"\", \n\"nnapov80\", \"npov80\", \"\", \"nwpov80\", \"\", \"\", \"\", \"ohu80sp\", \"\", \"olang80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"pop80sf3\", \"pop80sf4\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"prof80\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"ruanc80\", \"rufb80\", \"scanc80\", \"scfb80\", \"semp80\", \"unemp80\", \"\", \"vet80\", \"\", \"\", \"\")" 
                X1990.f 
                "c(\"state\", \"county\", \"tract\", \"TRTID10\", \"cbsa10\", \"ccflag10\", \"metdiv10\", \"placefp10\", \"GlobD90\", \"GlobG90\", \"placefp10\", \"cbsa10\", \"metdiv10\", \"ccflag10\", \"A15ASN90\", \"A15BLK90\", \"A15HSP90\", \"A15NTV90\", \"A15WHT90\", \"A18UND90\", \"A60ASN90\", \"A60BLK90\", \"A60HSP90\", \"A60NTV90\", \"A60UP90\", \"A60WHT90\", \"\", \"\", \"\", \"\", \"\", \"A75UP90\", \"AG15UP90\", \"\", \"\", \"\", \"\", \"AGEASN90\", \"AGEBLK90\", \"AGEHSP90\", \"AGENTV90\", \"AGEWHT90\", \"ASIAN90\", \"\", \"CHINA90\", \"\", \"\", \"\", \"CUBAN90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"\", \"\", \"\", \"\", \"\", \"FILIP90\", \"\", \"\", \"\", \"\", \"\", \"HAW90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"HISP90\", \"\", \"HU90\", \"\", \"\", \"\", \"\", \"\", \"INDIA90\", \"\", \"\", \"\", \"\", \"JAPAN90\", \"KOREA90\", \"\", \"\", \"Mar-90\", \"\", \"\", \"MEX90\", \"MHMVAL90\", \"MRENT90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"NHBLK90\", \"\", \"NHWHT90\", \"\", \"\", \"NTV90\", \"\", \"OHU90\", \"\", \"\", \"\", \"\", \"\", \"OWN90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"POP90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"PR90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"RENT90\", \"\", \"\", \"\", \"\", \"\", \"\", \"VAC90\", \"\", \"VIET90\", \"WDS90\", \"\")" 
                X1990.s 
                "c(\"state\", \"county\", \"tract\", \"TRTID10\", \"cbsa10\", \"ccflag10\", \"metdiv10\", \"placefp10\", \"\", \"\", \"placefp10\", \"cbsa10\", \"metdiv10\", \"ccflag10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"AG16CV90\", \"\", \"AG25UP90\", \"AG5UP90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"CLF90\", \"CNI16U90\", \"COL90\", \"\", \"DAPOV90\", \"DBPOV90\", \"\", \"DFLABF90\", \"DFMPOV90\", \"DHPOV90\", \"DIS90\", \"DMULTI90\", \"DNAPOV90\", \"DPOV90\", \"DWPOV90\", \"EMPCLF90\", \"FAMILY90\", \"FB90\", \"FHH90\", \"\", \"FLABF90\", \"GEANC90\", \n\"GEFB90\", \"H10YRS90\", \"H30OLD90\", \"\", \"HH90\", \"HHA90\", \"HHB90\", \"HHH90\", \"HHW90\", \"HINC90\", \"HINCA90\", \"HINCB90\", \"HINCH90\", \"HINCW90\", \"\", \"HS90\", \"\", \"\", \"\", \"\", \"HU90SP\", \"INCPC90\", \"\", \"IRANC90\", \"IRFB90\", \"ITANC90\", \"ITFB90\", \"\", \"\", \"LEP90\", \"MANUF90\", \"\", \"\", \"\", \"\", \"\", \"\", \"MULTI90\", \"N10IMM90\", \"N65POV90\", \"NAPOV90\", \"NAT90\", \"NBPOV90\", \"NFMPOV90\", \"\", \"NHPOV90\", \"\", \"NNAPOV90\", \"NPOV90\", \"\", \"NWPOV90\", \"\", \"\", \"\", \"\", \"OHU90SP\", \"OLANG90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"POP90SF3\", \"POP90SF4\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"PROF90\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"RUANC90\", \"RUFB90\", \"SCANC90\", \"SCFB90\", \"SEMP90\", \"UNEMP90\", \"\", \"VET90\", \"\", \"\", \"\")" 
                X2000.f 
                "c(\"state\", \"county\", \"tract\", \"TRTID10\", \"cbsa10\", \"ccflag10\", \"metdiv10\", \"placefp10\", \"GlobD00\", \"GlobG00\", \"placefp10\", \"cbsa10\", \"metdiv10\", \"ccflag10\", \"A15ASN00\", \"A15BLK00\", \"A15HSP00\", \"A15NTV00\", \"A15WHT00\", \"A18UND00\", \"A60ASN00\", \"A60BLK00\", \"A60HSP00\", \"A60NTV00\", \"A60UP00\", \"A60WHT00\", \"\", \"\", \"\", \"\", \"\", \"A75UP00\", \"\", \"\", \"\", \"\", \"\", \"AGEASN00\", \"AGEBLK00\", \"AGEHSP00\", \"AGENTV00\", \"AGEWHT00\", \"ASIAN00\", \"\", \"CHINA00\", \"\", \"\", \"\", \"CUBAN00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"FAMILY00\", \"\", \"FHH00\", \"FILIP00\", \"\", \"\", \"\", \"\", \"\", \"HAW00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"HISP00\", \"\", \"HU00\", \"\", \"\", \"\", \"\", \"\", \"INDIA00\", \"\", \"\", \"\", \"\", \"JAPAN00\", \"KOREA00\", \"\", \"\", \"\", \"\", \"\", \"MEX00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"NHBLK00\", \"\", \"NHWHT00\", \"\", \"\", \"NTV00\", \"\", \"OHU00\", \"\", \"\", \"\", \"\", \"\", \"OWN00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"POP00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"PR00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"RENT00\", \"\", \"\", \"\", \"\", \"\", \"\", \"VAC00\", \"\", \"VIET00\", \"\", \"\")" 
                X2000.s 
                "c(\"state\", \"county\", \"tract\", \"TRTID10\", \"cbsa10\", \"ccflag10\", \"metdiv10\", \"placefp10\", \"\", \"\", \"placefp10\", \"cbsa10\", \"metdiv10\", \"ccflag10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"AG15UP00\", \"\", \"AG18CV00\", \"AG25UP00\", \"AG5UP00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"CLF00\", \"CNI16U00\", \"COL00\", \"\", \"DAPOV00\", \"DBPOV00\", \"\", \"DFLABF00\", \"DFMPOV00\", \"DHPOV00\", \"DIS00\", \"DMULTI00\", \"DNAPOV00\", \"DPOV00\", \"DWPOV00\", \"EMPCLF00\", \"\", \"FB00\", \"\", \"\", \"FLABF00\", \"GEANC00\", \n\"GEFB00\", \"H10YRS00\", \"H30OLD00\", \"\", \"HH00\", \"HHA00\", \"HHB00\", \"HHH00\", \"HHW00\", \"HINC00\", \"HINCA00\", \"HINCB00\", \"HINCH00\", \"HINCW00\", \"\", \"HS00\", \"\", \"HU00SP\", \"\", \"\", \"\", \"INCPC00\", \"\", \"IRANC00\", \"IRFB00\", \"ITANC00\", \"ITFB00\", \"\", \"\", \"LEP00\", \"MANUF00\", \"\", \"Mar.00\", \"\", \"\", \"MHMVAL00\", \"MRENT00\", \"MULTI00\", \"N10IMM00\", \"N65POV00\", \"NAPOV00\", \"NAT00\", \"NBPOV00\", \"NFMPOV00\", \"\", \"NHPOV00\", \"\", \"NNAPOV00\", \"NPOV00\", \"\", \"NWPOV00\", \"\", \"OHU00SP\", \"\", \"\", \"\", \"OLANG00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \n\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"POP00SF3\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"PROF00\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"RUANC00\", \"RUFB00\", \"SCANC00\", \"SCFB00\", \"SEMP00\", \"UNEMP00\", \"\", \"VET00\", \"\", \"WDS00\", \"\")" 
                X2010.f 
                "c(\"state\", \"county\", \"tract\", \"tractid\", \"\", \"\", \"\", \"\", \"GlobD10\", \"GlobG10\", \"\", \"\", \"\", \"\", \"a15asn10\", \"a15blk10\", \"a15hsp10\", \"a15ntv10\", \"a15wht10\", \"a18und10\", \"a60asn10\", \"a60blk10\", \"a60hsp10\", \"a60ntv10\", \"a60up10\", \"a60wht10\", \"\", \"\", \"\", \"\", \"\", \"a75up10\", \"\", \"\", \"\", \"\", \"\", \"ageasn10\", \"ageblk10\", \"agehsp10\", \"agentv10\", \"agewht10\", \"asian10\", \"\", \"china10\", \"\", \"\", \"\", \"cuban10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"family10\", \"\", \"fhh10\", \"filip10\", \"\", \"\", \"\", \"\", \"\", \n\"haw10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"hisp10\", \"\", \"hu10\", \"\", \"\", \"\", \"\", \"\", \"india10\", \"\", \"\", \"\", \"\", \"japan10\", \"korea10\", \"\", \"\", \"\", \"\", \"\", \"mex10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"nhblk10\", \"\", \"nhwht10\", \"\", \"\", \"ntv10\", \"\", \"ohu10\", \"\", \"\", \"\", \"\", \"\", \"own10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"pop10\", \n\"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"pr10\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"rent10\", \"\", \"\", \"\", \"\", \"\", \"\", \"vac10\", \"\", \"viet10\", \"\", \"\")" 
                X2010.s 
                "c(\"statea\", \"countya\", \"tracta\", \"tractid\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"\", \"a15asn12\", \"a15blk12\", \"a15hsp12\", \"a15ntv12\", \"a15wht12\", \"a18und12\", \"\", \"\", \"\", \"\", \"a60up12\", \"\", \"a65asn12\", \"a65blk12\", \"a65hsp12\", \"a65ntv12\", \"a65wht12\", \"a75up12\", \"ag15up12\", \"\", \"ag18cv12\", \"ag25up12\", \"ag5up12\", \"ageasn12\", \"ageblk12\", \"agehsp12\", \"agentv12\", \"agewht12\", \"asian12\", \"\", \"china12\", \"clf12\", \"\", \"col12\", \"cuban12\", \"dapov12\", \"dbpov12\", \"\", \"dflabf12\", \"dfmpov12\", \"dhpov12\", \"\", \"dmulti12\", \n\"dnapov12\", \"dpov12\", \"dwpov12\", \"empclf12\", \"family12\", \"fb12\", \"fhh12\", \"filip12\", \"flabf12\", \"geanc12\", \"gefb12\", \"h10yrs12\", \"h30old12\", \"haw12\", \"hh12\", \"hha12\", \"hhb12\", \"hhh12\", \"hhw12\", \"hinc12\", \"hinca12\", \"hincb12\", \"hinch12\", \"hincw12\", \"hisp12\", \"hs12\", \"hu12\", \"\", \"\", \"\", \"\", \"incpc12\", \"india12\", \"iranc12\", \"irfb12\", \"itanc12\", \"itfb12\", \"japan12\", \"korea12\", \"lep12\", \"manuf12\", \"\", \"\", \"X12.Mar\", \"mex12\", \"mhmval12\", \"mrent12\", \"multi12\", \"n10imm12\", \"n65pov12\", \"napov12\", \"nat12\", \n\"nbpov12\", \"nfmpov12\", \"nhblk12\", \"nhpov12\", \"nhwht12\", \"nnapov12\", \"npov12\", \"ntv12\", \"nwpov12\", \"ohu12\", \"\", \"\", \"\", \"\", \"olang12\", \"own12\", \"p10imm12\", \"p10yrs12\", \"p15asn12\", \"p15blk12\", \"p15hsp12\", \"p15ntv12\", \"p15wht12\", \"p18und12\", \"p30old12\", \"p60up12\", \"p65asn12\", \"p65blk12\", \"p65hsp12\", \"p65ntv12\", \"p65pov12\", \"p65wht12\", \"p75up12\", \"papov12\", \"pasian12\", \"pbpov12\", \"pchina12\", \"pcol12\", \"pcuban12\", \"pfb12\", \"pfhh12\", \"pfilip12\", \"pflabf12\", \"pfmpov12\", \"pgeanc12\", \"pgefb12\", \"phaw12\", \n\"phisp12\", \"phpov12\", \"phs12\", \"pindia12\", \"piranc12\", \"pirfb12\", \"pitanc12\", \"pitfb12\", \"pjapan12\", \"pkorea12\", \"plep12\", \"pmanuf12\", \"pmar12\", \"pmex12\", \"pmulti12\", \"pnapov12\", \"pnat12\", \"pnhblk12\", \"pnhwht12\", \"pntv12\", \"polang12\", \"pop12\", \"\", \"\", \"\", \"\", \"pown12\", \"ppov12\", \"ppr12\", \"pprof12\", \"pr12\", \"prof12\", \"pruanc12\", \"prufb12\", \"pscanc12\", \"pscfb12\", \"psemp12\", \"punemp12\", \"pvac12\", \"pvet12\", \"pviet12\", \"pwds12\", \"pwpov12\", \"rent12\", \"ruanc12\", \"rufb12\", \"scanc12\", \"scfb12\", \"semp12\", \n\"unemp12\", \"vac12\", \"vet12\", \"viet12\", \"wds12\", \"\")" 
                X 
                "c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, \nNA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)" 
                X.1 
                "c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, \nNA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)" 
                X.2 
                "c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, \nNA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)" 
                X.3 
                "c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, \nNA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)" 
                X.4 
                "c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, \nNA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)" 
                X.5 
                "c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, \nNA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)" 
                X.6 
                "c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, \nNA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)" 
                X.7 
                "c(NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, \nNA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA)" 
                > # help
                  > help(filter)
                > df.years <- data %>%
                  +   select(root, root2, category, definition, contains(search.years)) %>%
                  +   filter(search.years = TRUE)
                > head(df.years, 15)
                root   root2        category
                1    state   state              id
                2   county  county              id
                3    tract   tract              id
                4    trtid   trtid              id
                5     cbsa    cbsa tract attribute
                6   ccflag  ccflag tract attribute
                7   metdiv  metdiv tract attribute
                8  placefp placefp tract attribute
                9    globd   globd tract attribute
                10   globg   globg tract attribute
                11 placefp placefp tract attribute
                12    cbsa    cbsa tract attribute
                13  metdiv  metdiv tract attribute
                14  ccflag  ccflag tract attribute
                15  a15asn  a15asn        age-race
                definition
                1                                                                                                                                                                     
                2                                                                                                                                                                     
                3                                                                                                                                                                     
                4                                                                                                                                                                     
                5                                                                                                                                                                     
                6                                                                                                                                                                     
                7                                                                                                                                                                     
                8                                                                                                                                                                     
                9                                                                                                                                                                     
                10                                                                                                                                                                    
                11                                                                                                                                                                    
                12                                                                                                                                                                    
                13                                                                                                                                                                    
                14                                                                                                                                                                    
                15 0-15 years old of Asians and Pacific Islanders (in 1980, 0-14 years old of Asians/Pacific Islanders; in 2008-12 ACS, 0-14 years old of Asian/Pacific Islander race)
                X1970.f   X1970.s   X1980.f   X1980.s
                1      state     state     state     state
                2     county    county    county    county
                3      tract     tract     tract     tract
                4    TRTID10   TRTID10   TRTID10   trtid10
                5     cbsa10    cbsa10    cbsa10    cbsa10
                6   ccflag10  ccflag10  ccflag10  ccflag10
                7   metdiv10  metdiv10  metdiv10  metdiv10
                8  placefp10 placefp10 placefp10 placefp10
                9                        GlobD80          
                10                       GlobG80          
                11                     placefp10 placefp10
                12                        cbsa10    cbsa10
                13                      metdiv10  metdiv10
                14                      ccflag10  ccflag10
                15                                a15asn80
                > help(for)
                Error: unexpected ')' in "help(for)"
                > help(if)
                Error: unexpected ')' in "help(if)"
                > # search by category
                  > category_search(dd, c("age", "ses")
                                    + 
                                      + # search by category
                                      + category_search(dd, c("age", "ses")
                                                        Error: unexpected symbol in:
                                                          "# search by category
category_search"
                                                        > 
                                                          > # search by category
                                                          > category_search(dd, c("age", "ses"))
                                                        argument 'pattern' has length > 1 and only the first element will be used
                                                        > # search by category
                                                          > category_search(dd, c("ses", "language"))
                                                        argument 'pattern' has length > 1 and only the first element will be used
                                                        > # search by category
                                                          > category_search(dd, "anguage"))
                                    Error: unexpected ')' in "category_search(dd, "anguage"))"
                                    > # search by category
                                      > category_search(dd, "language")
                                    > # keyword search
                                      > search_word(dd, c("income")
                                                    + 
                                                      + # keyword search
                                                      + search_word(dd, "income")
                                                    Error: unexpected symbol in:
                                                      "# keyword search
search_word"
                                                    > # keyword search
                                                      > search_word(dd, "income")
                                                    > # search by year(s)
                                                      > search_years(dd, year = c("1970", "1980", "1990", "2000"))
                                                    > knitr::opts_chunk$set(echo = TRUE)
                                                    > #libraries
                                                      > library(dplyr)
                                                    > library(here)
                                                    > library(pander)
                                                    > 
                                                      > #data
                                                      > 
                                                      > # store data dictionary file path
                                                      > DD_FILEPATH <- here::here( "data/rodeo/ltdb_data_dictionary.csv" )
                                                    > 
                                                      > # import data dictionary
                                                      > dd <- read.csv( DD_FILEPATH, stringsAsFactors=F )
                                                    > 
                                                      > # longitudinal tract data base 2010 sample
                                                      > ltdb.data <- read.csv(here("data/raw/ltdb_std_2010_sample.csv"))
                                                    > 
                                                      > # rename columns to lowercase
                                                      > ltdb.data <- as.data.frame( sapply(ltdb.data, tolower))
                                                    > # load function source files
                                                      > source(here("analysis/utilities.R"))
                                                    > source(here("analysis/helper_functions_amp.R"))
                                                    > # test helper functions
                                                      > 
                                                      > # search by category
                                                      > category_search(dd, "language")
                                                    > 
                                                      > 
                                                      > # keyword search
                                                      > search_word(dd, "income")
                                                    > 
                                                      > # search by year(s)
                                                      > search_years(dd, year = c("1970", "1980", "1990", "2000"))
                                                    > # load function source files
                                                      > source(here("analysis/utilities.R"))
                                                    > # search by category
                                                      > category_search(dd, "language")
                                                    > # keyword search
                                                      > search_word(dd, "income")
                                                    > # search by year(s)
                                                      > search_years(dd, year = c("1970", "1980", "1990", "2000"))