library(ggplot2)

df <- read.table(file = "C2-tabu-even.csv", sep = ",", skip = 7)
df6 <- read.table(file = "C2-tabu-even-600.csv", sep = ",", skip = 7)

colnames(df) <- c("run", "demand", "tabu", "step", "area_start", "area_end", "disutility", "security")
df$security2 <- ifelse(df$security < 100, "insecure", "secure") 
df$linie <- as.factor(1)

colnames(df6) <- c("run", "demand", "tabu", "step", "area_start", "area_end", "disutility", "security")
df6$security2 <- ifelse(df6$security < 100, "insecure", "secure") 
df6$linie <- as.factor(2)

df <- subset(df, tabu == 4 | tabu == 8 | tabu == 12)
df6 <- subset(df6, tabu == 4 | tabu == 8 | tabu == 12)

p1 <- ggplot(data = df, aes(x = df$demand, y = df$disutility, colour = as.factor(tabu))) + 
  geom_point(size = 4, aes(shape = as.factor(df$security2))) +
  geom_line(size = 1.5, aes(linetype = df$linie)) +
  geom_point(data = df6, size = 4, aes(x = df6$demand, y = df6$disutility, shape = as.factor(df6$security2))) +
  geom_line(data = df6, size = 1.5, aes(x = df6$demand, y = df6$disutility, linetype = df6$linie)) + 
  ggtitle("(d) Even distribution") +
  labs(x = "Household power demand [MWh]", 
       y = "Number of occupied grid cells [-]",
       color = "Tabu radius [CU]", 
       shape = "", 
       linetype = "") + 
  coord_cartesian(ylim = c(0, 5300)) +
  scale_x_continuous(breaks = seq(2, 16, by = 2)) +
  scale_y_continuous(breaks = seq(0, 6000, by = 1000)) +
  scale_shape_manual(values = c(15, 19)) +
  scale_color_manual(values = c("#fd8d3c", "#31a354", "#2c7bb6")) +
  scale_linetype_manual(values = c(1, 3), 
                        labels = c(expression(paste(r[wind], "= 300")), 
                                   expression(paste(r[wind], "= 600")))) +
  theme_classic() + 
  theme(plot.title = element_text(size = 26, face = "bold",  hjust = 0.5), 
        plot.margin = margin(18, 5.5, 5.5, 5.5, "pt"),
        legend.position = "none",
        axis.text = element_text(colour = "black", size = 18), 
        axis.title = element_text(colour = "black", size = 20), 
        panel.grid.major.y = element_line(colour = "#e4e4e4", size = 0.1),
        panel.grid.minor.y = element_line(colour = "#e4e4e4", size = 0.1), 
        panel.border = element_rect(fill = NA, size = 1)) + 
  guides(shape = guide_legend(order = 2), col = guide_legend(order = 1)) +
  guides(shape = FALSE, linetype = FALSE)

ggsave(filename = "c2_tabu_even_d.pdf", device = "pdf",
       width = 16, height = 14, units = "cm")
p1
dev.off()
