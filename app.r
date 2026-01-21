library(shiny)
library(RPostgres)
library(DBI)
library(ggplot2)
library(dplyr)

# --- UI: The "Front End" ---
ui <- fluidPage(
  titlePanel("Actuarial Claims Monitor"),
  
  sidebarLayout(
    sidebarPanel(
      h4("Control Panel"),
      helpText("Data is pulled live from the PostgreSQL warehouse."),
      actionButton("refresh", "Refresh Data", class = "btn-primary"),
      hr(),
      h3(textOutput("total_exposure"), style = "color: #d9534f;")
    ),
    
    mainPanel(
      # Top row: The Chart
      plotOutput("severityDist"),
      br(),
      # Bottom row: The Data Table
      h4("Recent Claims Feed"),
      tableOutput("claimsTable")
    )
  )
)

# --- SERVER: The "Back End" Logic ---
server <- function(input, output, session) {

  # 1. Function to fetch data from DB
  get_data <- reactive({
    input$refresh # Triggers update when button is clicked
    
    # Connect to the local Docker database
    con <- dbConnect(RPostgres::Postgres(),
                     dbname = "claims_warehouse",
                     host = "localhost",
                     port = 5433,
                     user = "actuary",
                     password = "password123")
    
    # Query the data
    data <- dbGetQuery(con, "SELECT * FROM claims ORDER BY created_at DESC")
    
    # Close connection immediately (Good practice)
    dbDisconnect(con)
    
    return(data)
  })

  # 2. Calculate Total Reserve Exposure
  output$total_exposure <- renderText({
    df <- get_data()
    val <- sum(df$estimated_reserve, na.rm = TRUE)
    paste0("$", format(val, big.mark=",", nsmall=2))
  })

  # 3. Render the Severity Distribution Plot
  output$severityDist <- renderPlot({
    df <- get_data()
    if(nrow(df) > 0){
      ggplot(df, aes(x=as.factor(severity_score))) +
        geom_bar(fill="#4da6ff", color="black") +
        labs(title="Claims Frequency by Severity Score", 
             x="Severity Score (1-10)", 
             y="Number of Claims") +
        theme_minimal() +
        theme(text = element_text(size=14))
    }
  })

  # 4. Render the Data Table
  output$claimsTable <- renderTable({
    get_data() %>% 
      select(policy_number, incident_date, severity_score, estimated_reserve, status) %>%
      head(10) # Show top 10 most recent
  })
}

# Run the App
shinyApp(ui = ui, server = server)