class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.page(params[:page])
  end

  def create
    @genre = Genre.new(genre_params)
    @genre_all = Genre.where(id: id)
    if @genre.save
      flash[:notice] = "ジャンルを登録しました。"
      redirect_to admin_genres_path
    else
      flash[:notice] = "ジャンルを登録できませんでした。"
      redirect_to admin_genres_path
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre_items = Item.where(genre_id: @genre.id)
    if @genre_items.present?
      flash[:notice] = "このジャンルに関連する商品が存在するため、削除できません。"
      redirect_to admin_genres_path
    else
      @genre.destroy
      flash[:notice] = "ジャンルを削除しました。"
      redirect_to admin_genres_path
    end
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
