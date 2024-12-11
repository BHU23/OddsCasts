class Admin::ArticlesController < ApplicationController

    before_action :set_article, only: %i[ show edit update destroy submit_for_review approve reject]
    
    # GET /articles or /articles.json
    def index
        @articles = Article.all
    end
    
    # GET /articles/1 or /articles/1.json
    def show
    end
    
    # GET /articles/new
    def new
        @article = Article.new
        @article.build_content
    end
    
    # GET /articles/1/edit
    def edit
        @article.build_content if @article.content.nil?
    end
    
    # POST /articles or /articles.json
    def create
        @article = Article.new(article_params)
    
        respond_to do |format|
        if @article.save
            format.html { redirect_to [:admin, @article], notice: "Article was successfully created." }
            format.json { render :show, status: :created, location: @article }
        else
            format.html { render :new, status: :unprocessable_entity }
            format.json { render json: @article.errors, status: :unprocessable_entity }
        end
        end
    end
    
    # PATCH/PUT /articles/1 or /articles/1.json
    def update
        respond_to do |format|
        if @article.update(article_params)
            format.html { redirect_to [:admin, @article], notice: "Article was successfully updated." }
            format.json { render :show, status: :ok, location: @article }
        else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @article.errors, status: :unprocessable_entity }
        end
        end
    end
    
    # DELETE /articles/1 or /articles/1.json
    def destroy
        @article.destroy!
    
        respond_to do |format|
        format.html { redirect_to admin_articles_path, status: :see_other, notice: "Article was successfully destroyed." }
        format.json { head :no_content }
        end
    end

    # POST /articles/:id/submit_for_review
    def submit_for_review
        if @article.content.draft?
            @article.content.submit_for_review!
            ContentMailer.with(content: @article.content).notify_content_submitted.deliver_now
            redirect_to admin_articles_path, notice: "Article submitted for review."
        else
            redirect_to admin_articles_path, alert: "Article cannot be submitted for review."
        end
    end

    # POST /articles/:id/approve
    def approve
        @article = Article.find(params.expect(:id))
        if @article.content.in_review?
            @article.content.approve!
            redirect_to admin_articles_path, notice: "Article approved."
        else
            redirect_to admin_articles_path, alert: "Article cannot be approved."
        end
    end

    # POST /articles/:id/reject
    def reject
        if @article.content.in_review?
            @article.content.reject!
            ContentMailer.with(content: @article.content).notify_content_submitted.deliver_now
            redirect_to admin_articles_path, notice: "Article rejected."
        else
            redirect_to admin_articles_path, alert: "Article cannot be rejected."
        end
    end 
    
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
        @article = Article.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def article_params
        params.require(:article).permit(:cover, content_attributes: [:title, :description])
    end
end