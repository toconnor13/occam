# This project requires the following:

# The time series regressions.  Around 12 different variables need to be run on 4 different specifications, on 25 differend dependent variables.  SO around 12*4*25(1200) time series regressions in total.

# 1. Load the Factor Data.

rm(list=ls())

library("foreign")
library("AER")

factors <- read.dta("innovation_factors.dta")

pfs_25 = names(factors)[18:42]

dep_vars = paste('lm', pfs_25, sep='_')

orig_formula <- sl ~ mktrf + hml + smb

new_formula <- lapply(pfs_25, function(x, orig = orig_formula) {
	new = reformulate(".", x)
	update(orig, new)})

dep_vars <- lapply(new_formula, lm, data=factors)
