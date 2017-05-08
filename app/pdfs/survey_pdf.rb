class SurveyPdf < Prawn::Document
  def initialize(current_user,all_attempts, proficient, improve, deltas,total_score)
    super()
    @current_user = current_user
    @all_attempts = all_attempts
    @total_score = total_score
    @total_score = @total_score.round(1)
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
    headers
    footers
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
        font "Helvetica", :style => :bold_italic, :size => 20
        text "Sophity Services Success Model Health Check"
        move_down 40
        font "Times-Roman", :size => 12, :style => :normal
        text "Prepared for:"
        move_down 20
        text "#{ @current_user.name}"
        move_down 10
        text "#{ @current_user.job_title}"
        move_down 10
        text "#{ @current_user.company}"
        move_down 20
        text "Prepared on: #{Time.now.strftime('%B %d, %Y')}"
      end
      bounding_box([72, 90], :width => 468, :height => 45) do
        font "Helvetica", :style => :normal, :size => 8
        text "© 2017 Sophity LLC. All Rights Reserved. Cannot be used all or in part without express written permission from Sophity LLC."
      end
    end
    # move_down 20
    # text "Fonts will be located in #{Rails.root.join('vendor', 'assets', 'fonts')}"
  end

  def content

    font "Times-Roman", :style => :normal, :size => 12
    default_leading 3

    start_new_page(:margin => [72, 90])
    table_of_contents
    start_new_page(:margin => [72, 90])
    intro_section
    start_new_page(:margin => [72, 90])
    about_survey
    start_new_page(:margin => [72, 90])
    your_scores
    start_new_page(:margin => [72, 90])
    outro_section

    outline.define do
         page :title => "The Sophity Services Success Model", :destination => 3
         page :title => "Sophity Services Success Health Check – Introduction", :destination => 5
         page :title => "Sophity Services Success Health Check – Results", :destination => 6
         page :title => "About Sophity LLC", :destination => 8
    end
  end

  def table_of_contents
    move_down 10
    font "Helvetica", :size => 16 do
      text "Table of Contents", :color => "345A8A"
    end

    move_down 20
    line_y = cursor
    toc_string = "<link anchor='page3'>The Sophity Services Success Model " + " . " * 100 + "</link>"
    text_box toc_string,
        :at => [0, line_y],
        :inline_format => true,
        :width => 412,
        :height => 18,
        :overflow => :truncate
    move_cursor_to line_y
    span(20, :position => :right) do
      text "<link anchor='page3'>3</link>", :align => :right, :inline_format => true
    end

    move_down 20
    line_y = cursor
    toc_string = "<link anchor='page5'>Sophity Services Success Health Check – Introduction" + " . " * 100 + "</link>"
    text_box toc_string,
        :at => [0, line_y],
        :inline_format => true,
        :width => 412,
        :height => 18,
        :overflow => :truncate
    move_cursor_to line_y
    span(20, :position => :right) do
      text "<link anchor='page5'>5</link>", :align => :right, :inline_format => true
    end

    move_down 20
    line_y = cursor
    toc_string = "<link anchor='page6'>Sophity Services Success Health Check – Your Results " + " . " * 100 + "</link>"
    text_box toc_string,
        :at => [0, line_y],
        :inline_format => true,
        :width => 412,
        :height => 18,
        :overflow => :truncate
    move_cursor_to line_y
    span(20, :position => :right) do
      text "<link anchor='page6'>6</link>", :align => :right, :inline_format => true
    end

    move_down 20
    line_y = cursor
    toc_string = "<link anchor='page8'>About Sophity LLC " + " . " * 100 + "</link>"
    text_box toc_string,
        :at => [0, line_y],
        :inline_format => true,
        :width => 412,
        :height => 18,
        :overflow => :truncate
    move_cursor_to line_y
    span(20, :position => :right) do
      text "<link anchor='page8'>8</link>", :align => :right, :inline_format => true
    end
  end

  def intro_section
    add_dest "page3", dest_xyz(bounds.absolute_left, y)

    move_down 20
    font "Helvetica", :size => 16 do
      text "The Sophity Services Success Model", :color => "345A8A"
    end

    move_down 20
    formatted_text [ { :text => "Sophity has developed the  " },
                     { :text => "Sophity 6-Point Services Success Model ", :styles => [:italic] },
                     { :text => "in order to provide a framework our customers use to build their business plan for a world-class consulting business. "}
                   ]

    move_down 20
    text "We use this model to evaluate the current health of a consulting practice and identify opportunities to improve your business model and execution plan. We work with our customers to develop a roadmap of change that drives the business to growth and world-class status."
    move_down 20
    formatted_text [ { :text => "Our customers continue to use the " },
                    { :text => "Sophity 6-Point Services Success Model ", :styles => [:italic] },
                    { :text => "to evolve their business over time in order to address changes in the market and technical environment."}
                  ]
    move_down 20
    formatted_text [ { :text => "The components of the "},
                    { :text => "Sophity 6-Point Services Success Model ", :styles => [:italic] },
                    { :text => "are pictured below."}
                  ]

    move_down 30
    image "#{Rails.root}/app/assets/images/6Dimensions.png",  :width => 342, :position => :center

    move_down 30
    text "Each component is comprised of a number of attributes:"
    move_down 10

    span(432) do
      span(417, :position => :right) do
        text "•    Services Business Strategy: Evaluates the degree to which the services business strategy is aligned with the corporate strategy (in an embedded consulting business) and the strategies of key business partners such as sales, marketing, finance, and product management.", :indent_paragraphs => -17
      end
      move_down 18

      span(417, :position => :right) do
        text "•    Services Go To Market Strategy: The Go To Market (GTM) Strategy evaluation looks at the degree to which there is a plan for how sales will be conducted and to whom. We look at the marketing plan, sales model, and sales team, among other things.", :indent_paragraphs => -17
      end
      move_down 18

      span(417, :position => :right) do
        text "•    Services Portfolio: The Services Portfolio evaluation assesses the degree to which clear, easy to sell services offerings have been developed. We look at the alignment of the offerings to the services team’s skills and capabilities, the market need, and the sell-ability of each.", :indent_paragraphs => -17
      end
      move_down 18

      span(417, :position => :right) do
        text "•    Repeatable Delivery Framework: The Repeatable Delivery Framework assessment reviews the tools, templates, and processes that have been developed for each service offering in the services portfolio and how they are used within services to improve delivery quality and scalability, new hire and partner onboarding, and even the sales process.", :indent_paragraphs => -17
      end
      move_down 18

      span(417, :position => :right) do
        text "•    The Team: The Team assessment looks at the alignment of skills represented on the team and the stated mission of the services department, as well as the needs expressed by the market. Additionally, we assess how well services management communicates with, empowers, and invests in the team.", :indent_paragraphs => -17
      end
      move_down 18

      span(417, :position => :right) do
        text "•    Business Operations & Financial Management: The Business Operations & Financial Management assessment reviews whether the KPIs, practice operations, and financial tools and processes are in support of the services business’s core purpose and goals.", :indent_paragraphs => -17
      end
      move_down 18
    end

    move_down 20
    bounding_box([45, cursor], :width => 342) do
      image "#{Rails.root}/app/assets/images/Categories.png", :width => 342, :position => :center
      stroke_bounds
    end

  end


  def about_survey
    add_dest "page5", dest_xyz(bounds.absolute_left, y)

    move_down 20
    font "Helvetica", :size => 16 do
      text "Sophity Services Success Health Check – Introduction", :color => "345A8A"
    end

    move_down 20
    text "Sophity presented a series of statements in the form of a survey and asked the participant to rate the degree to which s/he agreed with each statement. The questions were framed such that the more you agreed with the statement in context with the reality of your current business, the more points you received for your response."
    move_down 20
    text "We took the average of the scores for all questions to calculate the category-level " +
        "scores. We then took the average of the 6 category scores to calculate the total score for your business."
    move_down 20
    text "The following table shows how the letter grades were derived:"
    move_down 20

    # bounding_box([45, cursor], :width => 342) do
    #   image "#{Rails.root}/app/assets/images/scores.png", :width => 342, :position => :center
    # end
    table [
      ["", {:content => "Category Average", :colspan => 3}],
      ["Letter Grade", "+", "", "-", ""],
      ["A","5","–","4.1", "(Strongly Agree)"],
      ["B","4.0","–","3.2", "(Agree)"],
      ["C","3.1","–","2.3", "(Neutral)"],
      ["D","2.2","–","1.4", "(Disagree)"],
      ["F","1.3","–","1", "(Strongly Disagree)"],
    ], :cell_style => {:align => :center}, :position => :center do
      cells.padding = 4
      cells.borders = [:bottom]
      column(0).borders = [:right, :bottom]
    end

  end


  def your_scores
    add_dest "page6", dest_xyz(bounds.absolute_left, y)

    move_down 20
    font "Helvetica", :size => 16 do
      text "Sophity Services Success Health Check – Your Results", :color => "345A8A"
    end

    move_down 20
    build_results_table

    start_new_page(:margin => [72, 90])
    move_down 20
    font "Helvetica", :size => 16 do
      text "Summary", :color => "345A8A"
    end

    move_down 24
    text "Total Grade: #{ @gradeLetter }", :style => :bold
    move_down 20
    table_proficient

    move_down 20
    table_improve

    move_down 20
    table_deltas
  end

  def outro_section
    add_dest "page8", dest_xyz(bounds.absolute_left, y)

    move_down 10
    font "Helvetica", :size => 16 do
      text "About Sophity LLC", :color => "345A8A"
    end

    font "Times-Roman", :style => :normal, :size => 10

    move_down 20
    text "Sophity knows first hand that running a growing IT consulting business is challenging. People don’t scale well, sales are competitive, and poor visibility into practice and project health can wreck a business forecast or client relationship over night. If your practice is embedded in a software or hardware business, you have the added challenges of ensuring your mission is aligned with the corporate mission, managing through conflicts with sales, marketing, and product management, and ensuring your work does not adversely affect overall corporate financial reporting. (Did I hear you say “VSOE?”)"
    move_down 10
    text "At Sophity, we are committed to partnering with our customers – members of the services leadership and delivery teams – to ensure you are wildly successful in your endeavor to build a world-class consulting business."
    move_down 10
    text "Sophity provides software and consulting services designed to help you optimize the 6 dimensions of a success consulting practice and your business."
    move_down 10
    text "Clients who work with us:"
    move_down 10

    line_y = cursor
    text "•"
    move_cursor_to line_y
    span(417, :position => :right) do
      text "Increase sales by defining an effective Services Portfolio that monetizes what you do."
    end
    move_down 8

    line_y = cursor
    text "•"
    move_cursor_to line_y
    span(417, :position => :right) do
      text "Improve margins and expedite new hire onboarding by developing a Repeatable Delivery Framework that ensures consistent quality across your team."
    end
    move_down 8

    line_y = cursor
    text "•"
    move_cursor_to line_y
    span(417, :position => :right) do
      text "Reduce friction, improve relationships, and improve employee and customer satisfaction by partnering with sales and marketing to define a Go To Market Strategy that accelerates sales while giving you the command and control you need to ensure a high-level customer satisfaction from every project."
    end
    move_down 8

    line_y = cursor
    text "•"
    move_cursor_to line_y
    span(417, :position => :right) do
      text "Reduce voluntary attrition and increase employee satisfaction by developing the programs you need to find, hire, and retain the best people for your team."
    end
    move_down 8

    line_y = cursor
    text "•"
    move_cursor_to line_y
    span(417, :position => :right) do
      text "Look like heroes to executive management when your business strategies align with corporate goals and you have the right governance, controls, and reporting to manage your business effectively."
    end
    move_down 20

    text "Contact us today to talk about how we can help you build a fast growing, profitable, and truly world-class consulting business."
    move_down 10

    table [
      ["Phone: 978-265-2378", "<u><link href='https://www.facebook.com/sophity1/'>facebook.com/sophity1</link></u>"],
      ["Email: info@sophity.com", "<u><link href='https://twitter.com/SophityPSA'>twitter.com/SophityPSA</link></u>"],
      ["<u><link href='www.sophity.com'>www.sophity.com</link></u>", "<u><link href='https://www.linkedin.com/company/sophity-llc/'>linkedin.com/company/sophity-llc</link></u>"]
    ], :cell_style => {:inline_format => true}, :position => :center do
      cells.borders = []
      cells.padding = 8
    end

  end

  def headers
    font "Helvetica", :style => :normal, :size => 10
    header_string = "Sophity Services Success Model Health Check – #{@current_user.company}"
    header_options = {
      at: [bounds.right - 300, bounds.top + 32],
      width: 300,
      align: :right,
      page_filter: (2..15),
      start_count_at: 2,
      color: '000000'
    }
    number_pages header_string, header_options
  end

  def footers
    font "Helvetica", :style => :normal, :size => 8
    page_number_string = '<page>'
    footer_string = "© 2017 Sophity LLC. All Rights Reserved. Cannot be used all or in part without express written permission from Sophity LLC."
    page_number_options = {
      at: [bounds.right - 12, -8],
      width: 12,
      align: :right,
      page_filter: (2..15),
      start_count_at: 2,
      color: '000000'
    }
    footer_options = {
      at: [bounds.left, -8],
      width: 240,
      align: :left,
      page_filter: (2..15),
      start_count_at: 2,
      color: '000000'
    }
    number_pages page_number_string, page_number_options
    number_pages footer_string, footer_options
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
      [["You're proficient in: "]] + [[" – " + "N/A"]]
    else
      [["You're proficient in: "]] +
      @proficient.map do |p|
        ["  – " + p.survey.description]
      end
    end
  end

  def improve_rows
    if @improve.empty?
      [[ "You have room for improvement in these areas: "]]+ [[" – " + "N/A"]]
    else
      [[ "You have room for improvement in these areas: "]]+
      @improve.map do |i|
        ["  – " + i.survey.description]
      end
    end
  end

  def deltas_rows
    if @deltas.empty?
      [[ "You need to make significant improvement in these areas: "]] + [[" – " + "N/A"]]
    else
      [[ "You need to make significant improvement in these areas: "]] +
      @deltas.map do |d|
        ["  – " + d.survey.description]
      end
    end
  end


  def build_results_table
    table table_rows, {:header => true} do |table|
      table.column(2).size = 11
      table.column(3).size = 11
      table.cells.padding = 8
      table.width = 450
      table.column(1).width = 55
      table.column(2).borders = [:top, :bottom, :left]
      table.column(3).borders = [:top, :bottom, :right]
      table.row(0).borders = [:bottom]
      table.row(0).size = 12
      table.row(0).font_style = :bold
    end
  end

  def table_rows
    [["Service Component", "Grade", {:content => "Top Concerns", :colspan => 2}]] +
      @all_attempts.map do |l|
          [l.survey.description, l.grade, "•  " + l.top_concerns.first(5).join("\n\r\n\r"+"•  ")] +
          [(l.top_concerns.slice(5, 10) || []).unshift("").join("\n\r\n\r"+"•  ")[1..-1]]
          # ["", "", "•  " + l.top_concerns[6..(l.top_concerns.size - 1)].join("\n\r\n\r"+"•  ")]
        # else
        #   [l.survey.description, l.grade, "•  " + l.top_concerns.join("\n\r\n\r"+"•  ")]
        # end
      end
  end

end
