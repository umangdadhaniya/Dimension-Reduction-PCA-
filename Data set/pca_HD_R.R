
#import file
data = read.csv(choose.files())
#first we perform PCA
attach(data)
#apply pca
pcaHd <- princomp(data, cor = TRUE, scores = TRUE, covmat = NULL)
str(pcaHd)
summary(pcaHd)

loadings(pcaHd)

plot(pcaHd) # graph showing importance of principal components 

biplot(pcaHd)

plot(cumsum(pcaHd$sdev * pcaHd$sdev) * 100 / (sum(pcaHd$sdev * pcaHd$sdev)), type = "b")

pcaHd$scores
pcaHd$scores[, 1:6]

# Top 6 pca scores 
final <- cbind(data[,0], pcaHd$scores[, 1:6])
View(final)


# Scatter diagram
plot(final$Comp.1, final$Comp.2) # 1 & 2
plot(final$Comp.2, final$Comp.3) # 2 & 3


#apply Euclidean method and ploat endrogram

distInsData <- dist(data, method = "euclidean")
clusterData <- hclust(distInsData, method = "complete")

plot(clusterData, hang = -1)

groupData <- cutree(clusterData, k = 6)
rect.hclust(clusterData, k = 4, border = 'red')
data <- as.matrix(groupData)
finalData <- data.frame(data, insuranceData)

# write to file
write.csv(finalData, "insurance.csv")

aggregate(finalData, list(finalData$data), mean)


#k - Means clustering scree plot
normalized_data <- scale(final[, 1:6])

install.packages("animation")
library(animation)

twss <- NULL
for (i in 1:6) {
  twss <- c(twss, kmeans(normalized_data, centers = i)$tot.withinss)
}
twss

plot(1:6, twss, type = "b", xlab = "Number of Clusters", ylab = "Within groups sum of squares")
title(sub = "K-Means Clustering Scree-Plot")