
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# setwd('~/Coursera/09_developing_products/project_prestige/')
# options(shiny.deprecation.messages=FALSE)

library(shiny)
require(ggplot2)

shinyUI(
 fluidPage(
  titlePanel("What jobs are respected in society?"),
  sidebarLayout(
    sidebarPanel(
      h3('Modify the plot'),
      tags$br(),
      selectInput('x', 'X axis', c("education", "income", "women"), selected = "education"),
      selectInput('size', 'Size of points', c("education", "income", "women"), selected = "women"),
      checkboxInput('label', 'Labels on/off')
      ),
    mainPanel(
      h3('Exploratory analysis of the data'),
      p('Here you can explore the 1971 Canadian census data from the ', code('car::Prestige'), ' dataset, containing information about 102 different occupations and the income, education, and prestige associated with each of them.'),
      strong('Questions:'),
      p('What trends do you notice between the prestige of an occupation and average educational level? Does the percentage of women in the occupation matter? What about the income, how closely does it correlate to prestige?'),
      p('Enjoy!'),
      plotOutput("distPlot"),
      tags$br(),
      strong('Relevant varibles:'),
      tags$ul(
        tags$li('Education -- Average education (years)'),
        tags$li('Income -- Average income (Canadian dollars, 1971 value)'),
        tags$li('Women -- Percentage of women in the occupation.'),
        tags$li('Prestige -- Pineo-Porter prestige score for occupation from a social survey conducted in the mid-1960s.')
      ), 
      tags$br(),

      tabPanel('Prestige', 
        dataTableOutput('mytable'))
      )
    )
  )
)

