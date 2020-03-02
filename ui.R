library(shiny)


shinyUI(
  pageWithSidebar(
    headerPanel(h4("This app will help you to control the goods of your Pizzeria")
    ),
    sidebarPanel(
      p("In this place you will enter the material received for your stock"),
      fluidRow( column(5,numericInput("flour", label = h5("Flour"), value = 0),offset = 1), 
                column(5,numericInput("ham", label = h5("Ham"), value = 0) ,offset = 0)),
      fluidRow( column(5,numericInput("cheese", label = h5("Cheese"), value = 0),offset = 1), 
                column(5,numericInput("egg", label = h5("Egg"), value = 0) ,offset = 0)),
      fluidRow( column(5,numericInput("bacon", label = h5("Bacon"), value = 0),offset = 1), 
                column(5,numericInput('tomato', label = h5('Tomato'), value = 0) ,offset = 0)),
      fluidRow( column(5,numericInput("olive", label = h5("Olive"), value = 0),offset = 1), 
                column(5,numericInput('onion', label = h5('Onion'), value = 0) ,offset = 0)),
      fluidRow( column(5,numericInput("salami", label = h5("Salami"), value = 0),offset = 1)
                ),
      
      
      fluidRow( column(5, actionButton("addValues", "Confirm values!"), offset = 1),
                column(5, actionButton("plusTen", "+10!"),offset = 1)),
      p(""),
      
      fluidRow( column(5, actionButton("fillValues", "Fill Stock!"),offset = 1),
                column(5, actionButton("clearValues", "Clear stock!"),offset = 1)),

      h6(strong("The goods in stock are limited from 0 to 500, the values will be forced to 
      closest boundary edges in case of trespass limits."), align = "justify")
      
      ),
      
      mainPanel (
        div(
          h3("In this area you can register your sales", align = "center"),
            fluidRow( column(2,numericInput("pepperoni", label="Pepperoni", value = 0),offset = 0), 
                      column(2,numericInput("marguerita", label="Marguerita",value = 0) ,offset = 0),
                      column(2,numericInput("mozzarela", label="Mozzarela",value = 0) ,offset = 0),
                      column(2,numericInput("meat", label="Meat",value = 0) ,offset = 0),
                      align = "center"),
            
            fluidRow( column(2, actionButton("receipt1", "Confirm!"),offset = 0),
                      column(2, actionButton("receipt2", "Confirm!"),offset = 0),
                      column(2, actionButton("receipt3", "Confirm!"),offset = 0),
                      column(2, actionButton("receipt4", "Confirm!"),offset = 0),
                      align = "center"),
          
            fluidRow( column(2, textOutput("recp1_status"),offset = 0),
                      column(2, textOutput("recp2_status"),offset = 0),
                      column(2, textOutput("recp3_status"),offset = 0),
                      column(2, textOutput("recp4_status"),offset = 0),
                      align = "center")
        ),
        div(
          h3("This shows your stock area", align = "center"),
          plotOutput("stock_graph",height = 400)
        ),
        
        div(
          h3("Manual available at:", align = "center"),
          a("https://rpubs.com/bergojr/580400")
        )
      )
    )
  )