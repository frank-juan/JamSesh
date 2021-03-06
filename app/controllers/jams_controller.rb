class JamsController < ApplicationController
	before_action :find_jam, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show]

	def index
		if params[:genre].blank?
			@jams = Jam.all.order("created_at DESC").paginate(page: params[:page], per_page: 9)
		else
			@genre_id = Genre.find_by(name: params[:genre])
			@jams = Jam.where(genre: @genre_id).order("created_at DESC").paginate(page: params[:page], per_page: 9)
		end
	end

	def show
		@comments = Comment.where(jam_id: @jam).all.order("created_at DESC")
	end

	def new
		@jam = current_user.jams.build
	end

	def create
		@jam = current_user.jams.build(jam_params)

		if @jam.save
			redirect_to @jam
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @jam.update(jam_params)
			redirect_to @jam
		else
			render 'edit'
		end
	end

	def destroy
		@jam.destroy
		redirect_to jams_path
	end

	private

	def find_jam
		@jam = Jam.find(params[:id])
	end

	def jam_params
		params.require(:jam).permit(:title, :location, :date, :time, :number_of_musicians, :instrument_types, :genre_id, :jam_skill_id, :information )
	end
end
