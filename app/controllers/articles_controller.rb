class ArticlesController < ApplicationController 
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def show
    end

    def index
        @articles = Article.paginate(page: params[:page], per_page: 2)
    end

    def new
        @article = Article.new
    end

    def edit
    end

    def update
        if @article.update(article_params)
            flash[:notice] = "Article was successfully updated"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end

    def destroy
        @article= Article.find(params[:id])
        @article.destroy
        flash[:success] = "The to-do item was successfully destroyed."
        redirect_to articles_path
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
            flash[:notice] = "Article was created"
            redirect_to @article
        else
            render 'new'
        end
    end

    private
    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :decription, category_ids: [])
    end
    def require_same_user
        if current_user != @article.user && !current_user.admin?
          flash[:alert] = "You can only edit or delete your own article"
          redirect_to @article
        end
    end
end