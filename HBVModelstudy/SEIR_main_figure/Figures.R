library(ggplot2)
library(ggforce)
library(readxl)
library(reshape2)
library(RColorBrewer)
library(patchwork)
library(ggpubr)
library(ggsci)
library(scales)  #rescale
library(plyr)    #ddply
library(tidyr)
#-------------------------------------------Fig.1-----------------------------------------------
#-------------------------------------------A-------------------------------------------
df_state <- read_excel("chronic_infection_4.xlsx",sheet = 1)
df_s1 <- df_state[,c(1,7:9)] 
df_s1<-melt(df_s1,id.vars='YEAR')
df_v <- read_excel("vaccincation.xlsx",sheet = 2)
df_v <- df_v[-c(1:2),]
df_v<-melt(df_v,id.vars='YEAR')

tiff('Fig1.tiff', width = 2700,height = 5200, res = 350)

df_s1$variable<-factor(df_s1$variable,
                       levels = c('Chronic_infection','CHBu','CHBd'),
                       labels = c("Chronic infections","Chronic hepatitis B cases(undetected)","Chronic hepatitis B cases(detected)"))
p1 <- ggplot()+
  geom_bar(data=df_s1,aes(YEAR,value,fill=variable),stat="identity",position="stack", color="black", width=1,size=0.15)+
  geom_line(data = df_v,aes(YEAR,value,color=variable),size=0.8)+
  scale_fill_manual(values=c("#00468B99","#AD002A99","#0099B499"))+
  scale_x_continuous(breaks=seq(1990,2090,10))+
  xlab("Year")+ 
  ylim(0, 125000000)+
  ylab("Number of chronic hepatitis B infections")+
  theme(
    axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
    axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
    axis.line =element_line(size=0.4,colour = "black"),
    axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
    panel.background = element_rect(fill='white'),
    plot.margin = margin(1, 1, 1, 1, "cm"),
    legend.position = c(0.74,0.57),
    legend.background = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 9,face = 'plain',color = 'black',family ='Times New Roman' ),
    legend.key=element_rect(fill='transparent', color='transparent')
  )+
  scale_y_continuous(sec.axis = sec_axis(~.*100/(1.0e+08), name = "Hepatitis B vaccination coverage(100%)"))

#-------------------------------------------B-------------------------------------------
df_h <- read_excel("chronic_infection_4.xlsx",sheet=1)
df_h1 <- df_h[-(1:2),c(1,14,22)] #  
df_h1<-melt(df_h1,id.vars='YEAR')
df_v <- read_excel("vaccincation.xlsx",sheet = 2)
df_v <- df_v[-c(1:2),c(1,3)]

df_h1$variable<-factor(df_h1$variable,
                       levels = c('Sum_infection','PMTCT'),
                       labels = c("Chronic infections(vertical transmission excepted)","Chronic infections(vertical transmission)"))
p2 <- ggplot()+
  geom_bar(data=df_h1,aes(YEAR,value,fill=variable),stat="identity",position="stack", color="black", width=1,size=0.15)+
  geom_line(data = df_v,aes(YEAR,Timely_birth_dose_coverage),color="#33CCCC",linetype= "solid",size=0.8)+
  scale_fill_manual(values=c("#00468B99","#AD002A99","#0099B499"))+
  scale_x_continuous(breaks=seq(1990,2090,10))+
  xlab("Year")+ 
  ylim(0, 125000000)+
  ylab("Number of chronic hepatitis B infections")+
  theme(
    axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
    axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
    axis.line =element_line(size=0.4,colour = "black"),
    axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
    panel.background = element_rect(fill='white'),
    plot.margin = margin(1, 1, 1, 1, "cm"),
    legend.position = c(0.74,0.57),
    legend.background = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 9,face = 'plain',color = 'black',family ='Times New Roman' ),
    legend.key=element_rect(fill='transparent', color='transparent')
  )+
  scale_y_continuous(sec.axis = sec_axis(~.*100/(1.0e+08), name = "Timely birth dose coverage(100%)"))


#------------------------------------------C---------------------------------------------------------------
df_u5 <- read_excel("chronic_infection_4.xlsx",sheet = 1)
df_u5_1 <- df_u5[,c(1,16)] #chronic infections under 5 years old
df_u5_1 <- df_u5_1[-(62:101),]
#tiff('fig4.tiff', width = 2700,height = 1700, res = 350)
p3 <- ggplot(df_u5_1, aes(x =YEAR))+
  geom_bar(aes(y=under5),fill="#00468B99",stat="identity", color="black", width=1,size=0.15)+
  scale_x_continuous(breaks=seq(1990,2090,10))+
  xlab("Year")+ 
  ylab("Number of chronic hepatitis B infections")+
  theme( axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
         axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
         axis.line =element_line(size=0.4,colour = "black"),
         axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
         panel.background = element_rect(fill='white'),
         plot.margin = margin(1, 1, 1, 1, "cm"),
         legend.position = "right",#c(0.25,0.6),
         legend.background = element_blank(),
         legend.title = element_blank(),
         legend.text = element_text(size = 10,face = 'plain',color = 'black',family ='Times New Roman' ),
         legend.key=element_rect(fill='transparent', color='transparent'))+
  facet_zoom(xlim = c(2010, 2050),ylim=c(0,350000),zoom.size = 0.4, horizontal = FALSE,show.area = FALSE)

p1 + p2 + p3 + plot_layout(nrow=3, ncol = 1)+
plot_annotation(tag_levels = 'A')
dev.off()

#---------------------------Fig.2----------------------------------------------------
df_2030 <- read_excel("2030achieve.xlsx",sheet = 1)
df_2030 <- df_2030[29:61,c(1,2,4)]
df_2030_1<-melt(df_2030,id.vars='YEAR')  
tiff('fig10_1.tiff', width = 2700,height = 1700, res = 350)
ggplot(df_2030_1, aes(x =YEAR))+
  geom_bar(aes(YEAR,value,fill=variable),stat="identity",position=position_dodge(), color="black", width=0.5,size=0.15)+
  scale_x_continuous(breaks=seq(2018,2050,4))+
  scale_fill_manual(values=c("#AD002A99","#00468B99"))+
  xlab("Year")+ 
  ylab("Number of chronic hepatitis B infections")+
  theme( axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
         axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
         axis.line =element_line(size=0.4,colour = "black"),
         axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
         panel.background = element_rect(fill='white'),
         plot.margin = margin(1, 1, 1, 1, "cm"),
         legend.position = "right",#c(0.25,0.6),
         legend.background = element_blank(),
         legend.title = element_blank(),
         legend.text = element_text(size = 10,face = 'plain',color = 'black',family ='Times New Roman' ),
         legend.key=element_rect(fill='transparent', color='transparent'))+
  facet_zoom(xlim = c(2025, 2035),ylim=c(0,290000),zoom.size = 0.4, horizontal = FALSE,show.area = FALSE)
dev.off()

#-------------------------------------------Fig.3-----------------------------------------------
#-------------------------------------------A-------------------------------------------
##Chronic infection in the absence of vaccine intervention
df_no <- read_excel("chronic_infection_4.xlsx",sheet = 2)
df_n1 <- df_no[,c(7:9)] 
df_state <- read_excel("chronic_infection_4.xlsx",sheet = 1)
#Status quo
df_s1 <- df_state[,c(1,7:9)] 
df_z <- cbind(df_s1,df_n1)


#making area part
#chronic infection
df_z$ymin1<-apply(df_z[,c(2,5)], 1, min)
df_z$ymax1<-apply(df_z[,c(2,5)], 1, max)
#CHB(undetected)
df_z$ymin2<-apply(df_z[,c(3,6)], 1, min)
df_z$ymax2<-apply(df_z[,c(3,6)], 1, max)
#CHB(detected)
df_z$ymin3<-apply(df_z[,c(4,7)], 1, min)
df_z$ymax3<-apply(df_z[,c(4,7)], 1, max)
tiff('Fig3.tiff', width = 3700,height = 5200, res = 350)

p4 <- ggplot(df_z, aes(x =YEAR))+
  geom_ribbon( aes(ymin=ymin1, ymax=ymax1),alpha=0.5,fill="#ADB6B6FF",color=NA)+
  geom_ribbon( aes(ymin=ymin2, ymax=ymax2),alpha=0.5,fill="#0099B4FF",color=NA)+
  geom_ribbon( aes(ymin=ymin3, ymax=ymax3),alpha=0.5,fill="#AD002A99",color=NA)+
  #geom_area(aes(fill=variable),alpha=0.5,position="identity")+ 
  geom_line(aes(y=Chronic_infection,color="#00B2F6"),size=0.6,alpha=0.8,linetype = 6)+#color="black",
  geom_line(aes(y=Chronic_infection2,color="#00B2F6"),size=0.6,alpha=1,linetype = "solid")+#color="#00B2F6",# linetype = "dotdash" ;0 = blank, 1 = solid, 2 = dashed, 3 = dotted, 4 = dotdash, 5 = longdash, 6 = twodash
  geom_line(aes(y=CHBu,color="#00468B99"),size=0.6,alpha=1,linetype = 6)+#color="black",
  geom_line(aes(y=CHBu2,color="#00468B99"),size=0.6,alpha=1,linetype = "solid")+#color="black",
  geom_line(aes(y=CHBd,color="#AD002A99"),size=0.6,alpha=1,linetype = 6)+#color="black",
  geom_line(aes(y=CHBd2,color="#AD002A99"),size=0.6,alpha=1,linetype = "solid")+#color="black",
  scale_x_continuous(breaks=seq(1990,2090,10))+
  xlab("Year")+ 
  ylab("Number of chronic hepatitis B infections")+
  scale_colour_manual(name = "Variable", 
                      labels = c("Chronic infections", "Chronic hepatitis B cases(undetected)", "Chronic hepatitis B cases(detected)"),
                      values = c("#00468B99","#00B2F6", "#AD002A99"))+
  theme( axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
         axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
         axis.line =element_line(size=0.4,colour = "black"),
         axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
         panel.background = element_rect(fill='white'),
         plot.margin = margin(1, 1, 1, 1, "cm"),
         legend.position = "right",#c(0.25,0.6),
         legend.background = element_blank(),
         legend.title = element_blank(),
         legend.text = element_text(size = 10,face = 'plain',color = 'black',family ='Times New Roman' ),
         legend.key=element_rect(fill='transparent', color='transparent'))

#-------------------------------------------B--------------------------------------------------------------------------------
#1992年
df_d <- read_excel("chronic_infection_4.xlsx",sheet = 3)   #总的慢性感染不同场景比较
df_d1 <- df_d[,19] #chronic infections

#2002年
df_f <- read_excel("chronic_infection_4.xlsx",sheet = 4)
df_f1 <- df_f[,19] #chronic infections

#status quo
df_state <- read_excel("chronic_infection_4.xlsx",sheet = 1)
df_ss1 <- df_state[,c(1,19)]

df <- cbind(df_ss1,df_f1,df_d1)
#df<-melt(df,id.vars='YEAR')

#status quo vs 2002
df$ymin1<-apply(df[,c(2,3)], 1, min)
df$ymax1<-apply(df[,c(2,3)], 1, max)

# 2002 vs 1992
df$ymin2<-apply(df[,c(3,4)], 1, min)
df$ymax2<-apply(df[,c(3,4)], 1, max)


p5 <- ggplot(df, aes(x =YEAR))+
  geom_bar(aes(y=Sum_infection_sq),fill="#00468B99",stat="identity", color="black", width=1,size=0.15)+
  geom_line(aes(y=Sum_infection_1992,color="dark red"),size=0.6,alpha=1,linetype = 4)+#color="#00B2F6",# linetype = "dotdash" ;0 = blank, 1 = solid, 2 = dashed, 3 = dotted, 4 = dotdash, 5 = longdash, 6 = twodash
  geom_line(aes(y=Sum_infection_2002,color="#00468B99"),size=0.6,alpha=1,linetype = 6)+#color="black",
  geom_ribbon( aes(ymin=ymin1, ymax=ymax1),alpha=0.5,fill="dark red",color=NA)+
  geom_ribbon( aes(ymin=ymin2, ymax=ymax2),alpha=0.5,fill="#0099B4FF",color=NA)+
  scale_x_continuous(breaks=seq(1990,2090,10))+
  xlab("Year")+ 
  ylab("Number of chronic hepatitis B infections")+
  scale_colour_manual(labels = c("maintain with 2002 level", "maintain with 1992 level"),
                      values = c("dark red","#00468B99"))+
  scale_fill_manual(name=df,
                    labels = "status quo",
                    values = "#00468B99")+
  theme( axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
         axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
         axis.line =element_line(size=0.4,colour = "black"),
         axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
         panel.background = element_rect(fill='white'),
         plot.margin = margin(1, 1, 1, 1, "cm"),
         legend.position = "right",#c(0.25,0.6),
         legend.background = element_blank(),
         legend.title = element_blank(),
         legend.text = element_text(size = 10,face = 'plain',color = 'black',family ='Times New Roman' ),
         legend.key=element_rect(fill='transparent', color='transparent'))

#--------------------------------------------------C ----------------------------------------------------------------------
#Comparison of the number of individuals prevented from infection by vaccination in different scenarios

#1992年
df_d <- read_excel("chronic_infection_4.xlsx",sheet = 3)   
df_d1 <- df_d[,17] #chronic infections

#2002年
df_f <- read_excel("chronic_infection_4.xlsx",sheet = 4)
df_f1 <- df_f[,17] #chronic infections

#status quo
df_state <- read_excel("chronic_infection_4.xlsx",sheet = 1)
df_ss1 <- df_state[,c(1,17)]

df <- cbind(df_ss1,df_f1,df_d1)
df$D_sq_2002 <- df$RW3_sq-df$RW3_2002
df$D_2002_1992 <- df$RW3_2002-df$RW3_1992

df <- df[1:101,c(1,4:6)]

df<-melt(df,id.vars='YEAR')

df$variable<-factor(df$variable,
                    levels = c('D_sq_2002','D_2002_1992','RW3_1992'),
                    labels = c("Prevented cases based on status quo","Prevented cases based on 2002 level","Prevented cases based on 1992 level"))
p6 <- ggplot()+
  geom_bar(data=df,aes(YEAR,value,fill=variable),stat="identity",position="stack", color="black", width=1,size=0.15)+
  scale_fill_manual(values=c("#00468B99","#AD002A99","#0099B499"))+
  scale_x_continuous(breaks=seq(1990,2090,10))+
  xlab("Year")+ 
  ylim(0, 670000000)+
  ylab("Number of population avoided infecting HBV")+
  theme(
    axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
    axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
    axis.line =element_line(size=0.4,colour = "black"),
    axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
    panel.background = element_rect(fill='white'),
    plot.margin = margin(1, 1, 1, 1, "cm"),
    legend.position = "right",
    legend.background = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 9,face = 'plain',color = 'black',family ='Times New Roman' ),
    legend.key=element_rect(fill='transparent', color='transparent')
  )
p4 + p5 + p6 + plot_layout(nrow=3, ncol = 1)+
  plot_annotation(tag_levels = 'A')
dev.off()

#-------------------------------------------Fig.4-----------------------------------------------
#-------------------------------------------A-------------------------------------------
# Changes in the incidence of MTC transmission in different scenes
df_h3 <- read_excel("chronic_infection_4.xlsx",sheet=7)   
df_h3 <- df_h3[-(1:2),] #  
df_h3<-melt(df_h3,id.vars='YEAR')    
tiff('PANEL 4.tiff', width = 3700,height = 5200, res = 350)

df_h3$variable<-factor(df_h3$variable,
                       levels = c("PMTCT_no_1992","PMTCT_1992_2002",'PMTCT_2002_sq','PMTCT_sq'),
                       labels = c( "Without vaccination","Maintain with 1992 level","Maintain with 2002 level","Status quo"))
p11 <- ggplot()+
  geom_bar(data=df_h3,aes(YEAR,value,fill=variable),stat="identity",position="stack", color="black", width=1,size=0.15)+
  scale_fill_manual(values=c("#00468B99","#0099B499","#00828099","#AD002A99"))+
  scale_x_continuous(breaks=seq(1994,2090,10))+
  xlab("Year")+ 
  ylim(0, 60000000)+
  ylab("Number of chronic hepatitis B infections")+
  theme(
    axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
    axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
    axis.line =element_line(size=0.4,colour = "black"),
    axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
    panel.background = element_rect(fill='white'),
    plot.margin = margin(1, 1, 1, 1, "cm"),
    legend.position = "right",
    legend.background = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 9,face = 'plain',color = 'black',family ='Times New Roman' ),
    legend.key=element_rect(fill='transparent', color='transparent')
  )

#------------------------------------------- B ---------------------------------------------------------------
df_h4 <- read_excel("chronic_infection_4.xlsx",sheet=1)
df_h4 <- df_h[-(1:2),c(1,14,23,25)] #  
df_h4<-melt(df_h4,id.vars='YEAR')

df_h4$variable<-factor(df_h4$variable,
                       levels = c("Sum_infection_noim",'immunoglobulin','PMTCT'),
                       labels = c("Chronic infections(MTC transmission excepted)","Increment of MTC transmission(only Hepatitis B vaccine)","Chronic infections(MTC transmission)"))
p12 <- ggplot()+
  geom_bar(data=df_h4,aes(YEAR,value,fill=variable),stat="identity",position="stack", color="black", width=1,size=0.15)+
  scale_fill_manual(values=c("#00468B99","#AD002A99","#0099B499"))+
  scale_x_continuous(breaks=seq(1992,2090,10))+
  xlab("Year")+ 
  ylim(0, 125000000)+
  ylab("Number of chronic hepatitis B infections")+
  theme(
    axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
    axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
    axis.line =element_line(size=0.4,colour = "black"),
    axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
    panel.background = element_rect(fill='white'),
    plot.margin = margin(1, 1, 1, 1, "cm"),
    legend.position = "right",
    legend.background = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 9,face = 'plain',color = 'black',family ='Times New Roman' ),
    legend.key=element_rect(fill='transparent', color='transparent')
  )

    p11 + p12 + plot_layout(nrow=2, ncol = 1)+
  plot_annotation(tag_levels = 'A')
dev.off()

#------------------------------------------S4 Fig----------------------------------------------------------------------
#Model fitting result
df_d2 <- read_excel("df_d2_4.xlsx",sheet=1)
df_d2 <- df_d2[,-1]
df_st1 <- df_state[,c(1,20)] #Simulate the number of confirmed cases per year
df_d3 <- df_state[,c(1,21)]  #Actural number of confirmed cases per year
options(scipen=000)
tiff('S4_Fig.tiff', width = 3900,height = 2000, res = 350)
ggplot()+
  geom_point(aes(x = df_st1$YEAR[1:29],y = df_st1$D[1:29],fill = "#BC3C29FF"),size = 1.6,shape=21) +
  geom_point(aes(x = df_st1$YEAR[30:101],y = df_st1$D[30:101],color = "#0072B5FF",fill = "#0072B5FF"),size = 1.6,shape=17) +
  geom_point(aes(x = df_d3$YEAR,y = df_d3$D_true),color = "black",size = 1.2,shape=4)+
  scale_x_continuous(breaks=seq(1990,2090,10))+
  scale_y_continuous(breaks=seq(0,1500000,200000))+
  xlab("Year")+ 
  ylab("Number of chronic hepatitis B infections")+
  theme( axis.title=element_text(size=20,face="plain",color="black",family ='Times New Roman'),
         axis.text = element_text(size=18,face="plain",color="black",family ='Times New Roman'),
         axis.line =element_line(size=0.4,colour = "black"),
         axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
         panel.background = element_rect(fill='white'),
         plot.margin = margin(1, 1, 1, 1, "cm"),
         legend.position = "right",#c(0.25,0.6),
         legend.background = element_blank(),
         legend.title = element_blank(),
         legend.text = element_text(size = 18,face = 'plain',color = 'black',family ='Times New Roman' ),
         legend.key=element_rect(fill='transparent', color='transparent'))
dev.off()

#-------------------------------------------S5 Fig-----------------------------------------------
#Exploration of feasible vaccination interventions on hepatitis B
#-------------------------------------------A-------------------------------------------
#The impact on the total chronic infectious cases
tiff('FigS5.tiff', width = 2700,height = 1700, res = 350)
#tiff('fig 6.tiff', width = 2700,height = 1700, res = 350)
df <- read_excel("lastone_4.xlsx",sheet = 2)
colnm <- c("Theta","0.3", "0.4", "0.5", "0.6","0.7","0.8")
colnames(df) = colnm  #重命名列名
df$Theta <- with(df, reorder(Theta, Theta))
df.m <- melt(df,id.vars = "Theta")
df.m <- ddply(df.m, .(variable), transform,
              rescale = rescale(value))
p7 <- ggplot(df.m, aes(variable, Theta)) + 
  geom_tile(aes(fill = rescale), colour = "grey")+ 
  scale_fill_gradient(low = "#00468B00", high = "#00468B44",) +
  scale_x_discrete(expand = c(0, 0)) + scale_y_discrete(expand = c(0, 0))+
  xlab("Non-neonatal vaccination coverage")+ 
  theme(axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
        axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
        axis.line =element_blank(),
        axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
        panel.background = element_rect(fill='white'),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right",
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 10,face = 'plain',color = 'black',family ='Times New Roman' ),
        legend.key=element_rect(fill='transparent', color='transparent'))
#dev.off()

#------------------------------------------B ----------------------------------------------------------
# The impact on the MTCT cases
df <- read_excel("lastone_4.xlsx",sheet = 4)

colnm <- c("Theta","0.3", "0.4", "0.5", "0.6","0.7","0.8")
colnames(df) = colnm  #重命名列名
df$Theta <- with(df, reorder(Theta, Theta))
df.m <- melt(df,id.vars = "Theta")
df.m <- ddply(df.m, .(variable), transform,
              rescale = rescale(value))
p8 <- ggplot(df.m, aes(variable, Theta)) + 
  geom_tile(aes(fill = rescale), colour = "grey")+ 
  scale_fill_gradient(low = "white", high = "#99CCCC") +
  scale_x_discrete(expand = c( 0, 0)) + scale_y_discrete(expand = c(0, 0))+
  xlab("Non-neonatal vaccination coverage")+ 
  theme(axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
        axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
        axis.line =element_blank(),
        axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
        panel.background = element_rect(fill='white'),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right",
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 10,face = 'plain',color = 'black',family ='Times New Roman' ),
        legend.key=element_rect(fill='transparent', color='transparent'))
#dev.off()

#------------------------------------------C ----------------------------------------------------------
#The impact on the chronic infectious cases under 5 years old
df <- read_excel("lastone_4.xlsx",sheet = 6)
colnm <- c("Theta","0.3", "0.4", "0.5", "0.6","0.7","0.8")
colnames(df) = colnm  #重命名列名
df$Theta <- with(df, reorder(Theta, Theta))
df.m <- melt(df,id.vars = "Theta")
df.m <- ddply(df.m, .(variable), transform,
              rescale = rescale(value))
p9 <- ggplot(df.m, aes(variable, Theta)) + 
  geom_tile(aes(fill = rescale), colour = "grey")+ 
  scale_fill_gradient(low = "white", high = "#CC9999") +
  scale_x_discrete(expand = c(0, 0)) + scale_y_discrete(expand = c(0, 0))+
  xlab("Non-neonatal vaccination coverage")+ 
  theme(axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
        axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
        axis.line =element_blank(),
        axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
        panel.background = element_rect(fill='white'),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right",
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 10,face = 'plain',color = 'black',family ='Times New Roman' ),
        legend.key=element_rect(fill='transparent', color='transparent'))

#------------------------------------------D ----------------------------------------------------------
#The impact on the number of averted infectious cases
df <- read_excel("lastone_4.xlsx",sheet = 8)
colnm <- c("Theta","0.3", "0.4", "0.5", "0.6","0.7","0.8")
colnames(df) = colnm  #rename the column
df$Theta <- with(df, reorder(Theta, Theta))
df.m <- melt(df,id.vars = "Theta")
df.m <- ddply(df.m, .(variable), transform,
              rescale = rescale(value))
p10 <- ggplot(df.m, aes(variable, Theta)) + 
  geom_tile(aes(fill = rescale), colour = "grey")+ 
  scale_fill_gradient(low = "white", high = "#99B9CC") +
  scale_x_discrete(expand = c(0, 0)) + scale_y_discrete(expand = c(0, 0))+
  xlab("Non-neonatal vaccination coverage")+ 
  theme(axis.title=element_text(size=11,face="plain",color="black",family ='Times New Roman'),
        axis.text = element_text(size=10,face="plain",color="black",family ='Times New Roman'),
        axis.line =element_blank(),
        axis.ticks = element_line(colour = "black", linetype = 1,size=0.4),
        panel.background = element_rect(fill='white'),
        plot.margin = margin(1, 1, 1, 1, "cm"),
        legend.position = "right",
        legend.background = element_blank(),
        legend.title = element_blank(),
        legend.text = element_text(size = 10,face = 'plain',color = 'black',family ='Times New Roman' ),
        legend.key=element_rect(fill='transparent', color='transparent'))

p7 + p8 + p9 + p10 + plot_layout(nrow=2, ncol = 2)+
  plot_annotation(tag_levels = 'A')
dev.off()



#-------------------------------------------S6 Fig-----------------------------------------------
#Sensitivity analysis of parameters and Re
#-------------------------------------------A-------------------------------------------
tiff('FigS6.tiff', width = 2900,height = 2400, res = 350)

df <- read.csv("theta_omiga2.csv", header = TRUE)
df <- melt(df,id="omiga2")
df <- df %>% separate(variable, c("d1","Theta"), "[X]") 
df <- df[,-2]
colnm <- c("Omega2","Theta","Re")
colnames(df) = colnm  
df$Theta <- as.numeric(df$Theta)

S1 <- ggplot(df, aes(x=Theta,y=Omega2,fill=Re))+
  geom_tile()+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_viridis_c(option =  "viridis", direction = 1)+
  labs(x="Theta",y="Omega2",fill="Re")+
  theme(legend.title = element_blank(),
        legend.background = element_blank(),legend.key.size = unit(15,"pt"),
        legend.key = element_blank(),legend.text=element_text(size=10,hjust = 0),
        axis.text = element_text(size = 10,colour = "black",family ='Times New Roman'),
        axis.text.x = element_text(angle = 30,vjust = 0.75,family ='Times New Roman'),
        axis.title = element_text(size=11,color = "black",family ='Times New Roman'),
        axis.line = element_line(colour = "black",size = 0.4),
        axis.ticks = element_line(color = "black",size = 0.4),
        panel.background = element_blank(),
        panel.border = element_rect(fill = NA,colour = "black",size = 0.6),
        plot.margin=unit(rep(2,4),'lines')
  )

#-------------------------------------------B-------------------------------------------
df <- read.csv("theta_Dc.csv", header = TRUE)
df <- melt(df,id="Dc")
df <- df %>% separate(variable, c("d1","Theta"), "[X]") 
df <- df[,-2]
colnm <- c("Dc","Theta","Re")
colnames(df) = colnm  
df$Theta <- as.numeric(df$Theta)

S2 <- ggplot(df, aes(x=Theta,y=Dc,fill=Re))+
  geom_tile()+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_viridis_c(option =  "viridis", direction = 1)+
  labs(x="Theta",y="Dc",fill="Re")+
  theme(legend.title = element_blank(),
        legend.background = element_blank(),legend.key.size = unit(15,"pt"),
        legend.key = element_blank(),legend.text=element_text(size=10,hjust = 0),
        axis.text = element_text(size = 10,colour = "black",family ='Times New Roman'),
        axis.text.x = element_text(angle = 30,vjust = 0.75,family ='Times New Roman'),
        axis.title = element_text(size=11,color = "black",family ='Times New Roman'),
        axis.line = element_line(colour = "black",size = 0.4),
        axis.ticks = element_line(color = "black",size = 0.4),
        panel.background = element_blank(),
        panel.border = element_rect(fill = NA,colour = "black",size = 0.6),
        plot.margin=unit(rep(2,4),'lines')
  )


#-------------------------------------------C-------------------------------------------
df <- read.csv("omiga2_e2.csv", header = TRUE)
df <- melt(df,id="omiga2")
df <- df %>% separate(variable, c("d1","e2"), "[X]") 
df <- df[,-2]
colnm <- c("Omega2","e2","Re")
colnames(df) = colnm  
df$e2 <- as.numeric(df$e2)

S3 <- ggplot(df, aes(x=e2,y=Omega2,fill=Re))+
  geom_tile()+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_viridis_c(option =  "viridis", direction = 1)+
  labs(x="e2",y="Omega2",fill="Re")+
  theme(legend.title = element_blank(),
        legend.background = element_blank(),legend.key.size = unit(15,"pt"),
        legend.key = element_blank(),legend.text=element_text(size=10,hjust = 0),
        axis.text = element_text(size = 10,colour = "black",family ='Times New Roman'),
        axis.text.x = element_text(angle = 30,vjust = 0.75,family ='Times New Roman'),
        axis.title = element_text(size=11,color = "black",family ='Times New Roman'),
        axis.line = element_line(colour = "black",size = 0.4),
        axis.ticks = element_line(color = "black",size = 0.4),
        panel.background = element_blank(),
        panel.border = element_rect(fill = NA,colour = "black",size = 0.6),
        plot.margin=unit(rep(2,4),'lines')
  )


#-------------------------------------------D-------------------------------------------
df <- read.csv("beta3_beta2.csv", header = TRUE)
df <- melt(df,id="beta2")
df <- df %>% separate(variable, c("d1","beta3"), "[X]") 
df <- df[,-2]
colnm <- c("beta2","beta3","Re")
colnames(df) = colnm  
df$beta3 <- as.numeric(df$beta3)

S4 <- ggplot(df, aes(x=beta3,y=beta2,fill=Re))+
  geom_tile()+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(expand = c(0,0))+
  scale_fill_viridis_c(option =  "viridis", direction = 1)+
  labs(x="beta3",y="beta2",fill="Re")+
  theme(legend.title = element_blank(),
        legend.background = element_blank(),legend.key.size = unit(15,"pt"),
        legend.key = element_blank(),legend.text=element_text(size=10,hjust = 0),
        axis.text = element_text(size = 10,colour = "black",family ='Times New Roman'),
        axis.text.x = element_text(angle = 30,vjust = 0.75,family ='Times New Roman'),
        axis.title = element_text(size=11,color = "black",family ='Times New Roman'),
        axis.line = element_line(colour = "black",size = 0.4),
        axis.ticks = element_line(color = "black",size = 0.4),
        panel.background = element_blank(),
        panel.border = element_rect(fill = NA,colour = "black",size = 0.6),
        plot.margin=unit(rep(2,4),'lines')
  )

S1 + S2 + S3 + S4 + plot_layout(nrow=2, ncol = 2)+
  plot_annotation(tag_levels = 'A')
dev.off()
