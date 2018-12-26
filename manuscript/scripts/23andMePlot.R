###23andMe Results
outdir="figures/"

#LD vs window size 
ld=read.table("data/23andMe/MeanLD_AM_AF.csv",sep=",",header=T)
ld=ld[ld$MAF=="0.01",]
ld$Method=factor(ld$Method,levels = c("LDSC","cov-LDSC"))
p=ggplot(data=ld, aes(x=cM, y=L2,linetype=pop, color=Method))+geom_line()+
  geom_point() +xlab("Window size (cM)")+
  ylab("Mean LD score")+scale_color_manual(values=mypalette,labels=c("LDSC (unadjusted)","cov-LDSC (10 PCs)"))+
  scale_x_continuous(breaks=scales::pretty_breaks(n = 10))+
  scale_linetype_manual(values=unique(as.factor(ld$pop)),labels=c("African Americans (46,844)","Latinos (161,894)"),
                        name="Population")
ggsave(paste(outdir,"SF10-23andMe_MeanLD_varying_widow_size.png",sep=""))


#Figure 3
trait_23andme=read.csv("data/23andMe/population_h2_7traits.csv")
x<-trait_23andme
df<-data.frame(Phenotype=x$Trait,hg2=x$h2,
               LowerLimit=x$h2-x$std,
               UpperLimit=x$h2+x$std,
               Cohort=x$Populations)

df$trait = factor(df$Phenotype, levels=c('BMI','height','age at menarche','left handedness','morning person','motion sickness','nearsightedness'))

p = ggplot(data=df,
           aes(x = Cohort,y = hg2, ymin = LowerLimit, ymax = UpperLimit ))+
  geom_pointrange(aes(col=Cohort))+
  #geom_hline(aes(fill=Group),yintercept =1, linetype=2)+
  xlab(NULL)+ ylab("Heritablilty (standard error)")+
  geom_errorbar(aes(ymin=LowerLimit, ymax=UpperLimit,col=Cohort),width=0.5,cex=1)+ 
  facet_wrap(~trait,strip.position="left",nrow=9,scales = "fixed") +
  scale_color_manual(values=c("blue1","red3","orange1","green4"),labels=c(" 23andMe African Americans (47K) "," 23andMe Latinos (162K) "," 23andMe Europeans (135K) "," SIGMA (8K) "))+
  theme(plot.title=element_text(size=20,face="bold"),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.x=element_text(face="bold"),
        axis.title=element_text(size=20,face="bold"),
        legend.position = "bottom",
        legend.title=element_blank(),
        strip.text.y = element_text(hjust=1,vjust = 0.5,angle=180,face="bold",size=25))+
  coord_flip()
p
ggsave(paste(outdir,"Fig3-23andme.png",sep=""),p,width=15,height=10)


