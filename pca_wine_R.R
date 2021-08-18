#import file
Data = read.csv(choose.files())
#first we perform PCA
attach(Data)
#apply pca
pcaWine <- princomp(Data, cor = TRUE, scores = TRUE, covmat = NULL)
str(pcaWine)
summary(pcaWine)

loadings(pcaWine)

plot(pcaWine) # graph showing importance of principal components 

biplot(pcaWine)

plot(cumsum(pcaWine$sdev * pcaWine$sdev) * 100 / (sum(pcaWine$sdev * pcaWine$sdev)), type = "b")

pcaWine$scores
pcaWine$scores[, 1:3]

# Top 3 pca scores 
final <- cbind(Data[,0], pcaWine$scores[, 1:3])
View(final)


# Scatter diagram
plot(final$Comp.1, final$Comp.2) # 1 & 2
plot(final$Comp.2, final$Comp.3) # 2 & 3

#apply Euclidean method and ploat endrogram

distInsData <- dist(final, method = "euclidean")
clusterData <- hclust(distInsData, method = "complete")

plot(clusterData, hang = -1)

groupData <- cutree(clusterData, k = 4)
rect.hclust(clusterData, k = 4, border = 'red')

#k - Means clustering scree plot
normalized_data <- scale(final[, 1:3])

install.packages("animation")
library(animation)

twss <- NULL
for (i in 1:3) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

plot(1:3, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")
