class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote, only: [:show, :edit, :update, :destroy]

  # GET /votes
  # GET /votes.json
  def index
    @votes = Vote.all

    respond_to do |format|
      format.html
      format.csv { send_data @votes.to_csv, filename: "votes-#{Date.today}.csv" }
    end
  end

  # GET /votes/1
  # GET /votes/1.json
  def show
    raise 'Método não permitido'
  end

  # GET /votes/new
  def new
    @vote = Vote.new
  end

  # GET /votes/1/edit
  def edit
    raise 'Método não permitido'
  end

  # POST /votes
  # POST /votes.json
  def create
    @vote = Vote.new(vote_params)
    @vote.cpf = current_user.email

    if Vote.where(cpf: @vote.cpf).exists?
      respond_to do |format|
        sign_out current_user
        format.html { redirect_to new_user_session_url, alert: "CPF #{@vote.cpf} já votou!" }
        #format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
      return
    end

    respond_to do |format|
      if @vote.save
        sign_out current_user
        format.html { redirect_to new_user_session_url, notice: 'Voto enviado com sucesso.' }
        #format.html { redirect_to @vote, notice: 'Vote was successfully created.' }
        #format.json { render :show, status: :created, location: @vote }
      else
        format.html { render :new }
        #format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /votes/1
  # PATCH/PUT /votes/1.json
  def update
    raise 'Método não permitido'

    respond_to do |format|
      if @vote.update(vote_params)
        format.html { redirect_to @vote, notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      else
        format.html { render :edit }
        format.json { render json: @vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /votes/1
  # DELETE /votes/1.json
  def destroy
    raise 'Método não permitido'

    @vote.destroy
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vote_params
      params.require(:vote).permit(:cpf, :vote)
    end
end
