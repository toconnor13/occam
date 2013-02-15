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

orig_formula <- sl ~ mktrf + hml + smb

create_models <- function(x, orig) {
	new = reformulate(".", x)
	update(orig, new)}

# Create the Standard Fama-French three factor model
ff_formula <- lapply(pfs_25, create_models, orig=orig_formula)
		     

# Run the 25 FF time series regression

dep_vars <- lapply(ff_formula, lm, data=factors)
