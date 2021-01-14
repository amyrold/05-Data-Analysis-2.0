# === Table of Contents ========================================================
# 1) Read In Raw Data
# 2) Data Cleaning (if it were needed)
# 3) Write Clean Data

# === Introduction =============================================================
#This assignment is much like the Workshops you did for assignment 03. I am giving you data and asking you to explore those data and produce output results and figures. Except this time, no answers are provided. You will find that you have already seen all the tools you need to solve these problems. You don't need to use those eact tools, necessarily, if you Google to find your own solutions or if you apply a different set of functions that you've found in the past few days. However, don't spend too much time re-creating the wheel!
#I am giving you three data tables in .csv format.
#A. phenotypic.data.for.analysis.no.sc.csv. These data are measurements for 21 traits taken by my collaborators from fossilized specimens of threespine stickleback fish. Specimens were taken from a diatomite quarry near Fernley, Nevada. They are fish from a 10 million year old lake. They were deposited and fossilized in annual layers, and the sequence sampled here spans about 17,000 years of sediment deposition. The data here comprise fish binned into 18 samples. The samples were taken approximately 1000 years apart;that is, the mean time of deposition for each bin is approximately 1000 years from its neighboring bin. Each sample has a varying number of fish specimens. Fossils are often damaged during preservation so not every trait could be measured for every specimen. Thus, you will find quite a bit of missing data, meaning that you have different sample sizes for different traits. THIS SAMPLING DESIGN WAS DESIGNATED THE K SERIES. Based on previous knowledge in this system, the K series targeted a span of evolution in this lineage just after a fully armored form (Lineage II) colonized from a different lake and replaced what was previously a low armor form in this lake (Lineage I). We have named this the replacement event, and time in this data set starts at k.T0 (i.e., T for transition, or replacement) and counts toward the present: k.19, k.18, k.17, ... k.04, k.03. Explanations of trait abbreviations are provided in a Word document that accompanies this assignment.

#B. univariate.data.L.fromTableS4_forAnalysis.csv. This data set is from a different sampling design in the same section of rock, DESIGNATED THE L SERIES. In this design, my collaborators sampled fish continuously (that is, not every 1000 years), every year for 5250 years before the replacement event (i.e., k.T0 in the K series) to 23250-5250 = 18,000 years after the replacement event. Thus, the L series overlaps all of the K series, but has 5250 years at the start that pre-date the arrival of the high-armor form. This data set is meant to track the reduction and loss of the pelvic girdle. The pelvic girdle is a bony structure composed of a ventral plate, an ascending arch, and two spines. The first Lineage II fish arrived fully armored, and had all of these elements. However, over the next 10-15,000 years, the lineage evolved amrmor reduction, losing the pelvic spines and the ascending arch, while retaining small, vestgial ventral plates that had broken into left-side and right-side elements. In modern stickleback, this pelvic reduction is due to a mutation that stops expression of the gene Pitx1. One thing that has been noted in modern stickleback is that Pitx1 loss manifests not just as reduced pelvic armor, but also vestigial armor plates that are larger on the left side. Thus, we have a phenotypic signature that we can look for in the fossils (left-larger pelvic vestiges) to infer the genetic basis of fossil evolution. This L series data set has left and right side pelvic vestige measurements for a subset of fish, allowing us to ask if left side vestiges are, on average, larger. The L series starts counting at 0, but fish are binned into 250-year intervals (the column INT). Thus, when INT = 250, that represents fish collected from years 0-250 of the sequence. INT = 500 represents years 251-500, and so on. We had to pool fish into these bins to get sample sizes large enough for statistical analysis. 

#C. KSampleMeanTimes.csv. This denotes the K series sample (T = k.T0 = time 0) and the number of years elapsed since the Transition. You will use this for the first few questions in section 3, and it might be useful for x-axes while plotting.
#
# end Introduction.

# === 1. Read Raw Data =========================================================
##### (2. Load and Define Global Variables Cont...)
#2c. Load data. We will use three .csv files for analysis, described in the introduction.
#2c-1. load "phenotypic.data.for.analysis.no.sc.csv" and call it k.series. The oldest time section is k.T0, then k.19, then counting down to k.03
k.series <- read.csv(paste(p.data.raw, 'phenotypic.data.for.analysis.no.sc.csv', sep=''))

#2c-2. load "univariate.data.L.fromTableS4_forAnalysis.csv" and call it l.series. INT is the time interval of the bin, with smaller numbers being older sections. k.series k.T0 is the same time slice as l.series INT 5250.
l.series <- read.csv(paste(p.data.raw, "univariate.data.L.fromTableS4_forAnalysis.csv", sep=''))

#2c.3. load K series time since colonization. #means time of sampling for each k.series sample (i.e., each time slice), since lineage II appeared in the section.
times.k.series <- read.csv(paste(p.data.raw, 'KSampleMeanTimes.csv', sep=''))

# === 2. Data Cleaning =========================================================

# === 3. Write Clean Data ======================================================

write.csv(k.series, paste(p.data.clean, 'phenotypic.data.for.analysis.no.sc.CLEAN.csv', sep=''))
write.csv(l.series, paste(p.data.clean, 'univariate.data.L.fromTableS4_forAnalysis.CLEAN.csv', sep=''))
write.csv(times.k.series, paste(p.data.clean, 'KSampleMeanTimes.CLEAN.csv', sep=''))
rm(k.series, l.series, times.k.series) # Remove raw data frames to avoid future manipulation of raw data

#___ end _______________________________________________________________________