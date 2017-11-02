library(dplyr)
library(lubridate)
library(ggthemes)

#file <- choose.files()
#raw <- read.csv(file, sep = ';')

process <- function (INraw) {
  
  raw <- INraw
  data <- raw %>%
    select(Route, 
           Supplier
    )
  
  data$Agendamento_Inic <- as.POSIXlt(as.character(raw$Scheduled), format = "%d/%m/%Y %H:%M")
  data$Agendamento_Fim <- as.POSIXlt(as.character(raw$Scheduled_End), format = "%d/%m/%Y %H:%M")
  data$Realizado_Inic <- as.POSIXlt(as.character(raw$Real), format = "%d/%m/%Y %H:%M")
  data$Realizado_Fim <- as.POSIXlt(as.character(raw$Real_End), format = "%d/%m/%Y %H:%M")
  #data$Atraso_Inic <- ifelse(difftime(data$Realizado_Inic, data$Agendamento_Inic, units = 'mins') > 15, difftime(data$Realizado_Inic, data$Agendamento_Inic, units = 'mins'), 0)
  #data$Atraso_Fim <- ifelse(difftime(data$Realizado_Fim, data$Agendamento_Fim, units = 'mins') > 15, difftime(data$Realizado_Fim, data$Agendamento_Fim, units = 'mins'), 0)
  data$Hour_Inic <- hour(data$Agendamento_Inic)
  data$Min_Inic <- minute(data$Agendamento_Inic)
  data$Hour_Fim <- hour(data$Agendamento_Fim)
  data$Min_Fim <- minute(data$Agendamento_Fim)
  data$TempoAgendado <- difftime(data$Agendamento_Fim, data$Agendamento_Inic, units = 'mins')
  data$TempoRealizado <- difftime(data$Realizado_Fim, data$Realizado_Inic, units = 'mins')
  data$Agendamento_Inic <- as.Date(data$Agendamento_Inic)
  data$Agendamento_Fim <- as.Date(data$Agendamento_Fim)
  data$Realizado_Inic <- NULL
  data$Realizado_Fim <- NULL
  
  # Supplier = 1, Yard = 2, Base = 3
  data$Tipo <- 1
  data[grep("Inic|Fim", data$Supplier), 'Tipo'] <- 2
  data[grep("JSL", data$Supplier), 'Tipo'] <- 3
  
  # 1 = Finalizada, 2 = Expirada e 3 = Cancelada
  #data$Status <- 1
  #  data[grep("Expirada", data$Status.da.OS), 'Status'] <- 2
  #  data[grep("Cancelada", data$Status.da.OS), 'Status'] <- 3
  #data$Status.da.OS <- NULL
  
  #############################################################################
  # Split the data into training and testing
  #############################################################################
  
  days <- sort(unique(data$Agendamento_Inic))
  
  l <- round(length(days) * 0.3)
  testing <- data[data$Agendamento_Inic >= days[length(days) - 18], ]
  training <- data[data$Agendamento_Inic < days[length(days) - 18], ]
  
  #Check if the split has the same number as the original dataset
  (nrow(training) + nrow(testing)) == nrow(data)
  
  # Remove new levels that only appears at the end
  testing <- subset(testing, (testing$Route %in% training$Route & 
                                testing$Codigo.do.fluxo %in% training$Codigo.do.fluxo))
  
  
  #############################################################################
  # Fit Linear Model
  #############################################################################
  tinic <- Sys.time()
  fitlm <- lm(TempoRealizado ~ ., training)
  tfim <- Sys.time()
  timelm <- tfim - tinic
  timelm
  
  pred_lm <- predict(fitlm,newdata=testing)
  
  testing$linear <- pred_lm
  
  
  
  
  testing
  
}

#c <-ggplot(data=testing, aes(x = Agendamento_Inic)) +
#  geom_line(aes(y = TempoAgendado, colour="Time Scheduled")) +
#  geom_line(aes(y = linear, colour="Linear Prediction")) +
#  theme_pander() +
#  scale_fill_pander() +
#  ggtitle("Model")
#c
