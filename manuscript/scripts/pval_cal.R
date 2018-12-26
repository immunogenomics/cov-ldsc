# calculating pairwise pval between three populations

library('metafor') 
dat<-read.table("data/23andMe/fig3_values.txt",h=T,stringsAsFactors = F,sep="\t")
head(dat)
df<-dat[,!grepl("AA",names(dat))] #change here for 'EUR' or 'LAT' to get rid of one poulation
names(df)<-c("Phneotype","m1i","se1i","m2i","se2i","n1i","n2i")
df$sd1i<-with(df,se1i*sqrt(n1i))
df$sd2i<-with(df,se2i*sqrt(n2i))

df$d<-with(df,m1i-m2i)
df$s<-with(df,sqrt(((n1i-1)*sd1i^2 + (n2i-1)*sd2i^2)/(n1i + n2i - 2)))
df$v<-with(df,s^2*(1/n1i+1/n2i))
df$v2<-with(df,sd1i^2/n1i+sd2i^2/n2i)
df$se<-with(df,sqrt(v)) #assuming same population deviance
df$se2<-with(df,sqrt(v2)) #assuming different deviance
df$tval<-with(df,d/se)
df$tval2<-with(df,d/se2)
df$pval <- 2 * with(df, pt(abs(d/se), df = n1i + n2i - 2, lower.tail=FALSE))
df$pval2 <- 2 * with(df, pt(abs(d/se2), df = n1i + n2i - 2, lower.tail=FALSE))
df$sig <- ifelse(df$pval<0.05/3,1,0)
df$sig2<-ifelse(df$pval2<0.05/3,1,0)

df
