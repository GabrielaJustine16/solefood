class SneakersController < ApplicationController

    before_action :require_login


    def index
        @sneakers = Sneaker.all
        @brands = Brand.all
        
    end

    def new
        @user = User.find_by(id: params[:id])
        @sneaker = Sneaker.new
        @sneaker.build_brand
    end

    def create
        @user = User.find_by(id: params[:id])
        @sneaker = Sneaker.new(sneaker_params)
        @sneaker.user_id = session[:user_id]

        if @sneaker.save
            redirect_to user_sneaker_path(@user)
        else
            render :new
        end
    end

    def show
        @sneakers = Sneaker.all
        @brands = Brand.all
        # redirect_to '/' if !@sneaker
    end

    def edit
        @sneaker = Sneaker.find_by(id: params[:id])
    end

    def update

        @sneaker = Sneaker.find_by(id: params[:id])
        @sneaker.update(sneaker_params)
        if @sneaker.valid?
        redirect_to user_sneaker_path(@user)
        else
        render :edit
        end
    end

    def destroy
        sneaker = Sneaker.find_by(id: params[:id])
        sneaker.delete
        redirect_to sneakers_path
    end

        private

        def sneaker_params

            params.require(:sneaker).permit(:name, :size, :price, :user_id, :brand_id, brand_attributes: [:name])

        end

end
