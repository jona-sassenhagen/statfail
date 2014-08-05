import pandas as pd
from scipy import stats
import numpy as np
pd.set_option('display.width', 180)

with open("/Users/jona/Dropbox/manuscripts/statfail/data/Sheet 1-Table 1.csv") as file:
    df1 = pd.read_csv(file)

with open("/Users/jona/Dropbox/manuscripts/statfail/data/Sheet 2-Table 1.csv") as file:
    df2 = pd.read_csv(file)

with open("/Users/jona/Dropbox/manuscripts/statfail/data/Sheet 3-Table 1.csv") as file:
    df3 = pd.read_csv(file)

df1.accept_null = [int(s) for s in df1.accept_null]

(sum(df1.inference)  + sum(df2.inference)  + sum(df3.inference) )/3
(sum(df1.descriptive)  + sum(df2.descriptive)  + sum(df3.descriptive) )/3
(sum(df1.accept_null) + sum(df2.accept_null)  + sum(df3.accept_null))/3

(sum(df1.inference) / sum(df1.descriptive) + sum(df2.inference) / sum(df2.descriptive) + sum(df3.inference) / sum(df3.descriptive))/3
(sum(df1.accept_null) / sum(df1.inference) + sum(df2.accept_null) / sum(df2.inference) + sum(df3.accept_null) / sum(df3.inference))/3
