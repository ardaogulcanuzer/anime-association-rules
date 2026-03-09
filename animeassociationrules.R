library(data.table)
library(dplyr)
library(arules)
library(arulesViz)
knitr::opts_chunk$set(echo = TRUE)

anime  <- fread("anime.csv")
rating <- fread("rating.csv")

anime[, name := gsub("&#039;", "'", name, fixed = TRUE)]
anime[, name := gsub("&amp;", "&", name, fixed = TRUE)]

top200 <- anime[order(-members)][1:200, .(anime_id, name, members)]

liked <- rating[rating >= 8]
liked <- merge(liked, top200[, .(anime_id, name)], by = "anime_id")
liked <- unique(liked, by = c("user_id", "name"))

baskets <- liked[, .(items = list(unique(name))), by = user_id]
baskets <- baskets[lengths(items) >= 2]

trans <- as(baskets$items, "transactions")
summary(trans)
itemFrequencyPlot(trans, topN = 20, type = "absolute")

rules <- apriori(
  trans,
  parameter = list(
    supp = 0.006,
    conf = 0.60,
    minlen = 2,
    maxlen = 5,
    target = "rules"
  )
)
rules <- subset(rules, lift > 1.2)
rules <- rules[!is.redundant(rules)]

rules_1lhs <- subset(rules, size(lhs(rules)) == 1)
top_lift <- sort(rules_1lhs, by = "lift", decreasing = TRUE)
inspect(head(top_lift, 10))

top_conf <- sort(rules_1lhs, by = "confidence", decreasing = TRUE)
inspect(head(top_conf, 10))

plot(head(top_lift, 15), method="graph", engine="htmlwidget")
