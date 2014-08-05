import pandas as pd
import random
import numpy as np
from scipy import stats
from matplotlib import pyplot as plt

n = 10000

corr=[]
for r in  [2, 3, 5, 10]:
    corrs=[]
    for i in range(0,int(n/10)):
        # generate uncontaminated values
        group1 = np.asarray([(random.normalvariate(1,1)) for i in range(0,20)])
        # generate nuisance contamination
        cont1 = np.asarray([(random.normalvariate(1.4,1)) for i in range(0,20)]) / r
        coef,p = stats.pearsonr(group1+cont1,cont1)
        corrs.append(coef)    
    corr.append(np.median(corrs))

corrvals = [round(i*i*100) for i in corrvals]
print(corrvals)

clean = []
cont = []
test = []
for r in [2, 3, 5, 10]:
    print(r)
    contp=[]
    cleanp=[]
    testp = []
    for i in range(0,n):
        # generate uncontaminated values
        group1 = np.asarray([(random.normalvariate(1,1)) for i in range(0,20)])
        group2 = np.asarray([(random.normalvariate(1,1)) for i in range(0,20)])

        # generate nuisance contamination
        cont1 = np.asarray([(random.normalvariate(0.4,1)) for i in range(0,20)])
        cont2 = np.asarray([(random.normalvariate(0,1)) for i in range(0,20)])

        t,p1 = stats.ttest_ind(group1,group2)
        t,p2 = stats.ttest_ind(group1+cont1/r,group2+cont2/r)
        t,p3 = stats.ttest_ind(cont1,cont2)

        cleanp.append(p1)
        contp.append(p2)
        testp.append(p3)

    clean.append(cleanp)
    cont.append(contp)
    test.append(testp)


df = pd.DataFrame()

df["conts"] = cont[0] + cont[1] + cont[2] + cont[3]
df["tests"] = test[0] + test[1] + test[2] + test[3]
df['cleans'] = clean[0] + clean[1] + clean[2] + clean[3]
df['exps'] = list(np.repeat(1,n)) + list(np.repeat(2,n)) + list(np.repeat(3,n)) + list(np.repeat(4,n))

df['Result'] = ['Irrelevant' if ((df.loc[i,'conts']  < 0.05) and (df.loc[i,'cleans'] < 0.05)) or ((df.loc[i,'conts']  > 0.05) and (df.loc[i,'cleans'] > 0.05))
                                   else 'Detected surplus positive' for i in range(0,len(df))]

df['Result'] = ['Nondetected surplus positive' if df.loc[i,'conts']  < 0.05 and 
                                      df.loc[i,'cleans'] > 0.05 and 
                                      df.loc[i,'tests']  > 0.05
                                   else df.loc[i,'Result'] for i in range(0,len(df))]

df['Result'] = ['Nondetected surplus negative' if df.loc[i,'conts']  > 0.05 and 
                                      df.loc[i,'cleans'] < 0.05 and 
                                      df.loc[i,'tests']  > 0.05 
                                   else df.loc[i,'Result'] for i in range(0,len(df))]

df['NuisanceTest'] = ['Rejected' if df.loc[i,'tests']  < 0.05 
                        else "Not Rejected" for i in range(0,len(df))]

df['UncontaminatedExperimentalTest'] = ['Rejected' if df.loc[i,'cleans']  < 0.05 
                        else "Not Rejected" for i in range(0,len(df))]

df['Correlation'] = [str(corrvals[i-1]) + '% variance explained by parameter' for i in df.exps]

df.to_csv('simul.csv')

for i in df:
    outs[i] = 