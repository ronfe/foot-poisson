import numpy as np 
import csv
import pandas as pd

def readMatches(fileName):
    reader = csv.reader(open(fileName, 'rb'))
    reader = list(reader)
    reader = np.array(reader)
    
    #get teams list
    teamsH = reader[:,0]
    teamsA = reader[:,1]
    teams = np.concatenate((teamsH, teamsA))
    teams = np.unique(teams)
    n = len(teams)
    g = len(reader)
    
    #construct league table dataframe
    teams = pd.Series(teams)
    zero = pd.Series(0, range(n))
    d = {
        'team': teams,
        'P': zero,
        'HW': zero,
        'HD': zero,
        'HL': zero,
        'HF': zero,
        'HA': zero,
        'AW': zero,
        'AD': zero,
        'AL': zero,
        'AF': zero,
        'AA': zero,
        'GD': zero,
        'Points': zero
    }
    T = pd.DataFrame(d)
    
    #rearrange the columns order to put teams to the primary position
    cols = ['team', 'P', 'HW', 'HD', 'HL', 'HF', 'HA', 'AW', 'AD', 'AL', 'AF', 'AA', 'GD', 'Points']
    T = T[cols]
    
    #calculate league table
    #convert home and away score to integer
    homeScore = reader[:,2]
    homeScore = homeScore.astype(np.integer)
    awayScore = reader[:,3]
    awayScore = awayScore.astype(np.integer)
    
    for i in range(1, g):
        if homeScore[i] > awayScore[i]:
            T.loc[(T['team'] == reader[i,0]), 'Points'] += 3
            T.loc[(T['team'] == reader[i,0]), 'HW'] += 1
            T.loc[(T['team'] == reader[i,1]), 'AL'] += 1
        elif homeScore[i] == awayScore[i]:
            T.loc[(T['team'] == reader[i,0]), 'Points'] += 1
            T.loc[(T['team'] == reader[i,1]), 'Points'] += 1
            T.loc[(T['team'] == reader[i,0]), 'HD'] += 1
            T.loc[(T['team'] == reader[i,1]), 'AD'] += 1
        else:
            T.loc[(T['team'] == reader[i,1]), 'Points'] += 3
            T.loc[(T['team'] == reader[i,1]), 'AW'] += 1
            T.loc[(T['team'] == reader[i,0]), 'HL'] += 1
            
        T.loc[(T['team'] == reader[i,0]), 'P'] += 1
        T.loc[(T['team'] == reader[i,1]), 'P'] += 1
        T.loc[(T['team'] == reader[i,0]), 'HF'] += homeScore[i]
        T.loc[(T['team'] == reader[i,0]), 'HA'] += awayScore[i]
        T.loc[(T['team'] == reader[i,1]), 'AF'] += awayScore[i]
        T.loc[(T['team'] == reader[i,0]), 'GD'] += (homeScore[i] - awayScore[i])
        T.loc[(T['team'] == reader[i,1]), 'GD'] += (awayScore[i] - homeScore[i])

    T = T.sort(['Points', 'GD'], ascending=[0,0])
    T.index = pd.Series(range(1, n+1))
    return T


fileName = '/home/ronfe/funcoding/foot-poisson/matches.csv'
S = readMatches(fileName)
print S