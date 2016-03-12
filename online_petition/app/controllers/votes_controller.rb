class VotesController < ApplicationController
  before_filter :authorize, only: [:new, :vote]

  def new
    @vote = Vote.new
  end


  def dovote
    @petition = Petition.find(params[:id])
    @vote.create(vote_params).save
    redirect_to :back, notice: 'Спасибо. Ваш голос был учтен!'
    end

  private

  def vote_params
    params.require(:vote).permit(:petition_id, :user_id)
  end

end
