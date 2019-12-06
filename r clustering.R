setwd('/Users/Anand/Desktop/Practice/')
inputDF<- read.csv(file='SMSDATA/sms-call-internet-mi-2013-11-01.csv',header = TRUE)
#
inputDF<-inputDF[sample(nrow(inputDF),size = 10000),]

#
columnsToFactorify<-c('CellID','countrycode')
inputDF[columnsToFactorify]<-lapply(inputDF[columnsToFactorify],as.factor)
inputDF$activity_start_time<-as.POSIXct(inputDF$datetime)
inputDF$activity_time<-format(inputDF$activity_start_time,format = "%H")
inputDF$activity_date<-as.Date(inputDF$activity_start_time)
#inputDF$total_activity<-rowSums(inputDF[,c( "smsin","smsout","callin",
#                                            "callout","internet")],na.rm = TRUE)
inputDF$total_activity<-rowSums(inputDF[,c("smsin","callin",
                                            "callout","internet")],na.rm = TRUE)

library(ggplot2)
#ggplot2.barplot(data=plotDF, xName="activity_time", yName='total_activity')

clusterDF<-inputDF[,c("activity_time","total_activity")]
clusterDF$activity_time<-as.numeric(clusterDF$activity_time)
clusterDF$activity_time<-(clusterDF$activity_time - min(clusterDF$activity_time))/
                         (max(clusterDF$activity_time)-min(clusterDF$activity_time))
clusterDF$total_activity<-(clusterDF$total_activity - min(clusterDF$total_activity))/
                          (max(clusterDF$total_activity)-min(clusterDF$total_activity))

k.max <- 15
wss <- sapply(1:k.max, 
              function(k){kmeans(clusterDF, k, nstart=50,iter.max = 15 )$tot.withinss})
plot(1:k.max, wss,
     type="b", pch = 19, frame = FALSE, 
     xlab="Number of clusters K",
     ylab="Total within-clusters sum of squares")
chosenK<-10
modelObj<-kmeans(clusterDF, chosenK, nstart=50,iter.max = 30 )
clusterDF$clusterNo<- modelObj$cluster
#clusterDF$activity_time<-as.integer(clusterDF$activity_time)
aggregatedClusters=with(clusterDF, aggregate(total_activity, by=list(clusterNo=clusterNo, activity_time=activity_time), sum))
ggplot(aggregatedClusters, aes(activity_time, clusterNo, fill= x)) + geom_tile() + scale_fill_gradient(low="white", high="blue")


#library(fpc)
#plotclust

ggplot(clusterDF, aes(activity_time, total_activity)) +
  #geom_smooth(method='lm')+
  geom_point(shape = 16, aes( color=as.factor(clusterNo)), show.legend = FALSE) +
  theme_classic()+scale_color_brewer(palette="RdYlGn")+
  #geom_point(mapping=aes_string(x=modelObj$centers[,1], y =modelObj$centers[,2]), colour="blue")
  geom_point(mapping = aes_string(x = rep(modelObj$centers[,1],1000), 
                                  y = rep(modelObj$centers[,2],1000)),
             color = "red", size = 4, shape=3)

#countryDF[order(-countryDF$total_activity),]
#countryDF<-countryDF[order(-countryDF$total_activity),]
countryMapping<-read.csv(file='CountryMapping.csv')
#gsub("+","",as.character(factor(countryMapping$International.dialing)))
countryMapping$newCode <- as.factor(gsub("-","",gsub("\\+", "", countryMapping$International.dialing)))
inputDF2<-merge(x=inputDF,y=countryMapping,by.x = "countrycode", by.y = "newCode", all.x=TRUE)

#barplot(aggregate(total_activity ~ countrycode, countryDF, sum)$total_activity, 
#        names.arg=aggregate(total_activity ~ countrycode, countryDF, sum)$countrycode)
AgrCountr<-aggregate(total_activity ~ Country.code, inputDF2, sum)
AgrCountr<-AgrCountr[order(-AgrCountr$total_activity),]


barplot(AgrCountr[2:21,]$total_activity, 
        names.arg=AgrCountr[2:21,]$Country.code)

