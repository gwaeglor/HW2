class PetitionsController < ApplicationController
  before_filter :authorize, only: [:new, :create, :update, :upvote]
  before_filter :author, only: [:edit, :update]

  def index
    if params[:my] && current_user
      @petitions = Petition.where(user_id: current_user.id).reverse
      @title = 'Мои петиции'
    else
      @petitions = Petition.all.reverse
      @title = 'Все петиции'
    end
    @users = User.all
  end

  def index_last
    @petitions = Petition.last(10).reverse
    @users = User.all
    @title = 'Последние петиции'
    render 'index'
  end

  def new
    @petition = Petition.new
  end

  def edit
    @petition = Petition.find(params[:id])
  end

  def destroy
    @petition = Petition.find(params[:id])
    @petition.destroy!
    redirect_to :back, notice: 'Петиция удалена'
  end

  def show
    @petition = Petition.find(params[:id])
  end

  def create
    @petition = Petition.new(petition_params)
    @petition.user_id = current_user.id
    if @petition.save
      redirect_to @petition
    else
      render 'new'
    end
  end

  def update
    @petition = Petition.find(params[:id])
    if @petition.update_attributes(petition_params)
      redirect_to @petition, notice: 'Петиция обновлена'
    else
      render 'edit'
    end
  end

  def upvote
    @vote = Vote.new
    @petition = Petition.find(params[:id])
    if @petition.votes.create(user_id: current_user.id, petition_id: @petition.id).save
      Resque.enqueue(SendEmailJob, @petition.id)
    redirect_to :back, notice: 'Спасибо. Ваш голос был учтен!'
    end
  end

  private

  def petition_params
    params.require(:petition).permit(:title, :text) if params[:petition]
  end
end
