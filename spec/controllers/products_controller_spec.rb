require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:manufacturer) { Manufacturer.create!(name: 'Acme Robots') }
  let!(:product) { Product.create!(model_number: 'XY-123', height: 40, weight: 80, manufacturer_id: manufacturer.id ) }

  describe "GET #index" do
    it "responds with status code 200" do
      get :index
      expect(response).to have_http_status 200
    end

    it "assigns all products as @products" do
      get :index
      expect(assigns(:products)).to eq product.all
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "responds with status code 200" do
      get :show, params: { id: product.id }
      expect(response).to have_http_status 200
    end

    it "assigns the correct product as @product" do
      get :show, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end

    it "renders the :show template" do
      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end
  end
end
