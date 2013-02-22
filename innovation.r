# This project requires the following:

# The time series regressions.  Around 12 different variables need to be run on 4 different specifications, on 25 differend dependent variables.  SO around 12*4*25(1200) time series regressions in total.

# 1. Load the Factor Data.

rm(list=ls())

library("foreign")
library("AER")

factors <- read.dta("innovation_factors.dta")
N <- length(factors$vc_returns)
factors$vc_returns_l1 <- c(NA, factors$vc_returns[1:(N-1)])

candidate_factors <- c(names(factors)[6:17], "vc_returns_l1")

pfs_25 = names(factors)[18:42]
ind_10 = names(factors)[43:54]
mom_12 = names(factors)[55:64]

capm_model <- sl ~ mktrf
hml_model <- sl ~ mktrf + hml
smb_model <- sl ~ mktrf + smb
ff3f_model <- sl ~ mktrf + hml + smb

pfs_25_matrix <- as.matrix(factors)[,18:42]

pfs25_means <- colMeans(pfs_25_matrix)

list_of_models <- c(capm_model, hml_model, smb_model, ff3f_model)

change_dep_var <- function(new_dep_var, model) {
	new = reformulate(".", new_dep_var)
	update(model, new)}

add_ind_var <- function(new_var, model){
	new = reformulate(c('.', new_var))
	update(model, new)
}

ts_analysis <- function(portfolios=pfs_25, formula=hml_model, factor=NULL){
	this_formula <- formula
	if(!missing(factor)){
	this_formula <- add_ind_var(factor, formula)
	}


	model_list <- lapply(portfolios, change_dep_var, this_formula)
	lapply(model_list, lm, data=factors)}


drop_intercept <- function(data){
	colnames(data)[1] <- 'intercept'
	data_2 <- subset(data, select=-c(intercept))
	return(data_2)
	}


beta_extract <- function(regression_series){
	coef_list <- lapply(regression_series, coef)
	start <- coef_list[[1]]
	J=length(coef_list)
	for(i in 2:J){
		start <- rbind(start, coef_list[[i]])}
	return(drop_intercept(start))
	}

count <- 0

add_subscript <- function(beta_set){
	var_names <- colnames(beta_set)
	thing = paste(var_names, count, sep="_")
	count <<- count + 1
	return(thing)
	}


all_time_series <- lapply(list_of_models, ts_analysis, portfolios=pfs_25, factor='vc_returns')

# this function can only take betas from a given set of portfolios.  The number/type of factors shouldn't matter.
merge_betas_for_factor <- function(this_factor, k=0){
	all_time_series <- lapply(list_of_models, ts_analysis, portfolios=pfs_25, factor=this_factor)
	start <- beta_extract(all_time_series[[1]])
	colnames(start) <- add_subscript(start)
#	k <- k+1
	J = length(all_time_series)
	for(j in 2:J){
		betas_to_bind <- beta_extract(all_time_series[[j]])
		colnames(betas_to_bind) <- add_subscript(betas_to_bind)
#		k <- k+1
#		count <<- count + 1
		start <- cbind(start, betas_to_bind)
	}
	return(start)
	}




t <- ts_analysis(factor='vc_returns')

cs <- merge_betas_for_factor('vc_returns')

# Merge all betas for different factors

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
