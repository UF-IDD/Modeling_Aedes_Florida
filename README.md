# Modeling_Aedes_Florida
Datafile and R script for replicating the modeling of distribution of Aedes Aegypti and Aedes Albopictus in Florida.

# Notes
Data files need to be combined before fiting the model.

# Keys for data

record_id - unique id for the trap record

num_aeg - number of aegypti captured in this trap episode

num_alb - number of albpictus captured in this trap episode

trap_day - trap-days of this trap episode

county - one of the Floridian countries where the trap was placed

site - one of the Floridian countries where the trap was placed

abundance_aeg_1 - the weekly average number of aegypti per trap-day for this trap site at week t-1

abundance_aeg_2 - the weekly average number of aegypti per trap-day for this trap site at weeks t-2

abundance_aeg_3 - the weekly average number of aegypti per trap-day for this trap site at weeks t-3

abundance_alb_1 - the weekly average number of albpictus per trap-day for this trap site at week t-1

abundance_alb_2 - the weekly average number of albpictus per trap-day for this trap site at weeks t-2

abundance_alb_3 - the weekly average number of albpictus per trap-day for this trap site at weeks t-3

occurrence_aeg_1 - whether aegypti was found (1) or not (0) in this trap at week t-1

occurrence_aeg_2 - whether aegypti was found (1) or not (0) in this trap at week t-2

occurrence_aeg_2 - whether aegypti was found (1) or not (0) in this trap at week t-2

occurrence_alb_1 - whether albpictus was found (1) or not (0) in this trap at week t-1

occurrence_alb_2 - whether albpictus was found (1) or not (0) in this trap at week t-2

occurrence_alb_2 - whether albpictus was found (1) or not (0) in this trap at week t-2

hum_pop_dens - human population density extracted for the pixel where the trap locates

wind - weekly average wind speed extracted for the pixel where the trap locates

tmin - weekly average of minimum temperature extracted for the pixel where the trap locates

delta_tmax - weekly average of residuals of maximum temperature (derived from the linear regression) extracted for the pixel where the trap locates

rh - weekly average relative humidity extracted for the pixel where the trap locates

bg_sentinel - whether this trap used bg trap (1) or not (0)

light_trap - whether this trap used ligth trap (1) or not (0)

other_traps - whether this trap used traps other than bg/light trap (1) or not (0)

longitudinal_data - whether this trap record was included in the longitudinal dataset (1) or not (0)

external_data - whether this trap record was included in the external dataset (1) or not (0)

grid.long - the longtitude of the pixel where the trap locates

grid.lat - the latitude of the pixel where the trap locates
