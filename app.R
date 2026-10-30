library(shiny)
library(bslib)

# UI Layer
ui <- fluidPage(
  # प्रीमियम और प्रोफेशनल लुक के लिए थीम सिलेक्शन
  theme = bs_theme(version = 5, bootswatch = "flatly", primary = "#2c3e50"), 
  
  # मुख्य हेडर
  tags$div(
    style = "background-color: #2c3e50; padding: 20px; border-radius: 0 0 10px 10px; margin-bottom: 25px; color: white; text-align: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);",
    tags$h2("🎓 Student Academic Dashboard & Scholarship Tracker", style = "font-weight: bold; margin: 0; font-size: 26px;"),
    tags$p("Live In-Semester Assessment & Eligibility Engine", style = "margin: 5px 0 0 0; opacity: 0.8; font-size: 14px;")
  ),
  
  sidebarLayout(
    sidebarPanel(
      width = 4,
      style = "background-color: #f8f9fa; border-radius: 10px; border: 1px solid #e2e8f0; padding: 20px;",
      
      tags$h4("📅 Eligibility Metrics", style = "font-weight: bold; color: #2c3e50; margin-bottom: 15px;"),
      numericInput("attendance", "Overall Attendance Percentage (%):", value = 80, min = 0, max = 100),
      
      hr(style = "border-top: 2px solid #cbd5e1;"),
      
      tags$h4("📝 Input Subject Marks (Out of 100)", style = "font-weight: bold; color: #2c3e50; margin-bottom: 15px;"),
      
      # इनपुट कंट्रोल्स को ग्रिड में सजाया गया है
      fluidRow(
        column(6, numericInput("rlab", "RLab:", value = 75, min = 0, max = 100)),
        column(6, numericInput("adbms", "ADBMS:", value = 80, min = 0, max = 100))
      ),
      fluidRow(
        column(6, numericInput("plsql", "PL/SQL Lab:", value = 70, min = 0, max = 100)),
        column(6, numericInput("aip", "AIP:", value = 85, min = 0, max = 100))
      ),
      fluidRow(
        column(6, numericInput("daa_th", "DAA Theory:", value = 78, min = 0, max = 100)),
        column(6, numericInput("python", "Python:", value = 82, min = 0, max = 100))
      ),
      fluidRow(
        column(6, numericInput("fds", "Data Science:", value = 74, min = 0, max = 100)),
        column(6, numericInput("daa_pr", "DAA Practical:", value = 80, min = 0, max = 100))
      ),
      
      hr(style = "border-top: 1px solid #cbd5e1;"),
      tags$div(
        style = "background-color: #edf2f7; padding: 12px; border-radius: 6px; font-size: 13px; color: #4a5568;",
        tags$b("📌 Policy Rule:"), " Attendance must be ≥ 75% AND Academic Average must be ≥ 75% to claim the 20% Tuition Scholarship."
      )
    ),
    
    mainPanel(
      width = 8,
      
      # टॉप केपीआई समरी कार्ड्स
      layout_column_wrap(
        width = 1/2,
        card(
          style = "border-top: 5px solid #3498db; box-shadow: 0 4px 6px rgba(0,0,0,0.05);",
          card_header(tags$b("📅 Attendance Status"), style = "background: none; color: #3498db;"),
          card_body(
            uiOutput("att_badge")
          )
        ),
        card(
          style = "border-top: 5px solid #9b59b6; box-shadow: 0 4px 6px rgba(0,0,0,0.05);",
          card_header(tags$b("📈 Aggregated Academic Average"), style = "background: none; color: #9b59b6;"),
          card_body(
            uiOutput("avg_badge")
          )
        )
      ),
      
      br(),
      
      # स्कॉलरशिप निर्णय कार्ड (हाइलाइटेड बैनर)
      card(
        style = "box-shadow: 0 4px 10px rgba(0,0,0,0.08); border: none;",
        card_header(tags$b("🏆 System Scholarship Decision"), style = "background-color: #f8f9fa; color: #2c3e50; font-size: 16px;"),
        card_body(
          style = "padding: 0;",
          uiOutput("scholarship_status")
        )
      ),
      
      br(),
      tags$h4("📊 Subject-Wise Assessment Matrix", style = "font-weight: bold; color: #2c3e50; margin-bottom: 15px;"),
      
      # डायनेमिक कंडीशनल बॉर्डर वाले कार्ड्स
      uiOutput("subject_cards")
    )
  )
)

# Server Logic
server <- function(input, output) {
  
  # सिक्योर इनपुट पार्सर
  parse_mark <- function(val) {
    if (is.null(val) || is.na(val)) return(0)
    return(val)
  }
  
  # लाइव एवरेज स्कोर कैलकुलेटर
  avg_score <- reactive({
    total <- (parse_mark(input$rlab) + parse_mark(input$adbms) + parse_mark(input$plsql) + parse_mark(input$aip) + 
                parse_mark(input$daa_th) + parse_mark(input$python) + parse_mark(input$fds) + parse_mark(input$daa_pr))
    round(total / 8, 2)
  })
  
  # अटेंडेंस स्टेटस आउटपुट विथ कलर इंडिकेटर
  output$att_badge <- renderUI({
    att <- parse_mark(input$attendance)
    color <- if (att >= 75) "#2ecc71" else "#e74c3c"
    tags$div(
      style = "text-align: center; padding: 10px;",
      tags$h1(paste0(att, "%"), style = paste0("font-weight: bold; margin: 0; color: ", color, ";")),
      tags$span(if (att >= 75) "✔ Criteria Met" else "❌ Defaulter Zone", style = paste0("color: ", color, "; font-size: 14px; font-weight: bold;"))
    )
  })
  
  # एकेडमिक एवरेज आउटपुट विथ कलर इंडिकेटर
  output$avg_badge <- renderUI({
    score <- avg_score()
    color <- if (score >= 75) "#16a085" else "#f39c12"
    tags$div(
      style = "text-align: center; padding: 10px;",
      tags$h1(paste0(score, "%"), style = paste0("font-weight: bold; margin: 0; color: ", color, ";")),
      tags$span(if (score >= 75) "✔ Target Score Achieved" else "⚠ Below Scholarship Benchmark", style = paste0("color: ", color, "; font-size: 14px; font-weight: bold;"))
    )
  })
  
  # कंडीशनल स्कॉलरशिप डिसीजन बैनर
  output$scholarship_status <- renderUI({
    score <- avg_score()
    att <- parse_mark(input$attendance)
    
    if (att < 75) {
      tags$div(
        style = "background-color: #e74c3c; color: white; padding: 25px; text-align: center; font-size: 20px; font-weight: bold;",
        "❌ Application Rejected: Overall Attendance is below 75% threshold!"
      )
    } else {
      if (score >= 75) {
        tags$div(
          style = "background-color: #2ecc71; color: white; padding: 25px; text-align: center; font-size: 22px; font-weight: bold; animation: pulse 2s infinite;",
          "🎉 Congratulations! You are Eligible for a 20% Academic Scholarship!"
        )
      } else {
        tags$div(
          style = "background-color: #f39c12; color: white; padding: 25px; text-align: center; font-size: 20px; font-weight: bold;",
          "⚠️ Not Eligible: Attendance is secure, but aggregate evaluation marks are below 75%."
        )
      }
    }
  })
  
  # स्मार्ट कंडीशनल कलर कोडिंग ग्रिड (75% से नीचे वाले मार्क्स रेड आउटलाइन होंगे)
  output$subject_cards <- renderUI({
    subjects <- list(
      list(name = "💻 RLab", val = parse_mark(input$rlab)),
      list(name = "🗄️ ADBMS", val = parse_mark(input$adbms)),
      list(name = "🛢️ PL/SQL Lab", val = parse_mark(input$plsql)),
      list(name = "🌐 AIP", val = parse_mark(input$aip)),
      list(name = "📐 DAA Theory", val = parse_mark(input$daa_th)),
      list(name = "🐍 Python", val = parse_mark(input$python)),
      list(name = "🔬 Data Science", val = parse_mark(input$fds)),
      list(name = "⚙️ DAA Practical", val = parse_mark(input$daa_pr))
    )
    
    card_elements <- lapply(subjects, function(sub) {
      is_low <- sub$val < 75
      border_color <- if (is_low) "#e74c3c" else "#e2e8f0"
      bg_color <- if (is_low) "#fff5f5" else "#ffffff"
      text_color <- if (is_low) "#c53030" else "#2d3748"
      
      tags$div(
        style = paste0("background-color: ", bg_color, "; border: 2px solid ", border_color, "; border-radius: 8px; padding: 15px; box-shadow: 0 2px 4px rgba(0,0,0,0.02); transition: all 0.3s;"),
        tags$div(style = "font-weight: bold; color: #4a5568; font-size: 14px; margin-bottom: 5px;", sub$name),
        tags$div(style = paste0("font-size: 22px; font-weight: bold; color: ", text_color, ";"), paste0(sub$val, "%")),
        if(is_low) tags$div(style = "font-size: 11px; color: #e74c3c; font-weight: bold; margin-top: 3px;", "⚠ Critical (Below 75)")
      )
    })
    
    layout_column_wrap(width = 1/4, gap = "15px", card_elements)
  })
}

# App Execution
shinyApp(ui = ui, server = server)
