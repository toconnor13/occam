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

dep_vars = paste('lm', pfs_25, sep='_')

model1 <- sl ~ mktrf + hml + smb
model1 <- sl ~ mktrf
model2 <- sl ~ mktrf + hml
model3 <- sl ~ mktrf + smb
model4 <- sl ~ mktrf + hml + smb

change_dep_var <- function(x, orig) {
	new = reformulate(".", x)
	update(orig, new)}

add_ind_var <- function(x, model){
#	new = reformulate(c())
}

ts_analysis <- function(portfolios, formula){
#	dep_vars <- paste('lm', portfolios, sep="_")
	model_list <- lapply(portfolios, create_models, formula)
	lapply(model_list, lm, data=factors)}



# Create the Standard Fama-French three factor model
# ff_formula <- lapply(pfs_25, create_models, orig=orig_formula)
		     

# Run the 25 FF time series regression

# dep_vars <- lapply(ff_formula, lm, data=factors)
