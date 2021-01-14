# === Table of Contents ========================================================
# 1. Read In Cleaned Data
# 2. define global variables
# 3. Explorations and analyses with the K series
# 3. Explorations and analyses with the L series

# === Introduction =============================================================
#This assignment is much like the Workshops you did for assignment 03. I am giving you data and asking you to explore those data and produce output results and figures. Except this time, no answers are provided. You will find that you have already seen all the tools you need to solve these problems. You don't need to use those eact tools, necessarily, if you Google to find your own solutions or if you apply a different set of functions that you've found in the past few days. However, don't spend too much time re-creating the wheel!
#I am giving you three data tables in .csv format.
#A. phenotypic.data.for.analysis.no.sc.csv. These data are measurements for 21 traits taken by my collaborators from fossilized specimens of threespine stickleback fish. Specimens were taken from a diatomite quarry near Fernley, Nevada. They are fish from a 10 million year old lake. They were deposited and fossilized in annual layers, and the sequence sampled here spans about 17,000 years of sediment deposition. The data here comprise fish binned into 18 samples. The samples were taken approximately 1000 years apart;that is, the mean time of deposition for each bin is approximately 1000 years from its neighboring bin. Each sample has a varying number of fish specimens. Fossils are often damaged during preservation so not every trait could be measured for every specimen. Thus, you will find quite a bit of missing data, meaning that you have different sample sizes for different traits. THIS SAMPLING DESIGN WAS DESIGNATED THE K SERIES. Based on previous knowledge in this system, the K series targeted a span of evolution in this lineage just after a fully armored form (Lineage II) colonized from a different lake and replaced what was previously a low armor form in this lake (Lineage I). We have named this the replacement event, and time in this data set starts at k.T0 (i.e., T for transition, or replacement) and counts toward the present: k.19, k.18, k.17, ... k.04, k.03. Explanations of trait abbreviations are provided in a Word document that accompanies this assignment.

#B. univariate.data.L.fromTableS4_forAnalysis.csv. This data set is from a different sampling design in the same section of rock, DESIGNATED THE L SERIES. In this design, my collaborators sampled fish continuously (that is, not every 1000 years), every year for 5250 years before the replacement event (i.e., k.T0 in the K series) to 23250-5250 = 18,000 years after the replacement event. Thus, the L series overlaps all of the K series, but has 5250 years at the start that pre-date the arrival of the high-armor form. This data set is meant to track the reduction and loss of the pelvic girdle. The pelvic girdle is a bony structure composed of a ventral plate, an ascending arch, and two spines. The first Lineage II fish arrived fully armored, and had all of these elements. However, over the next 10-15,000 years, the lineage evolved amrmor reduction, losing the pelvic spines and the ascending arch, while retaining small, vestgial ventral plates that had broken into left-side and right-side elements. In modern stickleback, this pelvic reduction is due to a mutation that stops expression of the gene Pitx1. One thing that has been noted in modern stickleback is that Pitx1 loss manifests not just as reduced pelvic armor, but also vestigial armor plates that are larger on the left side. Thus, we have a phenotypic signature that we can look for in the fossils (left-larger pelvic vestiges) to infer the genetic basis of fossil evolution. This L series data set has left and right side pelvic vestige measurements for a subset of fish, allowing us to ask if left side vestiges are, on average, larger. The L series starts counting at 0, but fish are binned into 250-year intervals (the column INT). Thus, when INT = 250, that represents fish collected from years 0-250 of the sequence. INT = 500 represents years 251-500, and so on. We had to pool fish into these bins to get sample sizes large enough for statistical analysis. 

#C. KSampleMeanTimes.csv. This denotes the K series sample (T = k.T0 = time 0) and the number of years elapsed since the Transition. You will use this for the first few questions in section 3, and it might be useful for x-axes while plotting.
#
# end Introduction.

# === 1. Read In Cleaned Data ==================================================

##### (2. Load data and define global variables Cont....)
k.series.c <- read.csv(paste(p.data.clean, 'phenotypic.data.for.analysis.no.sc.CLEAN.csv', sep=''))
l.series.c <- read.csv(paste(p.data.clean, "univariate.data.L.fromTableS4_forAnalysis.CLEAN.csv", sep=''))
times.k.series.c <- read.csv(paste(p.data.clean, 'KSampleMeanTimes.CLEAN.csv', sep=''))

# === 2. Define Global Variables ===============================================
##### (2. Load data and define global variables Cont....)
#2d. define the following global variables, which might help you as you partition and subsample the above data frames.
layers.k.series.c <- unique(substr(k.series.c$univ.specimenID, 1, 4)) #these are the names of the k series time sections, from oldest to youngest
layers.l.series.c <-sort(unique(l.series.c$INT)) #these are the names of the l series time sections, from oldest to youngest
#
# end 2. Load Data

##### 3. Explorations and analyses with the K series #####
head(k.series.c) ; str(k.series.c)
#the specimen ID format for the k series is X.YY_### where X denotes that we are working with the k series, YY denotes the section of rock from which a specimen was taken, and ### is an individual specimen identifier. Each YY is a section of rock that makes up population "sample" comprised of multiple fossil specimens. 

##1. How many k.series samples are there?
sum(is.na(k.series.c[,1])) # Check for NAs in ID column (none)
length(unique(k.series.c[,1])) # (814 unique samples)


##2. KSampleMeanTimes tells how much time in years have passed between k.T0 and subsequent samples. What are the minimum, maximum, and average amounts of time separating each successive sample? That is, sample to sample, how much time separates them, on average. Min? Max?
time.diff=c() #create an empty vector to store values
for(i in 1:length(times.k.series.c[,1])-1){ #For loop that will cycle through the rows
  time.diff <- append(time.diff, times.k.series.c[i,3] - times.k.series.c[i+1,3]) #We calculate the difference between the current row and the following. Store that difference in 'time.diff'
  #NB: We stop one row short (length(times.k.series.c[,1])-1) to avoid creating an NA.
}
#Now that we have created a vector of time differences, we can easily calculate the max/min/mean
mean(time.diff) #978.6635
max(time.diff) #1674.87
min(time.diff) #230.36

##3. For each trait in the k.series table (i.e. columns 2:23), what is the sample size pooled across all temporal samples?
#(You can just copy and paste your Console output inline with your code. Add "#" in front of each line, however, so that the output isn't treated as code)



##4. For each trait in the k.series table, what is the sample size within each sample, i.e., for k.T0, k.19, etc.? At roughly what time sample do first dorsal spines (ds1) and second dorsal spines (ds2) become rare? 
#(You can just copy and paste your Console output inline with your code. Add "#" in front of each line, however, so that the output isn't treated as code)



##5. What are the trait means and standard deviations for each trait, pooling across the temporal samples. (i.e., one mean and one sd per column)?
#(You can just copy and paste your Console output inline with your code. Add "#" in front of each line, however, so that the output isn't treated as code)



##6. For each trait, how many individual trait values are more than 3 standard deviations from the mean, suggesting an outlier?
#(You can just copy and paste your Console output inline with your code. Add "#" in front of each line, however, so that the output isn't treated as code)



##7. Let's visualize these outliers. Generate a frequency histogram for each trait (pooling across temporal samples). On each histogram, place a vertical line 3 sds above and 3 sds below the mean. Do outliers tend to be larger than the mean, smaller, or evenly distributed about the mean? A for loop will be of service here. You might also consider the function abline for adding the vertical lines.
#run this parameter setting first:
par(mfrow = c(1,1), mar = c(4,4,0,0), oma = c(0,0,0,0))



##8. What is the general trend of evolution in this lineage between the first and tenth samples (i.e., k.T0 and k.11)? That is, trait by trait, how do trait values differ from the start of the sequence and the 10th sample.



##9. Let's visualize these trends. For each trait, plot each trait mean value, at each time section from k.T0 to k.11. Connect successive means with a line. A for loop will be helpful here, cycling through traits, using tapply or table or something similar to get means at each timestep for each trait. make sure you plot from k.T0 to k.03.



#
# end 3. Explorations and analyses with the K series

##### 4. Explorations and analyses with the L series #####
head(l.series)

##10. This dataset is filled with NAs, because many more fossils were collected then were measured for left and right side pelvic vestiges. Create a new data frame that contains only specimens for which both left and right side pelvic vestige lengths were measured. What is the number of fish sampled in this new data frame?



##11. If left-side pelvic vestiges are larger on average than their corresponding right-side pelvic vestiges (i.e., if a fish has pelvic vestiges and the one on the left is larger than the one on the right), then we have evidence that mutations to Pitx1 are likely responsible for pelvic reduction (see the paper for more information). Create a new column that measures percent asymmetry with the following formula: (right side pelvic vestige - left side pelvic vestige) / (right side pelvic vestige + left side pelvic vestige) * 100. With this formula, negative values imply left larger asymmetry.



#12. There are some pelvic vestige measurements that are equal to the fourth decimal place on right and left sides. This seems unlikely for continuous traits. First report out how many fish have a score of 0 for asymmetry. Then remove them from your data frame.



#13. Plot these percent asymmetry values from most left biased to most right biased as you proceed along the x-axis.  Are there more fish with left or right side larger pelvic vestiges? 
#Bonus Challenge (1EC point): If you used boxplot, add an x-axis and put a vertical line where percent asymmetry switches from left to right biased.



#
# end 4. Explorations and analyses with the L series