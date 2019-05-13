# Colors
almost_white <- "#fffff8"
light_grey <- "#58585b"
og_blue <- "#00A7E0"
og_green <- "#81BC41"
og_orange <- "#F18A20"

# Palette (length 10)
og_pal <- c("#148CBE", "#19A7E1", "#37C9FF", "#E4831E", "#FF9321", "#FFB04D", "#9E9E9E", "#BBBBBB", "#DCDCDC")

# Define theme
theme_og <- function() {
  theme(plot.background =
          element_rect(fill = almost_white,
                       colour = almost_white,
                       size = 0.5,
                       linetype = "solid"),
        plot.margin = unit(c(1, 1, 0.5, 0.5), "lines"), 
        axis.line = element_line(colour = og_blue,
                                 size = 1.1),
        panel.background =
          element_rect(fill = almost_white,
                       colour = almost_white,
                       size = 0.5,
                       linetype = "solid"),
        panel.grid.major = element_line(colour = light_grey,
                                        size = 0.08),
        panel.grid.minor = element_line(colour = light_grey,
                                        size = 0.08),
        legend.box.background =
          element_rect(fill = almost_white,
                       colour = almost_white,
                       linetype = "solid"), 
        axis.ticks = element_blank(),
        axis.text = element_text(family = "Arial", size = 10),
        axis.title.x = element_text(family = "Arial", size = 12,
                                    margin = margin(t = 10, r = 0, b = 0, l = 0),
                                    colour = light_grey),
        axis.title.y = element_text(family = "Arial", size = 12,
                                    margin = margin(t = 0, r = 15, b = 0, l = 0),
                                    colour = light_grey),
        strip.text.x = element_text(size = 10, 
                                    colour = light_grey),
        strip.background = element_rect(fill = almost_white, colour = almost_white),
        text = element_text(family = "Arial",
                            size = 12), 
        legend.text = element_text(family = "Arial", size = 10,
                                   colour = light_grey),
        legend.title = element_text(family = "Arial", size = 12,
                                    colour = light_grey),
        legend.background = element_rect(fill = almost_white,
                                         colour = almost_white,
                                         linetype = "solid"),
        legend.key = element_rect(fill = almost_white,
                                  colour = almost_white,
                                  linetype = "solid"),
        plot.title = element_text(colour = light_grey,
                                  hjust = 0.5,
                                  face = 'bold',
                                  size = 15))
}
