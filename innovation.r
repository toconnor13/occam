rm(list=ls())

library("foreign")
library("AER")
require(ggplot2)

# Read in the data on the time-series regressions on portfolio returns, factor returns, and other data. 
factors <- read.dta("innovation_factors.dta")

# Create a new variable - VC returns lagged by one year.
N <- length(factors$vc_returns)
factors$vc_returns_l1 <- c(NA, factors$vc_returns[1:(N-1)])

# Get factos in terms of percentage points i.e. 9.01 rather that 0.0901.
factors$g_ipo <- factors$g_ipo*100
factors$g_fund_no <- factors$g_fund_no*100

# Save the new dataset for generating graphs etc. 
fin_factors <- write.dta(factors, "final_factors.dta")

# Isolate the new factors we are interested in testing.
candidate_factors <- c(names(factors)[6:17], "vc_returns_l1")

# Designte the different portfolio groups.
pfs_25 = names(factors)[18:42]
ind_10 = names(factors)[43:54]
mom_12 = names(factors)[55:64]

# State and store the different specifications the factors will be tested on.
capm_model <- sl ~ mktrf
hml_model <- sl ~ mktrf + hml
smb_model <- sl ~ mktrf + smb
ff3f_model <- sl ~ mktrf + hml + smb
list_of_models <- c(capm_model, hml_model, smb_model, ff3f_model)

# Get the average returns on the 25 portfolios.
pfs_25_matrix <- as.matrix(factors)[,18:42]
pfs25_means <- colMeans(pfs_25_matrix)

# Function that changes the dependent variable on the specification we want to test - so we can loop through different protfolios.
change_dep_var <- function(new_dep_var, model) {
	new = reformulate(".", new_dep_var)
	update(model, new)}

# Add an independent variable to the model - to allow us to add a factor.
add_ind_var <- function(new_var, model){
	new = reformulate(c('.', new_var))
	update(model, new)
}

# This function adds the factor specified to the model provided, and loops through all the portfolios running an OLS on the model specified. 
ts_analysis <- function(portfolios=pfs_25, formula=hml_model, factor=NULL){
	this_formula <- formula
	if(!missing(factor)){
	this_formula <- add_ind_var(factor, formula)
	}
	model_list <- lapply(portfolios, change_dep_var, this_formula)
	lapply(model_list, lm, data=factors)}

# This model drops the intercept from the list of regressions from the time-series stage.
drop_intercept <- function(data){
	colnames(data)[1] <- 'intercept'
	data_2 <- subset(data, select=-c(intercept))
	return(data_2)
	}

# Thsi model takes the output of a given specification, and binds the estimated betas together by row.
beta_extract <- function(regression_series){
	coef_list <- lapply(regression_series, coef)
	start <- coef_list[[1]]
	J=length(coef_list)
	for(i in 2:J){
		start <- rbind(start, coef_list[[i]])}
	return(drop_intercept(start))
	}

# Set a count variable
count <- 0

# Label the rows of betas so we can tell which columns come from the same regression (for the cross-sectional analysis)
add_subscript <- function(beta_set){
	var_names <- colnames(beta_set)
	thing = paste(var_names, count, sep="_")
	count <<- count + 1
	return(thing)
	}


all_time_series <- lapply(list_of_models, ts_analysis, portfolios=pfs_25, factor='vc_returns')

# The full program part 1: give this function a factor to test and it will returns all model specifications, for cross-sectional analysis. 
merge_betas_for_factor <- function(this_factor, k=0){
	all_time_series <- lapply(list_of_models, ts_analysis, portfolios=pfs_25, factor=this_factor)
	start <- beta_extract(all_time_series[[1]])
	colnames(start) <- add_subscript(start)
	J = length(all_time_series)
	for(j in 2:J){
		betas_to_bind <- beta_extract(all_time_series[[j]])
		colnames(betas_to_bind) <- add_subscript(betas_to_bind)
		start <- cbind(start, betas_to_bind)
	}
	return(start)
	}

t <- ts_analysis(factor='vc_returns')

cs <- merge_betas_for_factor('vc_returns')

# The full program; give it a list of factors and it will return a cross-sectional dataset to run regressions on.
all_cs_results <- function(list_of_factors){
	start <- merge_betas_for_factor(list_of_factors[0])
	m <- 1
	J = length(list_of_factors)
	for(j in 2:J ){
		start <- cbind(start, merge_betas_for_factor(list_of_factors[j], k=m))
		m <- m + 1	
	}
	return(start)
	}

all_cs <- all_cs_results(candidate_factors)
cs_data_less_means <- data.frame(all_cs)
cs_data <- cbind(pfs25_means, cs_data_less_means)

write.dta(cs_data, file="cs_data.dta")
write(cs_data, file="cs_data")
