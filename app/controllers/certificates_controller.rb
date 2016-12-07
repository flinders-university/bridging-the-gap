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
      content()
    end

    def content()
  	    bounding_box [0, 792], width: 612, height: 842 do
  		    bounding_box [85, 792], width: 442, height: 792 do
  			    move_down 0
  			    image Rails.root.join("app/assets/images/flinders.png"), width: 178, height: 68
  			    move_down 20
  			    text "<centre>Teacher Conference Professional Development Certificate", inline_format: true
  			    move_down 20

  				line_items = [["Standard achieved", "AITSL: blah"]]

  				borders = line_items.length - 2

  			    table(line_items, cell_style: { border_color: 'cccccc' }) do
  					cells.padding = 10
  					cells.borders = []
  					row(0..borders).borders = [:bottom]
  				end

  				text "Teacher Solutions, Pty Ltd"
  				text "<color rgb='888888'>Unit 3, 92 Beaconsfield Tce\nAscot Park, SA 5043\n\nACN 607 327 837</color>", inline_format: true
  		    end
  	    end
      end
    end
end
