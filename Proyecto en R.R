###### Proyecto BEDU - Noé González - Data Analysis-21-12 ######


### Conexión a BBDD de MySql ###

library(DBI)
library(RMySQL)

SqlData <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "proyecto_bedu",
  host = "localhost",
  username = "root",
  password = ""
)

dbListTables(SqlData)

dbListFields(SqlData, 'query_r_detail')

data.detail <- dbGetQuery(SqlData, "select * from query_r_detail")
data.tienda <- dbGetQuery(SqlData, "select * from query_r_tienda")
data.fecha <- dbGetQuery(SqlData, "select * from query_r_fecha")
data.mes <- dbGetQuery(SqlData, "select * from query_r_mes")


### Exploración y preparación del Dataset ###

str(data.detail)
summary(data.detail)
names(data.detail) = c(
  "Tienda",
  "Grupo",
  "Cadena",
  "Clasificacion",
  "Region",
  "Fecha",
  "Mes",
  "Venta.Pzas",
  "Precio",
  "SOS.Seco",
  "SOS.Frio"
)

str(data.tienda)
summary(data.tienda)
names(data.tienda) = c(
  "Tienda",
  "Grupo",
  "Cadena",
  "Clasificacion",
  "Region",
  "Venta.Pzas",
  "Precio",
  "SOS.Seco",
  "SOS.Frio"
)

str(data.fecha)
summary(data.fecha)
names(data.fecha) = c("Fecha", "Mes", "Venta.Pzas", "Precio", "SOS.Seco", "SOS.Frio")


str(data.mes)
summary(data.mes)
names(data.mes) = c("Fecha", "Mes", "Venta.Pzas", "Precio", "SOS.Seco", "SOS.Frio")


names(data.detail)
names(data.tienda)
names(data.fecha)


library(dplyr)

data.detail <-
  mutate_at(data.detail, c("SOS.Seco", "SOS.Frio"), ~ replace(., is.na(.), 0))
summary(data.detail)
data.detail <-
  mutate(data.detail, suma.SOS = data.detail$SOS.Seco + data.detail$SOS.Frio)
data.detail <-
  mutate(data.detail,
         SOS =  ifelse(
           data.detail$SOS.Seco == 0,
           data.detail$SOS.Frio,
           ifelse(
             data.detail$SOS.Frio == 0,
             data.detail$SOS.Seco,
             data.detail$suma.SOS / 2
           )
         ))

detail.complete <- complete.cases(data.detail)
sum(detail.complete)
data.detail <- data.detail[detail.complete, ]
data.detail <-
  as.data.frame(data.detail %>% select(1, 2, 3, 4, 5, 6, 7, 8, 9, 13))
data.detail <- filter(data.detail, SOS != 0)
data.detail <- filter(data.detail, Precio != 0)
data.detail <-
  mutate(data.detail, Fecha = as.Date(Fecha, "%Y-%m-%d"))
summary(data.detail)
str(data.detail)


data.tienda <-
  mutate_at(data.tienda, c("SOS.Seco", "SOS.Frio"), ~ replace(., is.na(.), 0))
summary(data.tienda)
data.tienda <-
  mutate(data.tienda, suma.SOS = data.tienda$SOS.Seco + data.tienda$SOS.Frio)
data.tienda <-
  mutate(data.tienda,
         SOS =  ifelse(
           data.tienda$SOS.Seco == 0,
           data.tienda$SOS.Frio,
           ifelse(
             data.tienda$SOS.Frio == 0,
             data.tienda$SOS.Seco,
             data.tienda$suma.SOS / 2
           )
         ))

tienda.complete <- complete.cases(data.tienda)
sum(tienda.complete)
data.tienda <- data.tienda[tienda.complete,]
data.tienda <-
  as.data.frame(data.tienda %>% select(1, 2, 3, 4, 5, 6, 7, 11))
data.tienda <- filter(data.tienda, SOS != 0)
data.tienda <- filter(data.tienda, Precio != 0)
summary(data.tienda)
str(data.tienda)


data.fecha <-
  mutate_at(data.fecha, c("SOS.Seco", "SOS.Frio"), ~ replace(., is.na(.), 0))
data.fecha <-
  mutate(data.fecha, suma.SOS = data.fecha$SOS.Seco + data.fecha$SOS.Frio)
data.fecha <-
  mutate(data.fecha,
         SOS =  ifelse(
           data.fecha$SOS.Seco == 0,
           data.fecha$SOS.Frio,
           ifelse(
             data.fecha$SOS.Frio == 0,
             data.fecha$SOS.Seco,
             data.fecha$suma.SOS / 2
           )
         ))

fecha.complete <- complete.cases(data.fecha)
sum(fecha.complete)
data.fecha <- data.fecha[fecha.complete, ]
data.fecha <- as.data.frame(data.fecha %>% select(1, 2, 3, 4, 8))
data.fecha <- filter(data.fecha, SOS != 0)
data.fecha <- filter(data.fecha, Precio != 0)
data.fecha <- mutate(data.fecha, Fecha = as.Date(Fecha, "%Y-%m-%d"))
summary(data.fecha)
str(data.fecha)


data.mes <-
  mutate_at(data.mes, c("SOS.Seco", "SOS.Frio"), ~ replace(., is.na(.), 0))
data.mes <-
  mutate(data.mes, suma.SOS = data.mes$SOS.Seco + data.mes$SOS.Frio)
data.mes <-
  mutate(data.mes,
         SOS =  ifelse(
           data.mes$SOS.Seco == 0,
           data.mes$SOS.Frio,
           ifelse(
             data.mes$SOS.Frio == 0,
             data.mes$SOS.Seco,
             data.mes$suma.SOS / 2
           )
         ))

mes.complete <- complete.cases(data.mes)
sum(mes.complete)
data.mes <- data.mes[mes.complete, ]
data.mes <- as.data.frame(data.mes %>% select(1, 2, 3, 4, 8))
data.mes <- filter(data.mes, SOS != 0)
data.mes <- filter(data.mes, Precio != 0)
data.mes <- mutate(data.mes, Fecha = as.Date(Fecha, "%Y-%m-%d"))
summary(data.mes)
str(data.mes)



### EDA ###

library(ggplot2)

data.tienda %>%
  ggplot() +
  aes(SOS) +
  geom_histogram(binwidth = 8,
                 col = "black",
                 fill = "orange") +
  ggtitle("Histograma de SOS") +
  ylab("Frecuencia") +
  xlab("SOS") +
  theme_replace()


### Modelo de regresión ###


attach(data.tienda)

par(mfrow = c(1,1) ) 

plot(Venta.Pzas, SOS, xlab = "Venta en piezas", ylab = "% SOS", pch = 16)
plot(Venta.Pzas, Precio, xlab = "Venta en piezas", ylab = "% SOS", pch = 16)



mlm <- lm(Venta.Pzas ~ SOS + Precio)

summary(mlm)

ml <- lm(SOS~Venta.Pzas)

summary(ml)

plot(Venta.Pzas, SOS, xlab = "Venta en piezas", ylab = "% SOS", pch = 16)
abline(lsfit(Venta.Pzas, SOS))



  
  