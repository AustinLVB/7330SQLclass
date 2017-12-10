#Importing libraries
import nump as np
import pandas as pd
import matplotlib.pyplt as plt
%matplotlib inline
import seaborn as sns
import re

#Histogram 
Salary['Salary'].plot.hist(bins=50, color='blue', alpha=0.65)

#2010 Density Plot
Salary['Salary'].plot.density(color='green')

#Printing median and mean
print("Average median salaries for White House staff in 2010:",
  "$"+str(Salary[Salary''.median()))
print(Average mean salaries for White House staff in 2010:",
  "$"str(Salary[Salary'].mean())))
  
  

