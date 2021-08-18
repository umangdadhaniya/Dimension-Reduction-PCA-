import pandas as pd 
import numpy as np

Hd1 = pd.read_csv(r"C:\Users\UMANG\OneDrive\Desktop\heart disease.csv")
Hd1.describe()


Hd = Hd1.drop(["age"], axis = 1)

from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
from sklearn.preprocessing import scale 

# Considering only numerical data 
#uni.data = uni.iloc[:, 1:]

# Normalizing the numerical data 
Hd_normal = scale(Hd)
Hd_normal

pca = PCA(n_components = 13)
pca_values = pca.fit_transform(Hd_normal)

# The amount of variance that each PCA explains is 
var = pca.explained_variance_ratio_
var

pca.components_
pca.components_[0]
# Cumulative variance 

var1 = np.cumsum(np.round(var, decimals = 4) * 100)
var1

# Variance plot for PCA components obtained 
plt.plot(var1, color = "Blue")

# PCA scores
pca_values

pca_data = pd.DataFrame(pca_values)
pca_data.columns = "comp0", "comp1", "comp2", "comp3", "comp4", "comp5","comp6", "comp7", "comp8", "comp9", "comp10", "comp11","comp12"
final = pd.concat([Hd1.age, pca_data.iloc[:, 0:10]], axis = 1)

# Scatter diagram
import matplotlib.pylab as plt
plt.scatter(x = final.comp1, y = final.comp2)
