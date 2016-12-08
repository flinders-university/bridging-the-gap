class CertificatesController < ApplicationController
  def conference
    respond_to do |format|
      format.pdf {
        rsvp = Rsvp.find(params[:rsvp_id])
        pdf = CertificatePdf.new(rsvp)
		    send_data pdf.render, filename: 'BridgingTheGapCertificate.pdf', type: 'application/pdf', disposition: :inline
      }
    end
  end

  private

  class CertificatePdf < Prawn::Document
    def initialize(rsvp)
      super(margin: 0)
      font_families.update("OpenSans" => {
        normal: "#{Rails.root}/app/assets/fonts/OpenSans-Regular.ttf",
        italic: "#{Rails.root}/app/assets/fonts/OpenSans-Italic.ttf",
        bold: "#{Rails.root}/app/assets/fonts/OpenSans-Bold.ttf",
        bold_italic: "#{Rails.root}/app/assets/fonts/OpenSans-BoldItalic.ttf"
      })
      content(rsvp)
    end

    def content(rsvp)
  	    bounding_box [0, 792], width: 612, height: 842 do
  		    bounding_box [85, 792], width: 442, height: 792 do
  			    move_down 0
  			    image Rails.root.join("app/assets/images/flinders.png"), width: 178, height: 64
            move_up 49
            image Rails.root.join("app/assets/images/logo-on-white-with-letterhead-arb-print.png"), width: 178, height: 48, at: [278, cursor]
            move_down 75
  			    move_down 30
            font "OpenSans"
  			    text "Teacher Conference Professional Development Certificate", inline_format: true, align: :center, style: :bold, size: 14
  			    move_down 20
            stroke_color "cccccc"
            stroke do
              horizontal_line 0, 455
              move_down 20
              text "#{rsvp.full_name}", inline_format: true, align: :center, style: :bold, size: 20
              move_down 20
              horizontal_line 0, 455
            end

            move_down 30

            text "This certifies that #{rsvp.full_name} has completed six and a half (6.5) hours of teacher professional development at Flinders University on Monday the 5th of December 2016.", leading: 15

            move_down 10

            text "AITSL standards:", style: :bold, leading: 15

    				line_items = [
                          ["•", "Standard 2 - Focus area 2.1 and 2.2"],
                          ["•", "Standard 3 - Focus area 3.2 and 3.3"],
                          ["•", "Standard 6 - Focus area 6.2, 6.3 and 6.4"],
                          ["•", "Standard 7 - Focus area 7."]
                         ]

    				borders = line_items.length - 2

    			    table(line_items, cell_style: { border_color: 'FFFFFF' }) do
    					cells.padding = 10
    					cells.borders = []
    					row(0..borders).borders = [:bottom]
    				end

            move_down 20
            image "#{Rails.root}/app/assets/images/crasig.png", width: 108, height: 58
            move_down 20

            text "Dr Carol Aldous", inline_format: true, style: :bold
            move_down 6
            text "Project Leader - Student Teacher STEM Industry Engagement", inline_format: true
            move_down 6
            text "School of Education | Flinders University", inline_format: true

            move_down 12

  				  text "<color rgb='888888'>Flinders University\nCRICOS No. 00114A</color>", inline_format: true, leading: 6
  		    end
  	    end
      end
    end
end
