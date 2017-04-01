logopath = "#{RAILS_ROOT}/public/favicon.ico"

pdf.image logopath, :width => 197, :height => 91


pdf.font_size 14
 
pdf.bounding_box([pdf.bounds.right - 50,pdf.bounds.bottom], :width => 60, :height => 20) do
	count = pdf.page_count
	pdf.text "Page #{count}"
end

