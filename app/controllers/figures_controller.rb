class FiguresController < ApplicationController

  get "/figures" do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/new"
  end

  post "/figures" do
    @figure = Figure.create(params[:figure])
    create_new_landmark(@figure)
    create_new_title(@figure)
    redirect "/figures/#{@figure.id}"
  end

  get "/figures/:id/edit" do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/edit"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"figures/show"
  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])
    create_new_landmark(@figure)
    create_new_title(@figure)
    redirect "/figures/#{@figure.id}"
  end

private

  def create_new_landmark(figure)
    if params[:landmark][:name] != ""
      landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
      figure.landmarks << landmark
    end
  end

  def create_new_title(figure)
    if params[:title][:name] != ""
      title = Title.find_or_create_by(params[:title])
      figure.titles << title
    end
  end

end
