# This app is "as simple as possible" emulator of a wharehouse stock of a pizzeria
# the main idea concerns in:
# - An area to receive the goods that will be added to stock.
# - A graph to indicate the level of each good.
# - An area for goods displacement acording to the pizza ordered, in this case
# acording to the hardcoded receipts, the goods are decreased from stock.

library(shiny)
library(UsingR)
library(ggplot2)

# This function is necessary to reduce the verbosity of code, otherwhise a simple variable
# update will take thi form e.g.: total_ham(total_ham() +as.numeric(input$flour))
# Also for the sake of demonstration , this function assure no negative os unbounded
# values. For sure In a real problem should be adopted more robust solution:

sumVal <- function(x,y){
  x(x()+y)
  if(x()>500){
    x(500)    
  }  else if (x()<0){
    x(0)
  }
}

# Again for the sake of simplicity in demonstration the receipts are hardcoded an
# the amount needed for each good depends on the number of each kind of pizza 
# ordered this multiplication is passed as an argument of function to update stock.

updateStock <- function (receipt){
  sumVal(total_flour,receipt[1])
  sumVal(total_ham, receipt[2])
  sumVal(total_cheese, receipt[3])
  sumVal(total_egg, receipt[4])
  sumVal(total_bacon, receipt[5])
  sumVal(total_tomato, receipt[6])
  sumVal(total_olive, receipt[7])
  sumVal(total_onion, receipt[8])
  sumVal(total_salami, receipt[9])
}


# This function check if there are good enough to order a Pizza.

checkStock <- function(receipt){
  return ((total_flour() > receipt[1]) &
       (total_ham() > receipt[2]) &
       (total_cheese() > receipt[3]) &
       (total_egg () > receipt[4]) &
       (total_bacon () > receipt[5]) &
       (total_tomato () > receipt[6]) &
       (total_olive() > receipt[7]) &
       (total_onion() > receipt[8]) &
       (total_salami() > receipt[9]))
  
}

# Initialization of reactive variables to represent each good. 
# It is worthy to note that was very difficult to handle structutures as data frames
# or array. If could be possible to use then, the code certainly would be more 
# legible and clean.

total_flour<- reactiveVal(0)
total_ham <- reactiveVal(0)
total_cheese <- reactiveVal(0)
total_egg <- reactiveVal(0) 
total_bacon <- reactiveVal(0) 
total_tomato <- reactiveVal(0) 
total_olive <- reactiveVal(0) 
total_onion <- reactiveVal(0) 
total_salami <- reactiveVal(0) 


# Hardcoded recipts of pizza.
# Ingredients (in order): flour, ham, cheese, egg, bacon, tomato, olive, onion, salami
receipts <- as.data.frame(cbind(c(10, 3, 2, 1, 1, 1, 0.5, 0.6, 5),  # Receipt for Pepperoni Pizza
                                c(10, 0, 4, 0, 0, 2, 1, 2, 0),  # Receipt for Marguerita Pizza
                                c(10, 0, 5, 0, 0, 2, 1, 2, 0),  # Receipt for Mozzarela Pizza
                                c(10, 2, 1, 1, 1, 1, 0.5, 0.6, 1))) # Receipt for Meat Pizza

names(receipts) <- c("pepperoni", "marguerita", "mozzarela","meat")



shinyServer(
  
  function(input, output) {
    
    # The amount displayed at sidebar input values are added to stock.
    observeEvent(
      input$addValues , {
        sumVal(total_flour, as.numeric(input$flour))
        sumVal(total_ham, as.numeric(input$ham))
        sumVal(total_cheese, as.numeric(input$cheese))
        sumVal(total_egg, as.numeric(input$egg))
        sumVal(total_bacon, as.numeric(input$bacon))
        sumVal(total_tomato, as.numeric(input$tomato))
        sumVal(total_olive, as.numeric(input$olive))
        sumVal(total_onion, as.numeric(input$onion))
        sumVal(total_salami, as.numeric(input$salami))
      }
    )
    
    # A shortcut to add resources in group of ten.
    observeEvent(
      input$plusTen , {
        sumVal(total_flour, 10)
        sumVal(total_ham, 10)
        sumVal(total_cheese, 10)
        sumVal(total_egg, 10)
        sumVal(total_bacon, 10)
        sumVal(total_tomato, 10)
        sumVal(total_olive, 10)
        sumVal(total_onion, 10)
        sumVal(total_salami, 10)
      }
    )
    
    # Update the stock with the maximum value allowed for this app.
    observeEvent(
      input$fillValues , {
        total_flour(500)
        total_ham(500)
        total_cheese(500)
        total_egg(500)
        total_bacon(500)
        total_tomato(500)
        total_olive(500)
        total_onion(500)
        total_salami(500)
      }
    )
    
    # Set stock to zero.
    observeEvent(
      input$clearValues , {
        total_flour(0)
        total_ham(0)
        total_cheese(0)
        total_egg(0)
        total_bacon(0)
        total_tomato(0)
        total_olive(0)
        total_onion(0)
        total_salami(0)
      }
    )
    
    # If possible update the stock according to the ordered pizza.
    observeEvent(
      input$receipt1 , {
          testReceipt <- checkStock(receipts$pepperoni)
        
          if (testReceipt){
            recp <- -as.numeric(input$pepperoni)*receipts$pepperoni
            updateStock(recp)
            output$recp1_status <- renderText({"Updated"})
          } else{
            output$recp1_status <- renderText({"Not enough itens"})
          }

      }
    )
    
    # If possible update the stock according to the ordered pizza.
    observeEvent(
      input$receipt2 , {
        testReceipt <- checkStock(receipts$marguerita)
        if (testReceipt){
          recp <- -as.numeric(input$marguerita)*receipts$marguerita
          updateStock(recp)
          output$recp2_status <- renderText({"Updated"})
        } else{
          output$recp2_status <- renderText({"Not enough itens"})
        }
      }
    )
    
    # If possible update the stock according to the ordered pizza.
    observeEvent(
      input$receipt3 , {
        testReceipt <- checkStock(receipts$mozzarela)
        if (testReceipt){
          recp <- -as.numeric(input$marguerita)*receipts$mozzarela
          updateStock(recp)
          output$recp3_status <- renderText({"Updated"})
        } else{
          output$recp3_status <- renderText({"Not enough itens"})
        }
      }
    )
    
    # If possible update the stock according to the ordered pizza.
    observeEvent(
      input$receipt4 , {
        testReceipt <- checkStock(receipts$meat)
        if (testReceipt){
          recp <- -as.numeric(input$meat)*receipts$meat
          updateStock(recp)
          output$recp4_status <- renderText({"Updated"})
        } else{
          output$recp4_status <- renderText({"Not enough itens"})
        }
      }
    )
    
    # Brings a visual presentation of stock.
    output$stock_graph <- renderPlot({
      supData <- c(total_flour(), total_ham(), total_cheese(),
                   total_egg(), total_bacon(), total_tomato(),
                   total_olive(), total_onion(), total_salami())
      namesData <- c("Flour", "Ham","Cheese", "Egg","Bacon", "Tomato", "Olive",
                     "Onion", "Salami")
      
      barplot(supData,
              names.arg = namesData,
              ylab = "Amount available",
              xlab = "Products",
              col = "blue",
              main = "Stock of goods available",
              ylim = c(0,500)
      )
      abline(h = 480, col="green", lwd=3, lty=2)
      abline(h = 20, col="red", lwd=3, lty=2)
    })
    
    
  }
)