library("shiny")
library("dplyr")
library("plotly")

# Loading the dataframe to work with
co2_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# Calculations for the 5 values of interest:

# Finding the year where maximum co2 emission was produced due to gas:
by_year <- co2_df %>%
  group_by(year) %>%
  summarise(Sum_gas_co2 = sum(gas_co2, na.rm = T), Sum_oil_co2 = sum(oil_co2, na.rm = T), Sum_coal_co2 = sum(coal_co2, na.rm = T))

gas_max <- by_year %>%
  filter(Sum_gas_co2 == max(Sum_gas_co2))%>%
  pull(year)


# Finding the value of USA having the biggest percentage of share in the global co2 emission production:

USA_df <- co2_df %>%
  filter(country == "United States")

US_max_share <- max(USA_df$share_global_co2)

# Finding the year when USA had the biggest share in the global co2 emission production:

US_max_share_year <- USA_df %>%
  filter(share_global_co2 == US_max_share) %>%
  pull(year)

# Finding which continent had the most consumption-based emission of co2:

by_country <- co2_df %>%
  group_by(country) %>%
  summarise(Consumption_CO2 = sum(consumption_co2, na.rm = T))

by_country <- by_country %>%
  filter(country != "World")

max_consumption_continent <- by_country %>%
  filter(Consumption_CO2 == max(Consumption_CO2)) %>%
  pull(country)

# Finding which among oil, gas, and coal on average has the highest global share in terms of producing the most co2 emissions:

oil_share <- mean(co2_df$share_global_oil_co2, na.rm = T)
gas_share <- mean(co2_df$share_global_gas_co2, na.rm = T)
coal_share <- mean(co2_df$share_global_coal_co2, na.rm = T)

max_share <- ""

if (oil_share > gas_share & oil_share > coal_share){
  max_share <- "oil"
} else if (gas_share > oil_share & gas_share > coal_share) {
  max_share <- "gas"
} else {
  max_share <- "coal"
}
# Chart calculations:

chart_based_df <- co2_df%>%
  filter(country == "World" & year > 1881) %>%
  select(year, oil_co2, gas_co2, coal_co2)
chart_based_df[is.na(chart_based_df)] <- 0


server <- function(input, output) {
  
  output$first_var <- renderText({
    paste(gas_max)
  })
  
  output$second_var <- renderText({
    paste(US_max_share)
  })
  
  output$third_var <- renderText({
    paste(US_max_share_year)
  })
  
  output$forth_var <- renderText({
    paste(max_consumption_continent)
  })
  
  output$fifth_var <- renderText({
    paste(max_share)
  })
  
  oil_plot <- plot_ly(data = chart_based_df,
                      x = ~year,
                      y = ~oil_co2,
                      type = "scatter",
                      mode = "markers",
                      marker = list(size = 5, color = ~input$colorchoice)) %>%
    layout(title = "CO2 emissions produced by Oil since 1882", xaxis = list(title = "Year"), 
           yaxis = list(title = "Emissions of C02 by Oil (Million Tonnes)"))
    
  
  gas_plot <- plot_ly(data = chart_based_df,
                      x = ~year,
                      y = ~gas_co2,
                      type = "scatter",
                      mode = "markers",
                      marker = list(size = 5, color = ~input$colorchoice)) %>%
    layout(title = "CO2 emissions produced by Gas since 1882", xaxis = list(title = "Year"), 
           yaxis = list(title = "Emissions of C02 by Gas (Million Tonnes)"))

    
  coal_plot <- plot_ly(data = chart_based_df,
                       x = ~year,
                       y = ~coal_co2,
                       type = "scatter",
                       mode = "markers",
                       marker = list(size = 5, color = ~input$colorchoice)) %>%
    layout(title = "CO2 emissions produced by Coal since 1882", xaxis = list(title = "Year"), 
           yaxis = list(title = "Emissions of C02 by Coal (Million Tonnes)"))
                       
    
    
  
  
  output$scatterplot <- renderPlotly({
    if (input$category == "Oil") {
      oil_plot
    } else if (input$category == "Gas") {
      gas_plot
    } else {
      coal_plot
    }
  })

}