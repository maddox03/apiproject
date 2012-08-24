class Api::PagesController < InheritedResources::Base
  respond_to :xml, :json
  custom_actions :resource => [:publish, :total_words], :collection => [:published, :unpublished]
  
  def new
    @page = Page.create(:title => params[:title], :content => params[:content])
    respond_to do |format|
      format.xml { render :xml => @page }
      format.json { render :json => @page }
    end
  end
  
  def edit
    @page = Page.find_by_id(params[:id])
    @page.update_attributes(:title => params[:title], :content => params[:content])
    respond_to do |format|
      format.xml { render :xml => @page }
      format.json { render :json => @page }
    end
  end
  
  def total_words
    @page = Page.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @page.to_xml(:methods => :total_words) }
      format.json { render :json => @page.as_json(:methods => :total_words) }
    end
  end
  
  def publish
    @page = Page.find(params[:id])
    respond_to do |format|
      format.xml { render :xml => @page.to_xml(:methods => :publish) }
      format.json { render :json => @page.to_xml(:methods => :publish) }
    end
  end
  
  def published
    respond_to do |format|
      format.xml { render :xml => Page.published }
      format.json { render :json => Page.published }
    end
  end

  def unpublished
    respond_to do |format|
      format.xml { render :xml => Page.unpublished }
      format.json { render :json => Page.unpublished }
    end
  end
end
