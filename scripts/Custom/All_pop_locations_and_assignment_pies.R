library(ggmap)
library(ggplot2)
library(ggrepel)
library(scatterpie)
library(extrafont)
loadfonts()

## My API key
# AIzaSyAl5SlLG_UH2irTf7bQGYcX-HBEVZg0bts

## register google map API
register_google(key = "AIzaSyAl5SlLG_UH2irTf7bQGYcX-HBEVZg0bts")

## Get a nice mapstyle by playing with settings here: https://mapstyle.withgoogle.com/ 
mystyle <- "element:geometry%7Ccolor:0xf5f5f5&style=element:labels%7Cvisibility:off&style=element:labels.icon%7Cvisibility:off&style=element:labels.text.fill%7Ccolor:0x616161&style=element:labels.text.stroke%7Ccolor:0xf5f5f5&style=feature:administrative%7Celement:geometry%7Cvisibility:off&style=feature:administrative.country%7Celement:geometry.stroke%7Ccolor:0x959595%7Cvisibility:on&style=feature:administrative.land_parcel%7Cvisibility:off&style=feature:administrative.land_parcel%7Celement:labels.text.fill%7Ccolor:0xbdbdbd&style=feature:administrative.neighborhood%7Cvisibility:off&style=feature:poi%7Cvisibility:off&style=feature:poi%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:poi%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:poi.park%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:poi.park%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:road%7Cvisibility:off&style=feature:road%7Celement:geometry%7Ccolor:0xffffff&style=feature:road%7Celement:labels.icon%7Cvisibility:off&style=feature:road.arterial%7Celement:labels.text.fill%7Ccolor:0x757575&style=feature:road.highway%7Celement:geometry%7Ccolor:0xdadada&style=feature:road.highway%7Celement:labels.text.fill%7Ccolor:0x616161&style=feature:road.local%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&style=feature:transit%7Cvisibility:off&style=feature:transit.line%7Celement:geometry%7Ccolor:0xe5e5e5&style=feature:transit.station%7Celement:geometry%7Ccolor:0xeeeeee&style=feature:water%7Celement:geometry%7Ccolor:0xc9c9c9&style=feature:water%7Celement:labels.text.fill%7Ccolor:0x9e9e9e&size=480x360"

# get coordinates
coords_and_assign <- read.table("/home/djeffrie/Dropbox/PhD/Dans_PhD_Shared/Thesis/Chapter_5_Hybridisation_and_introgression/data/Combined_RAD_MICRO_assignments.tbl", header = T, stringsAsFactors = F)  ## load my microsat coordinates file. 

coords_and_assign$N <- rowSums(coords_and_assign[c(4:16)])

BigPie <- colSums(coords_and_assign[c(4:16)])
sum(BigPie)
pie(BigPie, 
    col = spp.cols, 
    labels = "",
    border = "white", init.angle = 90 )

## Get map
map <- get_googlemap(center = c(15,60),
        zoom = 4, 
        source = "google",
        style = mystyle)
  
## Add population locations

ggmap(map) + 
  geom_point(data = coords_and_assign, 
             aes(x = Long, y = Lat), 
             color = 'black', 
             size = 1) +
  geom_text_repel(data = coords_and_assign, 
                  max.overlaps = 100,
                  aes(x = Long,
                      y = Lat,
                      label = Pop)) + 



## Add pie charts of sample assignments. . . 

names(coords_and_assign)

C.carassius = "deepskyblue3"
C.carassius_DAN = "navyblue"
C.carassius_DON = "turquoise"
C.a.auratus = "firebrick4"
C.a.gibelio = "darkorange"
C.carpio = "black"
C.carassiusxC.a.auratus = "darkorchid4"
C.carassiusxC.a.gibelio = "deeppink"
C.carassiusxC.carpio = "grey54"
C.a.auratusxC.carpio = "darkorange4"
C.carassiusxC.a.auratus_F2 = "green4"
C.carassiusxC.a.gibelio_F2 = "limegreen"
C.carassiusxC.a.gibelio_BKX = "red"


spp.cols <- c(C.carassius,
              C.carassius_DAN,
              C.carassius_DON,
              C.a.auratus,
              C.a.gibelio,
              C.carpio,
              C.carassiusxC.a.auratus,
              C.carassiusxC.a.gibelio,
              C.carassiusxC.carpio,
              C.a.auratusxC.carpio,
              C.carassiusxC.a.auratus_F2,
              C.carassiusxC.a.gibelio_F2,
              C.carassiusxC.a.gibelio_BKX)


ggmap(map) + 
  scale_fill_manual(values=spp.cols) +
  geom_scatterpie(aes(x = Long, y = Lat, group = Pop), 
                  data = coords_and_assign,
                  cols = names(coords_and_assign)[c(4:16)],
                  color = "white")




