class PasswordsController < ApplicationController

  def edit
  end

  def update
    if current_user.update_with_password(user_params)
      flash[:notice] = 'Senha atualizada com sucesso'
    else
      flash[:error] = 'Erro ao atualizar a senha'
    end

    redirect_to new_vote_url
  end

  private

  def user_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end
end
