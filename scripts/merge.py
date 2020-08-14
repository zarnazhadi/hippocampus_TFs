import os
os.getcwd()

import pandas as pd 

tfs = pd.read_csv("/Users/zarnazhadi/Desktop/hippocampus_TFs/TF.csv", sep= '\t', header=0) 
tfs.head()

print(type(tfs)) # <class 'pandas.core.frame.DataFrame'>

# first 10 rows only 
#exp_rows_small = pd.read_csv("/Users/zarnazhadi/Desktop/hippocampus_TFs/RNA_seq.txt", sep= '\t', header= 2, nrows= 10)
#print(exp_rows_small.head())

# first 3 columns only
fields = ['Name', 'Description']
exp_col = pd.read_csv("/Users/zarnazhadi/Desktop/hippocampus_TFs/RNA_seq.txt", sep= '\t', header= 2, usecols=fields)

# See content in 'Name'
print(exp_col.Name)

exp_col.head()

# add emsembl column
exp_col['Ensembl'] = exp_col['Name'].str[0:-2]
exp_col

# inner join on ensembl
merged_inner = pd.merge(left=exp_col, right=tfs, left_on='Ensembl', right_on='Ensembl')

# sort by ensembl
tfs_ensembl_sort = tfs.sort_values('Ensembl')
tfs_ensembl_sort

# check for duplicates
tfs.duplicated(subset='Ensembl', keep='first') # no duplicates
exp_col.duplicated(subset='Ensembl', keep='first') # no duplicates