# This project requires the following:

# The time series regressions.  Around 12 different variables need to be run on 4 different specifications, on 25 differend dependent variables.  SO around 12*4*25(1200) time series regressions in total.

# 1. Load the Factor Data.

rm(list=ls())

library("foreign")
library("AER")

factors <- read.dta("innovation_factors.dta")

pfs_25 = names(factors)[18:42]
ind_10 = names(factors)[43:54]
mom_12 = names(factors)[55:64]

ts(facotrs, start=1927, end=2011, frequency=1)

capm_model <- sl ~ mktrf
hml_model <- sl ~ mktrf + hml
smb_model <- sl ~ mktrf + smb
ff3f_model <- sl ~ mktrf + hml + smb

change_dep_var <- function(new_dep_var, model) {
	new = reformulate(".", new_dep_var)
	update(model, new)}

add_ind_var <- function(new_var, model){
	new = reformulate(c(new_var, '.'))
	update(model, new)
}

ts_analysis <- function(portfolios, formula, factor=NULL){
	this_formula <- formula
	if(!missing(factor)){
	this_formula <- add_ind_var(factor, formula)
	}


	model_list <- lapply(portfolios, change_dep_var, this_formula)
	lapply(model_list, lm, data=factors)}




