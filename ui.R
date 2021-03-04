library(shiny)

# Define UI 
shinyUI(fluidPage(
        # Application title
        titlePanel("Predict who will win the 36th America's Cup"),

        mainPanel(
                #Add tabs to main screen
                tabsetPanel(
                        # Tab 1 Background information
                        tabPanel("About",
                                 h2("America's Cup"),
                                 imageOutput("ACImage",height=200),
                                 p("The America's Cup in RNZYS. Photo / B.Martin.",tags$br(),tags$br()),
                                 p("The America's cup is the worlds most prestigous sailing regatta."),
                                 p("It's the oldest continuously contested sporting event in the world, having started in 1851 held approximately every 3 to 4 years."),
                                 p("It is a Match race series between a Defending yacht and a Challenging yacht. What makes the event unique - the Defender sets the venue, the rules and the yacht type."),
                                 p("In the 36th America's Cup is to be held 6 to 15th March 2021 in Auckland, New Zealand. "),
                                 p("The Defender, Emirates Team New Zealand will race against the winner of the Challenger selection series, Luna Rossa Prada Pirelli from Italy in a best of 13 Match Race Series"),
                                 p("There was 1 Defending Team and 3 Challenging teams for the 2021 event"),
                                 p("Definitions:"),
                                 p(strong("Defender"),": A team representing the Country of the previous winner of the Cup. A Defender selection series is held when more than one defenfing team."),
                                 p(strong("Challenger"),": The winner of the Challenger selection series"),
                                 p(strong("Match Race"),": A race between only 2 yachts, winner takes all."),
                                 imageOutput("TeamNZImage",height=200),
                                 p("Team New Zealand during practice races with Luna Rossa. Photo / Brett Phibbs. ",
                                        a("Link",href="https://www.nzherald.co.nz/sport/americas-cup-2021-all-you-need-to-know-ahead-of-opening-ceremony-for-world-series-and-christmas-cup/JJTJMCPE7MJAUGLGFOX5E3CBOQ/"))
                                 ), #tab 2
                 
                     #Tab 2 Prediction tool 
                     tabPanel("Prediction Model",
                          
                              sidebarLayout(
                                  # Side bar for  user input
                                  sidebarPanel(
                                          # Slider for Number of Defenders
                                          sliderInput("NumberDefenders",
                                                      "How many Defenders?",
                                                      min = 1,
                                                      max = 10,
                                                      value = 1,
                                                      ticks=FALSE),
                                          
                                          # Slider for Number of Defenders
                                          sliderInput("NumberChallengers",
                                                      "How many Challengers?",
                                                      min = 1,
                                                      max = 20,
                                                      value = 1,
                                                      ticks=FALSE),
                                          
                                          # Checkbox for Match Race filter
                                          checkboxInput("MatchFilter","Include Only Match Races?",TRUE)
                                            ),
                                  mainPanel( p("Historically Challengers have only been sucessful in winning the America's cup 19% of the time. However it is often hypothesized that a large number of teams in the Challanger selection series better prepares the final Challenger with months of tough racing."),
                                             p("Based on the predictions of a Binomial (logistical) Model, predict who will win the 36th America's Cup match."),
                                             p("Select the number of Defenders and Challengers with the sliders on the left.",tags$br(),tags$br()),
                                             p("Would the more Challengers decrease Emirates Team New Zealand's chance of defending the cup?",tags$br()),
                                             h4("Selected Challenger to Defender Ratio: ",strong(textOutput("SelectedRatio"))),
                                             h4("Predicted Winner: ",strong(textOutput("result"))),
                                             plotOutput("Gplot", width="500px")
                                             
                                  )#mainPanel 
                              ),
                              
                              
                            ),#tab 2
                
       
                    tabPanel("Data", 
                             p("Data was compilied from different sources:"),
                             p("America's Cup, Wikipedia....",a("Link",href="https://en.wikipedia.org/wiki/America%27s_Cup")),
                             p("Amercia's Cup Official Website...",a("Link",href="https://www.americascup.com/")),
                             p("The America's Cup: History, teams and yachts, Alex Ferguson...",a("Link",href="https://www.amazon.com/Americas-Cup-History-teams-yachts-ebook/dp/B07H48MM3Z/ref=sr_1_18?dchild=1&keywords=americas+cup&qid=1614654531&s=books&sr=1-18")),
                             tableOutput("filetable"))
                    ) #tabSetPanel
                ) #mainpanel
    
        ))
