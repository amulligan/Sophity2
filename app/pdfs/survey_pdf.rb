class SurveyPdf < Prawn::Document
  def initialize(current_user,all_attempts, proficient, improve, deltas,total_score)
    super()
    @current_user = current_user
    @all_attempts = all_attempts
    @total_score = total_score
    @proficient = proficient
    @improve = improve
    @deltas = deltas
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
    # paper dimensions [612, 792]
    canvas do
      fill_color "E0E0E0"
      rectangle [25, (792 - 20)], (612 - 50), (792 - 50)
      fill
      image "#{Rails.root}/app/assets/images/sophity-report-logo.png",  :at => [231, (792 - 25 - 35)], :width => (612 - 40 - 231)
      image "#{Rails.root}/app/assets/images/puzzle.png",  :at => [25, 610], :width => (612 - 50)
      fill_color "000000"
      bounding_box([72, 342], :width => 468, :height => 252) do
        font "DejaVuSans", :style => :bold_italic, :size => 20
        text "Sophity Services Success Model Health Check"
        move_down 30
        font :style => :normal, :size => 12
        text "Prepared for:"
        move_down 12
        text "#{ @current_user.name}"
        move_down 6
        text "#{ @current_user.job_title}"
        move_down 6
        text "#{ @current_user.company}"
        move_down 12
        text "Prepared on: #{Time.now.strftime('%B %d, %Y')}"
      end
      bounding_box([72, 90], :width => 468, :height => 45) do
        font :style => :normal, :size => 8
        text "© 2016 Sophity LLC. All Rights Reserved. Cannot be used all or in part without express written permission from Sophity LLC."
      end
    end
    # move_down 20
    # text "Fonts will be located in #{Rails.root.join('vendor', 'assets', 'fonts')}"
  end

  def content
    start_new_page(:margin => [72, 90])
    page_2
    start_new_page(:margin => [72, 90])
    page_3
    start_new_page(:margin => [72, 90])
    page_5
    start_new_page(:margin => [72, 90])
    page_6
    start_new_page(:margin => [72, 90])
    page_8
    outline.define do
         page :title => "The Sophity Services Success Model", :destination => 3
         page :title => "Sophity Services Success Health Check – Introduction", :destination => 5
         page :title => "Sophity Services Success Health Check - Results", :destination => 6
         page :title => "About Sophity LLC", :destination => 8
    end
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    text "Sophity Services Success Model Health Check - #{@current_user.company}", :align => :center
  end

  def page_2
    move_down 20
    text "Table of Contents",:color => "0000ff", :size => 16
    move_down 20
    text "The Sophity Services Success Model                                               " +"<u><link anchor='page3'>3</link></u>", :size => 12, :inline_format => true
    move_down 20
    text " Sophity Services Success Health Check – Introduction                    " + "<u><link anchor='page5'>5</link></u>", :size => 12, :inline_format => true
    move_down 20
    text " Sophity Services Success Health Check - #{@current_user.company} Results           " +"<u><link anchor='page6'>6</link></u>", :size => 12,:inline_format => true
    move_down 20
    text " About Sophity LLC                                                                            " +"<u><link anchor='page8'>8</link></u>",:size => 12, :inline_format => true
    footer
  end

  def page_3
    add_dest "page3", dest_xyz(bounds.absolute_left, y)
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
    image "#{Rails.root}/app/assets/images/6Dimensions.png",  :width => 400
    move_down 10
    text "Each component is comprised of a number of attributes; Each component is described here.", :size => 12
    move_down 10
    text " - Services Business Strategy: Evaluates the degree to which the services business strategy is aligned with the corporate strategy (in an embedded consulting business) and the strategies of key business partners such as sales, marketing, finance, and product management." , :size => 12
    start_new_page
    text " - Services Go To Market Strategy: The Go To Market (GTM) Strategy evaluation looks at the degree to which there is a plan for how sales will be conducted and to whom. We look at the marketing plan, sales model, and sales team, among other things." , :size => 12
    text " - Services Portfolio: The Services Portfolio evaluation assesses the degree to which clear, easy to sell services offerings have been developed. We look at the alignment of the offerings to the services team’s skills and capabilities, the market need, and the sell-ability of each.", :size => 12
    text " - Repeatable Delivery Framework: The Repeatable Delivery Framework assessment reviews the tools, templates, and processes that have been developed for each service offering in the services portfolio and how they are used within services to improve delivery quality and scalability, new hire and partner onboarding, and even the sales process.", :size => 12
    text " - The Team: The Team assessment looks at the alignment of skills represented on the team and the stated mission of the services department, as well as the needs expressed by the market. Additionally, we assess how well services management communicates with, empowers, and invests in the team." , :size => 12
    text " -  Business Operations & Financial Management: The Business Operations & Financial Management assessment reviews whether the KPIs, practice operations, and financial tools and processes are in support of the services business’s core purpose and goals." , :size => 12
    move_down 20
    image "#{Rails.root}/app/assets/images/Categories.png", :width => 400
    footer
  end


  def page_5
    add_dest "page5", dest_xyz(bounds.absolute_left, y)
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
    image "#{Rails.root}/app/assets/images/scores.png", :width => 400
    footer
  end


  def page_6
    add_dest "page6", dest_xyz(bounds.absolute_left, y)
    text "Sophity Services Success Health Check - #{@current_user.company} Results", :color => "0000ff", :size => 16
    move_down 20
    main_build
    move_down 40
    text "Total Grade: #{ @gradeLetter }", :color => "0000ff", :size => 16
    move_down 20
    text "Comments: ", :size => 12
    move_down 5
    text "Your grade of #{ @gradeLetter } indicates that", :size => 12
    move_down 10
    table_proficient

    move_down 20
    table_improve

    move_down 20
    table_deltas
    start_new_page
    footer
  end

   def page_8
    add_dest "page8", dest_xyz(bounds.absolute_left, y)
    text "About Sophity LLC", :color => "0000ff", :size => 16
    move_down 20
    text "Sophity knows first hand that running a growing IT consulting business is challenging. People don’t scale well, sales are competitive, and poor visibility into practice and project health can wreck a business forecast or client relationship over night. If your practice is embedded in a software or hardware business, you have the added challenges of ensuring your mission is aligned with the corporate mission, managing through conflicts with sales, marketing, and product management, and ensuring your work does not adversely affect overall corporate financial reporting. (Did I hear you say “VSOE?”)", :size => 12
    move_down 10
    text "At Sophity, we are committed to partnering with our customers – members of the services leadership and delivery teams – to ensure you are wildly successful in your endeavor to build a world-class consulting business.", :size => 12
    move_down 10
    text "Sophity provides software and consulting services designed to help you optimize the 6 dimensions of a success consulting practice and your business.", :size => 12
    move_down 10
    text "Clients who work with us:", :size => 12
    text " Increase sales by defining an effective Services Portfolio that monetizes what you do.",  :size => 12, :indent_paragraphs => 30
    text "Improve margins and expedite new hire onboarding by developing a Repeatable Delivery Framework that ensures consistent quality across your team.",  :size => 12, :indent_paragraphs => 30
    text "Reduce friction, improve relationships, and improve employee and customer satisfaction by partnering with sales and marketing to define a Go To Market Strategy that accelerates sales while giving you the command and control you need to ensure a high-level customer satisfaction from every project.",  :size => 12, :indent_paragraphs => 30
    text "Reduce voluntary attrition and increase employee satisfaction by developing the programs you need to find, hire, and retain the best people for your team.",  :size => 12, :indent_paragraphs => 30
    text" Look like heroes to executive management when partnerships with members of operations and finance to align business strategies and ensure the right governance, controls, and reporting are in place to allow you to have the visibility you need into your practice’s health.",  :size => 12, :indent_paragraphs => 30
    text "Contact us today to talk about how we can help you build a fast growing, profitable, and truly world-class consulting business.", :size => 12
    move_down 10
    text "Phone: 978-265-2378 ", :size => 12
    move_down 10
    text "Email: info@sophity.com", :size => 12
    move_down 10
    text "<u><link href='www.sophity.com'>www.sophity.com" +
         "</link></u>", :color => "0000ff",
         :inline_format => true
    move_down 10
    text "<u><link href='https://www.facebook.com/sophity1/'>https://www.facebook.com/sophity1/" "</link></u>", :color => "0000ff",
         :inline_format => true
    move_down 10
    text "<u><link href='https://twitter.com/SophityPSA'>https://twitter.com/SophityPSA" "</link></u>", :color => "0000ff",
         :inline_format => true
    move_down 10
    text "<u><link href='https://www.linkedin.com/company/sophity-llc/'>https://www.linkedin.com/company/sophity-llc/" "</link></u>", :color => "0000ff",
         :inline_format => true
    footer
  end

  def footer
      string = '#<page>'
  # Green page numbers 1 to 7
  options = {
    at: [bounds.right - 150, 0],
    width: 150,
    align: :right,
    page_filter: (2..8),
    start_count_at: 2,
    color: '000000'
  }
  number_pages string, options

  end

  def table_proficient
    table(proficient_rows, :cell_style => {:border_width => 0})
 end

  def table_improve
    table(improve_rows, :cell_style => {:border_width => 0})
  end

  def table_deltas
    table(deltas_rows, :cell_style => {:border_width => 0})

  end

  def proficient_rows
    if @proficient.empty?
      [["You're proficient in: "]] + [[" - " + "N/A"]]
    else
      [["You're proficient in: "]] +
      @proficient.map do |p|
        ["  - " + p.survey.description]
      end
    end
  end

  def improve_rows
    if @improve.empty?
      [[ "You have room for improvement in these areas: "]]+ [[" - " + "N/A"]]
    else
      [[ "You have room for improvement in these areas: "]]+
      @improve.map do |i|
        ["  - " + i.survey.description]
      end
    end
  end

  def deltas_rows

    if @deltas.empty?
      [[ "You need to make significant improvement in these areas: "]] + [[" - " + "N/A"]]
    else
      [[ "You need to make significant improvement in these areas: "]] +
      @deltas.map do |d|
        ["  - " + d.survey.description]
      end
    end
  end


   def main_build
     move_down 20
     table table_rows, :cell_style => { :font => "Helvetica", :font_style => :italic }
   end

   def subtable(top_concerns)
      top_concerns do |c|
        [c.text]
   end
   end

   def table_rows
    top_concerns_string = "bla bla bla \n\r bla bla bla \n\r bla bla \n\r"
      [["Service Component", "Grade", "Top Concerns"]] +
      @all_attempts.map do |line|
        #  [{:content => l.survey.description, :rowspan => l.survey.top_concerns.count}, {:content => l.grade, :rowspan => l.survey.top_concerns.count}, {:content => "test", :rowspan => l.survey.top_concerns.count}]
         [line.survey.description, line.grade, top_concerns_string]
      end
  end

  #  def table_rows
  #   [["Service Component", "Grade", "Top Concerns"]] +
  #     @all_attempts.map do |l|
  #        [{:content => l.survey.description, :rowspan => l.survey.top_concerns.count}, {:content => l.grade, :rowspan => l.survey.top_concerns.count}, {:content => "test", :rowspan => l.survey.top_concerns.count}]
  #     end
  #  end

   def toc
    table(toc_rows, :cell_style => {:border_width => 0})
   end

   def toc_rows
      [["Table of Contents", "     "]]+
      [[" The Sophity Services Success Model",  "<u> <link anchor='page3'>3</link></u> "]] +
      [[" Sophity Services Success Health Check – Introduction  " ,  " <u> <link anchor='page5'>5</link></u>"]]+
      [[" Sophity Services Success Health Check - #{@current_user.company} Results", "<u> <link anchor='page6'>6</link></u>"]] +
      [[" About Sophity LLC", "<u> <link anchor='page8'>8</link></u>"]]

   end


end
