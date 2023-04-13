class ScorecardPdf < Prawn::Document
  def initialize(user)
    super(top_margin: 70)
    @user = user
    name
    handicap_items
    handicap_score
  end

  def name
    text "#{@user.name}", size: 30, style: :bold, align: :center
    text "Scorecard", size: 10, style: :bold, align: :center
  end

  def handicap_items
    move_down 20
    table_content = line_item_rows do
      #not working ######################################################
      style row(0), :background_color => "DDDDDD", :font_style => :bold
      columns(0..4).align = :center
      self.header = true
    end
    table table_content, width: bounds.width
  end


  def line_item_rows
    [["Course", "Date", "Slope", "Rating", "Score"]] +
    @user.microposts.each.map do |micropost|
      [micropost.course, micropost.game_date, micropost.slope, micropost.rating, micropost.score]
    end
  end

  def handicap_score
    move_down 20
    text "Handicap", size: 15, style: :bold, align: :center
    text "#{@user.handicap}", size: 20, :color => "FF0000", style: :bold, align: :center
  end


end
