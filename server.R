
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://www.rstudio.com/shiny/
#

library(shiny)
require(ggplot2)
data <- car::Prestige
data$type <- plyr::revalue(data$type, c("bc"="Blue Collar", "wc"="White Collar", 'prof'="Professional"))
data$occupation <- rownames(data)

label_women <- 'Percentage of women'
label_education <- 'Level of education'
label_income <- 'Income'

shinyServer(
  function(input, output) {

    output$mytable <- renderDataTable({data}) 
    output$distPlot <- reactivePlot(function() {

      label_x <- ifelse(input$x=='education', label_education, 
        ifelse(input$x=='women', label_women, label_income))

      label_size <- ifelse(input$size=='education', label_education, 
        ifelse(input$size=='women', label_women, label_income))

      gg <- ggplot(data, aes_string(x=input$x, y='prestige', label='occupation')) + 
        geom_point(aes_string(size=input$size, color='type')) + 
        theme_bw() + scale_colour_brewer(palette="Dark2", name="Type of occupation") + 
        scale_size_continuous(name=label_size) +
        labs(x=label_x, y="Occupation prestige")
      

      if (input$label)
        gg <- gg + geom_text(size=3)

      print(gg)


    }) #, height=500

  }
)
