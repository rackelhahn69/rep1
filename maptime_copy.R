## Maptime-Example ##

## Author: Catherina Cader
## Date: 24/10/2017

#install required packages
install.packages(c("sp","rgdal","raster"))

#loading packages
library(sp)
library(raster)
library(rgdal)

#check what is in the folder
dir()

#getting spatial data into R

#import raster
r = raster("prec_01.tif")

#plot the file
plot(r)

#create raster stack
list.r= list.files(path, full.names = TRUE, pattern = ".tif")
s=stack(list.r)
s=setNames(s, month.abb[1:12])

#vecor
v=readOGR(path, "mmr")
v@data
plot(v, add=T)

#Create a smaller subset of the shapfile by selecting an attribute
h=subset(v, TS=="Homalin")
plot(r)
plot(h, add=T)

#Crop to the extent of the subset
sh=crop(s, h)
plot(sh, 1)
plot(h, add=TRUE)

#Mask the boundaries of the subset
sh=mask(sh, h)
plot(sh, 1)
plot(sh)

#Statistics
bp=boxplot(sh, names=month.abb[1:12], xlab="Months", ylab="Precipitation in mm")

#export new croped raster as tiff
writeRaster(sh, "homalin.tif",format="GTiff", bylayer=T, suffix='names')

#export map
for (i in 1:nlayers(sh)){
  filename=paste(i, "_prec.png", sep="")
  png(file=filename)
  plot(sh,i, zlim=c(0,800))
  plot(h,add=TRUE)
  grid()
  legend("topright", "Precipitation in mm", col=c("black"))
  title(xlab="lon", ylab="lat")
  
  dev.off()
} 

graphics.off()
