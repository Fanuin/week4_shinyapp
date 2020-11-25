library(readr)
library(dplyr)
library(plotly)
library(shiny)


#data derived from https://github.com/GoogleCloudPlatform/covid-19-open-data
data_in <- as.data.frame(read_csv("GoogleBQ_reg_month_pop.csv"))

#add country code:
library(countrycode)
data_in$continent <- countrycode(sourcevar = data_in[, "countries_and_territories"],
                                 origin = "country.name",
                                 destination = "region")


#shiny
# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$scatterPlot <- renderPlotly({

         data_plot <- data_in %>%  
            filter(month <= input$mth_to) %>% #mth_to is input
            filter(!is.na(continent)) %>%
            group_by(countries_and_territories, continent, pop_data_2019) %>%
            summarise(cov19_cases_new=sum(new_confirmed_cases),cov19_decsd_new=sum(new_daily_deaths)) %>%
            mutate(cov19_cases_new_rel=cov19_cases_new/pop_data_2019*100000, cov19_decsd_new_rel=cov19_decsd_new/pop_data_2019*100000)
          
        plot_ly(data_plot, x = ~cov19_cases_new_rel, y = ~cov19_decsd_new_rel, type="scatter", color = ~continent,
                 mode = 'markers', hoverinfo = 'text',text = ~paste('</br> Country: ', countries_and_territories)) %>% 
            layout(xaxis = list(title="cumulative incidence rate per 100.000 people"), yaxis = list(title="cumulative death rate per 100.000 people"))

    })

})
