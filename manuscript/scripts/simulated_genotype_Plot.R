library(ggplot2)
library(gtable)
library(grid)
library(gridExtra)
library(ggpubr)

mypalette=c("orange1","dodgerblue1")
theme_set(theme_bw(base_size = 16))
outdir="figures/"
ylab<-expression(h[g]^2)
methods<-c("LDSC (unadjusted)","cov-LDSC (with 10 PCs)")

## different admixed proportion, 1% causal 
admix_0.1_wadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_wadj_p0.1_unrelated_num.txt")
admix_0.1_nadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_noadj_p0.1_unrelated_num.txt")
admix_0.2_wadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_wadj_p0.2_unrelated_num.txt")
admix_0.2_nadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_noadj_p0.2_unrelated_num.txt")
admix_0.3_wadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_wadj_p0.3_unrelated_num.txt")
admix_0.3_nadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_noadj_p0.3_unrelated_num.txt")
admix_0.4_wadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_wadj_p0.4_unrelated_num.txt")
admix_0.4_nadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_noadj_p0.4_unrelated_num.txt")
admix_0.5_wadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_wadj_p0.5_unrelated_num.txt")
admix_0.5_nadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_noadj_p0.5_unrelated_num.txt")
eur_wadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_eur_1per_adj_unrelated_num.txt")
eur_nadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_eur_1per_unrelated_num.txt")

all_h2=rbind(admix_0.1_wadj,admix_0.1_nadj,
             admix_0.2_wadj,admix_0.2_nadj,
             admix_0.3_wadj,admix_0.3_nadj,
             admix_0.4_wadj,admix_0.4_nadj,
             admix_0.5_wadj,admix_0.5_nadj,
             eur_wadj,eur_nadj)
pop_col=c(rep("0.1",nrow(admix_0.1_wadj)+nrow(admix_0.1_nadj)),
          rep("0.2",nrow(admix_0.2_wadj)+nrow(admix_0.2_nadj)),
          rep("0.3",nrow(admix_0.3_wadj)+nrow(admix_0.3_nadj)),
          rep("0.4",nrow(admix_0.4_wadj)+nrow(admix_0.4_nadj)),
          rep("0.5",nrow(admix_0.5_wadj)+nrow(admix_0.5_nadj)),
          rep("0",nrow(eur_wadj)+nrow(eur_nadj)))
tool_col=c(rep("cov-LDSC",nrow(admix_0.1_wadj)),rep("LDSC",nrow(admix_0.1_nadj)),
           rep("cov-LDSC",nrow(admix_0.2_wadj)),rep("LDSC",nrow(admix_0.2_nadj)),
           rep("cov-LDSC",nrow(admix_0.3_wadj)),rep("LDSC",nrow(admix_0.3_nadj)),
           rep("cov-LDSC",nrow(admix_0.4_wadj)),rep("LDSC",nrow(admix_0.4_nadj)),
           rep("cov-LDSC",nrow(admix_0.5_wadj)),rep("LDSC",nrow(admix_0.5_nadj)),
           rep("cov-LDSC",nrow(eur_wadj)),rep("LDSC",nrow(eur_nadj)))
df=cbind(pop_col,tool_col,all_h2)
colnames(df)=c("pop_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggplot()+geom_hline(yintercept = 0.4,linetype="dashed",colour="red",size=1)
p=p+ geom_boxplot(data=df,aes(x=pop_col,y=h2,fill=tool_col)) +
  scale_fill_manual(values=mypalette,labels=c("LDSC (unadjusted)","cov-LDSC (10 PCs)"))
p=p+guides(fill=guide_legend(title="Method"))+xlab("Admixed Proportion")+ylab(ylab)
p=p+ylim(0.1,0.7)+theme_set(theme_bw(base_size = 16))
pdiffadmix<-p
ggsave(paste(outdir,"SF3(a)-simulated_diffadm.png",sep=""),width=10,height=7)


####different causal variants 
causal_0.01_nadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_noadj_p0.5_unrelated_0.01per_num.txt")
causal_0.01_wadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_wadj_p0.5_unrelated_0.01per_num.txt")
causal_0.05_nadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_noadj_p0.5_unrelated_0.05per_num.txt")
causal_0.05_wadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_wadj_p0.5_unrelated_0.05per_num.txt")
causal_0.1_nadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_noadj_p0.5_unrelated_0.1per_num.txt")
causal_0.1_wadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_wadj_p0.5_unrelated_0.1per_num.txt")
causal_0.5_nadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_noadj_p0.5_unrelated_0.5per_num.txt")
causal_0.5_wadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_wadj_p0.5_unrelated_0.5per_num.txt")
causal_1_nadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_noadj_p0.5_unrelated_num.txt")
causal_1_wadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_wadj_p0.5_unrelated_num.txt")
causal_5_nadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_noadj_p0.5_unrelated_5per_num.txt")
causal_5_wadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_wadj_p0.5_unrelated_5per_num.txt")
causal_10_nadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_noadj_p0.5_unrelated_10per_num.txt")
causal_10_wadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_wadj_p0.5_unrelated_10per_num.txt")
causal_50_nadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_noadj_p0.5_unrelated_50per_num.txt")
causal_50_wadj=read.table("data/simulated_genotypes/difcausal_unrelated/multiple_h2_wadj_p0.5_unrelated_50per_num.txt")

all_h2=rbind(causal_0.01_nadj,causal_0.01_wadj,
             causal_0.05_nadj,causal_0.05_wadj,
             causal_0.1_nadj,causal_0.1_wadj,
             causal_0.5_nadj,causal_0.5_wadj,
             causal_1_nadj,causal_1_wadj,
             causal_5_nadj,causal_5_wadj,
             causal_10_nadj,causal_10_wadj,
             causal_50_nadj,causal_50_wadj)
pro_col=c(rep("0.01%",nrow(causal_0.01_nadj)+nrow(causal_0.01_wadj)),
          rep("0.05%",nrow(causal_0.05_nadj)+nrow(causal_0.05_wadj)),
          rep("0.1%",nrow(causal_0.1_nadj)+nrow(causal_0.1_wadj)),
          rep("0.5%",nrow(causal_0.5_nadj)+nrow(causal_0.5_wadj)),
          rep("1%",nrow(causal_1_nadj)+nrow(causal_1_wadj)),
          rep("5%",nrow(causal_5_nadj)+nrow(causal_5_wadj)),
          rep("10%",nrow(causal_10_nadj)+nrow(causal_10_wadj)),
          rep("50%",nrow(causal_50_nadj)+nrow(causal_50_wadj)))

tool_col=c(rep("LDSC",nrow(causal_0.01_nadj)),rep("cov-LDSC",nrow(causal_0.01_wadj)),
           rep("LDSC",nrow(causal_0.05_nadj)),rep("cov-LDSC",nrow(causal_0.05_wadj)),
           rep("LDSC",nrow(causal_0.1_nadj)),rep("cov-LDSC",nrow(causal_0.1_wadj)),
           rep("LDSC",nrow(causal_0.5_nadj)),rep("cov-LDSC",nrow(causal_0.5_wadj)),
           rep("LDSC",nrow(causal_1_nadj)),rep("cov-LDSC",nrow(causal_1_wadj)),
           rep("LDSC",nrow(causal_5_nadj)),rep("cov-LDSC",nrow(causal_5_wadj)),
           rep("LDSC",nrow(causal_10_nadj)),rep("cov-LDSC",nrow(causal_10_wadj)),
           rep("LDSC",nrow(causal_50_nadj)),rep("cov-LDSC",nrow(causal_50_wadj)))
df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggplot()+ geom_hline(yintercept = 0.4,size=1, linetype="dashed",colour="red")
p=p+geom_boxplot(data=df,aes(x=pro_col,y=h2,fill=tool_col))+guides(fill=guide_legend(title="Method"))
p=p+xlab("Causal variant")+scale_fill_manual(values=mypalette,labels=methods)+ylab(expression(h[g]^2))
p=p+theme_set(theme_bw(base_size = 16))+ylim(0.1,0.7)
p
pdidffcausal<-p
ggsave(paste(outdir,"SF3(b)-simulated_diffcausal.png",sep=""),width=10,height=7)


#######dif heritability 
h2_5per_nadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_noadj_p0.5_unrelated_5h2_num.txt")
h2_5per_wadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_wadj_p0.5_unrelated_5h2_num.txt")
h2_10per_nadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_noadj_p0.5_unrelated_10h2_num.txt")
h2_10per_wadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_wadj_p0.5_unrelated_10h2_num.txt")
h2_20per_nadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_noadj_p0.5_unrelated_20h2_num.txt")
h2_20per_wadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_wadj_p0.5_unrelated_20h2_num.txt")
h2_30per_nadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_noadj_p0.5_unrelated_30h2_num.txt")
h2_30per_wadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_wadj_p0.5_unrelated_30h2_num.txt")
h2_40per_nadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_noadj_p0.5_unrelated_num.txt")
h2_40per_wadj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_wadj_p0.5_unrelated_num.txt")
h2_50per_nadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_noadj_p0.5_unrelated_50h2_num.txt")
h2_50per_wadj=read.table("data/simulated_genotypes/difh2_unrelated/multiple_h2_wadj_p0.5_unrelated_50h2_num.txt")

all_h2=rbind(h2_5per_nadj,h2_5per_wadj,
             h2_10per_nadj,h2_10per_wadj,
             h2_20per_nadj,h2_20per_wadj,
             h2_30per_nadj,h2_30per_wadj,
             h2_40per_nadj,h2_40per_wadj,
             h2_50per_nadj,h2_50per_wadj)
pro_col=c(rep("0.05",nrow(h2_5per_nadj)+nrow(h2_5per_wadj)),
          rep("0.10",nrow(h2_10per_nadj)+nrow(h2_10per_wadj)),
          rep("0.20",nrow(h2_20per_nadj)+nrow(h2_20per_wadj)),
          rep("0.30",nrow(h2_30per_nadj)+nrow(h2_30per_wadj)),
          rep("0.40",nrow(h2_40per_nadj)+nrow(h2_40per_wadj)),
          rep("0.50",nrow(h2_50per_nadj)+nrow(h2_50per_wadj)))

tool_col=c(rep("LDSC",nrow(h2_5per_nadj)),rep("cov-LDSC",nrow(h2_5per_wadj)),
           rep("LDSC",nrow(h2_10per_nadj)),rep("cov-LDSC",nrow(h2_10per_wadj)),
           rep("LDSC",nrow(h2_20per_nadj)),rep("cov-LDSC",nrow(h2_20per_wadj)),
           rep("LDSC",nrow(h2_30per_nadj)),rep("cov-LDSC",nrow(h2_30per_wadj)),
           rep("LDSC",nrow(h2_40per_nadj)),rep("cov-LDSC",nrow(h2_40per_wadj)),
           rep("LDSC",nrow(h2_50per_nadj)),rep("cov-LDSC",nrow(h2_50per_wadj)))

df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
p=ggplot(df,aes(x=pro_col,y=h2))+ geom_boxplot(aes(fill=tool_col))
p=p+guides(fill=guide_legend(title="Methods"))+scale_fill_manual(values=mypalette,label=methods)
p=p+xlab("True Heritability")+theme_set(theme_bw(base_size = 16))+ylab(expression(h[g]^2))

p=p+geom_segment(aes(x=0.5,xend=1.5,y=0.05,yend=0.05),size=0.5,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=1.5,xend=2.5,y=0.10,yend=0.10),size=0.5,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=2.5,xend=3.5,y=0.20,yend=0.20),size=0.5,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=3.5,xend=4.5,y=0.30,yend=0.30),size=0.5,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=4.5,xend=5.5,y=0.40,yend=0.40),size=0.5,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=5.5,xend=6.5,y=0.50,yend=0.50),size=0.5,colour="red",linetype='dashed')
pdiffh<-p
ggsave(paste(outdir,"SF3(c)-simulated_diffh2.png",sep=""),width=10,height=7)


##env_str
no_adj=read.table("data/simulated_genotypes/env_str/multiple_h2_noadj_p0.5_unrelated_envstr_num.txt")
w_adj=read.table("data/simulated_genotypes/env_str/multiple_h2_wadj_p0.5_unrelated_envstr_num.txt")
gcta=read.table("data/simulated_genotypes/env_str/multiple_gcta_p0.5_unrelated_envstr_num.txt")
all_h2=rbind(no_adj,w_adj)
tool_col=c(rep(methods[1],nrow(no_adj)),rep(methods[2],nrow(w_adj)))
df=cbind(tool_col,all_h2)
colnames(df)=c("tool_col","h2")
df$tool_col=factor(df$tool_col,levels = methods)
p=ggplot(df,aes(x=tool_col,y=h2))+geom_boxplot(aes(fill=tool_col))+xlab("Methods")+ylab(expression(h[g]^2))
p=p+guides(fill=guide_legend(title="Methods"))+scale_fill_manual(values=mypalette,labels=methods)+theme_set(theme_bw(base_size = 16))
p=p+geom_hline(yintercept = 0.4,linetype="dashed",colour="red",size=1)
pevnstr<-p+theme(legend.position  = "none")

ggsave(paste(outdir,"SF3(d)-simulated_envstr.png",sep=""),width=10,height=7)

#####subsample 
subsample_no_adj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_noadj_p0.5_unrelated_num.txt")
subsample_with_adj=read.table("data/simulated_genotypes/difpro_unrelated/multiple_h2_wadj_p0.5_unrelated_num.txt")
subsample_50per_nadj=read.table("data/simulated_genotypes/subsample/multiple_h2_noadj_p0.5_unrelated_50per_num.txt")
subsample_50per_wadj=read.table("data/simulated_genotypes/subsample/multiple_h2_wadj_p0.5_unrelated_50per_num.txt")
subsample_10per_nadj=read.table("data/simulated_genotypes/subsample/multiple_h2_noadj_p0.5_unrelated_10per_num.txt")
subsample_10per_wadj=read.table("data/simulated_genotypes/subsample/multiple_h2_wadj_p0.5_unrelated_10per_num.txt")
subsample_5per_nadj=read.table("data/simulated_genotypes/subsample/multiple_h2_noadj_p0.5_unrelated_5per_num.txt")
subsample_5per_wadj=read.table("data/simulated_genotypes/subsample/multiple_h2_wadj_p0.5_unrelated_5per_num.txt")
subsample_1per_nadj=read.table("data/simulated_genotypes/subsample/multiple_h2_noadj_p0.5_unrelated_1per_num.txt")
subsample_1per_wadj=read.table("data/simulated_genotypes/subsample/multiple_h2_wadj_p0.5_unrelated_1per_num.txt")
subsample_10per_rest_noadj=read.table("data/simulated_genotypes/subsample_indep/multiple_h2_noadj_p0.5_unrelated_num.txt")
subsample_10per_rest_wadj=read.table("data/simulated_genotypes/subsample_indep/multiple_h2_wadj_p0.5_unrelated_num.txt")

all_h2=rbind(subsample_no_adj, subsample_with_adj,
             subsample_50per_nadj,subsample_50per_wadj,
             subsample_10per_nadj,subsample_10per_wadj,
             subsample_5per_nadj,subsample_5per_wadj,
             subsample_1per_nadj,subsample_1per_wadj,
             subsample_10per_rest_noadj,subsample_10per_rest_wadj)
pro_col=c(rep("1",nrow(subsample_no_adj)+nrow(subsample_with_adj)),
          rep("0.50",nrow(subsample_50per_nadj)+nrow(subsample_50per_wadj)),
          rep("0.10",nrow(subsample_10per_nadj)+nrow(subsample_10per_wadj)),
          rep("0.05",nrow(subsample_5per_nadj)+nrow(subsample_5per_wadj)),
          rep("0.01",nrow(subsample_1per_nadj)+nrow(subsample_1per_wadj)),
          rep("0.10_independent",nrow(subsample_10per_rest_noadj)+nrow(subsample_10per_rest_wadj)))

tool_col=c(rep("LDSC",nrow(subsample_no_adj)),rep("cov-LDSC",nrow(subsample_with_adj)),
           rep("LDSC",nrow(subsample_50per_nadj)),rep("cov-LDSC",nrow(subsample_50per_wadj)),
           rep("LDSC",nrow(subsample_10per_nadj)),rep("cov-LDSC",nrow(subsample_10per_wadj)),
           rep("LDSC",nrow(subsample_5per_nadj)),rep("cov-LDSC",nrow(subsample_5per_wadj)),
           rep("LDSC",nrow(subsample_1per_nadj)),rep("cov-LDSC",nrow(subsample_1per_wadj)),
           rep("LDSC",nrow(subsample_10per_nadj)),rep("cov-LDSC",nrow(subsample_10per_rest_wadj)))

df=cbind(pro_col,tool_col,all_h2)
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))
label<-c("0.01","0.05","0.10","0.50","1","0.10_independent")
df$pro_col=factor(df$pro_col,levels=rev(label))
colnames(df)=c("pro_col","tool_col","h2")
p=ggboxplot(data=df[df$tool_col=="cov-LDSC",],x="pro_col",y="h2",fill="tool_col",ggtheme=theme_bw(base_size=16))+
  scale_fill_manual(values=mypalette[2])+geom_hline(yintercept = 0.4,size=1,linetype="dashed",colour="red")
p=p+guides(fill=guide_legend("none"))+xlab("Subsample Size")+ylim(-0.1,1)+ylab(expression(h[g]^2))

p<-p+scale_x_discrete(limits=rev(label),labels=c("10% independent\nsamples (1,000)","All (10,000)","50% (5,000)","10% (1,000)","5% (500)","1% (100)"))
my_comparisons <- list( c("1","0.50"),c("1", "0.10"),c("1","0.05") ,
                        c("1","0.01"),c("1","0.10_independent"))
p=p+stat_compare_means(comparisons = my_comparisons)+theme(legend.position="none")
p
psubsampling<-p

ggsave(paste(outdir,"SF9-simulated_subsampling.png",sep=""),width=11,height=7)

#combining plots (when necessary)
legend = gtable_filter(ggplotGrob(pdiffadmix), "guide-box") 
p<-grid.arrange(arrangeGrob(pdiffadmix+ylab(NULL)+ggtitle("(a)")+theme(legend.position  = "none"),pdidffcausal+ylab(NULL)+theme(legend.position  = "none")+ggtitle("(b)"),pdiffh+ylab(NULL)+theme(legend.position  = "none")+ggtitle("(c)"),pevnstr+ylab(NULL)+xlab(NULL)+ggtitle("(d)"),
                            nrow=2,
                            left = textGrob(expression(h[g]^2), rot = 90, gp=gpar(fontsize=20,face="bold"), vjust = 1)),
                legend,
                widths=unit.c(unit(1, "npc") - legend$width, legend$width),nrow=1)
p
ggsave(paste(outdir,"SF3-combined.png",sep=""),p,width=13,height=10)

###case and control 
admix_0.1_nadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_noadj_p_0.1_sum_new.txt")
admix_0.1_wadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_wadj_p_0.1_sum_new.txt")
admix_0.2_nadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_noadj_p_0.2_sum_new.txt")
admix_0.2_wadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_wadj_p_0.2_sum_new.txt")
admix_0.3_nadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_noadj_p_0.3_sum_new.txt")
admix_0.3_wadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_wadj_p_0.3_sum_new.txt")
admix_0.4_nadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_noadj_p_0.4_sum_new.txt")
admix_0.4_wadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_wadj_p_0.4_sum_new.txt")
admix_0.5_nadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_noadj_p_0.5_sum_new.txt")
admix_0.5_wadj=read.table("data/simulated_genotypes/cc_difpro/multiple_h2_wadj_p_0.5_sum_new.txt")

all_h2=rbind(admix_0.1_wadj,admix_0.1_nadj,
             admix_0.2_wadj,admix_0.2_nadj,
             admix_0.3_wadj,admix_0.3_nadj,
             admix_0.4_wadj,admix_0.4_nadj,
             admix_0.5_wadj,admix_0.5_nadj)
pop_col=c(rep("0.1",nrow(admix_0.1_wadj)+nrow(admix_0.1_nadj)),
          rep("0.2",nrow(admix_0.2_wadj)+nrow(admix_0.2_nadj)),
          rep("0.3",nrow(admix_0.3_wadj)+nrow(admix_0.3_nadj)),
          rep("0.4",nrow(admix_0.4_wadj)+nrow(admix_0.4_nadj)),
          rep("0.5",nrow(admix_0.5_wadj)+nrow(admix_0.5_nadj)))

tool_col=c(rep("cov-LDSC",nrow(admix_0.1_wadj)),rep("LDSC",nrow(admix_0.1_nadj)),
           rep("cov-LDSC",nrow(admix_0.2_wadj)),rep("LDSC",nrow(admix_0.2_nadj)),
           rep("cov-LDSC",nrow(admix_0.3_wadj)),rep("LDSC",nrow(admix_0.3_nadj)),
           rep("cov-LDSC",nrow(admix_0.4_wadj)),rep("LDSC",nrow(admix_0.4_nadj)),
           rep("cov-LDSC",nrow(admix_0.5_wadj)),rep("LDSC",nrow(admix_0.5_nadj)))

df=cbind(pop_col,tool_col,all_h2)
colnames(df)=c("pop_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels = c("LDSC","cov-LDSC"))

p=p+geom_hline(yintercept = 0.4,linetype="dashed",colour="red",size=1)
p=ggplot(df,aes(x=pop_col,y=h2))+ geom_boxplot(aes(fill=tool_col))
p=p+guides(fill=guide_legend(title="Methods"))
p=p+xlab("Subsample size")+xlab("Admixed Proportion")+ylab(expression(h[g]^2))+
  scale_fill_manual(values=mypalette,labels=methods)+theme_set(theme_bw(base_size = 16))
p=p+geom_hline(yintercept = 0.4,linetype="dashed",colour="red")+ylim(0.1,0.55)
pdiffadm<-p
ggsave(paste(outdir,"SF4(a)-simulated_cc_diffadm.png",sep=""),width=10,height=7)

####case and control diff causal 
causal_0.01_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_0.01per_noadj.txt")
causal_0.01_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_0.01per_wadj.txt")
causal_0.05_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_0.05per_noadj.txt")
causal_0.05_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_0.05per_wadj.txt")
causal_0.1_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_0.1per_noadj.txt")
causal_0.1_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_0.1per_wadj.txt")
causal_0.5_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_0.5per_noadj.txt")
causal_0.5_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_0.5per_wadj.txt")
causal_1_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_1per_noadj.txt")
causal_1_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_1per_wadj.txt")
causal_5_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_5per_noadj.txt")
causal_5_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_5per_wadj.txt")
causal_10_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_10per_noadj.txt")
causal_10_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_10per_wadj.txt")
causal_50_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_50per_noadj.txt")
causal_50_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_50per_wadj.txt")
all_h2=rbind(
  causal_0.01_nadj,causal_0.01_wadj,
  causal_0.05_nadj,causal_0.05_wadj,
  causal_0.1_nadj,causal_0.1_wadj,
  causal_0.5_nadj,causal_0.5_wadj,
  causal_1_nadj,causal_1_wadj,
  causal_5_nadj,causal_5_wadj,
  causal_10_nadj,causal_10_wadj,
  causal_50_nadj,causal_50_wadj)
pro_col=c(
  rep("0.01%",nrow(causal_0.01_nadj)+nrow(causal_0.01_wadj)),
  rep("0.05%",nrow(causal_0.05_nadj)+nrow(causal_0.05_wadj)),
  rep("0.1%",nrow(causal_0.1_nadj)+nrow(causal_0.1_wadj)),
  rep("0.5%",nrow(causal_0.5_nadj)+nrow(causal_0.5_wadj)),
  rep("1%",nrow(causal_1_nadj)+nrow(causal_1_wadj)),
  rep("5%",nrow(causal_5_nadj)+nrow(causal_5_wadj)),
  rep("10%",nrow(causal_10_nadj)+nrow(causal_10_wadj)),
  rep("50%",nrow(causal_50_nadj)+nrow(causal_50_wadj)))
tool_col=c(
  rep("LDSC",nrow(causal_0.01_nadj)),rep("cov-LDSC",nrow(causal_0.01_wadj)),
  rep("LDSC",nrow(causal_0.05_nadj)),rep("cov-LDSC",nrow(causal_0.05_wadj)),
  rep("LDSC",nrow(causal_0.1_nadj)),rep("cov-LDSC",nrow(causal_0.1_wadj)),
  rep("LDSC",nrow(causal_0.5_nadj)),rep("cov-LDSC",nrow(causal_0.5_wadj)),
  rep("LDSC",nrow(causal_1_nadj)),rep("cov-LDSC",nrow(causal_1_wadj)),
  rep("LDSC",nrow(causal_5_nadj)),rep("cov-LDSC",nrow(causal_5_wadj)),
  rep("LDSC",nrow(causal_10_nadj)),rep("cov-LDSC",nrow(causal_10_wadj)),
  rep("LDSC",nrow(causal_50_nadj)),rep("cov-LDSC",nrow(causal_50_wadj)))
df=cbind(pro_col,tool_col,all_h2)
colnames(df)=c("pro_col","tool_col","h2")
df$tool_col=factor(df$tool_col,levels=c("LDSC","cov-LDSC"))
df$pro_col=factor(df$pro_col,levels=c("0.01%","0.05%","0.1%","0.5%","1%","5%","10%","50%"))
p=ggplot()+geom_hline(yintercept = 0.4,linetype="dashed",colour="red",size=1)+ylim(0.1,0.7)
p=p+geom_boxplot(data = df,aes(x=pro_col,y=h2,fill=tool_col))+scale_fill_manual(values=mypalette,labels=methods)
p=p+guides(fill=guide_legend(title="Method"))
p=p+xlab("Causal variant")+ylab(expression(h[g]^2))
p=p+theme_set(theme_bw(base_size = 16))
pdiffcausal<-p
ggsave(paste(outdir,"SF4(b)-simulated_cc_diffcausal.png",sep=""),width=10,height=7)


### case and control diff h2 
h2_0per_nadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0_causal_1per_noadj.txt")
h2_0per_wadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0_causal_1per_wadj.txt")
h2_5per_nadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.05_causal_1per_noadj.txt")
h2_5per_wadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.05_causal_1per_wadj.txt")
h2_10per_nadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.1_causal_1per_noadj.txt")
h2_10per_wadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.1_causal_1per_wadj.txt")
h2_20per_nadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.2_causal_1per_noadj.txt")
h2_20per_wadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.2_causal_1per_wadj.txt")
h2_30per_nadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.3_causal_1per_noadj.txt")
h2_30per_wadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.3_causal_1per_wadj.txt")
h2_40per_nadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.4_causal_1per_noadj.txt")
h2_40per_nadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_1per_noadj.txt")
h2_40per_wadj=read.table("data/simulated_genotypes/cc_diffcausal/h2_0.4_causal_1per_wadj.txt")
h2_50per_wadj=read.table("data/simulated_genotypes/cc_diffh2/h2_0.5_causal_1per_wadj.txt")
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
p=p+xlab("True heritability")+ylim(-0.10,1)+ylab(expression(h[g]^2))
p=p+theme_set(theme_bw(base_size = 16))#+scale_x_continuous(breaks=scales::pretty_breaks(n = 10))
p=p+geom_segment(aes(x=0.5,xend=1.5,y=0,yend=0),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=1.5,xend=2.5,y=0.05,yend=0.05),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=2.5,xend=3.5,y=0.10,yend=0.10),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=3.5,xend=4.5,y=0.20,yend=0.20),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=4.5,xend=5.5,y=0.30,yend=0.30),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=5.5,xend=6.5,y=0.40,yend=0.40),size=1,colour="red",linetype='dashed')
p=p+geom_segment(aes(x=6.5,xend=7.5,y=0.50,yend=0.50),size=1,colour="red",linetype='dashed')
pdiffh2<-p
ggsave(paste(outdir,"SF4(c)-simulated_cc_diffh2.png",sep=""),width=10,height=7)

##case and control env str
no_adj<-read.table("data/simulated_genotypes/cc_envstr/cc_envstr_noadj.txt",stringsAsFactors = F)
w_adj<-read.table("data/simulated_genotypes/cc_envstr/cc_envstr_wadj.txt",stringsAsFactors = F)

all_h2=rbind(no_adj,w_adj)
tool_col=c(rep(methods[1],nrow(no_adj)),rep(methods[2],nrow(w_adj)))
df=cbind(tool_col,all_h2)
colnames(df)=c("tool_col","h2")
df$tool_col=factor(df$tool_col,levels = methods)
p=ggplot(df,aes(x=tool_col,y=h2))+geom_boxplot(aes(fill=tool_col))+xlab("Methods")+ylab(expression(h[g]^2))
p=p+guides(fill=guide_legend(title="Methods"))+scale_fill_manual(values=mypalette,labels=methods)+theme_set(theme_bw(base_size = 16))
p=p+geom_hline(yintercept = 0.4,linetype="dashed",colour="red",size=1)
pevnstr<-p+theme(legend.position  = "none")
p
ggsave(paste(outdir,"SF4(d)-simulated_cc_envstr.png",sep=""),width=10,height=7)


#combining plots (when necessary)
legend = gtable_filter(ggplotGrob(pdiffadm), "guide-box") 
p<-grid.arrange(arrangeGrob(pdiffadm+ylab(NULL)+ggtitle("(a)")+theme(legend.position  = "none"),pdiffcausal+ylab(NULL)+theme(legend.position  = "none")+ggtitle("(b)"),pdiffh2+ylab(NULL)+theme(legend.position  = "none")+ggtitle("(c)"),pevnstr+ylab(NULL)+xlab(NULL)+ggtitle("(d)"),
             nrow=2,
             left = textGrob(expression(h[g]^2), rot = 90, gp=gpar(fontsize=20,face="bold"), vjust = 1)),
             legend,
widths=unit.c(unit(1, "npc") - legend$width, legend$width),nrow=1)
p
ggsave(paste(outdir,"SF4-combined.png",sep=""),p,width=13,height=10)

