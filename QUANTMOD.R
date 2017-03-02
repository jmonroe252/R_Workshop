require(quantmod)
require(plyr)

ARS<-getSymbols('ARS=X',src='yahoo', auto.assign = FALSE)
BOB<-getSymbols('BOB=X',src='yahoo', auto.assign = FALSE)
BRL<-getSymbols('BRL=X',src='yahoo', auto.assign = FALSE)
CLP<-getSymbols('CLP=X',src='yahoo', auto.assign = FALSE)
COP<-getSymbols('COP=X',src='yahoo', auto.assign = FALSE)
PYG<-getSymbols('PYG=X',src='yahoo', auto.assign = FALSE)
PEN<-getSymbols('PEN=X',src='yahoo', auto.assign = FALSE)
UYU<-getSymbols('UYU=X',src='yahoo', auto.assign = FALSE)
VEF<-getSymbols('VEF=X',src='yahoo', auto.assign = FALSE)


ARS1<-tail(to.monthly(ARS), n=14)
ARS2<-(ARS1$ARS.Close)
ARS3<-data.frame(Date=index(ARS2),coredata(ARS2))

BOB1<-tail(to.monthly(BOB), n=14)
BOB2<-(BOB1$BOB.Close)
BOB3<-data.frame(Date=index(BOB2),coredata(BOB2))

BRL1<-tail(to.monthly(BRL), n=14)
BRL2<-(BRL1$BRL.Close)
BRL3<-data.frame(Date=index(BRL2),coredata(BRL2))

CLP1<-tail(to.monthly(CLP), n=14)
CLP2<-(CLP1$CLP.Close)
CLP3<-data.frame(Date=index(CLP2),coredata(CLP2))

COP1<-tail(to.monthly(COP), n=14)
COP2<-(COP1$COP.Close)
COP3<-data.frame(Date=index(COP2),coredata(COP2))

PYG1<-tail(to.monthly(PYG), n=14)
PYG2<-(PYG1$PYG.Close)
PYG3<-data.frame(Date=index(PYG2),coredata(PYG2))

PEN1<-tail(to.monthly(PEN), n=14)
PEN2<-(PEN1$PEN.Close)
PEN3<-data.frame(Date=index(PEN2),coredata(PEN2))

UYU1<-tail(to.monthly(UYU), n=14)
UYU2<-(UYU1$UYU.Close)
UYU3<-data.frame(Date=index(UYU2),coredata(UYU2))

VEF1<-tail(to.monthly(VEF), n=14)
VEF2<-(VEF1$VEF.Close)
VEF3<-data.frame(Date=index(VEF2),coredata(VEF2))


FX0<- merge(ARS3,BOB3,ALL=TRUE)
FX1<- merge(FX0,BRL3,ALL=TRUE)
FX2<- merge(FX1,CLP3,ALL=TRUE)
FX3<- merge(FX2,COP3,ALL=TRUE)
FX4<- merge(FX3,PYG3,ALL=TRUE)
FX5<- merge(FX4,PEN3,ALL=TRUE)
FX6<- merge(FX5,UYU3,ALL=TRUE)
FX<- merge(FX6,VEF3, ALL=TRUE)

out<-data.frame(rename(FX,c("ARS.Close"="USD/ARS", "BOB.Close"="USD/BOB","BRL.Close"="USD/BRL", "CLP.Close"="USD/CLP", "COP.Close"="USD/COP", "PYG.Close"="USD/PYG","PEN.Close"="USD/PEN", "UYU.Close"="USD/UYU", "VEF.Close"="USD/VEF")))