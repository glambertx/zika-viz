
  
library(shiny)
library(choroplethr)
library(choroplethrMaps)
library(ggplot2)
library(RColorBrewer)
pdf(NULL)
df1 <- read.csv("zika_clean.csv")
data(continental_us_states)

#zika_clean <- read.csv("zika_clean.csv", header=T)
names(df1) <- c("region","6","5","4","3","2")
df1 <- df1[c(1,6,5,4,3,2)]

  
  options(shiny.error=browser)
  
  shinyServer(function(input, output) {
    value_range <- range(df1[,2:6])

    fill_scale <- scale_fill_gradientn(limits = range(value_range),colours=c("#ffffff", brewer.pal(n=9, name="YlOrRd")),na.value="#ffffff", name="Cases")
    output$stateMap = renderPlot({
      
      # add a progress bar
      progress = shiny::Progress$new()
      on.exit(progress$close())
      progress$set(message = "Creating image. Please wait.", value = 0)
      
      year = as.numeric(input$month)
      df1$value= df1[,input$month]
      #p <- state_choropleth(df1, num_colors = input$num_colors)
      state_choropleth(df1, num_colors = 1, zoom=continental_us_states) + fill_scale
      #print(p + fill_scale)
    })
  
  
  
})
