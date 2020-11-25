#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(plotly)
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Covid 19 across space and time"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("mth_to",
                        "Months 2020:",
                        min = 1,
                        max = 11,
                        value = 6),
        
        p("The app visualizes the development of covid 19 in terms of cumulative incidence and deaths in countries over time.
        We use public data from January to November 2020. Death rates are calculated as the total number of Covid-19 deaths divided by the population number in year 2019, multiplied by 100.000. The cumulative incidence is calculated in the same manner.
        Use the radio button to vary the index date until which both detected cases and deaths are summarized over time."),
            ),

        # Show a plot of the generated distribution
        mainPanel(
            plotlyOutput("scatterPlot")
        )
    )
))
