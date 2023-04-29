library(shiny)

ui <- fluidPage(
  titlePanel("跑团判定器"),
  sidebarLayout(
    sidebarPanel(
      numericInput("K", "输入战力值", value = 10, min = 1, max = 100),
      actionButton("generate", "生成战斗结果")
    ),
    mainPanel(
      verbatimTextOutput("random_number")
    )
  )
)

server <- function(input, output, session) {
  random_num <- eventReactive(input$generate, {
    sample(1:100, 1)
  })
  
  output$random_number <- renderPrint({
    if (random_num() >= 96) {
      paste0(random_num()," 结果为大失败")
    }else if (random_num() <= 5) {
      paste0(random_num()," 结果为大成功")
    }else if (random_num() > input$K){
      paste0(random_num()," 结果为失败")
    }else{
      paste0("战力足以通过一场简单的战斗:", random_num() <= input$K, " ",
             "战力足以通过一场困难的战斗:", random_num() <= input$K/2," ",
             "战力足以通过一场极难的战斗:", random_num() <= input$K/5)
    }
    
  })
}

shinyApp(ui, server)
