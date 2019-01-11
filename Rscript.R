################################################################################################
#                                                                                              #
# Modelling distributions of Aedes aegypti and Aedes albopictus using climate, host density    #
#   and interspecies competition                                                               #
#                                                                                              #
# Yang B. et al. 2019                                                                          #
#                                                                                              #        
# Zero-inflated negative binomial regression                                                   #
#                                                                                              #
################################################################################################

library(glmmTMB)

#
# load data
#
# df <- read.table("~/fl_aeg_alb.txt",
#                  sep = "\t",
#                  stringsAsFactors = FALSE)
files <- c("fl_aeg_alb_part_1.txt",
           "fl_aeg_alb_part_2.txt")
df <- lapply(files, read.table, sep = "\t",
             stringsAsFactors = FALSE)
df <- do.call('rbind', df)


#
# fit ZINB model - main analysis
#

fit <- function(data, # dataset used to fit ZINB model
                species # 1 - Ae. aegypti; 2 - Ae. albopictus
                ){
  #
  # This is the function to fit ZINB model using glmmTMB
  #
  # Input:
  #   data, data used to fit model
  #   species ==1, Ae. aegypti;
  #   species ==2, Ae. albopictus
  #
  # Output:
  #   a glmmTMB object
  #
  
  # formular for logistic component
  zi.formular <- ~ occurrence_aeg_1 + occurrence_aeg_2 + occurrence_aeg_3 + # prior occurrence of Aedes aegypti
    occurrence_alb_1 + occurrence_alb_2 + occurrence_alb_3 + # prior occurrence of Aedes albopictus
    hum_pop_dens + # human population density
    wind + tmin + delta_tmax + rh + # climatic variables
    light_trap + other_traps + # trap types
    (1|site) + (1|county) # random effects for site and county
  
  if(species == 1){
    
    m <- glmmTMB(Ae ~ log(abundance_aeg_1+1e-5) + log(abundance_aeg_2+1e-5) + log(abundance_aeg_3+1e-5) +
                   log(abundance_alb_1+1e-5) + log(abundance_alb_2+1e-5) + log(abundance_alb_3+1e-5) + 
                   hum_pop_dens + # human population density
                   wind + tmin + delta_tmax + rh + # climatic variables
                   light_trap + other_traps + # trap types
                   offset(trap_day) +
                   (1|site) + (1|county), # random effects for site and county
                 ziformula=zi.formular, # formular for logistic component
                 data=data, 
                 family=nbinom2,
                 verbose=TRUE, 
                 se=TRUE,
                 control=glmmTMBControl(profile=quote(length(parameters$beta)>=5)))
    
  }
  
  if(species == 2){
    
    m <- glmmTMB(Al ~ log(abundance_aeg_1+1e-5) + log(abundance_aeg_2+1e-5) + log(abundance_aeg_3+1e-5) +
                   log(abundance_alb_1+1e-5) + log(abundance_alb_2+1e-5) + log(abundance_alb_3+1e-5) + 
                   hum_pop_dens + # human population density
                   wind + tmin + delta_tmax + rh + # climatic variables
                   light_trap + other_traps + # trap types
                   offset(trap_day) +
                   (1|site) + (1|county), # random effects for site and county
                 ziformula=zi.formular, # formular for logistic component
                 data=data, 
                 family=nbinom2,
                 verbose=TRUE, 
                 se=TRUE,
                 control=glmmTMBControl(profile=quote(length(parameters$beta)>=5)))
    
  }
  
  return(m)
  
  
}

data <- df[df$longitudinal_data==1, ] # subset longitudinal training dataset
model <- fit(data, species) # change value of species accordingly
pred.main <- glmmTMB::predict(model, 
                              newdata = data, 
                              type = "response", 
                              allow.new.levels = TRUE) # retuen value of mu*(1-p); see predict.glmmTMB for more details

#
# predict no abundance validation dataset
#

fitNoAbundance <- function(data, # dataset used to fit ZINB model
                           species # 1 - Ae. aegypti; 2 - Ae. albopictus
){
  #
  # This is the function to fit no abundance model using glmmTMB
  #
  # Input:
  #   data, data used to fit model
  #   species ==1, Ae. aegypti;
  #   species ==2, Ae. albopictus
  #
  # Output:
  #   a glmmTMB object
  #
  
  # formular for logistic component
  zi.formular <- ~ hum_pop_dens + # human population density
    wind + tmin + delta_tmax + rh + # climatic variables
    light_trap + other_traps + # trap types
    (1|site) + (1|county) # random effects for site and county
  
  if(species == 1){
    
    m <- glmmTMB(Ae ~ hum_pop_dens + # human population density
                   wind + tmin + delta_tmax + rh + # climatic variables
                   light_trap + other_traps + # trap types
                   offset(trap_day) +
                   (1|site) + (1|county), # random effects for site and county
                 ziformula=zi.formular, # formular for logistic component
                 data=data, 
                 family=nbinom2,
                 verbose=TRUE, 
                 se=TRUE,
                 control=glmmTMBControl(profile=quote(length(parameters$beta)>=5)))
    
  }
  
  if(species == 2){
    
    m <- glmmTMB(Al ~ hum_pop_dens + # human population density
                   wind + tmin + delta_tmax + rh + # climatic variables
                   light_trap + other_traps + # trap types
                   offset(trap_day) +
                   (1|site) + (1|county), # random effects for site and county
                 ziformula=zi.formular, # formular for logistic component
                 data=data, 
                 family=nbinom2,
                 verbose=TRUE, 
                 se=TRUE,
                 control=glmmTMBControl(profile=quote(length(parameters$beta)>=5)))
    
  }
  
  return(m)
  
  
}

ext <- df[df$external_data == 1, ] # subset no abundance validation dataset
no_abund_model <- fitNoAbundance(data, species)

pred.ext <- glmmTMB::predict(no_abund_model, 
                             newdata = ext, 
                             type = "response", 
                             allow.new.levels = TRUE) # retuen value of mu*(1-p); see predict.glmmTMB for more details

#
# The end
#
