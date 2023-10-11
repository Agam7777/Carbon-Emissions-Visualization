library(shiny)
library("plotly")

ui <- fluidPage(
  navbarPage("CO2 Emission Trends",
             tabPanel(title = "Introduction",
               h2("Description of the assignment", align = "center"),
               hr(),
               p("For this assignment we are tasked to work with a dataset
                 regarding carbon dioxide (CO2) emissions and find patterns and
                 trends emerging in it. With those trends we have to examine
                 certain key variables and present their values in the form of
                 an interactive chart. The variables that I found interesting
                 was the contribution of oil, coal, and gas based production of
                 CO2 emissions all around the world, which is something I will
                 be analyzing in detail through creating an interactive chart
                 about it.", style = "font-size:17px;"),
                
               br(),
               h3("5 Key Variables:"),
               
               p("1) The first value I calulcated was the year when gas based
                 production of co2 emissions was at its peak and the year was 
                 :", textOutput("first_var", inline = T),
                 style = "font-size:16px;"),
               
               p("2) Next I found the value of USA having the biggest percentage
                 of share in the global co2 emission production and the value
                 that came as a result of the calculation was : ",
                 textOutput("second_var", inline = T), "%",
                 style = "font-size:16px;"),
               
               p("3) As a result of the shocking result of the previous value, I
                 was interested to know the year when USA had the biggest
                 percentage of share in the global co2 emission production, and
                 the year happened to be: ", textOutput("third_var", inline = T),
                 style = "font-size:16px;"),
               
               p("4) After that I was curious about the continent which was 
                 responsible for the most consumption based co2 emissions in the
                 world, and ", textOutput("forth_var", inline = T), "was the
                 continent that fit that description unsurprisingly",
                 style = "font-size:16px;"),
               
               p("5) Lastly I decided to calculate which among oil, gas, and
                 coal on average had the highest global share in terms of
                 producing the most co2 emissions, and resource that ended up
                 being the answer was: ", textOutput("fifth_var", inline = T),
                 style = "font-size:16px;"),
              
             ),
             tabPanel(title = "Resource CO2 Emissions",
               h2("Oil, Gas, and Coal Contribution towards production based CO2
                  emissions", align = "center"),
               hr(),
               
               sidebarLayout(
                 sidebarPanel(
                   radioButtons(
                     inputId = "category",
                     label = "Select the type of resource:",
                     choices = c("Oil",
                                 "Gas",
                                 "Coal"),
                     selected = "Oil"),
                   selectInput(
                     inputId = "colorchoice",
                     label = "Select a color",
                     multiple = FALSE,
                     choices = c("Red",
                                 "Blue",
                                 "Green",
                                 "Orange"),
                     selected = "Red"),
                 width = 3),
                 mainPanel(
                   plotlyOutput(outputId = "scatterplot"),
                   p("This interactive chart lets the user choose the type of
                     resource they would like to analyze and see trends of it
                     since the year 1882 along with being able to pick the color
                     they would like to see the scatter plot in. I specifically
                     chose to analyze the data since 1882 because that is the
                     year that the dataset included values for all 3 types of
                     resources regarding the production-based CO2 emissions. The
                     reason I decided to create and include this visualization
                     is to let the users know which among these 3 abundantly
                     found resources is doing the most damage to us and our
                     environment. Given the recent urge among people to save
                     the environment by reducing CO2 emissions, this can be a
                     really useful information and can be used as a tool to see
                     whether we are improving each passing year or getting
                     worse. For example, the chart indicates that all 3
                     resources produced more CO2 emissions in 2019 than they
                     did in 2020 which is a positive sign that one could infer
                     after observing the chart.", style = "font-size:16.5px;")
                 ),
               ),
              
             ),
  )
)
