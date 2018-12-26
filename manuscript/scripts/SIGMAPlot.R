library(ggplot2)
library(gtable)
library(grid)
library(gridExtra)
library(ggpubr)

mypalette=c("orange1","dodgerblue1")
theme_set(theme_bw(base_size = 16))
outdir="figures/"
####Mean LD score of EUR vs. AMR in 1000G
ld=read.csv("data/1000G/1000G_windowsize.csv",header = T,stringsAsFactors = F)
ld=ld[ld$Population %in% c("AMR","EUR") & ld$PCs %in% c(0,10),]
ld$Method=factor(ld$Method,levels = c("LDSR","cov-LDSR"))
p=ggplot(data=ld, aes(x=cM, y=l2,linetype=Population, color=Method))+geom_line()+
  geom_point() +xlab("Window size (cM)")+
  ylab("Mean LD score")+scale_color_manual(values=mypalette,labels=c("LDSC (unadjusted)","cov-LDSC (10 PCs)"))+
  scale_x_continuous(breaks=scales::pretty_breaks(n = 10))+
  scale_linetype_manual(values=unique(as.factor(ld$Population)),labels=c("Admixed American (347)","European (503)"))
p
ggsave(paste(outdir,"SF1-1000G_MeanLD_varying_widow_size.png",sep=""))


####Mean LD score of AMR by different PCs 
ld=read.csv("data/1000G/1000G_windowsize.csv",header = T,stringsAsFactors = F)
cbbPalette <- c("orange1","#000000", "#56B4E9", "blue1", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
AMR_ld=ld[ld$Population %in% c("AMR") & ld$PCs !=50,]
AMR_ld$PCs=factor(AMR_ld$PCs,levels=c("0","2","5","10","20"))
p=ggplot(data=AMR_ld, aes(x=cM, y=l2, color=PCs))+geom_line()+
  geom_point() +xlab("Window size (cM)")+
  ylab("Mean LD score")+#scale_color_manual(values=c("orange1","green1","yellow1","blue1","pink1"))
  scale_color_manual(values=cbbPalette,name="Number of PCs")
p=p+theme_set(theme_bw(base_size = 16))+
  scale_x_continuous(breaks=scales::pretty_breaks(n = 10))
p
ggsave(paste(outdir,"SF2-1000G_AMR_diffpc.png",sep=""))

####Mean LD Score of SIGMA cohort
f=read.table("data/SIGMA_simulatephen/chr2_windowsize.csv",sep=",",header=T,stringsAsFactors = F)
f=f[f$PCs %in% c(0,10),]
f$Method=factor(f$Method,level=c("LDSC","cov-LDSC"))
p=ggplot(f,aes(x=as.numeric(window),y=L2,group=Method,color=Method))+geom_line()+geom_point()
p=p+guides(fill=guide_legend(title="Method"))
p=p+xlab("Window size (cM)")+ylab("Mean LD score")+
  scale_color_manual(values=mypalette,labels=methods)+
  scale_x_continuous(breaks=scales::pretty_breaks(n = 10))
p=p+theme_set(theme_bw(base_size = 16))
p
ggsave(paste(outdir,"SF6-SIGMA_MeanLD.png",sep=""))

###Mean LD Score of SIGMA cohort by different PCs 
f=read.table("data/SIGMA_simulatephen/chr2_windowsize.csv",sep=",",header=T,stringsAsFactors = F)
f=f[f$PCs!=50,]
f$Method=factor(f$Method,level=c("LDSC","cov-LDSC"))
f$PCs=factor(f$PCs,level=c("0","2","5","10","20"))
p=ggplot(f,aes(x=as.numeric(window),y=L2,group=PCs,color=PCs))+geom_line()+geom_point()
p=p+guides(fill=guide_legend(title="Number of PCs"))
p=p+xlab("Window size (cM)")+ylab("Mean LD score")+
  scale_color_manual(values=cbbPalette,name="Number of PCs")+
  scale_x_continuous(breaks=scales::pretty_breaks(n = 10))
p=p+theme_set(theme_bw(base_size = 16))
p
ggsave(paste(outdir,"SF7-SIGMA_MeanLD_diffpc.png",sep=""))

####different causal variants in SIGMA
causal_0.01_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_0.01per_h2.txt")
causal_0.01_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_0.01per_h2.txt")
causal_0.05_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_0.05per_h2.txt")
causal_0.05_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_0.05per_h2.txt")
causal_0.1_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_01per_h2.txt")
causal_0.1_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_01per_h2.txt")
causal_0.5_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_05per_h2.txt")
causal_0.5_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_05per_h2.txt")
causal_1_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_1per_h2.txt")
causal_1_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_1per_h2.txt")
causal_5_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_5per_h2.txt")
causal_5_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_5per_h2.txt")
causal_10_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_10per_h2.txt")
causal_10_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_10per_h2.txt")
causal_30_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_30per_h2.txt")
causal_30_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_30per_h2.txt")

all_h2=rbind(
  causal_0.01_nadj,causal_0.01_wadj,
  causal_0.05_nadj,causal_0.05_wadj,
  causal_0.1_nadj,causal_0.1_wadj,
  causal_0.5_nadj,causal_0.5_wadj,
  causal_1_nadj,causal_1_wadj,
  causal_5_nadj,causal_5_wadj,
  causal_10_nadj,causal_10_wadj,
  causal_30_nadj,causal_30_wadj)
pro_col=c(
  rep("0.01%",nrow(causal_0.01_nadj)+nrow(causal_0.01_wadj)),
  rep("0.05%",nrow(causal_0.05_nadj)+nrow(causal_0.05_wadj)),
  rep("0.1%",nrow(causal_0.1_nadj)+nrow(causal_0.1_wadj)),
  rep("0.5%",nrow(causal_0.5_nadj)+nrow(causal_0.5_wadj)),
  rep("1%",nrow(causal_1_nadj)+nrow(causal_1_wadj)),
  rep("5%",nrow(causal_5_nadj)+nrow(causal_5_wadj)),
  rep("10%",nrow(causal_10_nadj)+nrow(causal_10_wadj)),
  rep("30%",nrow(causal_30_nadj)+nrow(causal_30_wadj)))

tool_col=c(
  rep("LDSC",nrow(causal_0.01_nadj)),rep("cov-LDSC",nrow(causal_0.01_wadj)),
  rep("LDSC",nrow(causal_0.05_nadj)),rep("cov-LDSC",nrow(causal_0.05_wadj)),
  rep("LDSC",nrow(causal_0.1_nadj)),rep("cov-LDSC",nrow(causal_0.1_wadj)),
  rep("LDSC",nrow(causal_0.5_nadj)),rep("cov-LDSC",nrow(causal_0.5_wadj)),
  rep("LDSC",nrow(causal_1_nadj)),rep("cov-LDSC",nrow(causal_1_wadj)),
  rep("LDSC",nrow(causal_5_nadj)),rep("cov-LDSC",nrow(causal_5_wadj)),
  rep("LDSC",nrow(causal_10_nadj)),rep("cov-LDSC",nrow(causal_10_wadj)),
  rep("LDSC",nrow(causal_30_nadj)),rep("cov-LDSC",nrow(causal_30_wadj)))

df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels=c("LDSC","cov-LDSC"))
df$pro_col=factor(df$pro_col,levels=c("0.01%","0.05%","0.1%","0.5%","1%","5%","10%","30%"))
p=ggplot()+geom_hline(yintercept = 0.4,linetype="dashed",colour="red",size=1)+ylim(-0.1,1)
p=p+ geom_boxplot(data = df,aes(x=pro_col,y=h2,fill=tool_col))+scale_fill_manual(values=mypalette,labels=methods)
p=p+guides(fill=guide_legend(title="Method"))
p=p+xlab("Causal Variant")+ylab(expression(h[g]^2))
p=p+theme_set(theme_bw(base_size = 16))
pdiffcausal<-p
ggsave(paste(outdir,"Fig2(a)-SIGMA_diffcausal.png",sep=""))

####different causal variants in SIGMA intercept 
causal_0.01_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_0.01per_int.txt")
causal_0.01_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_0.01per_int.txt")
causal_0.05_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_0.05per_int.txt")
causal_0.05_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_0.05per_int.txt")
causal_0.1_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_01per_int.txt")
causal_0.1_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_01per_int.txt")
causal_0.5_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_05per_int.txt")
causal_0.5_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_05per_int.txt")
causal_1_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_1per_int.txt")
causal_1_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_1per_int.txt")
causal_5_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_5per_int.txt")
causal_5_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_5per_int.txt")
causal_10_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_10per_int.txt")
causal_10_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_10per_int.txt")
causal_30_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_30per_int.txt")
causal_30_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_30per_int.txt")

all_h2=rbind(
  causal_0.01_nadj,causal_0.01_wadj,
  causal_0.05_nadj,causal_0.05_wadj,
  causal_0.1_nadj,causal_0.1_wadj,
  causal_0.5_nadj,causal_0.5_wadj,
  causal_1_nadj,causal_1_wadj,
  causal_5_nadj,causal_5_wadj,
  causal_10_nadj,causal_10_wadj,
  causal_30_nadj,causal_30_wadj)
pro_col=c(
  rep("0.01%",nrow(causal_0.01_nadj)+nrow(causal_0.01_wadj)),
  rep("0.05%",nrow(causal_0.05_nadj)+nrow(causal_0.05_wadj)),
  rep("0.1%",nrow(causal_0.1_nadj)+nrow(causal_0.1_wadj)),
  rep("0.5%",nrow(causal_0.5_nadj)+nrow(causal_0.5_wadj)),
  rep("1%",nrow(causal_1_nadj)+nrow(causal_1_wadj)),
  rep("5%",nrow(causal_5_nadj)+nrow(causal_5_wadj)),
  rep("10%",nrow(causal_10_nadj)+nrow(causal_10_wadj)),
  rep("30%",nrow(causal_30_nadj)+nrow(causal_30_wadj)))

tool_col=c(
  rep("LDSC",nrow(causal_0.01_nadj)),rep("cov-LDSC",nrow(causal_0.01_wadj)),
  rep("LDSC",nrow(causal_0.05_nadj)),rep("cov-LDSC",nrow(causal_0.05_wadj)),
  rep("LDSC",nrow(causal_0.1_nadj)),rep("cov-LDSC",nrow(causal_0.1_wadj)),
  rep("LDSC",nrow(causal_0.5_nadj)),rep("cov-LDSC",nrow(causal_0.5_wadj)),
  rep("LDSC",nrow(causal_1_nadj)),rep("cov-LDSC",nrow(causal_1_wadj)),
  rep("LDSC",nrow(causal_5_nadj)),rep("cov-LDSC",nrow(causal_5_wadj)),
  rep("LDSC",nrow(causal_10_nadj)),rep("cov-LDSC",nrow(causal_10_wadj)),
  rep("LDSC",nrow(causal_30_nadj)),rep("cov-LDSC",nrow(causal_30_wadj)))

df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels=c("LDSC","cov-LDSC"))
df$pro_col=factor(df$pro_col,levels=c("0.01%","0.05%","0.1%","0.5%","1%","5%","10%","30%"))
p=ggplot()+ geom_boxplot(data = df,aes(x=pro_col,y=h2,fill=tool_col))+scale_fill_manual(values=mypalette,labels=methods)
p=p+guides(fill=guide_legend(title="Method"))+ylim(0.95,1.07)
p=p+xlab("Causal Variant")+ylab("Intercept")
p=p+theme_set(theme_bw(base_size = 16))
p=p+geom_hline(yintercept = 1,linetype="dashed",colour="red")+ylim(0.9,1.1)
pdiffcausal_intercept<-p


####diffh2 in SIGMA
h2_0per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0_10pc_h2.txt")
h2_0per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0_10pc_h2.txt")
h2_5per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.05_10pc_h2.txt")
h2_5per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.05_10pc_h2.txt")
h2_10per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.1_10pc_h2.txt")
h2_10per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.1_10pc_h2.txt")
h2_20per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.2_10pc_h2.txt")
h2_20per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.2_10pc_h2.txt")
h2_30per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.3_10pc_h2.txt")
h2_30per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.3_10pc_h2.txt")
h2_40per_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_1per_h2.txt")
h2_40per_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_1per_h2.txt")
h2_50per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.5_10pc_h2.txt")
h2_50per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.5_10pc_h2.txt")

all_h2=rbind(h2_0per_nadj,h2_0per_wadj,
             h2_5per_nadj,h2_5per_wadj,
             h2_10per_nadj,h2_10per_wadj,
             h2_20per_nadj,h2_20per_wadj,
             h2_30per_nadj,h2_30per_wadj,
             h2_40per_nadj,h2_40per_wadj,
             h2_50per_nadj,h2_50per_wadj)
pro_col=c(rep("0",nrow(h2_0per_nadj)+nrow(h2_0per_wadj)),
          rep("0.05",nrow(h2_5per_nadj)+nrow(h2_5per_wadj)),
          rep("0.10",nrow(h2_10per_nadj)+nrow(h2_10per_wadj)),
          rep("0.20",nrow(h2_20per_nadj)+nrow(h2_20per_wadj)),
          rep("0.30",nrow(h2_30per_nadj)+nrow(h2_30per_wadj)),
          rep("0.40",nrow(h2_40per_nadj)+nrow(h2_40per_wadj)),
          rep("0.50",nrow(h2_50per_nadj)+nrow(h2_50per_wadj)))

tool_col=c(rep("LDSC",nrow(h2_0per_nadj)),rep("cov-LDSC",nrow(h2_0per_wadj)),
           rep("LDSC",nrow(h2_5per_nadj)),rep("cov-LDSC",nrow(h2_5per_wadj)),
           rep("LDSC",nrow(h2_10per_nadj)),rep("cov-LDSC",nrow(h2_10per_wadj)),
           rep("LDSC",nrow(h2_20per_nadj)),rep("cov-LDSC",nrow(h2_20per_wadj)),
           rep("LDSC",nrow(h2_30per_nadj)),rep("cov-LDSC",nrow(h2_30per_wadj)),
           rep("LDSC",nrow(h2_40per_nadj)),rep("cov-LDSC",nrow(h2_40per_wadj)),
           rep("LDSC",nrow(h2_50per_nadj)),rep("cov-LDSC",nrow(h2_50per_wadj)))

df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggplot()+geom_boxplot(data=df,aes(x=pro_col,y=h2,fill=tool_col))+scale_fill_manual(values=mypalette,labels=methods)
p=p+guides(fill=guide_legend(title="Method"))
p=p+xlab("True Heritability")+ylim(-0.10,1)+ylab(expression(h[g]^2))
p=p+theme_set(theme_bw(base_size = 16))#+scale_x_continuous(breaks=scales::pretty_breaks(n = 10))
p=p+geom_segment(aes(x=0.5,xend=1.5,y=0,yend=0),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=1.5,xend=2.5,y=0.05,yend=0.05),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=2.5,xend=3.5,y=0.10,yend=0.10),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=3.5,xend=4.5,y=0.20,yend=0.20),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=4.5,xend=5.5,y=0.30,yend=0.30),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=5.5,xend=6.5,y=0.40,yend=0.40),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=6.5,xend=7.5,y=0.50,yend=0.50),size=1,colour="red",linetype='dashed')
pdiffh<-p
ggsave(paste(outdir,"Fig2(b)-SIGMA_diffh2.png",sep=""))

####diffh2 in SIGMA intercept 
h2_0per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0_10pc_int.txt")
h2_0per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0_10pc_int.txt")
h2_5per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.05_10pc_int.txt")
h2_5per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.05_10pc_int.txt")
h2_10per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.1_10pc_int.txt")
h2_10per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.1_10pc_int.txt")
h2_20per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.2_10pc_int.txt")
h2_20per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.2_10pc_int.txt")
h2_30per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.3_10pc_int.txt")
h2_30per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.3_10pc_int.txt")
h2_40per_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_1per_int.txt")
h2_40per_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_1per_int.txt")
h2_50per_nadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_noadj_h2_0.5_10pc_int.txt")
h2_50per_wadj=read.table("data/SIGMA_simulatephen/diffh2/multiple_ldsc_wadj_h2_0.5_10pc_int.txt")

all_h2=rbind(h2_0per_nadj,h2_0per_wadj,
             h2_5per_nadj,h2_5per_wadj,
             h2_10per_nadj,h2_10per_wadj,
             h2_20per_nadj,h2_20per_wadj,
             h2_30per_nadj,h2_30per_wadj,
             h2_40per_nadj,h2_40per_wadj,
             h2_50per_nadj,h2_50per_wadj)
pro_col=c(rep("0",nrow(h2_0per_nadj)+nrow(h2_0per_wadj)),
          rep("0.05",nrow(h2_5per_nadj)+nrow(h2_5per_wadj)),
          rep("0.10",nrow(h2_10per_nadj)+nrow(h2_10per_wadj)),
          rep("0.20",nrow(h2_20per_nadj)+nrow(h2_20per_wadj)),
          rep("0.30",nrow(h2_30per_nadj)+nrow(h2_30per_wadj)),
          rep("0.40",nrow(h2_40per_nadj)+nrow(h2_40per_wadj)),
          rep("0.50",nrow(h2_50per_nadj)+nrow(h2_50per_wadj)))

tool_col=c(rep("LDSC",nrow(h2_0per_nadj)),rep("cov-LDSC",nrow(h2_0per_wadj)),
           rep("LDSC",nrow(h2_5per_nadj)),rep("cov-LDSC",nrow(h2_5per_wadj)),
           rep("LDSC",nrow(h2_10per_nadj)),rep("cov-LDSC",nrow(h2_10per_wadj)),
           rep("LDSC",nrow(h2_20per_nadj)),rep("cov-LDSC",nrow(h2_20per_wadj)),
           rep("LDSC",nrow(h2_30per_nadj)),rep("cov-LDSC",nrow(h2_30per_wadj)),
           rep("LDSC",nrow(h2_40per_nadj)),rep("cov-LDSC",nrow(h2_40per_wadj)),
           rep("LDSC",nrow(h2_50per_nadj)),rep("cov-LDSC",nrow(h2_50per_wadj)))

df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggplot()+geom_boxplot(data=df,aes(x=pro_col,y=h2,fill=tool_col))+scale_fill_manual(values=mypalette)
p=p+guides(fill=guide_legend(title="Method"))+ylim(0.95,1.07)
p=p+xlab("True Heritability")+ylab("Intercept")
p=p+theme_set(theme_bw(base_size = 16))#+scale_x_continuous(breaks=scales::pretty_breaks(n = 10))
p=p+geom_hline(yintercept = 1,linetype="dashed",colour="red")+ylim(0.9,1.1)
pdiffh_intercept<-p

##env_str
no_adj=read.table("data/SIGMA_simulatephen/env_str/noadj_sum.txt")
w_adj=read.table("data/SIGMA_simulatephen/env_str/wadj_sum.txt")
all_h2=rbind(no_adj,w_adj)
tool_col=c(rep("LDSC",nrow(no_adj)),rep("cov-LDSC",nrow(w_adj)))
df=cbind(tool_col,all_h2)
colnames(df)=c("tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggplot(df,aes(x=tool_col,y=h2))+geom_boxplot(aes(fill=tool_col))+xlab(NULL)+ylab(expression(h[g]^2))
p=p+guides(fill=guide_legend(title="Methods"))+scale_fill_manual(values=mypalette,labels=methods)+theme_set(theme_bw(base_size = 16))
p=p+geom_hline(yintercept = 0.4,linetype="dashed",colour="red",size=1)
pevnstr<-p+theme(legend.position  = "none")
pevnstr
ggsave(paste(outdir,"Fig2(c)-SIGMA_envstrat.png",sep=""))

#env_strat intercept
no_adj=read.table("data/SIGMA_simulatephen/env_str/noadj_sum_int.txt")
w_adj=read.table("data/simulated_genotypes/env_str/multiple_h2_wadj_p0.5_unrelated_envstr_int.txt")
all_h2=rbind(w_adj,no_adj)
tool_col=c(rep("LDSC",nrow(no_adj)),rep("cov-LDSC",nrow(w_adj)))
df=cbind(tool_col,all_h2)
colnames(df)=c("tool_col","h2")
df$tool_col=factor(df$tool_col,labels = methods)
p=ggplot(df,aes(x=tool_col,y=h2))+geom_boxplot(aes(fill=tool_col))+xlab("Methods")+ylab("Intercept")
p=p+guides(fill=guide_legend(title="Methods"))+scale_fill_manual(values=mypalette)+theme_set(theme_bw(base_size = 16))
p=p+geom_hline(yintercept = 1,linetype="dashed",colour="red")+ylim(0.9,1.1)
p
pevnstrat_intercept<-p+theme(legend.position  = "none")

####subsampling in SIGMA cohort 
subsample_no_adj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_30per_h2.txt")
subsample_with_adj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_30per_h2.txt")
subsample_4k_nadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_noadj_h2_0.4_10pc_subsample4k_h2.txt")
subsample_4k_wadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_wadj_h2_0.4_10pc_subsample4k_h2.txt")
subsample_1k_nadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_noadj_h2_0.4_10pc_subsample1k_h2.txt")
subsample_1k_wadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_wadj_h2_0.4_10pc_subsample1k_h2.txt")
subsample_AFR_noadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_noadj_h2_0.4_10pc_AMR_h2.txt")
subsample_AFR_wadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_wadj_h2_0.4_10pc_AMR_h2.txt")
subsample_347_nadj=read.table("data/SIGMA_simulatephen/subsampling/subsample_347_h2_noadj_h2.txt")
subsample_347_wadj=read.table("data/SIGMA_simulatephen/subsampling/subsample_347_h2_wadj_h2.txt")

all_h2=rbind(subsample_no_adj, subsample_with_adj,
             subsample_4k_nadj,subsample_4k_wadj,
             subsample_1k_nadj,subsample_1k_wadj,
             subsample_347_nadj,subsample_347_wadj,
             subsample_AFR_noadj,subsample_AFR_wadj
             )
#subsample_10per_rest_noadj,subsample_10per_rest_wadj)
pro_col=c(rep("ALL",nrow(subsample_no_adj)+nrow(subsample_with_adj)),
          rep("4k",nrow(subsample_4k_nadj)+nrow(subsample_4k_wadj)),
          rep("1k",nrow(subsample_1k_nadj)+nrow(subsample_1k_wadj)),
          rep("347",nrow(subsample_347_nadj)+nrow(subsample_347_wadj)),
          rep("1000G AMR",nrow(subsample_AFR_noadj)+nrow(subsample_AFR_wadj))
          )

tool_col=c(rep("LDSC",nrow(subsample_no_adj)),rep("cov-LDSC",nrow(subsample_with_adj)),
           rep("LDSC",nrow(subsample_4k_nadj)),rep("cov-LDSC",nrow(subsample_4k_wadj)),
           rep("LDSC",nrow(subsample_1k_nadj)),rep("cov-LDSC",nrow(subsample_1k_wadj)),
           rep("LDSC",nrow(subsample_347_nadj)),rep("cov-LDSC",nrow(subsample_347_wadj)),
           rep("LDSC",nrow(subsample_AFR_noadj)),rep("cov-LDSC",nrow(subsample_AFR_wadj))
           )

df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggboxplot(data=df[df$tool_col=="cov-LDSC",],x="pro_col",y="h2",fill="tool_col",ggtheme=theme_bw(base_size=16))+
  scale_fill_manual(values=mypalette[2])+geom_hline(yintercept = 0.4,size=1,linetype="dashed",colour="red")
p=p+guides(fill=guide_legend("none"))+xlab("Subsample Size")+ylim(-0.1,1)+ylab(expression(h[g]^2))
p<-p+scale_x_discrete(limits=c("ALL","4k","1k","347","1000G AMR"),labels=c("All (8,124)","4,000","1,000","347","1000 Genomes \nAMR (347)"))
my_comparisons <- list( c("4k","ALL"), c("1k", "ALL"),c("347","ALL"),c("1000G AMR", "ALL") )

p=p+stat_compare_means(comparisons=my_comparisons,aes(group="cov-LDSC"))+theme(legend.position="none")
psubsampling<-p
psubsampling
ggsave(paste(outdir,"Fig2(d)-SIGMA_subsampling.png",sep=""))

####subsampling in SIGMA cohort intercept  
subsample_no_adj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_30per_int.txt")
subsample_with_adj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_30per_int.txt")
subsample_4k_nadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_noadj_h2_0.4_10pc_subsample4k_int.txt")
subsample_4k_wadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_wadj_h2_0.4_10pc_subsample4k_int.txt")
subsample_1k_nadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_noadj_h2_0.4_10pc_subsample1k_int.txt")
subsample_1k_wadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_wadj_h2_0.4_10pc_subsample1k_int.txt")
subsample_AFR_noadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_noadj_h2_0.4_10pc_AMR_int.txt")
subsample_AFR_wadj=read.table("data/SIGMA_simulatephen/subsampling/multiple_ldsc_wadj_h2_0.4_10pc_AMR_int.txt")
subsample_347_nadj=read.table("data/SIGMA_simulatephen/subsampling/subsample_347_h2_noadj_int.txt")
subsample_347_wadj=read.table("data/SIGMA_simulatephen/subsampling/subsample_347_h2_wadj_int.txt")

all_h2=rbind(subsample_no_adj, subsample_with_adj,
             subsample_4k_nadj,subsample_4k_wadj,
             subsample_1k_nadj,subsample_1k_wadj,
             subsample_347_nadj,subsample_347_wadj,
             subsample_AFR_noadj,subsample_AFR_wadj
)
pro_col=c(rep("ALL",nrow(subsample_no_adj)+nrow(subsample_with_adj)),
          rep("4k",nrow(subsample_4k_nadj)+nrow(subsample_4k_wadj)),
          rep("1k",nrow(subsample_1k_nadj)+nrow(subsample_1k_wadj)),
          rep("347",nrow(subsample_347_nadj)+nrow(subsample_347_wadj)),
          rep("1000G AMR",nrow(subsample_AFR_noadj)+nrow(subsample_AFR_wadj))
)


tool_col=c(rep("LDSC",nrow(subsample_no_adj)),rep("cov-LDSC",nrow(subsample_with_adj)),
           rep("LDSC",nrow(subsample_4k_nadj)),rep("cov-LDSC",nrow(subsample_4k_wadj)),
           rep("LDSC",nrow(subsample_1k_nadj)),rep("cov-LDSC",nrow(subsample_1k_wadj)),
           rep("LDSC",nrow(subsample_347_nadj)),rep("cov-LDSC",nrow(subsample_347_wadj)),
           rep("LDSC",nrow(subsample_AFR_noadj)),rep("cov-LDSC",nrow(subsample_AFR_wadj))
)


df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggboxplot(data=df[df$tool_col=="cov-LDSC",],x="pro_col",y="h2",fill="tool_col",ggtheme=theme_bw(base_size=16))+
  scale_fill_manual(values=mypalette[2])+geom_hline(yintercept = 1,size=1,linetype="dashed",colour="red")
p=p+guides(fill=guide_legend("none"))+xlab("Subsample Size")+ylim(0.9,1.1)+ylab("Intercept")
p<-p+scale_x_discrete(limits=c("ALL","4k","1k","347","1000G AMR"),labels=c("All (8,124)","4,000","1,000","347","1000 Genomes \nAMR (347)"))

psubsampling_intercept<-p


####SIGMA heatmap with different pcs 
LDpc=c(2,5,10,20)
sumstatpc=c(2,5,10,20)
pcmatrix=c()
for (i in LDpc)
{
  for (j in sumstatpc)
  {
    fname=paste("data/SIGMA_simulatephen/diffpc_heatmap/multiple_ldsc_wadj_",i,"pc_h2_0.4_",j,"pc_h2.txt",sep="")
    f=read.table(fname)
    true=c(rep(0.4,length(f$V1)))
    pcmatrix=rbind(pcmatrix,c(i,j,median(f$V1),t.test(f$V1,mu=0.4)$p.value))
  }
}

pcmatrix=as.data.frame(pcmatrix)
colnames(pcmatrix)=c("LD_PCs","sumstats_PCs","Value","pval")
#pcmatrix$Value=as.numeric(pcmatrix$Value)
pcmatrix$LD_PCs=factor(pcmatrix$LD_PCs,levels = c("2","5","10","20"))
pcmatrix$sumstats_PCs=factor(pcmatrix$sumstats_PCs,levels = c("2","5","10","20"))
pcmatrix$diff=abs(pcmatrix$Value-0.4)
pcmatrix$logpval=-log10(pcmatrix$pval)
corrplot(as.matrix(abs(M)), method="color",  col=col(100),
         type="upper", 
         addCoef.col = "black", # Add coefficient of correlation
         tl.col="black", tl.srt=45, #Text label color and rotation
         # hide correlation coefficient on the principal diagonal
         diag=FALSE,cl.lim = c(0, .5)
)
p=ggplot(data = pcmatrix, aes(x=LD_PCs, y=sumstats_PCs)) +
  geom_tile(aes(fill=logpval,colour=2))+scale_fill_gradient(low = "white", high = "red",name=expression(-log[10](P)),labels=c("0","10","20"),breaks=c(0.1,10,20))+
  geom_text(data=pcmatrix,aes(x=LD_PCs, y=sumstats_PCs,label=paste(format(round((Value-0.4)/0.4*100, digits=1), nsmall = 1),"%",sep="")) ,colour="black",size=4)+
  theme_set(theme_bw(base_size = 16))+xlab("Number of PCs used in LD score")+ylab("Number of PCs used in summary statistics")
p+scale_colour_continuous(guide = FALSE)
ggsave(paste(outdir,"SF11-SIGMA_pcheatmap.png",sep=""))

####different window size 
h2_1cm_nadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_noadj_1cm_h2_0.4_10pc_h2.txt")
h2_1cm_wadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_wadj_1cm_h2_0.4_10pc_h2.txt")
h2_2cm_nadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_noadj_2cm_h2_0.4_10pc_h2.txt")
h2_2cm_wadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_wadj_2cm_h2_0.4_10pc_h2.txt")
h2_5cm_nadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_noadj_5cm_h2_0.4_10pc_h2.txt")
h2_5cm_wadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_wadj_5cm_h2_0.4_10pc_h2.txt")
h2_10cm_nadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_noadj_10cm_h2_0.4_10pc_h2.txt")
h2_10cm_wadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_wadj_10cm_h2_0.4_10pc_h2.txt")
h2_20cm_nadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_noadj_h2_0.4_10pc_1per_h2.txt")
h2_20cm_wadj=read.table("data/SIGMA_simulatephen/diffpro/multiple_ldsc_wadj_h2_0.4_10pc_1per_h2.txt")
h2_30cm_nadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_noadj_30cm_h2_0.4_10pc_h2.txt")
h2_30cm_wadj=read.table("data/SIGMA_simulatephen/diffcm/multiple_ldsc_wadj_30cm_h2_0.4_10pc_h2.txt")

all_h2=rbind(h2_1cm_nadj,h2_1cm_wadj,
             h2_2cm_nadj,h2_2cm_wadj,
             h2_5cm_nadj,h2_5cm_wadj,
             h2_10cm_nadj,h2_10cm_wadj,
             h2_20cm_nadj,h2_20cm_wadj,
             h2_30cm_nadj,h2_30cm_wadj)
cm_col=c(rep("1",nrow(h2_1cm_nadj)+nrow(h2_1cm_wadj)),
          rep("2",nrow(h2_2cm_nadj)+nrow(h2_2cm_wadj)),
          rep("5",nrow(h2_5cm_nadj)+nrow(h2_5cm_wadj)),
          rep("10",nrow(h2_10cm_nadj)+nrow(h2_10cm_wadj)),
          rep("20",nrow(h2_20cm_nadj)+nrow(h2_20cm_wadj)),
          rep("30",nrow(h2_30cm_nadj)+nrow(h2_30cm_wadj)))

tool_col=c(rep("LDSC",nrow(h2_1cm_nadj)),rep("cov-LDSC",nrow(h2_1cm_wadj)),
           rep("LDSC",nrow(h2_2cm_nadj)),rep("cov-LDSC",nrow(h2_2cm_wadj)),
           rep("LDSC",nrow(h2_5cm_nadj)),rep("cov-LDSC",nrow(h2_5cm_wadj)),
           rep("LDSC",nrow(h2_10cm_nadj)),rep("cov-LDSC",nrow(h2_10cm_wadj)),
           rep("LDSC",nrow(h2_20cm_nadj)),rep("cov-LDSC",nrow(h2_20cm_wadj)),
           rep("LDSC",nrow(h2_30cm_nadj)),rep("cov-LDSC",nrow(h2_30cm_wadj)))

df=cbind(cm_col,tool_col,all_h2)
colnames(df)=c("cm_col","tool_col","h2")
df$cm_col=factor(df$cm_col,levels=c("1","2","5","10","20","30"))
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggplot()+geom_hline(yintercept = 0.4,linetype="dashed",colour="red",size=1)+ylim(-0.1,1)
p=p+ geom_boxplot(data = df,aes(x=cm_col,y=h2,fill=tool_col))+scale_fill_manual(values=mypalette,labels=methods)
p=p+guides(fill=guide_legend(title="Method"))
p=p+xlab("Window Size (cM)")+ylab(ylab)
p=p+theme_set(theme_bw(base_size = 16))
p
ggsave(paste(outdir,"SF13-SIGMA_varying_widow_size.png",sep=""))



#combined plot for figure 2
legend = gtable_filter(ggplotGrob(pdiffcausal), "guide-box") 
p<-grid.arrange(arrangeGrob(pdiffcausal+ylab(NULL)+theme(legend.position  = "none")+ggtitle("(a)"),pdiffh+ylab(NULL)+theme(legend.position  = "none")+ggtitle("(b)"),
                         pevnstr+ylab(NULL)+xlab(NULL)+ggtitle("(c)"),
                         psubsampling+ylab(NULL)+ggtitle("(d)"),
                         nrow=2,
                         left = textGrob(expression(h[g]^2), rot = 90, gp=gpar(fontsize=20,face="bold"), vjust = 1)),
             legend,
             widths=unit.c(unit(1, "npc") - legend$width, legend$width),nrow=1)
p
ggsave(paste(outdir,"Fig2-combined.png",sep=""),p,width=15,height=10)

#intercept
legend = gtable_filter(ggplotGrob(pdiffcausal_intercept), "guide-box") 
p<-grid.arrange(arrangeGrob(pdiffcausal_intercept+ylab(NULL)+theme(legend.position  = "none")+ggtitle("(a)"),
                            pdiffh_intercept+ylab(NULL)+theme(legend.position  = "none")+ggtitle("(b)"),
                            pevnstrat_intercept+ylab(NULL)+xlab(NULL)+ggtitle("(c)"),
                            psubsampling_intercept+ylab(NULL)+ggtitle("(d)")+theme(legend.position  = "none"),
                            nrow=2,
                            left = textGrob(expression(Intercept), rot = 90, gp=gpar(fontsize=20,face="bold"), vjust = 1)),
                legend,
                widths=unit.c(unit(1, "npc") - legend$width, legend$width),nrow=1)
p
ggsave(paste(outdir,"SF8-SIGMA_intercepts_combined.png",sep=""),p,width=13,height=10)
