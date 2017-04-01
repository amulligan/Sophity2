class SurveyPdf < Prawn::Document
  def initialize(all_attempts,total_score)
    super()
    @all_attempts = all_attempts
    @total_score = total_score
    if (@total_score >= 3.9) 
        @gradeLetter = "A+"
     elsif (@total_score >= 3.4) 
        @gradeLetter = "A"
     elsif (@total_score>= 3.0) 
       @gradeLetter = "A-"
     elsif (@total_score >= 3.9) 
       @gradeLetter  = "B+"
     elsif (@total_score>= 3.4) 
       @gradeLetter = "B"
    elsif (@total_score >= 3.0) 
       @gradeLetter = "B-"
    elsif (@total_score >= 2.9) 
        @gradeLetter = "C+"
     elsif (@total_score >= 2.4) 
       @gradeLetter = "C"
     elsif (@total_score >= 2.0) 
       @gradeLetter = "C-"
     elsif (@total_score>= 1.9) 
       @gradeLetter = "D+"
     elsif (@total_score >= 1.4) 
       @gradeLetter = "D"
     elsif (@total_score>= 1.0) 
       @gradeLetter = "D-"
     else
       @gradeLetter = "F"
    end
    cover   
    content
  end

  def cover 
    image "#{Rails.root}/app/assets/images/Sophity.png" 
    move_cursor_to 300
    font "Helvetica", :style => :bold_italic, :size => 20
    text "Sophity Services Success Model Health Check"
    move_cursor_to 200
    font "Helvetica", :style => :normal, :size => 12
    text "Prepared for: "
  end

  def content
    start_new_page
    header
    move_cursor_to 650
    text "Sophity Services Success Health Check - Your Results", :align => :center
    move_cursor_to 550
    text "Total Grade: #{ @gradeLetter }", :color => "0000ff", :size => 16
    main_build
    footer  
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    text "Sophity Services Success Model Health Check ", :align => :center
  end


  def footer
      string = '#<page>'
  # Green page numbers 1 to 7
  options = {
    at: [bounds.right - 150, 0],
    width: 150,
    align: :right,
    page_filter: (2..7),
    start_count_at: 1,
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