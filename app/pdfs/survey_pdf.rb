class SurveyPdf < Prawn::Document
  def initialize(current_user,all_attempts,total_score)
    super()
    @current_user = current_user
    @all_attempts = all_attempts
    @total_score = total_score
    if (@total_score >= 4.7)
        @gradeLetter = "A+"
     elsif (@total_score >= 4.4)
        @gradeLetter = "A"
     elsif (@total_score>= 4.1)
       @gradeLetter = "A-"
     elsif (@total_score >= 3.8)
       @gradeLetter  = "B+"
     elsif (@total_score>= 3.5)
       @gradeLetter = "B"
    elsif (@total_score >= 3.2)
       @gradeLetter = "B-"
    elsif (@total_score >= 2.9)
        @gradeLetter = "C+"
     elsif (@total_score >= 2.6)
       @gradeLetter = "C"
     elsif (@total_score >= 2.3)
       @gradeLetter = "C-"
     elsif (@total_score>= 2.0)
       @gradeLetter = "D+"
     elsif (@total_score >= 1.7)
       @gradeLetter = "D"
     elsif (@total_score>= 1.4)
       @gradeLetter = "D-"
     else
       @gradeLetter = "F"
    end
    cover
    content
  end

  def cover    
    stroke_axis
    image "#{Rails.root}/app/assets/images/sophity-report-logo.png",  :at => [50,700], :width => 450
    image "#{Rails.root}/app/assets/images/puzzle.png",  :at => [0,550], :width => 550
    move_cursor_to 300
    font "Helvetica", :style => :bold_italic, :size => 20
    text "Sophity Services Success Model Health Check"
    move_cursor_to 200
    font "Helvetica", :style => :normal, :size => 12
    text "Prepared for: #{ @current_user.name}" " on "
    text "#{ @current_user.name}"
    text "#{ @current_user.job_title}"
    text "#{ @current_user.company}"

  end

  def content
    start_new_page
    page_2
    start_new_page
    page_3
    start_new_page
    page_5
    start_new_page
    page_6
    start_new_page
    page_8
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    text "Sophity Services Success Model Health Check - #{@current_user.company}", :align => :center
  end

  def page_2
    text "Table of Contents", :color => "0000ff", :size => 16   

    footer
  end

  def page_3
    text "The Sophity Services Success Model", :color => "0000ff", :size => 16
    move_down 10
    text "Sophity has developed the Sophity 6-Point Services Success Model in order to provide a framework our customers use to build their business plan for a world-class consulting business.", :size => 12
    move_down 20
    text "We use this model to evaluate the current health of a consulting practice and identify opportunities to improve your business model and execution plan. We work with our customers to develop a roadmap of change that drives the business to growth and world-class status.", :size => 12
    move_down 20
    text "Our customers continue to use the Sophity 6-Point Services Success Model to evolve their business over time in order to address changes in the market and technical environment.", :size => 12
    move_down 20
    text "The components of the Sophity 6-Point Services Success Model are:", :size => 12
    move_down 10
    image "#{Rails.root}/app/assets/images/6Dimensions.png",   :width => 550
    move_down 10
    text "Each component is comprised of a number of attributes; Each component is described here.", :size => 12
    move_down 10
    text " - Services Business Strategy: Evaluates the degree to which the services business strategy is aligned with the corporate strategy (in an embedded consulting business) and the strategies of key business partners such as sales, marketing, finance, and product management." , :size => 12
    text " - Services Go To Market Strategy: The Go To Market (GTM) Strategy evaluation looks at the degree to which there is a plan for how sales will be conducted and to whom. We look at the marketing plan, sales model, and sales team, among other things." , :size => 12
    text " - Services Portfolio: The Services Portfolio evaluation assesses the degree to which clear, easy to sell services offerings have been developed. We look at the alignment of the offerings to the services team’s skills and capabilities, the market need, and the sell-ability of each.", :size => 12
    text " - Repeatable Delivery Framework: The Repeatable Delivery Framework assessment reviews the tools, templates, and processes that have been developed for each service offering in the services portfolio and how they are used within services to improve delivery quality and scalability, new hire and partner onboarding, and even the sales process.", :size => 12
    footer
    start_new_page
    text " - The Team: The Team assessment looks at the alignment of skills represented on the team and the stated mission of the services department, as well as the needs expressed by the market. Additionally, we assess how well services management communicates with, empowers, and invests in the team." , :size => 12
    text " -  Business Operations & Financial Management: The Business Operations & Financial Management assessment reviews whether the KPIs, practice operations, and financial tools and processes are in support of the services business’s core purpose and goals." , :size => 12
    move_down 20
    image "#{Rails.root}/app/assets/images/Categories.png",   :width => 550
    footer
  end


  def page_5
    text "Sophity Services Success Health Check – Introduction", :color => "0000ff", :size => 16
    move_down 10
    text "Sophity presented a series of statements in the form of a survey and asked the participant to rate the degree to which s/he agreed with each statement. The questions were framed such that the more you agreed with the statement in context with the reality of your current business, the more points you received for your response.", :size => 12
    move_down 20
    text "Each statement was worth five (5) points. Points were awarded as follows:", :size => 12
    move_down 20
    text "        Strongly Agree: 5 points ", :size => 12, :indent_paragraphs => 80
    text "        Agree: 4 points ", :size => 12, :indent_paragraphs => 80
    text "        Neutral: 3 points ", :size => 12, :indent_paragraphs => 80
    text "        Disagree: 2 points ", :size => 12, :indent_paragraphs => 80
    text "        Strongly Disagree: 1 point ", :size => 12, :indent_paragraphs => 80
    move_down 20
    text "A letter grade was provided for each of the six components of the Sophity 6-Point Services Success Model. An overall grade for your practice was also provided. Grades were determined by the number of points awarded per the information above. Grades were calculated as follows: ", :size => 12
    move_down 20
    image "#{Rails.root}/app/assets/images/scores.png", :width => 550
    footer
  end


  def page_6
    text "Sophity Services Success Health Check - #{@current_user.company} Results", :color => "0000ff", :size => 16
    move_cursor_to 550
    text "Total Grade: #{ @gradeLetter }", :color => "0000ff", :size => 16
    main_build
    footer
  end

   def page_8
    text "About Sophity LLC", :color => "0000ff", :size => 16
    footer
  end

  def footer
      string = '#<page>'
  # Green page numbers 1 to 7
  options = {
    at: [bounds.right - 150, 0],
    width: 150,
    align: :right,
    page_filter: (2..7),
    start_count_at: 2,
    color: '000000'
  }
  number_pages string, options

  end

   def main_build
     move_down 20
     table transaction_rows do
       row(0).font_style = :bold
       columns(1..3).align = :center
       self.row_colors = ["DDDDDD", "FFFFFF"]
       self.header = true
     end
   end

   def transaction_rows
      [["Service Component", "Grade", "Top Concerns"]] +
      @all_attempts.map do |l|
         [l.survey.description, l.grade, ""]
      end
    end




end
