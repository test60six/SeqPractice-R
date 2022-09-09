#install packages

install.packages("tidyverse","readxl","ggpubr",)
install.packages("reshape2")
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install()


#Import Data 
library(readxl)

df1 <- read_excel("Data/16S data analysis.xlsx",sheet="Analysis By Percentage")
  
    View(df1)
    
    
#convert to long format using reshape2
    
library(reshape2)
#dflong will use melt to convert.c vector 
    tmp <- df1[ , c(1, 5:32)] #blank then comma is give me all rows. (1, is column1 - 5:32 is selecting columns 5-32 trimming out 2,3 and 4)
    
    dflong <- melt(tmp, id.vars = c("Name"))  
    
    View(dflong)

library("ggplot2")

 ggplot(data = dflong, aes(x = Name, y= value))+
    geom_point()+
      facet_wrap(~variable)+
  coord_flip()
 

 dflong$value <- scale(dflong$value) 
ggplot(data=dflong, aes(x = Name, y= variable))+
  geom_tile(aes(fill=value))+
  scale_fill_gradient(low="#ffbd33", high="#ff3333")+
  theme(axis.text.x = element_text(angle = 90))+
  labs (x="Bacteria Type ", y=" Animal Number ")
 








